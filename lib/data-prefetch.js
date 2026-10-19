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
const GUIA_PDF = '/docs/guia-calificacion-matriz.pdf';

// Archivos de código y estilos que cada pantalla pide (los nombres llevan un
// código que cambia en cada versión).
const RE_ARCHIVOS = /\/_next\/static\/[^"'\\\s]+?\.(?:js|css)/g;
const archivosDe = (html) => [...new Set(html.match(RE_ARCHIVOS) || [])];

const pausa = (ms) => new Promise((r) => setTimeout(r, ms));

/** ¿Hay una versión nueva instalada que todavía no está activa? */
async function versionNuevaEsperando() {
  try {
    const reg = await navigator.serviceWorker?.getRegistration();
    return reg?.waiting || null;
  } catch {
    return null;
  }
}

/**
 * Baja UNA pantalla y la guarda. Devuelve el texto del documento si quedó
 * guardada de verdad, o null.
 */
async function guardarPantalla(cache, ruta, opciones) {
  const res = await fetch(ruta, opciones);
  // Nunca guardar redirecciones (el 307 del middleware a /login): quedaría el
  // login pegado como si fuera la pantalla.
  if (!res.ok || res.redirected) return null;
  const copia = res.clone();
  await cache.put(ruta, res.clone());
  return copia.text();
}

/**
 * Guarda un archivo de código que falta en el caché.
 *
 * Pedirlo basta cuando el service worker lo trata como archivo "cualquiera"
 * (lo guarda solo). Pero si es de los que la versión instalada espera tener
 * precargados, el service worker NO lo vuelve a guardar al pedirlo (solo lo
 * baja de la red cada vez): hay que escribirlo a mano en el caché de
 * precarga, que es donde lo busca.
 */
async function guardarArchivo(url) {
  const res = await fetch(url);
  if (!res.ok) return;
  if (await caches.match(url, { ignoreSearch: true })) return; // ya lo guardó el service worker
  const nombres = await caches.keys();
  const destino = nombres.find((n) => n.startsWith('serwist-precache')) || 'next-static-js-assets';
  const cache = await caches.open(destino);
  await cache.put(url, res);
}

/**
 * Guarda las pantallas (y los archivos de código que usan) y devuelve lo que
 * NO quedó guardado.
 *
 * - Una por una, no las 18 a la vez: cada petición pasa por el middleware, que
 *   consulta la sesión en Supabase; en una avalancha algunas se rechazaban y
 *   devolvían la redirección al login, que no se guarda.
 * - También los archivos de código de cada pantalla: si el celular tiene
 *   guardada la pantalla de una versión pero el código de otra (versión nueva
 *   en espera), sin señal la pantalla se queda en "Cargando perfil…" para
 *   siempre.
 * - Si hay una versión nueva esperando, NO se guarda nada: las pantallas
 *   nuevas no combinan con el código de la versión activa. Se pide activarla.
 *
 * Antes todo esto fallaba en silencio y el celular parecía listo sin estarlo
 * (prueba de campo, 19-oct-2026).
 *
 * @returns {Promise<{ok: boolean, falta: string[], archivosFaltan: string[], versionNueva?: boolean}>}
 */
export async function calentarPantallas() {
  const todoFalta = { ok: false, falta: [...RUTAS_APP], archivosFaltan: [] };
  if (typeof caches === 'undefined' || !navigator.onLine) return todoFalta;

  const esperando = await versionNuevaEsperando();
  if (esperando) {
    // Pantalla segura (esto corre en el inicio): activarla; la app se recarga
    // sola cuando el nuevo service worker toma el control.
    try { esperando.postMessage({ type: 'SKIP_WAITING' }); } catch { /* sin permiso */ }
    return { ...todoFalta, versionNueva: true };
  }

  const falta = new Set();
  const archivos = new Set();
  const destinos = [
    // Documento HTML: para abrir la pantalla o recargarla sin señal.
    [CACHE_HTML, { cache: 'reload' }, true],
    // Payload RSC: para la navegación interna entre pantallas.
    [CACHE_RSC, { headers: { RSC: '1' }, cache: 'reload' }, false],
  ];

  try {
    for (const [nombre, opciones, esHtml] of destinos) {
      const cache = await caches.open(nombre);
      for (const ruta of RUTAS_APP) {
        let texto = null;
        for (let intento = 1; intento <= 3 && texto === null; intento++) {
          try {
            texto = await guardarPantalla(cache, ruta, opciones);
          } catch { /* sin red un momento: se reintenta */ }
          if (texto === null && intento < 3) await pausa(700 * intento);
        }
        if (texto === null) falta.add(ruta);
        else if (esHtml) archivosDe(texto).forEach((a) => archivos.add(a));
      }
    }
  } catch {
    RUTAS_APP.forEach((r) => falta.add(r)); // sin Cache API disponible
  }

  // Archivos de código: pedirlos hace que el service worker los guarde; luego
  // se comprueba que de verdad estén.
  const archivosFaltan = [];
  for (const a of archivos) {
    if (await caches.match(a, { ignoreSearch: true })) continue;
    try { await guardarArchivo(a); } catch { /* se comprueba abajo */ }
    if (!(await caches.match(a, { ignoreSearch: true }))) archivosFaltan.push(a);
  }

  // Guía de calificación: el service worker la guarda (regla 'guias-pdf') al
  // pedirla. Sin esto solo estaba en campo si alguien la había abierto antes
  // con señal.
  fetch(GUIA_PDF).catch(() => {});

  const resultado = { ok: falta.size === 0 && archivosFaltan.length === 0, falta: [...falta], archivosFaltan };
  try {
    localStorage.setItem(FLAG_PANTALLAS, JSON.stringify({ fecha: new Date().toISOString(), ...resultado }));
  } catch { /* almacenamiento lleno o bloqueado */ }
  return resultado;
}

/**
 * ¿Están guardadas ahora mismo todas las pantallas y sus archivos de código?
 * Lee los cachés, no la marca de la última vez: si el navegador desalojó algo
 * o hay código de otra versión, se nota.
 * @returns {Promise<{total: number, guardadas: number, falta: string[], archivosFaltan: string[], versionNueva: boolean}>}
 */
export async function estadoPantallas() {
  const total = RUTAS_APP.length;
  const vacio = { total, guardadas: 0, falta: [...RUTAS_APP], archivosFaltan: [], versionNueva: false };
  if (typeof caches === 'undefined') return vacio;
  try {
    const versionNueva = !!(await versionNuevaEsperando());
    const [html, rsc] = await Promise.all([caches.open(CACHE_HTML), caches.open(CACHE_RSC)]);
    const falta = [];
    const archivos = new Set();
    for (const ruta of RUTAS_APP) {
      const enHtml = await html.match(ruta, { ignoreSearch: true, ignoreVary: true });
      const enRsc = await rsc.match(ruta, { ignoreSearch: true, ignoreVary: true });
      if (!enHtml || !enRsc) { falta.push(ruta); continue; }
      try { archivosDe(await enHtml.clone().text()).forEach((a) => archivos.add(a)); } catch { /* ilegible */ }
    }
    const archivosFaltan = [];
    for (const a of archivos) {
      if (!(await caches.match(a, { ignoreSearch: true }))) archivosFaltan.push(a);
    }
    return { total, guardadas: total - falta.length, falta, archivosFaltan, versionNueva };
  } catch {
    return vacio;
  }
}


/**
 * Descarga todo lo necesario para trabajar sin conexión, reportando avance.
 * @param {(pct:number, label:string)=>void} onProgress
 * @returns {Promise<{totalProductores:number}>}
 */
export async function prepararOffline(onProgress = () => {}) {
  if (typeof window === 'undefined' || !navigator.onLine) {
    throw new Error('SIN_CONEXION');
  }

  // Antes de bajar nada: si hay una versión nueva esperando, activarla. Bajar
  // pantallas con una versión y código con otra deja la app a medias sin señal.
  const esperando = await versionNuevaEsperando();
  if (esperando) {
    try { esperando.postMessage({ type: 'SKIP_WAITING' }); } catch { /* sin permiso */ }
    throw new Error('VERSION_NUEVA');
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
  if (pantallas.versionNueva) throw new Error('VERSION_NUEVA');
  if (!pantallas.ok) {
    const err = new Error('PANTALLAS_INCOMPLETAS');
    err.detalle = [...pantallas.falta, ...pantallas.archivosFaltan];
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
