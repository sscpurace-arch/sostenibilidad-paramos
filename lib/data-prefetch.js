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
import { RUTAS_APP } from './rutas-app';

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

// ─── Pantallas guardadas en el celular ────────────────────────────────────
//
// QUIÉN las guarda: el service worker (app/sw.js), no esta página. Al instalar
// cada versión baja su código y sus pantallas juntos, y solo guarda pantallas
// que sean de su misma versión. Aquí solo se le PREGUNTA qué tiene y se le
// PIDE completar lo que falte.
//
// Antes las guardaba esta página con peticiones sueltas, después de instalada
// la versión: si la señal se cortaba a mitad quedaban pantallas de una versión
// con código de otra y, sin señal, la pantalla se quedaba en "Cargando…"
// (pruebas de campo de sep y oct-2026).

const FLAG_PANTALLAS = 'pantallas-guardadas-v1';
const ESPERA_ACUSE_MS = 4000;       // un service worker de esta versión contesta de inmediato
const ESPERA_RESULTADO_MS = 240000; // guardar 18 copias con señal débil puede tardar
const ESPERA_INSTALACION_MS = 60000;

const esperar = (ms) => new Promise((r) => setTimeout(r, ms));

async function registro() {
  try {
    return (await navigator.serviceWorker?.getRegistration()) || null;
  } catch {
    return null;
  }
}

/**
 * Le manda un pedido al service worker activo y espera su respuesta.
 * @returns {Promise<object>} lo que contestó, o { sinServicio } si no hay
 *   service worker activo, { sinRespuesta } si es una versión anterior que no
 *   conoce el pedido, { tardo } si no terminó a tiempo.
 */
async function pedirAlServiceWorker(accion) {
  const reg = await registro();
  const activo = reg?.active;
  if (!activo) return { sinServicio: true };
  return new Promise((resolve) => {
    const canal = new MessageChannel();
    let terminado = false;
    const fin = (valor) => {
      if (terminado) return;
      terminado = true;
      clearTimeout(tAcuse);
      clearTimeout(tTotal);
      resolve(valor);
    };
    let acuse = false;
    const tAcuse = setTimeout(() => { if (!acuse) fin({ sinRespuesta: true }); }, ESPERA_ACUSE_MS);
    const tTotal = setTimeout(() => fin({ tardo: true }), ESPERA_RESULTADO_MS);
    canal.port1.onmessage = (e) => {
      const d = e.data || {};
      if (d.recibido && !d.listo) { acuse = true; return; }
      fin(d);
    };
    try {
      activo.postMessage({ type: 'PANTALLAS', accion }, [canal.port2]);
    } catch {
      fin({ sinServicio: true });
    }
  });
}

/** Espera (con tope) a que haya un service worker activo. */
async function esperarServicioActivo(ms) {
  if (typeof navigator === 'undefined' || !('serviceWorker' in navigator)) return false;
  const reg = await registro();
  if (reg?.active) return true;
  try {
    await Promise.race([navigator.serviceWorker.ready, esperar(ms)]);
  } catch { /* sin service worker */ }
  return !!(await registro())?.active;
}

/**
 * Deja guardadas las pantallas y el código que falten, y devuelve lo que NO
 * quedó guardado. Corre al abrir la app con señal y al tocar "Preparar".
 *
 * - Si hay una versión nueva ya instalada esperando, se activa (la app se
 *   recarga sola al cambiar) y se avisa con `versionNueva`.
 * - Si el servidor ya va en una versión más nueva que la del celular, se manda
 *   a buscar la actualización: las pantallas nuevas llegan con ella, completas.
 *
 * @returns {Promise<{ok: boolean, falta: string[], archivosFaltan: string[], motivos: string[], versionNueva?: boolean}>}
 */
