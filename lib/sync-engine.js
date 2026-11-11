/**
 * Sync Engine — Capa de sincronización offline-first
 * 
 * Flujo: IndexedDB primero → intenta Supabase → cola si offline
 * Conflictos: last-write-wins basado en updated_at
 * Auto-sync: reconexión vía window.online event
 */
import { db } from './db-offline';
import { esErrorDeRed } from './red';

// Versión de los datos de prueba (seed-data.json).
// SÚBELA (cambia el texto) cada vez que ajustes los datos demo —por ejemplo,
// al agregar o cambiar las calificaciones de ejemplo— para que los dispositivos
// que ya tienen datos viejos vuelvan a cargar los demos sin tener que reinstalar.
const SEED_VERSION = '2026-11-11-textos-niveles-v11';

// Filas por petición al subir la cola. Pequeño a propósito: con señal débil
// un lote grande no alcanza a llegar antes del tiempo límite (25 s).
const LOTE_SUBIDA = 25;

// ─── Estado interno ───────────────────────────────────────
let _supabase = null;
let _isSyncing = false;
let _syncPromise = null;
let _pendingCount = 0;
let _failedCount = 0;
let _failedReasons = [];   // [{ texto, n }] — por qué fallan, agrupado, para el banner
let _seedFailed = false;
let _lastError = null;   // último error real de la cola, para poder mostrarlo
let _yaRehabilitado = false;
let _lastSyncAt = null;
let _listeners = new Set();
let _initialized = false;
// Por qué la cola está esperando sin que sea culpa de ningún registro:
// 'sin-respuesta' (señal débil o servidor caído) | 'sesion' (hay que volver a
// entrar) | null. Para que el banner lo diga en vez de "pendientes" a secas.
let _colaEnEspera = null;
// Texto del último guardado que NO quedó en el celular (almacenamiento lleno,
// base bloqueada). Antes ese fallo solo iba a la consola y el técnico seguía
// calificando creyendo que todo quedaba guardado.
let _falloGuardado = null;

function estadoActual() {
  return {
    isSyncing: _isSyncing,
    pendingCount: _pendingCount,
    failedCount: _failedCount,
    failedReasons: _failedReasons,
    seedFailed: _seedFailed,
    lastError: _lastError,
    lastSyncAt: _lastSyncAt,
    colaEnEspera: _colaEnEspera,
    falloGuardado: _falloGuardado,
  };
}

function notify() {
  const state = estadoActual();
  _listeners.forEach(fn => { try { fn(state); } catch(e) {} });
}

export function subscribe(fn) {
  _listeners.add(fn);
  return () => _listeners.delete(fn);
}

export function getState() {
  return estadoActual();
}

/** El técnico ya vio el aviso de "no se pudo guardar en el celular". */
export function descartarFalloGuardado() {
  _falloGuardado = null;
  notify();
}

function registrarFalloGuardado(e) {
  const nombre = String(e?.name || '');
  const interno = String(e?.inner?.name || '');
  _falloGuardado = /Quota/i.test(nombre + interno)
    ? 'El celular se quedó sin espacio: lo último que marcaste NO quedó guardado. Libera espacio (fotos, videos, otras apps) y vuelve a marcarlo.'
    : `No se pudo guardar en el celular: lo último que marcaste NO quedó guardado. Cierra y vuelve a abrir la app, y márcalo de nuevo. (${String(e?.message || e).slice(0, 80)})`;
  notify();
}

// ─── Clasificación de errores del servidor ────────────────
//
// Hay errores que no se arreglan reintentando: la misma fila va a fallar
// igual las 5 veces, gastando batería y datos, y el usuario ve "41 cambios
// pendientes" para siempre sin saber por qué. Se reconocen por el código de
// Postgres/PostgREST, se marcan de una vez como fallo permanente y se
// explican en lenguaje llano.
const ERRORES_PERMANENTES = {
  '23505': 'Ya existe en el servidor (registro duplicado)',
  '23503': 'Apunta a un registro que ya no existe en el servidor (evaluación o productor borrado)',
  '23514': 'El servidor rechazó el dato (no cumple una regla de la base)',
  '23502': 'Falta un dato obligatorio',
  '22P02': 'Un dato tiene un formato inválido',
  '42703': 'La base de datos no conoce una de las columnas (falta actualizar la base)',
  'PGRST204': 'La base de datos no conoce una de las columnas (falta actualizar la base)',
  '42501': 'Sin permiso para escribir este registro',
  '42P01': 'La tabla no existe en el servidor',
};

function describirError(err) {
  const codigo = String((err && err.code) || '');
  const crudo = String((err && (err.message || err.details)) || err || 'Error desconocido').slice(0, 200);
  const permanente = Object.prototype.hasOwnProperty.call(ERRORES_PERMANENTES, codigo);
  const texto = permanente ? `${ERRORES_PERMANENTES[codigo]} · ${crudo}` : crudo;
  return { codigo, permanente, texto };
}

/**
 * ¿La subida falló SIN que el servidor rechazara el dato?
 *  - 'sin-respuesta': no hubo respuesta (señal débil, corte por tiempo) o el
 *    servidor está caído (502/503/504).
 *  - 'sesion': hay que volver a entrar (401).
 *  - null: el servidor contestó con un motivo sobre el registro.
 *
 * Estas fallas NO gastan intentos. Antes sí: con "una rayita" de señal cada
 * puntaje marcado lanzaba una subida que fallaba y sumaba un intento a TODO lo
 * pendiente; a los cinco, la visita completa quedaba como "no se pudo subir",
 * dejaba de reintentarse sola y el banner ofrecía "Descartar" como si el
 * servidor la hubiera rechazado (auditoría nov-2026).
 */
function clasificarFallaTransitoria(error, status) {
  if (typeof navigator !== 'undefined' && !navigator.onLine) return 'sin-respuesta';
  const estado = Number(status) || 0;
  if (estado === 401) return 'sesion';
  if (estado === 0 || estado === 502 || estado === 503 || estado === 504) return 'sin-respuesta';
  if (String((error && error.code) || '')) return null;
  return esErrorDeRed(error) ? 'sin-respuesta' : null;
}

