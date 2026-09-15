/**
 * Sync Engine — Capa de sincronización offline-first
 * 
 * Flujo: IndexedDB primero → intenta Supabase → cola si offline
 * Conflictos: last-write-wins basado en updated_at
 * Auto-sync: reconexión vía window.online event
 */
import { db } from './db-offline';

// Versión de los datos de prueba (seed-data.json).
// SÚBELA (cambia el texto) cada vez que ajustes los datos demo —por ejemplo,
// al agregar o cambiar las calificaciones de ejemplo— para que los dispositivos
// que ya tienen datos viejos vuelvan a cargar los demos sin tener que reinstalar.
const SEED_VERSION = '2026-09-14-hectareas-na';

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

function notify() {
  const state = {
    isSyncing: _isSyncing,
    pendingCount: _pendingCount,
    failedCount: _failedCount,
    failedReasons: _failedReasons,
    seedFailed: _seedFailed,
    lastError: _lastError,
    lastSyncAt: _lastSyncAt,
  };
  _listeners.forEach(fn => { try { fn(state); } catch(e) {} });
}

export function subscribe(fn) {
  _listeners.add(fn);
  return () => _listeners.delete(fn);
}

export function getState() {
  return {
    isSyncing: _isSyncing,
    pendingCount: _pendingCount,
    failedCount: _failedCount,
    failedReasons: _failedReasons,
    seedFailed: _seedFailed,
    lastError: _lastError,
    lastSyncAt: _lastSyncAt,
  };
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
async function importSeedData() {
  // Pedir el archivo FRESCO saltándose la caché del service worker:
  // el query ?v= no coincide con la regla de caché de /seed-data.json,
  // y cache:'no-store' evita la caché HTTP del navegador. Así, al subir
  // SEED_VERSION, los dispositivos descargan el seed nuevo (no el viejo cacheado).
  const url = `/seed-data.json?v=${encodeURIComponent(SEED_VERSION)}`;
  const res = await fetch(url, { cache: 'no-store' });
  if (!res.ok) throw new Error('No se pudo descargar seed-data.json');
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
      const data = await importSeedData();
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
      await importSeedData();
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
  _rehabilitarFallidosUnaVez().then(() => _limpiarColaHuerfana()).then(() => updatePendingCount());
  _initialized = true;

  if (supabase) {
    // Auto-sync al recuperar conexión (solo en modo real)
    window.addEventListener('online', () => {
      console.log('[sync] Conexión recuperada. Ejecutando syncQueue...');
      syncQueue();
    });
  }

  // Siempre sembrar datos locales; solo sincronizar con Supabase si hay cliente real.
  // isMock = sin cliente Supabase → recarga los datos demo si la versión cambió.
  seedLocalDatabase(!supabase).then(() => {
    if (supabase) {
      syncInitialData().then(() => syncQueue());
    }
  });
  updatePendingCount();
}

// ─── API pública: Escritura ───────────────────────────────

/**
 * Guarda un registro: IndexedDB primero, luego intenta sync.
 * Si no hay conexión, queda en cola con sync_pending = true.
 */
export async function saveRecord(tabla, payload) {
  try {
    const now = new Date().toISOString();
    const record = { ...payload, updated_at: payload.updated_at || now };

    // 1. Escribir en IndexedDB PRIMERO (nunca falla)
    await db[tabla].put(record);

    // 2. Si es modo prueba o no hay cliente real, no encolar para sync
    if (!_supabase || record.es_prueba) {
      return; // Queda solo en local, nunca va a Supabase
    }

    // 3. Encolar para sync
    await db.sync_queue.add({
      tabla,
      operacion: 'UPSERT',
      payload: record,
      sync_pending: 1,
      updated_at: now,
      error_count: 0
    });

    await updatePendingCount();

    // 4. Intentar sync inmediato si hay red
    if (navigator.onLine) {
      await syncQueue();
    }
  } catch (e) {
    console.error('[sync] Error en saveRecord:', e);
  }
}

/**
 * Elimina un registro: IndexedDB primero, luego encola DELETE.
 */
export async function deleteRecord(tabla, id) {
  try {
    // 1. Eliminar de IndexedDB
    await db[tabla].delete(id);

    // 2. Encolar DELETE
    await db.sync_queue.add({
      tabla,
      operacion: 'DELETE',
      payload: { id },
      sync_pending: 1,
      updated_at: new Date().toISOString(),
      error_count: 0
    });

    await updatePendingCount();

    if (navigator.onLine && _supabase) {
      syncQueue();
    }
  } catch (e) {
    console.error('[sync] Error en deleteRecord:', e);
  }
}

export async function deleteRecordBulk(tabla, ids) {
  if (!ids || ids.length === 0) return;
  try {
    await db[tabla].bulkDelete(ids);
    const entries = ids.map(id => ({
      tabla,
      operacion: 'DELETE',
      payload: { id },
      sync_pending: 1,
      updated_at: new Date().toISOString(),
      error_count: 0
    }));
    await db.sync_queue.bulkAdd(entries);
    await updatePendingCount();
    if (navigator.onLine && _supabase) {
      syncQueue();
    }
  } catch (e) {
    console.error('[sync] Error en deleteRecordBulk:', e);
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
    await refrescarUsuarioActual();
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
    while (hasMore && navigator.onLine) {
      if (++vueltas > MAX_VUELTAS) {
        console.error('[sync] Se alcanzó el tope de vueltas; queda trabajo pendiente.');
        break;
      }
      const pending = await db.sync_queue
        .where('sync_pending').equals(1)
        .and(item => (item.error_count || 0) < 5 && !yaIntentados.has(item.localId))
        .toArray();
      pending.forEach(i => yaIntentados.add(i.localId));

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

          // Marcar los de prueba como "sincronizados" localmente para limpiar la cola
          if (testItems.length > 0) {
            const testQueueIds = testItems.map(i => i.localId);
            await Promise.all(testQueueIds.map(id => db.sync_queue.update(id, { sync_pending: 0 })));
          }

          if (realItems.length === 0) continue;

          const payloads = realItems.map(i => i.payload);
          const { error } = await _supabase
            .from(tabla)
            .upsert(payloads, { onConflict: 'id', ignoreDuplicates: false });

          if (!error) {
            // Marcar TODOS los items del grupo como sincronizados
            const queueIds = ops.upserts.map(i => i.localId);
            await Promise.all(queueIds.map(id =>
              db.sync_queue.update(id, { sync_pending: 0 })
            ));
          } else {
            // El lote va en un solo upsert, así que UNA fila inválida lo tumba
            // entero. Antes se marcaban las N filas como fallidas y reintentar
            // repetía exactamente lo mismo: una cédula con una columna de más
            // dejó 212 cambios atascados durante meses.
            //
            // Ahora se reintenta fila por fila: las buenas pasan y solo la
            // culpable queda marcada, con su error a la vista.
            console.error(`[sync] Error en batch ${tabla}:`, error);
            _lastError = `${tabla}: ${error.message || error}`;

            const idsOk = new Set();
            const errorPorId = {};
            for (const item of realItems) {
              const { error: errFila } = await _supabase
                .from(tabla)
                .upsert([item.payload], { onConflict: 'id', ignoreDuplicates: false });

              if (!errFila) {
                idsOk.add(item.payload.id);
              } else {
                const desc = describirError(errFila);
                errorPorId[item.payload.id] = desc;
                _lastError = `${tabla}: ${desc.texto}`;
              }
            }

            // TODAS las entradas del grupo se resuelven aquí, sin excepción:
            // sincronizada, descartada (ya no tiene sentido), fallo permanente
            // o contador de reintentos +1. Si alguna quedara pendiente con el
            // contador intacto, el `while` de arriba la vuelve a tomar en la
            // siguiente vuelta y el bucle no termina nunca — la app se queda
            // girando y la pantalla parpadea.
            for (const i of ops.upserts) {
              if (idsOk.has(i.payload.id)) {
                await db.sync_queue.update(i.localId, { sync_pending: 0, ultimo_error: null });
              } else {
                const desc = errorPorId[i.payload.id] || describirError({ message: _lastError });
                await marcarFallo(i, desc);
              }
            }
          }
        }

      }

      // Borrados, de hijas a padres
      for (const tabla of [...tablasOrdenadas].reverse()) {
        const ops = byTable[tabla];
        if (ops.deletes.length > 0) {
          const deleteIds = ops.deletes.map(i => i.payload.id);
          const { error } = await _supabase
            .from(tabla)
            .delete()
            .in('id', deleteIds);

          if (!error) {
            await Promise.all(ops.deletes.map(i =>
              db.sync_queue.update(i.localId, { sync_pending: 0, ultimo_error: null })
            ));
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
              const { error: errFila } = await _supabase
                .from(tabla)
                .delete()
                .eq('id', i.payload.id);
              if (!errFila) {
                await db.sync_queue.update(i.localId, { sync_pending: 0, ultimo_error: null });
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

      _lastSyncAt = new Date();
      notify();
    }
  } catch (e) {
    console.error('[sync] Error en syncQueue:', e);
  } finally {
    _isSyncing = false;
    await updatePendingCount();
  }
}

// ─── Descarga inicial ─────────────────────────────────────

async function syncInitialData() {
  if (!navigator.onLine || !_supabase) return;

  try {
    const { data: { user } } = await _supabase.auth.getUser();
    if (!user) return;

    // 1. Descargar indicadores (catálogo público)
    const { data: inds } = await _supabase.from('indicadores').select('*');
    if (inds) await db.indicadores.bulkPut(inds);

    // 2. Descargar productores
    const { data: prods } = await _supabase.from('productores').select('*');
    if (prods) await db.productores.bulkPut(prods);

    // 3. Descargar evaluaciones del técnico actual
    const { data: evals } = await _supabase.from('evaluaciones').select('*').eq('tecnico_id', user.id);
    if (evals) {
      await db.evaluaciones.bulkPut(evals);

      // 4. Descargar respuestas de borradores (las enviadas ya vienen en el seed)
      // Solo borradores para evitar URL too long (406) con cientos de IDs
      const borradorIds = evals.filter(e => e.estado === 'borrador').map(e => e.id);
      if (borradorIds.length > 0) {
        const { data: resp } = await _supabase
          .from('respuestas_indicadores')
          .select('*')
          .in('evaluacion_id', borradorIds);
        if (resp) await db.respuestas_indicadores.bulkPut(resp);
      }
    }

    _lastSyncAt = new Date();
    notify();

    console.log(`[sync] Inicial exitosa para técnico ${user.email}: ${prods?.length} productores, ${evals?.length} evaluaciones.`);
  } catch (e) {
    console.error('[sync] Error en descarga inicial:', e);
  }
}
