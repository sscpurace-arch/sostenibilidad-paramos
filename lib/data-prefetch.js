/**
 * Descarga explícita de datos para trabajar sin conexión.
 *
 * A diferencia del seed silencioso en sync-engine, esta función es disparada
 * por el usuario (botón "Preparar sin conexión"), reporta progreso y deja un
 * registro verificable en localStorage. Funciona igual en iPhone, Android y
 * escritorio; en iPhone es la única forma confiable de poblar el
 * almacenamiento de la app instalada (que está separado del de Safari).
 */
import { db } from './db-offline';
import { getClient, syncQueue, syncInitialData, descargarHistorial, SEED_DEMO_URL } from './sync-engine';
import { prefetchDemoTiles } from './tile-prefetch';

const FLAG = 'offline-data-prepared-v1';

/** Estado de la última preparación offline. */
export function estadoOffline() {
  if (typeof window === 'undefined') return { listo: false };
  try {
    const raw = localStorage.getItem(FLAG);
    if (!raw) return { listo: false };
    const d = JSON.parse(raw);
    const diasDesde = Math.floor((Date.now() - new Date(d.fecha).getTime()) / 86400000);
    return { listo: true, fecha: d.fecha, totalProductores: d.totalProductores || 0, diasDesde };
  } catch {
    return { listo: false };
  }
}

// Pantallas de la app. Son cascarones estáticos: todos leen sus datos de
// IndexedDB, así que basta con tener el documento guardado una vez.
const RUTAS_APP = [
  '/', '/buscar', '/en-proceso', '/nuevo-productor',
  '/calificacion', '/calificacion/nueva', '/mapa', '/mapa/detalle', '/diagnostico',
];

/**
 * Guarda las pantallas de la app en los cachés del service worker.
 *
 * Antes esto era un `fetch(ruta)` a secas, y no servía de nada: el service
 * worker solo guarda en `paginas-html` lo que llega como NAVEGACIÓN
 * (request.mode === 'navigate'), y un fetch normal no lo es. Resultado: con
 * señal mala, abrir una pantalla que el celular no había visitado antes se
 * caía al respaldo "Sin conexión" y el técnico terminaba de vuelta en el
 * inicio. Aquí se escriben los cachés a mano, que es lo que sí funciona.
 *
 * Se guarda por ruta sin el query (?id=, ?productor=): el service worker busca
 * con ignoreSearch, así que una sola copia sirve para cualquier productor.
 */
const CACHE_HTML = 'paginas-html';
const CACHE_RSC = 'rsc-paginas-v2'; // mismo nombre que RSC_CACHE en app/sw.js
const FLAG_PANTALLAS = 'pantallas-guardadas-v1';

const pausa = (ms) => new Promise((r) => setTimeout(r, ms));

/** Baja UNA pantalla y la guarda. true solo si quedó guardada de verdad. */
async function guardarPantalla(cache, ruta, opciones) {
  const res = await fetch(ruta, opciones);
  // Nunca guardar redirecciones (el 307 del middleware a /login): quedaría el
  // login pegado como si fuera la pantalla.
  if (!res.ok || res.redirected) return false;
  await cache.put(ruta, res.clone());
  return true;
}

/**
 * Guarda las pantallas y devuelve cuáles NO quedaron guardadas.
 *
 * Una por una (no las 18 a la vez): cada petición pasa por el middleware, que
 * consulta la sesión en Supabase; en una avalancha algunas se rechazaban y
 * devolvían la redirección al login, que no se guarda. Antes eso fallaba en
 * silencio y el celular parecía listo sin estarlo: sin señal, al abrir un
 * productor no abría nada (prueba de campo, 19-oct-2026). Ahora cada pantalla
 * se reintenta y el resultado se registra para poder mostrarlo.
 *
 * @returns {Promise<{ok: boolean, falta: string[]}>}
 */
export async function calentarPantallas() {
  if (typeof caches === 'undefined' || !navigator.onLine) {
    return { ok: false, falta: [...RUTAS_APP] };
  }

  const falta = new Set();
  const destinos = [
    // Documento HTML: para abrir la pantalla o recargarla sin señal.
    [CACHE_HTML, { cache: 'reload' }],
    // Payload RSC: para la navegación interna entre pantallas.
    [CACHE_RSC, { headers: { RSC: '1' }, cache: 'reload' }],
  ];

  try {
    for (const [nombre, opciones] of destinos) {
      const cache = await caches.open(nombre);
      for (const ruta of RUTAS_APP) {
        let guardada = false;
        for (let intento = 1; intento <= 3 && !guardada; intento++) {
          try {
            guardada = await guardarPantalla(cache, ruta, opciones);
          } catch { /* sin red un momento: se reintenta */ }
          if (!guardada && intento < 3) await pausa(700 * intento);
        }
        if (!guardada) falta.add(ruta);
      }
    }
  } catch {
    RUTAS_APP.forEach((r) => falta.add(r)); // sin Cache API disponible
  }

  // Guía de calificación: el service worker la guarda (regla 'guias-pdf') al
  // pedirla. Sin esto solo estaba en campo si alguien la había abierto antes
  // con señal.
  fetch(GUIA_PDF).catch(() => {});

  const resultado = { ok: falta.size === 0, falta: [...falta] };
  try {
    localStorage.setItem(FLAG_PANTALLAS, JSON.stringify({ fecha: new Date().toISOString(), ...resultado }));
  } catch { /* almacenamiento lleno o bloqueado */ }
  return resultado;
}