/**
 * Saca de la cola los cambios pendientes de un registro que quedan
 * reemplazados por uno más nuevo (o por su borrado).
 *
 * Sin esto, un cambio viejo que había agotado sus intentos quedaba esperando;
 * el cambio nuevo subía bien y, al reabrir la app, el viejo se rehabilitaba y
 * subía DESPUÉS: el servidor terminaba con el dato viejo (una evaluación
 * enviada y firmada volvía a borrador; un puntaje corregido volvía al
 * anterior) y el celular seguía mostrando el nuevo (auditoría nov-2026).
 *
 * Debe llamarse dentro de la misma transacción que agrega el cambio nuevo.
 */
async function _reemplazarPendientes(tabla, ids) {
  const conjunto = new Set(ids);
  await db.sync_queue
    .where('sync_pending').equals(1)
    .and(item => item.tabla === tabla && conjunto.has(item.payload?.id))
    .modify({ sync_pending: 0, resuelto: 'reemplazado por un cambio más nuevo', ultimo_error: null });
}

/**
 * Al abrir la app: lo mismo para lo que ya estaba encolado antes de que
 * existiera _reemplazarPendientes. De cada registro solo queda pendiente su
 * cambio más reciente; y si después de un cambio pendiente ya subió uno más
 * nuevo del mismo registro, el pendiente sobra.
 */
async function _resolverReemplazados() {
  try {
    const todas = await db.sync_queue.toArray();
    const ultima = {}; // "tabla|id" -> mayor localId visto (pendiente o ya subido)
    for (const item of todas) {
      const id = item.payload?.id;
      if (!id || item.resuelto) continue;
      const k = `${item.tabla}|${id}`;
      if (!ultima[k] || item.localId > ultima[k]) ultima[k] = item.localId;
    }
    const sobran = todas.filter(item =>
      item.sync_pending === 1 && item.payload?.id &&
      item.localId < ultima[`${item.tabla}|${item.payload.id}`]
    );
    for (const item of sobran) {
      await db.sync_queue.update(item.localId, {
        sync_pending: 0, resuelto: 'reemplazado por un cambio más nuevo', ultimo_error: null,
      });
    }
  } catch (e) { /* si falla, la cola sigue como estaba */ }
}

/**
 * Una sola vez por celular: descartar las órdenes de BORRADO que quedaron
 * encoladas con el código anterior.
 *
 * El código anterior encolaba los borrados también en modo prueba (ver
 * deleteRecordBulk), y de una orden ya encolada no se puede saber en qué modo
 * se creó. Ante la duda se descartan: si alguna era legítima, el registro
 * sigue en el servidor y se puede volver a borrar; al revés —ejecutar una que
 * venía del modo prueba— se pierde un registro real sin respaldo.
 */
const MARCA_BORRADOS = 'cola-borrados-revisada-v1';
async function _descartarBorradosHeredados() {
  try {
    if (localStorage.getItem(MARCA_BORRADOS)) return;
    const borrados = await db.sync_queue
      .where('sync_pending').equals(1)
      .and(item => item.operacion === 'DELETE')
      .toArray();
    // Los cambios pendientes ANTERIORES al borrado del mismo registro también
    // sobran: sin el borrado, subirían y harían reaparecer en el servidor un
    // registro que el técnico borró (por ejemplo, una visita creada y borrada
    // sin señal antes de esta versión).
    const borradoEn = {}; // "tabla|id" -> localId del borrado
    for (const b of borrados) {
      const k = `${b.tabla}|${b.payload?.id}`;
      borradoEn[k] = Math.max(borradoEn[k] || 0, b.localId);
    }
    await db.sync_queue
      .where('sync_pending').equals(1)
      .and(item => item.operacion !== 'DELETE'
        && item.localId < (borradoEn[`${item.tabla}|${item.payload?.id}`] || 0))
      .modify({
        sync_pending: 0,
        resuelto: 'el registro se borró después en este celular',
        ultimo_error: null,
      });
    await db.sync_queue
      .where('sync_pending').equals(1)
      .and(item => item.operacion === 'DELETE')
      .modify({
        sync_pending: 0,
        resuelto: 'borrado encolado antes de nov-2026: no se sabe si venía del modo prueba',
        ultimo_error: null,
      });
    localStorage.setItem(MARCA_BORRADOS, new Date().toISOString());
  } catch (e) { /* si falla, se reintenta en la próxima apertura */ }
}

/**
 * ¿Este cambio pendiente es más viejo que lo que el celular tiene guardado?
 * Cinturón para colas antiguas: aunque ya no quede rastro del cambio nuevo
 * (los subidos se borran a las 24 h), el registro local sí lo refleja.
 */
async function _estaSuperado(item) {
  try {
    if (item.operacion === 'DELETE') return false;
    const local = await db[item.tabla].get(item.payload.id);
    if (!local) return false; // lo decide el borrado encolado, si lo hay
    if (item.tabla === 'evaluaciones') {
      return local.estado === 'enviada' && item.payload.estado !== 'enviada';
    }
    // Solo respuestas: cada guardado suyo lleva su propia hora. En otras
    // tablas (fotos, PDF) la fila local se retoca después de encolar y la
    // comparación daría falsos positivos.
    if (item.tabla !== 'respuestas_indicadores') return false;
    const a = Date.parse(item.payload.updated_at || '');
    const b = Date.parse(local.updated_at || '');
    return Number.isFinite(a) && Number.isFinite(b) && b > a;
  } catch (e) {
    return false;
  }
}

// Tablas cuyo padre es una evaluación. Su suerte depende de ella.
const TABLAS_HIJAS = ['respuestas_indicadores', 'planes_accion', 'diagnosticos', 'fotos_evidencia', 'reportes_pdf'];

// Quién está logueado en esta corrida (la cola es del CELULAR, no del
// usuario: si en el mismo teléfono entra otra cuenta, hereda la cola).
let _uidActual = null;
let _esAdminActual = false;

