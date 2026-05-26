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
let _pendingCount = 0;
let _lastSyncAt = null;
let _listeners = new Set();
let _initialized = false;

function notify() {
  const state = { isSyncing: _isSyncing, pendingCount: _pendingCount, lastSyncAt: _lastSyncAt };
  _listeners.forEach(fn => { try { fn(state); } catch(e) {} });
}

export function subscribe(fn) {
  _listeners.add(fn);
  return () => _listeners.delete(fn);
}

export function getState() {
  return { isSyncing: _isSyncing, pendingCount: _pendingCount, lastSyncAt: _lastSyncAt };
}

export async function waitForSync() {
  while (_isSyncing) {
    await new Promise(resolve => setTimeout(resolve, 100));
  }
}

// ─── Inicialización ───────────────────────────────────────
export function initSyncEngine(supabase) {
  if (_initialized) return;
  _supabase = supabase;
  _initialized = true;

  // Auto-sync al recuperar conexión
  window.addEventListener('online', () => {
    console.log('[sync] Conexión recuperada. Ejecutando syncQueue...');
    syncQueue();
  });

  // Descarga inicial + flush de cola pendiente
  syncInitialData().then(() => syncQueue());
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

    // 2. Encolar para sync
    await db.sync_queue.add({
      tabla,
      operacion: 'UPSERT',
      payload: record,
      sync_pending: 1,
      updated_at: now,
      error_count: 0
    });

    await updatePendingCount();

    // 3. Intentar sync inmediato si hay red
    if (navigator.onLine && _supabase) {
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
      
    // Limpieza automática de tareas trabadas permanentemente (>= 5 errores)
    await db.sync_queue
      .where('sync_pending').equals(1)
      .and(item => (item.error_count || 0) >= 5)
      .delete();
      
    notify();
  } catch (e) { /* silent */ }
}

export async function syncQueue() {
  if (_isSyncing || !navigator.onLine || !_supabase) return;

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

          const payloads = Object.values(latestById).map(i => i.payload);
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
    const [
      { data: inds },
      { data: prods },
      { data: evals },
      { data: resp }
    ] = await Promise.all([
      _supabase.from('indicadores').select('*'),
      _supabase.from('productores').select('*'),
      _supabase.from('evaluaciones').select('*'),
      _supabase.from('respuestas_indicadores').select('*')
    ]);

    if (inds) await db.indicadores.bulkPut(inds);
    if (prods) await db.productores.bulkPut(prods);
    if (evals) await db.evaluaciones.bulkPut(evals);
    if (resp) await db.respuestas_indicadores.bulkPut(resp);

    _lastSyncAt = new Date();
    notify();

    console.log(`[sync] Inicial: ${prods?.length} productores, ${evals?.length} evaluaciones, ${resp?.length} respuestas`);
  } catch (e) {
    console.error('[sync] Error en descarga inicial:', e);
  }
}