export async function calentarPantallas() {
  const todoFalta = { ok: false, falta: [...RUTAS_APP], archivosFaltan: [], motivos: [] };
  if (typeof navigator === 'undefined' || !('serviceWorker' in navigator)) {
    return { ...todoFalta, motivos: ['este navegador no permite guardar la app para usarla sin señal'] };
  }
  if (!navigator.onLine) return todoFalta;

  const reg = await registro();
  if (reg?.waiting) {
    // Versión nueva ya instalada (con sus pantallas): activarla. La app se
    // recarga sola cuando toma el control (components/UpdateBanner.jsx).
    try { reg.waiting.postMessage({ type: 'SKIP_WAITING' }); } catch { /* sin permiso */ }
    return { ...todoFalta, versionNueva: true };
  }

  if (!(await esperarServicioActivo(ESPERA_INSTALACION_MS))) {
    return { ...todoFalta, motivos: ['la app todavía no termina de instalarse en el celular (revisa la señal)'] };
  }

  const r = await pedirAlServiceWorker('guardar');
  if (r.sinServicio) {
    return { ...todoFalta, motivos: ['la app todavía no termina de instalarse en el celular'] };
  }
  if (r.sinRespuesta) {
    // Service worker de una versión anterior: no sabe guardar pantallas. Se
    // busca la actualización, que las trae.
    (await registro())?.update().catch(() => {});
    return { ...todoFalta, versionNueva: true };
  }
  if (r.tardo) return { ...todoFalta, motivos: ['la descarga tardó demasiado (señal débil)'] };
  if (r.error) return { ...todoFalta, motivos: [r.error] };

  if (r.otraVersion) (await registro())?.update().catch(() => {});

  const resultado = {
    ok: r.falta.length === 0 && r.archivosFaltan.length === 0,
    falta: r.falta,
    archivosFaltan: r.archivosFaltan,
    motivos: r.motivos || [],
    versionNueva: !!r.otraVersion,
  };
  try {
    localStorage.setItem(FLAG_PANTALLAS, JSON.stringify({ fecha: new Date().toISOString(), version: r.version, ...resultado }));
  } catch { /* almacenamiento lleno o bloqueado */ }
  return resultado;
}

/**
 * ¿Están guardadas ahora mismo todas las pantallas y sus archivos de código?
 * Lo contesta el service worker leyendo lo que hay en el celular (no una marca
 * de la última vez), así que sirve sin señal y nota si el navegador desalojó
 * algo.
 * @returns {Promise<{total:number, guardadas:number, falta:string[], archivosFaltan:string[], versionNueva:boolean, version:string|null, sinServicio:boolean}>}
 */
export async function estadoPantallas() {
  const total = RUTAS_APP.length;
  const vacio = { total, guardadas: 0, falta: [...RUTAS_APP], archivosFaltan: [], versionNueva: false, version: null, sinServicio: true };
  if (typeof navigator === 'undefined' || !('serviceWorker' in navigator)) return vacio;
  try {
    const reg = await registro();
    const versionNueva = !!reg?.waiting;
    const r = await pedirAlServiceWorker('estado');
    if (r.sinServicio || r.tardo || r.error) return { ...vacio, versionNueva };
    // Service worker anterior a este mecanismo: hay que actualizar la app
    if (r.sinRespuesta) return { ...vacio, versionNueva: true, sinServicio: false };
    return {
      total: r.total,
      guardadas: r.guardadas,
      falta: r.falta,
      archivosFaltan: r.archivosFaltan,
      versionNueva,
      version: r.version || null,
      sinServicio: false,
    };
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

  // Antes de bajar nada: si hay una versión nueva esperando, activarla (la
  // app se recarga sola y el técnico vuelve a tocar el botón).
  const reg = await registro();
  if (reg?.waiting) {
    try { reg.waiting.postMessage({ type: 'SKIP_WAITING' }); } catch { /* sin permiso */ }
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

  // ── Pantallas y código de la app (95% → 100%) ──
  onProgress(96, 'Comprobando las pantallas guardadas…');
  const pantallas = await calentarPantallas();

  // No dar por listo lo que no lo está: cada falla se dice con su nombre para
  // que el técnico no salga a campo creyendo que ya puede trabajar sin señal.
  if (pantallas.versionNueva) throw new Error('VERSION_NUEVA');
  if (!pantallas.ok) {
    const err = new Error('PANTALLAS_INCOMPLETAS');
    err.detalle = pantallas.motivos?.length
      ? pantallas.motivos
      : [...pantallas.falta.map((r) => `pantalla ${r}`), ...pantallas.archivosFaltan];
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