async function refrescarUsuarioActual() {
  _uidActual = null;
  _esAdminActual = false;
  if (!_supabase) return;
  try {
    const { data } = await _supabase.auth.getUser();
    _uidActual = data?.user?.id || null;
    if (!_uidActual) return;
    // Rol: primero la caché local (lib/perfil.js), luego el servidor
    let rol = null;
    try { rol = (await db.perfil_tecnico.get(_uidActual))?.rol || null; } catch (e) { /* sin tabla */ }
    if (!rol && navigator.onLine) {
      try {
        const { data: u } = await _supabase.from('usuarios').select('rol').eq('id', _uidActual).maybeSingle();
        rol = u?.rol || null;
      } catch (e) { /* red inestable */ }
    }
    _esAdminActual = rol === 'admin';
  } catch (e) { /* sin sesión */ }
}

/**
 * Situación del padre de un cambio, según lo que hay en ESTE celular:
 *  - 'sin-padre'    la evaluación (o el productor) ya no existe localmente → huérfano
 *  - 'prueba'       la evaluación es de prueba → nunca debió encolarse
 *  - 'otro-usuario' la evaluación es de otra cuenta y la actual no es admin →
 *                   el servidor la va a rechazar hasta que entre esa cuenta
 *  - 'ok'           nada raro: si falla, es por otra cosa
 */
async function contextoPadre(item) {
  const p = item.payload || {};
  try {
    if (TABLAS_HIJAS.includes(item.tabla) && p.evaluacion_id) {
      const ev = await db.evaluaciones.get(p.evaluacion_id);
      if (!ev) return 'sin-padre';
      if (ev.es_prueba) return 'prueba';
      if (_uidActual && ev.tecnico_id && ev.tecnico_id !== _uidActual && !_esAdminActual) return 'otro-usuario';
      return 'ok';
    }
    if (item.tabla === 'evaluaciones' && item.operacion !== 'DELETE') {
      if (p.es_prueba) return 'prueba';
      if (_uidActual && p.tecnico_id && p.tecnico_id !== _uidActual && !_esAdminActual) return 'otro-usuario';
      if (p.finca_id && !(await db.productores.get(p.finca_id))) return 'sin-padre';
    }
  } catch (e) { /* Dexie no disponible: se trata como ok */ }
  return 'ok';
}

async function resolverEntrada(item, motivo) {
  await db.sync_queue.update(item.localId, {
    sync_pending: 0,
    resuelto: motivo,
    ultimo_error: `Descartado: ${motivo}`,
  });
}

/**
 * Marca una entrada de la cola según el error y el contexto de su padre:
 * descartada (ya no tiene sentido), fallo permanente (sin más reintentos
 * automáticos) o reintento normal.
 *
 * OJO con RLS (42501) y clave foránea (23503) en tablas hijas: no siempre son
 * permanentes. Si la evaluación padre aún no ha subido (falló por red en esta
 * misma corrida), sus respuestas fallan con ese mismo error y a la siguiente
 * corrida pasan. Solo se dan por perdidas cuando el padre no existe, es de
 * prueba o es de otra cuenta.
 */
async function marcarFallo(item, desc) {
  const ctx = await contextoPadre(item);

  // Una evaluación sin productor local solo se descarta si el servidor confirmó
  // que el productor tampoco existe allá (23503): puede estar en Supabase sin
  // haberse descargado a este celular.
  const esHija = TABLAS_HIJAS.includes(item.tabla);
  if (ctx === 'sin-padre' && (esHija || desc.codigo === '23503')) {
    return resolverEntrada(item, 'la evaluación o el productor al que pertenecía ya no existe');
  }
  if (ctx === 'prueba') return resolverEntrada(item, 'pertenece a una calificación de prueba (no se sube por diseño)');
  if (desc.codigo === '23505' && item.tabla === 'respuestas_indicadores' && item.operacion !== 'DELETE') {
    return resolverEntrada(item, 'el servidor ya tiene esta respuesta (fila duplicada)');
  }

  const esDePermiso = desc.codigo === '42501' || desc.codigo === '23503';
  if (ctx === 'otro-usuario' && esDePermiso) {
    await db.sync_queue.update(item.localId, {
      error_count: 5,
      permanente: 1,
      ultimo_error: 'Pertenece a otra cuenta: entra con esa cuenta en este celular para que suba',
    });
    return;
  }
  if (esDePermiso && ctx === 'ok') {
    // El padre puede no haber subido todavía: reintento normal
    await db.sync_queue.update(item.localId, {
      error_count: (item.error_count || 0) + 1,
      ultimo_error: desc.texto,
    });
    return;
  }
  if (desc.permanente) {
    await db.sync_queue.update(item.localId, {
      error_count: 5,
      permanente: 1,
      ultimo_error: desc.texto,
    });
    return;
  }
  await db.sync_queue.update(item.localId, {
    error_count: (item.error_count || 0) + 1,
    ultimo_error: desc.texto,
  });
}

/**
 * Al abrir la app: reparar payloads con errores de forma ya conocidos, para
 * que suban en vez de fallar para siempre. Cada caso aquí es un bug que ya
 * se corrigió en el origen; esto es para lo que quedó encolado antes.
 *  - planes_accion.plazo = '' (DATE no acepta vacío, 22P02) → null
 */
async function _repararPayloads() {
  try {
    const pendientes = await db.sync_queue
      .where('sync_pending').equals(1)
      .and(item => item.tabla === 'planes_accion' && item.operacion !== 'DELETE' && item.payload?.plazo === '')
      .toArray();
    for (const item of pendientes) {
      await db.sync_queue.update(item.localId, {
        payload: { ...item.payload, plazo: null },
        error_count: 0,
        permanente: 0,
        ultimo_error: null,
      });
    }
  } catch (e) { /* si falla, la cola sigue como estaba */ }
}

/**
 * Al abrir la app: sacar de la cola lo que ya no tiene sentido sin
 * necesidad de red — hijos de evaluaciones que ya no están en el celular o
 * que son de prueba. Sin esto, esas filas fallaban por RLS en cada apertura
 * y el banner mostraba "N cambios pendientes" para siempre.
 */
