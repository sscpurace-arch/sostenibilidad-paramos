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
import { getClient, syncQueue, syncInitialData, SEED_DEMO_URL } from './sync-engine';
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
export async function calentarPantallas() {
  if (typeof caches === 'undefined' || !navigator.onLine) return;

  const guardar = async (cacheName, opciones) => {
    try {
      const cache = await caches.open(cacheName);
      await Promise.all(RUTAS_APP.map(async (ruta) => {
        try {
          const res = await fetch(ruta, opciones);
          // Nunca guardar redirecciones (el 307 del middleware a /login):
          // quedaría el login pegado como si fuera la pantalla.
          if (res.ok && !res.redirected) await cache.put(ruta, res.clone());
        } catch { /* esta ruta se queda sin guardar, no es fatal */ }
      }));
    } catch { /* sin Cache API disponible */ }
  };

  await Promise.all([
    // Documento HTML: para abrir la pantalla o recargarla sin señal.
    guardar('paginas-html', { cache: 'reload' }),
    // Payload RSC: para la navegación interna entre pantallas.
    guardar('rsc-paginas', { headers: { RSC: '1' }, cache: 'reload' }),
    // Guía de calificación: el service worker la guarda (regla 'guias-pdf')
    // al pedirla. Sin esto solo estaba en campo si alguien la había abierto
    // antes con señal.
    fetch(GUIA_PDF).catch(() => {}),
  ]);
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

  if (supabase) {
    // ── Modo real: datos desde Supabase ──
    // Primero subir lo pendiente y después bajar, con la misma descarga que
    // se hace al abrir la app (no pisa cambios sin subir, pagina, trae el
    // historial completo). Antes aquí había una copia aparte que sí pisaba.
    onProgress(3, 'Subiendo cambios pendientes…');
    await syncQueue();
    onProgress(10, 'Descargando productores y evaluaciones…');
    const ok = await syncInitialData();
    if (!ok) throw new Error('DESCARGA_INCOMPLETA');
    totalProductores = await db.productores.count();
    onProgress(40, `${totalProductores} productores guardados`);
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
  await calentarPantallas();

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