/**
 * ¿Están guardadas ahora mismo todas las pantallas? Lee los cachés, no la
 * marca de la última vez: si el navegador desalojó algo, se nota.
 * @returns {Promise<{total: number, guardadas: number, falta: string[]}>}
 */
export async function estadoPantallas() {
  const total = RUTAS_APP.length;
  if (typeof caches === 'undefined') return { total, guardadas: 0, falta: [...RUTAS_APP] };
  try {
    const [html, rsc] = await Promise.all([caches.open(CACHE_HTML), caches.open(CACHE_RSC)]);
    const falta = [];
    for (const ruta of RUTAS_APP) {
      const enHtml = await html.match(ruta, { ignoreSearch: true, ignoreVary: true });
      const enRsc = await rsc.match(ruta, { ignoreSearch: true, ignoreVary: true });
      if (!enHtml || !enRsc) falta.push(ruta);
    }
    return { total, guardadas: total - falta.length, falta };
  } catch {
    return { total, guardadas: 0, falta: [...RUTAS_APP] };
  }
}

const GUIA_PDF = '/docs/guia-calificacion-matriz.pdf';

/**
 * Descarga todo lo necesario para trabajar sin conexión, reportando avance.
 * @param {(pct:number, label:string)=>void} onProgress
 * @returns {Promise<{totalProductores:number}>}
 */
export async function prepararOffline(onProgress = () => {}) {
  if (typeof window === 'undefined' || !navigator.onLine) {
    throw new Error('SIN_CONEXION');
  }

  const supabase = getClient();
  let totalProductores = 0;
  let historialOk = true;

  if (supabase) {
    // ── Modo real: datos desde Supabase ──
    // Primero subir lo pendiente y después bajar, con la misma descarga que
    // se hace al abrir la app (no pisa cambios sin subir, pagina). Solo baja
    // indicadores y productores: lo necesario para evaluar en campo.
    onProgress(3, 'Subiendo cambios pendientes…');
    await syncQueue();
    onProgress(10, 'Descargando productores…');
    const ok = await syncInitialData();
    if (!ok) throw new Error('DESCARGA_INCOMPLETA');
    totalProductores = await db.productores.count();
    onProgress(25, `${totalProductores} productores guardados`);

    // Línea base y visitas anteriores: sin esto, "Estado de sostenibilidad" sale
    // vacío sin señal para todos los productores (prueba de campo, 19-oct-2026).
    // Es lo único histórico que se baja; las evaluaciones en borrador no.
    onProgress(28, 'Descargando evaluaciones anteriores…');
    historialOk = await descargarHistorial((pct) => onProgress(28 + Math.round(pct * 0.12), 'Descargando evaluaciones anteriores…'));
    onProgress(40, 'Evaluaciones anteriores guardadas');
  } else {
    // ── Modo prueba: datos desde el archivo local ──
    onProgress(10, 'Cargando datos de prueba…');
    const res = await fetch(SEED_DEMO_URL);
    if (!res.ok) throw new Error('No se pudieron cargar los datos de prueba');
    const seed = await res.json();
    if (seed.indicadores?.length) await db.indicadores.bulkPut(seed.indicadores);
    if (seed.productores?.length) {
      await db.productores.bulkPut(seed.productores);
      totalProductores = seed.productores.length;
    }
    if (seed.evaluaciones?.length) await db.evaluaciones.bulkPut(seed.evaluaciones);
    if (seed.respuestas_indicadores?.length) await db.respuestas_indicadores.bulkPut(seed.respuestas_indicadores);
    onProgress(40, 'Datos de prueba listos');
  }

  // ── Teselas del mapa de la zona Puracé (lo más pesado: 40% → 95%) ──
  onProgress(42, 'Descargando mapa de la zona…');
  await prefetchDemoTiles((done, total) => {
    if (total > 0) {
      const pct = 42 + Math.round((done / total) * 53);
      onProgress(Math.min(pct, 95), `Mapa: ${done} de ${total} teselas`);
    }
  });

  // ── Calentar el cascarón de la app (95% → 100%) ──
  onProgress(96, 'Guardando pantallas…');
  const pantallas = await calentarPantallas();

  // No dar por listo lo que no lo está: cada falla se dice con su nombre para
  // que el técnico no salga a campo creyendo que ya puede trabajar sin señal.
  if (!pantallas.ok) {
    const err = new Error('PANTALLAS_INCOMPLETAS');
    err.detalle = pantallas.falta;
    throw err;
  }
  if (!historialOk) throw new Error('HISTORIAL_INCOMPLETO');

  if (totalProductores === 0) {
    totalProductores = await db.productores.count();
  }
  localStorage.setItem(FLAG, JSON.stringify({
    fecha: new Date().toISOString(),
    totalProductores,
  }));
  onProgress(100, 'Listo para trabajar sin conexión');
  return { totalProductores };
}