async function _limpiarColaHuerfana() {
  try {
    const pendientes = await db.sync_queue.where('sync_pending').equals(1).toArray();
    for (const item of pendientes) {
      // Solo tablas hijas: una evaluación sin productor local puede tenerlo en el servidor
      if (!TABLAS_HIJAS.includes(item.tabla) || item.operacion === 'DELETE') continue;
      const ctx = await contextoPadre(item);
      if (ctx === 'sin-padre') await resolverEntrada(item, 'la evaluación a la que pertenecía ya no existe en este celular');
      else if (ctx === 'prueba') await resolverEntrada(item, 'pertenece a una calificación de prueba (no se sube por diseño)');
    }
  } catch (e) { /* si falla, la cola sigue como estaba */ }
}

export async function waitForSync() {
  if (_syncPromise) await _syncPromise;
}

/** Devuelve el cliente Supabase activo (null en modo prueba). */
export function getClient() {
  return _supabase;
}

// Descarga seed-data.json y lo vuelca a IndexedDB.
// bulkPut es idempotente: sobreescribe por id, así que NO borra los registros
// que el usuario haya creado (esos tienen ids nuevos que no están en el seed).
// Los datos reales (cédulas, coordenadas, calificaciones) ya NO son un
// archivo público: se piden a /api/seed, que exige sesión iniciada. El modo
// prueba (visitantes, sin cuenta) usa /seed-demo.json, una copia sin datos
// personales generada por scripts/generar-seed-demo.mjs.
export const SEED_DEMO_URL = '/seed-demo.json';

async function importSeedData(isMock = false) {
  // Pedir el archivo FRESCO saltándose la caché del service worker:
  // el query ?v= no coincide con la regla de caché de /seed-demo.json,
  // y cache:'no-store' evita la caché HTTP del navegador. Así, al subir
  // SEED_VERSION, los dispositivos descargan el seed nuevo (no el viejo cacheado).
  const base = isMock ? SEED_DEMO_URL : '/api/seed';
  const url = `${base}?v=${encodeURIComponent(SEED_VERSION)}`;
  const res = await fetch(url, { cache: 'no-store', credentials: 'same-origin' });
  if (!res.ok) throw new Error(`No se pudieron descargar los datos iniciales (${res.status})`);
  const data = await res.json();

  if (data.indicadores?.length > 0) await db.indicadores.bulkPut(data.indicadores);
  if (data.productores?.length > 0) await db.productores.bulkPut(data.productores);
  if (data.evaluaciones?.length > 0) await db.evaluaciones.bulkPut(data.evaluaciones);
  if (data.respuestas_indicadores?.length > 0) await db.respuestas_indicadores.bulkPut(data.respuestas_indicadores);

  return data;
}

function getStoredSeedVersion() {
  try { return localStorage.getItem('seed_version'); } catch { return null; }
}
function setStoredSeedVersion(v) {
  try { localStorage.setItem('seed_version', v); } catch { /* silent */ }
}

// Siembra/actualiza IndexedDB con seed-data.json.
// - Base vacía: carga completa (cualquier modo).
// - Base con datos pero versión vieja, en MODO PRUEBA: recarga los datos demo
//   (calificaciones de ejemplo) sin borrar lo que el tester haya capturado.
async function seedLocalDatabase(isMock = false) {
  try {
    const count = await db.productores.count();
    const versionVieja = getStoredSeedVersion() !== SEED_VERSION;

    // Base vacía → carga inicial completa.
    if (count === 0) {
      console.log('[sync] Base de datos vacía. Cargando datos de prueba desde seed-data.json...');
      _isSyncing = true;
      notify();
      const data = await importSeedData(isMock);
      setStoredSeedVersion(SEED_VERSION);
      console.log(`[sync] Datos de prueba importados con éxito: ${data.productores?.length} productores.`);
      _seedFailed = false;
      _isSyncing = false;
      notify();
      return;
    }

    // Base con datos pero versión desactualizada, solo en modo prueba →
    // recargar los demos (merge idempotente) para que aparezcan las
    // calificaciones de ejemplo sin reinstalar ni perder datos capturados.
    if (isMock && versionVieja) {
      console.log('[sync] Actualizando datos demo a', SEED_VERSION, '...');
      _isSyncing = true;
      notify();
      await importSeedData(isMock);
      setStoredSeedVersion(SEED_VERSION);
      _isSyncing = false;
      notify();
      console.log('[sync] Datos demo actualizados.');
      return;
    }

    console.log('[sync] Base de datos local al día. Omitiendo seed.');
  } catch (e) {
    console.error('[sync] Error importando datos de prueba:', e);
    _isSyncing = false;
    // Si la base sigue vacía, avisar a la UI: la app necesita conexión una vez
    try {
      const count = await db.productores.count();
      if (count === 0) { _seedFailed = true; }
    } catch { /* silent */ }
    notify();
  }
}

// ─── Inicialización ───────────────────────────────────────
export function initSyncEngine(supabase) {
  if (_initialized) return;
  _supabase = supabase;
  // Primero sacar los cambios viejos ya reemplazados; después rehabilitar lo
  // que quede. Al revés, un cambio viejo rehabilitado subía encima del nuevo.
  _colaLista = _descartarBorradosHeredados()
    .then(() => _resolverReemplazados())
    .then(() => _rehabilitarFallidosUnaVez())
    .then(() => _repararPayloads())
    .then(() => _limpiarColaHuerfana())
    .then(() => updatePendingCount());
  _initialized = true;

  if (supabase) {
    // Auto-sync al recuperar conexión (solo en modo real)
    window.addEventListener('online', () => {
      console.log('[sync] Conexión recuperada. Ejecutando syncQueue...');
      syncQueue();
    });
    // Con señal intermitente el evento 'online' no siempre llega (el celular
    // "cree" que siempre tuvo red). Reintentar solo cada pocos minutos
    // mientras la app está a la vista, y al volver a ella.
    setInterval(() => {
      if (document.visibilityState === 'visible') syncQueue();
    }, REINTENTO_MS);
    document.addEventListener('visibilitychange', () => {
      if (document.visibilityState === 'visible') syncQueue();
    });
  }

  // Siempre sembrar datos locales; solo sincronizar con Supabase si hay cliente real.
  // isMock = sin cliente Supabase → recarga los datos demo si la versión cambió.
  //
  // ORDEN (no cambiar): primero SUBIR lo pendiente y después BAJAR del
  // servidor. Al revés, la descarga pisaba en el celular los cambios hechos
  // sin señal (una evaluación enviada volvía a verse en borrador, respuestas
  // nuevas volvían a las viejas) y un "Guardar y salir" posterior subía lo
  // viejo encima de lo nuevo.
  _datosListos = seedLocalDatabase(!supabase).then(async () => {
    if (supabase) {
      // La limpieza de la cola de arriba debe terminar antes de la primera subida
      await _colaLista.catch(() => {});
      await syncQueue();
      await syncInitialData();
    }
  }).catch(() => {});
  updatePendingCount();
}

