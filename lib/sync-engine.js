/**
 * Sync Engine — Capa de sincronización offline-first
 * 
 * Flujo: IndexedDB primero → intenta Supabase → cola si offline
 * Conflictos: last-write-wins basado en updated_at
 * Auto-sync: reconexión vía window.online event
 */
import { db } from './db-offline';

// ─── Estado interno ───────────────────────────────────────
let _supabase = null;
let _isSyncing = false;
let _syncPromise = null;
let _pendingCount = 0;
let _failedCount = 0;
let _seedFailed = false;
let _lastSyncAt = null;
let _listeners = new Set();
let _initialized = false;

function notify() {
  const state = {
    isSyncing: _isSyncing,
    pendingCount: _pendingCount,
    failedCount: _failedCount,
    seedFailed: _seedFailed,
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
    seedFailed: _seedFailed,
    lastSyncAt: _lastSyncAt,
  };
}

export async function waitForSync() {
  if (_syncPromise) await _syncPromise;
}

// Función para sembrar IndexedDB con seed-data.json local si está vacío
async function seedLocalDatabase() {
  try {
    const count = await db.productores.count();
    if (count > 0) {
      console.log('[sync] Base de datos local ya tiene productores. Omitiendo seed.');
      return;
    }
    console.log('[sync] Base de datos vacía. Cargando datos de prueba desde seed-data.json...');
    const res = await fetch('/seed-data.json');
    if (!res.ok) throw new Error('No se pudo descargar seed-data.json');
    const data = await res.json();
    
    if (data.indicadores && data.indicadores.length > 0) {
      await db.indicadores.bulkPut(data.indicadores);
    }
    if (data.productores && data.productores.length > 0) {
      await db.productores.bulkPut(data.productores);
    }
    if (data.evaluaciones && data.evaluaciones.length > 0) {
      await db.evaluaciones.bulkPut(data.evaluaciones);
    }
    if (data.respuestas_indicadores && data.respuestas_indicadores.length > 0) {
      await db.respuestas_indicadores.bulkPut(data.respuestas_indicadores);
    }
    console.log(`[sync] Datos de prueba importados con éxito: ${data.productores?.length} productores.`);
    _seedFailed = false;
    notify();
  } catch (e) {
    console.error('[sync] Error importando datos de prueba:', e);
    // Si la base sigue vacía, avisar a la UI: la app necesita conexión una vez
    try {
      const count = await db.productores.count();
      if (count === 0) { _seedFailed = true; notify(); }
    } catch { /* silent */ }
  }
}

// ─── Inicialización ───────────────────────────────────────
export function initSyncEngine(supabase) {
  if (_initialized) return;
  _supabase = supabase;
  _initialized = true;

  if (supabase) {
    // Auto-sync al recuperar conexión (solo en modo real)
    window.addEventListener('online', () => {
      console.log('[sync] Conexión recuperada. Ejecutando syncQueue...');
      syncQueue();
    });
  }

  // Siempre sembrar datos locales; solo sincronizar con Supabase si hay cliente real
  seedLocalDatabase().then(() => {
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
    _failedCount = await db.sync_queue
      .where('sync_pending').equals(1)
      .and(item => (item.error_count || 0) >= 5)
      .count();

    notify();
  } catch (e) { /* silent */ }
}

/** Reintenta los items que agotaron sus reintentos (resetea su contador). */
export async function retryFailed() {
  try {
    await db.sync_queue
      .where('sync_pending').equals(1)
      .and(item => (item.error_count || 0) >= 5)
      .modify({ error_count: 0 });
    await updatePendingCount();
    return syncQueue();
  } catch (e) {
    console.error('[sync] Error en retryFailed:', e);
  }
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
    let hasMore = true;
    while (hasMore && navigator.onLine) {
      const pending = await db.sync_queue
        .where('sync_pending').equals(1)
        .and(item => (item.error_count || 0) < 5) // Max 5 reintentos
        .toArray();

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

      for (const [tabla, ops] of Object.entries(byTable)) {
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
            console.error(`[sync] Error en batch ${tabla}:`, error);
            await Promise.all(ops.upserts.map(i =>
              db.sync_queue.update(i.localId, { error_count: (i.error_count || 0) + 1 })
            ));
          }
        }

        // ── Batch DELETE ──
        if (ops.deletes.length > 0) {
          const deleteIds = ops.deletes.map(i => i.payload.id);
          const { error } = await _supabase
            .from(tabla)
            .delete()
            .in('id', deleteIds);

          if (!error) {
            await Promise.all(ops.deletes.map(i =>
              db.sync_queue.update(i.localId, { sync_pending: 0 })
            ));
          } else {
            console.error(`[sync] Error eliminando ${tabla}:`, error);
            // Increment error count for deletes so they don't get stuck forever if they fail repeatedly
            await Promise.all(ops.deletes.map(i =>
              db.sync_queue.update(i.localId, { error_count: (i.error_count || 0) + 1 })
            ));
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