let _datosListos = null;
// Limpieza de la cola al abrir la app; toda subida la espera (ver _runSyncQueue)
let _colaLista = Promise.resolve();

/**
 * Se resuelve cuando terminó la carga inicial (semilla + descarga del
 * servidor). Lo que depende de los productores —p. ej. calcular qué zona del
 * mapa descargar— debe esperar esto; si no, corre con la base vacía.
 */
export function datosIniciales() {
  return _datosListos || Promise.resolve();
}

// Cada cuánto se reintenta subir lo pendiente con la app abierta
const REINTENTO_MS = 3 * 60 * 1000;

/**
 * Guarda en el celular filas que vienen del servidor SIN pisar las que tienen
 * cambios locales todavía sin subir: esas son más nuevas que las del
 * servidor. Toda descarga desde Supabase hacia IndexedDB debe pasar por aquí.
 */
export async function guardarDesdeServidor(tabla, filas) {
  if (!filas || filas.length === 0) return;
  try {
    const pendientes = new Set(
      (await db.sync_queue
        .where('sync_pending').equals(1)
        .and(item => item.tabla === tabla)
        .toArray()
      ).map(item => item.payload?.id)
    );
    const libres = pendientes.size ? filas.filter(f => !pendientes.has(f.id)) : filas;
    if (libres.length) await db[tabla].bulkPut(libres);
  } catch (e) {
    console.error(`[sync] Error guardando ${tabla} desde el servidor:`, e);
  }
}

// El servidor devuelve como máximo 1.000 filas por consulta y corta el resto
// sin avisar: las descargas grandes van por páginas.
const PAGINA = 1000;

async function descargarPaginado(consulta) {
  const filas = [];
  for (let desde = 0; ; desde += PAGINA) {
    const { data, error } = await consulta().range(desde, desde + PAGINA - 1);
    if (error) throw error;
    filas.push(...(data || []));
    if (!data || data.length < PAGINA) return filas;
  }
}


// ─── API pública: Escritura ───────────────────────────────

/**
 * Guarda un registro: IndexedDB primero, luego intenta sync.
 * Si no hay conexión, queda en cola con sync_pending = true.
 */
/**
 * @returns {Promise<boolean>} true si el registro quedó guardado en el
 *   celular. Si es false, NO quedó: quien llama no debe seguir como si nada
 *   (además el banner lo avisa: ver registrarFalloGuardado).
 */
export async function saveRecord(tabla, payload) {
  try {
    const now = new Date().toISOString();
    const record = { ...payload, updated_at: payload.updated_at || now };
    // Modo prueba o sin cliente real: queda solo en local, nunca va a Supabase
    const encolar = !!_supabase && !record.es_prueba;

    // El registro y su entrada en la cola se escriben JUNTOS o no se escribe
    // ninguno. Sueltos, si el celular se quedaba sin espacio (o Android
    // cerraba la app) entre uno y otro, el registro quedaba en el celular
    // para siempre fuera de la cola: nunca subía y nadie se enteraba.
    await db.transaction('rw', db[tabla], db.sync_queue, async () => {
      await db[tabla].put(record);
      if (!encolar) return;
      await _reemplazarPendientes(tabla, [record.id]);
      await db.sync_queue.add({
        tabla,
        operacion: 'UPSERT',
        payload: record,
        sync_pending: 1,
        updated_at: now,
        error_count: 0
      });
    });

    if (_falloGuardado) { _falloGuardado = null; notify(); }
    if (!encolar) return true;

    await updatePendingCount();

    // Intentar sync si hay red, SIN esperarlo: el registro ya quedó a
    // salvo en el celular. Antes se esperaba la subida y, con señal débil,
    // "Guardar y salir" (29 respuestas seguidas) dejaba la pantalla
    // congelada varios minutos.
    if (navigator.onLine) {
      syncQueue();
    }
    return true;
  } catch (e) {
    console.error('[sync] Error en saveRecord:', e);
    registrarFalloGuardado(e);
    return false;
  }
}

/**
 * Elimina un registro: IndexedDB primero, luego encola DELETE.
 * @returns {Promise<boolean>} true si quedó borrado en el celular
 */
export async function deleteRecord(tabla, id) {
  return deleteRecordBulk(tabla, [id]);
}

export async function deleteRecordBulk(tabla, ids) {
  if (!ids || ids.length === 0) return true;
  try {
    const now = new Date().toISOString();
    // En modo prueba el borrado se queda en el celular. Antes también se
    // encolaba, y como los datos de prueba conservan los identificadores de
    // los registros reales, al entrar después una cuenta real en ese mismo
    // celular la orden de borrado salía hacia el servidor: con la cuenta de
    // administrador borraba de verdad (y sin respaldo) el registro real.
    const encolar = !!_supabase;
    await db.transaction('rw', db[tabla], db.sync_queue, async () => {
      await db[tabla].bulkDelete(ids);
      // Un cambio pendiente de un registro que se acaba de borrar ya no debe
      // subir: lo volvería a crear en el servidor.
      await _reemplazarPendientes(tabla, ids);
      if (!encolar) return;
      await db.sync_queue.bulkAdd(ids.map(id => ({
        tabla,
        operacion: 'DELETE',
        payload: { id },
        sync_pending: 1,
        updated_at: now,
        error_count: 0
      })));
    });
    await updatePendingCount();
    if (navigator.onLine && _supabase) {
      syncQueue();
    }
    return true;
  } catch (e) {
    console.error('[sync] Error en deleteRecord:', e);
    registrarFalloGuardado(e);
    return false;
  }
}

// ─── Cola de sincronización ───────────────────────────────

async function updatePendingCount() {
  try {
    // Solo contar los que no han superado el límite de reintentos
    _pendingCount = await db.sync_queue
      .where('sync_pending').equals(1)
      .and(item => (item.error_count || 0) < 5)
      .count();

    // Los que superan el límite NO se borran: se conservan y se reportan
    // para que el usuario sepa que hay datos sin subir.
    const fallidos = await db.sync_queue
      .where('sync_pending').equals(1)
      .and(item => (item.error_count || 0) >= 5)
      .toArray();
    _failedCount = fallidos.length;

    // Motivos agrupados (sin el detalle crudo tras el "·"), para que el
    // banner diga "29× Ya existe en el servidor" en vez de un solo error suelto.
    const porMotivo = {};
    for (const f of fallidos) {
      const texto = String(f.ultimo_error || 'Sin motivo registrado').split(' · ')[0].slice(0, 120);
      porMotivo[texto] = (porMotivo[texto] || 0) + 1;
    }
    _failedReasons = Object.entries(porMotivo)
      .map(([texto, n]) => ({ texto, n }))
      .sort((a, b) => b.n - a.n)
      .slice(0, 4);

    if (_pendingCount === 0 && _failedCount === 0) _lastError = null;

    notify();
  } catch (e) { /* silent */ }
}

/**
 * Reintenta los items que agotaron sus reintentos (resetea su contador).
 * Es la acción explícita del usuario: también da otra oportunidad a los
 * marcados como permanentes, por si el servidor ya se corrigió.
 */
export async function retryFailed() {
  try {
    await db.sync_queue
      .where('sync_pending').equals(1)
      .and(item => (item.error_count || 0) >= 5)
      .modify({ error_count: 0, permanente: 0 });
    await updatePendingCount();
    return syncQueue();
  } catch (e) {
    console.error('[sync] Error en retryFailed:', e);
  }
}

/**
 * Descarta los cambios que el servidor rechazó y que ya no van a subir.
 * Solo se llama desde el banner, tras confirmación del usuario. Los datos
 * siguen en IndexedDB (esto borra la ENTRADA de la cola, no el registro
 * local), así que la pantalla del técnico no cambia.
 * @returns {Promise<number>} cuántas entradas se descartaron
 */
export async function descartarFallidos() {
  try {
    const fallidos = await db.sync_queue
      .where('sync_pending').equals(1)
      .and(item => (item.error_count || 0) >= 5)
      .toArray();
    await db.sync_queue.bulkDelete(fallidos.map(f => f.localId));
    await updatePendingCount();
    return fallidos.length;
  } catch (e) {
    console.error('[sync] Error en descartarFallidos:', e);
    return 0;
  }
}

/**
 * Al abrir la app, dar otra oportunidad a lo que agoto sus reintentos.
 *
 * Un cambio puede haber fallado por algo que ya se corrigio del lado del
 * servidor (un permiso, una columna que faltaba). Sin esto, esas filas quedan
 * excluidas de la cola para siempre y el unico camino es que el usuario
 * encuentre el boton "Reintentar" en la franja ambar — que no es evidente y
 * que se confunde con "Sincronizar ahora", el cual NO las toca.
 */
async function _rehabilitarFallidosUnaVez() {
  if (_yaRehabilitado) return;
  _yaRehabilitado = true;
  try {
    // Los marcados como permanentes (duplicado, padre borrado, columna
    // desconocida) no se rehabilitan solos: volverían a fallar en cada
    // apertura. Para esos está el botón Reintentar, que sí los incluye.
    await db.sync_queue
      .where('sync_pending').equals(1)
      .and(item => (item.error_count || 0) >= 5 && !item.permanente)
      .modify({ error_count: 0 });
  } catch (e) { /* si falla, la cola sigue como estaba */ }
}

export function syncQueue() {
  if (!navigator.onLine || !_supabase) return Promise.resolve();
  // Si ya hay una sincronización en curso, devolver esa misma promesa
  // para que los llamadores que hacen `await syncQueue()` esperen de verdad.
  if (_syncPromise) return _syncPromise;
  _syncPromise = _runSyncQueue().finally(() => { _syncPromise = null; });
  return _syncPromise;
}

async function _runSyncQueue() {
  _isSyncing = true;
  notify();

  try {
    // La limpieza de la cola al abrir (borrados heredados, cambios
    // reemplazados) va antes que cualquier subida.
    await _colaLista.catch(() => {});
    await refrescarUsuarioActual();
    _colaEnEspera = null;
    // Se corta la corrida si el servidor no responde o la sesión venció:
    // insistir fila por fila solo gasta batería (hasta 25 s por intento).
    let cortar = null;
    let hasMore = true;
    // Tope duro. Cada vuelta debe resolver items; si por algún defecto dejara
    // alguno sin tocar, el bucle giraría para siempre y bloquearía la interfaz.
    // Mejor cortar y reportar que dejar la app inutilizable.
    let vueltas = 0;
    const MAX_VUELTAS = 50;
    // Una sola oportunidad por fila en cada corrida. Antes, al subir el
    // contador de reintentos, el while volvía a tomar las mismas filas hasta
    // agotarlas: 41 filas malas se convertían en 205 peticiones seguidas, la
    // sincronización no paraba y la interfaz quedaba inservible.
    const yaIntentados = new Set();
    while (hasMore && navigator.onLine && !cortar) {
      if (++vueltas > MAX_VUELTAS) {
        console.error('[sync] Se alcanzó el tope de vueltas; queda trabajo pendiente.');
        break;
      }
      const candidatos = await db.sync_queue
        .where('sync_pending').equals(1)
        .and(item => (item.error_count || 0) < 5 && !yaIntentados.has(item.localId))
        .toArray();
      candidatos.forEach(i => yaIntentados.add(i.localId));

      // Cambios más viejos que lo que el celular ya tiene guardado: no suben
      // (pisarían en el servidor el dato nuevo). Ver _estaSuperado.
      const pending = [];
      for (const item of candidatos) {
        if (await _estaSuperado(item)) {
          await db.sync_queue.update(item.localId, {
            sync_pending: 0, resuelto: 'reemplazado por un cambio más nuevo', ultimo_error: null,
          });
        } else {
          pending.push(item);
        }
      }

      if (pending.length === 0) {
        hasMore = false;
        break;
      }

      // Agrupar por tabla
      const byTable = {};
      for (const item of pending) {
        if (!byTable[item.tabla]) byTable[item.tabla] = { upserts: [], deletes: [] };
        if (item.operacion === 'DELETE') {
          byTable[item.tabla].deletes.push(item);
        } else {
          byTable[item.tabla].upserts.push(item);
        }
      }

      // Las tablas tienen dependencias: una respuesta no puede existir antes
      // que su evaluación, ni una evaluación antes que su productor. Recorrer
      // byTable en el orden que salga hace que las hijas suban primero, la
      // base las rechace por clave foránea y queden atascadas para siempre.
      // Los borrados van al revés: primero las hijas.
      const ORDEN = ['productores', 'evaluaciones', 'respuestas_indicadores',
                     'planes_accion', 'diagnosticos', 'fotos_evidencia', 'reportes_pdf'];
      const posicion = (t) => { const i = ORDEN.indexOf(t); return i === -1 ? ORDEN.length : i; };
      const tablasOrdenadas = Object.keys(byTable).sort((a, b) => posicion(a) - posicion(b));

      for (const tabla of tablasOrdenadas) {
        if (cortar) break;
        const ops = byTable[tabla];
        // ── Batch UPSERT (last-write-wins) ──
        if (ops.upserts.length > 0) {
          // Deduplicar: quedarse con el payload más reciente por ID
          const latestById = {};
          for (const item of ops.upserts) {
            const key = item.payload.id;
            if (!latestById[key] || item.updated_at > latestById[key].updated_at) {
              latestById[key] = item;
            }
          }

          const allItems = Object.values(latestById);
          // Nunca subir registros marcados como prueba a Supabase
          const realItems = allItems.filter(i => !i.payload.es_prueba);
          const testItems = allItems.filter(i => i.payload.es_prueba);

          // Marcar los de prueba como "sincronizados" localmente para limpiar la
          // cola. TODAS las entradas de prueba, no solo la más reciente de cada
          // registro: abajo se saltan y una vieja quedaría pendiente para siempre.
          if (testItems.length > 0 || ops.upserts.some(i => i.payload.es_prueba)) {
            const testQueueIds = ops.upserts.filter(i => i.payload.es_prueba).map(i => i.localId);
            await Promise.all(testQueueIds.map(id => db.sync_queue.update(id, { sync_pending: 0 })));
          }

          if (realItems.length === 0) continue;

          // Se sube en lotes de LOTE_SUBIDA filas. Un solo lote con todo lo
          // pendiente (tres visitas sin señal = más de 100 respuestas) no
          // alcanzaba a subir en 25 s con señal débil, se cortaba y en el
          // siguiente reintento pasaba lo mismo: no subía nunca nada.
          const idsOk = new Set();
          const errorPorId = {};
          const idsSinIntentar = new Set(); // el servidor dejó de responder: quedan como estaban
          for (let desde = 0; desde < realItems.length; desde += LOTE_SUBIDA) {
            const trozo = realItems.slice(desde, desde + LOTE_SUBIDA);
            if (cortar) { trozo.forEach(i => idsSinIntentar.add(i.payload.id)); continue; }

            const { error, status } = await _supabase
              .from(tabla)
              .upsert(trozo.map(i => i.payload), { onConflict: 'id', ignoreDuplicates: false });

            if (!error) {
              trozo.forEach(i => idsOk.add(i.payload.id));
              continue;
            }
            const transitoria = clasificarFallaTransitoria(error, status);
            if (transitoria) {
              // El servidor no respondió (o hay que volver a entrar): no es
              // culpa de ninguna fila. No se suman intentos ni se insiste; lo
              // que falta queda pendiente para el próximo reintento.
              cortar = transitoria;
              trozo.forEach(i => idsSinIntentar.add(i.payload.id));
              continue;
            }

            // El lote va en un solo upsert, así que UNA fila inválida lo tumba
            // entero. Antes se marcaban las N filas como fallidas y reintentar
            // repetía exactamente lo mismo: una cédula con una columna de más
            // dejó 212 cambios atascados durante meses.
            //
            // Ahora se reintenta fila por fila: las buenas pasan y solo la
            // culpable queda marcada, con su error a la vista.
            console.error(`[sync] Error en batch ${tabla}:`, error);
            _lastError = `${tabla}: ${error.message || error}`;
            for (const item of trozo) {
              if (cortar) { idsSinIntentar.add(item.payload.id); continue; }
              const { error: errFila, status: estadoFila } = await _supabase
                .from(tabla)
                .upsert([item.payload], { onConflict: 'id', ignoreDuplicates: false });

              if (!errFila) {
                idsOk.add(item.payload.id);
              } else if (clasificarFallaTransitoria(errFila, estadoFila)) {
                cortar = clasificarFallaTransitoria(errFila, estadoFila);
                idsSinIntentar.add(item.payload.id);
              } else {
                const desc = describirError(errFila);
                errorPorId[item.payload.id] = desc;
                _lastError = `${tabla}: ${desc.texto}`;
              }
            }
          }

          // TODAS las entradas del grupo se resuelven aquí, sin excepción:
          // sincronizada, fallo permanente o contador de reintentos +1, o
          // intacta si el servidor dejó de responder (esas ya están en
          // yaIntentados, así que esta corrida no las vuelve a tomar y termina:
          // ver `cortar`). Si alguna quedara pendiente con el contador intacto
          // SIN estar en yaIntentados, el `while` no terminaría nunca.
          for (const i of ops.upserts) {
            if (i.payload.es_prueba) continue; // ya resueltas arriba
            if (idsOk.has(i.payload.id)) {
              await db.sync_queue.update(i.localId, { sync_pending: 0, ultimo_error: null });
            } else if (idsSinIntentar.has(i.payload.id)) {
              // Sin tocar
            } else {
              const desc = errorPorId[i.payload.id] || describirError({ message: _lastError });
              await marcarFallo(i, desc);
            }
          }
        }

      }

      // Borrados, de hijas a padres
      for (const tabla of [...tablasOrdenadas].reverse()) {
        if (cortar) break;
        const ops = byTable[tabla];
        if (ops.deletes.length > 0) {
          const deleteIds = ops.deletes.map(i => i.payload.id);
          const { error, status } = await _supabase
            .from(tabla)
            .delete()
            .in('id', deleteIds);

          if (!error) {
            await Promise.all(ops.deletes.map(i =>
              db.sync_queue.update(i.localId, { sync_pending: 0, ultimo_error: null })
            ));
          } else if (clasificarFallaTransitoria(error, status)) {
            cortar = clasificarFallaTransitoria(error, status);
          } else {
            // Mismo trato que los upserts: el lote falla entero por una sola
            // fila (p. ej. un productor que aún tiene evaluaciones en el
            // servidor), así que se reintenta de a una, se guarda el motivo
            // real y solo la culpable queda marcada. Antes se subía el
            // contador de todas sin motivo: el banner decía "no se pudieron
            // subir" y nada más, durante semanas.
            console.error(`[sync] Error eliminando ${tabla}:`, error);
            _lastError = `${tabla} (borrar): ${describirError(error).texto}`;
            for (const i of ops.deletes) {
              if (cortar) break;
              const { error: errFila, status: estadoFila } = await _supabase
                .from(tabla)
                .delete()
                .eq('id', i.payload.id);
              if (!errFila) {
                await db.sync_queue.update(i.localId, { sync_pending: 0, ultimo_error: null });
              } else if (clasificarFallaTransitoria(errFila, estadoFila)) {
                cortar = clasificarFallaTransitoria(errFila, estadoFila);
              } else {
                const desc = describirError(errFila);
                _lastError = `${tabla} (borrar): ${desc.texto}`;
                await marcarFallo(i, desc);
              }
            }
          }
        }
      }

      // Limpiar registros sincronizados con más de 24h
      const cutoff = new Date(Date.now() - 24 * 60 * 60 * 1000).toISOString();
      await db.sync_queue
        .where('sync_pending').equals(0)
        .and(item => item.updated_at < cutoff)
        .delete();

      if (!cortar) _lastSyncAt = new Date();
      notify();
    }
    _colaEnEspera = cortar;
  } catch (e) {
    console.error('[sync] Error en syncQueue:', e);
  } finally {
    _isSyncing = false;
    await updatePendingCount();
  }
}

// ─── Descarga inicial ─────────────────────────────────────

/**
 * Baja del servidor lo que este usuario necesita para trabajar sin señal.
 * También la usa "Preparar sin conexión" (lib/data-prefetch.js).
 * @returns {Promise<boolean>} true si terminó sin errores
 */
export async function syncInitialData() {
  if (!navigator.onLine || !_supabase) return false;

  try {
    const { data: { user } } = await _supabase.auth.getUser();
    if (!user) return false;

    // 1. Descargar indicadores (catálogo público)
    // Si el catálogo no baja, la descarga NO terminó bien: sin indicadores no
    // se puede calificar, y antes este error se ignoraba y se decía 'listo'.
    const { data: inds, error: errorInds } = await _supabase.from('indicadores').select('*');
    if (errorInds) throw errorInds;
    if (inds?.length) await db.indicadores.bulkPut(inds);

    // 2. Descargar productores (todos: para abrirlos sin señal e iniciar
    // evaluaciones nuevas)
    const prods = await descargarPaginado(() => _supabase.from('productores').select('*').order('id'));
    await guardarDesdeServidor('productores', prods);

    // Y NADA MÁS, a propósito (decisión de Santiago, 26-sep-2026): en campo
    // basta con la lista de productores y el catálogo. Las evaluaciones
    // pasadas no se bajan al celular; el historial de UN productor se trae
    // al abrirlo con señal (calificacion/nueva), y lo que el técnico captura
    // en este celular ya vive aquí.

    _lastSyncAt = new Date();
    notify();

    console.log(`[sync] Inicial exitosa para ${user.email}: ${prods?.length} productores.`);
    return true;
  } catch (e) {
    console.error('[sync] Error en descarga inicial:', e);
    return false;
  }
}

/**
 * Baja las evaluaciones ENVIADAS (línea base y visitas anteriores, de todos los
 * productores) con sus respuestas, para que "Estado de sostenibilidad" y el
 * historial se vean sin señal. Solo la dispara "Preparar sin conexión", no la
 * apertura de la app: son ~270 evaluaciones y ~7.500 respuestas, unos pocos MB.
 *
 * Depende de la política de lectura `Leer evaluaciones enviadas de todos`
 * (migración 20261019): sin ella un técnico solo recibe lo suyo.
 *
 * @param {(fraccion:number)=>void} [onProgreso] 0..100
 * @returns {Promise<boolean>} true si terminó sin errores
 */
export async function descargarHistorial(onProgreso = () => {}) {
  if (!navigator.onLine || !_supabase) return false;
  try {
    const evals = await descargarPaginado(
      () => _supabase.from('evaluaciones').select('*').eq('estado', 'enviada').order('id')
    );
    await guardarDesdeServidor('evaluaciones', evals);
    onProgreso(40);

    // Solo las respuestas de esas evaluaciones (un admin también ve las de
    // borradores y pruebas, que aquí no hacen falta).
    const ids = new Set(evals.map(e => e.id));
    const resps = await descargarPaginado(
      () => _supabase.from('respuestas_indicadores').select('*').order('id')
    );
    await guardarDesdeServidor('respuestas_indicadores', resps.filter(r => ids.has(r.evaluacion_id)));
    onProgreso(100);

    console.log(`[sync] Historial: ${evals.length} evaluaciones y ${resps.length} respuestas.`);
    return true;
  } catch (e) {
    console.error('[sync] Error descargando el historial:', e);
    return false;
  }
}
