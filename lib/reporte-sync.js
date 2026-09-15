/**
 * reporte-sync — archivo de los PDF generados (diagnóstico y plan de acción).
 *
 * Canal SEPARADO del sync-engine, calcado de foto-sync.js y por las mismas
 * razones: Storage es otra API (sin batching, sin onConflict, errores
 * distintos) y la subida debe ser secuencial. `_runSyncQueue` no se toca; de
 * él solo se usan getClient() y saveRecord() para la fila de metadata.
 *
 * El TEXTO de ambos documentos ya vive en Postgres (`diagnosticos`,
 * `planes_accion`) — no se duplica. Lo que se archiva es el ARCHIVO tal como
 * se le entregó al productor, para tener historial y analizar después.
 *
 * Flujo:
 *   generar PDF -> Dexie (meta + blob)            [aunque no haya señal]
 *     -> cuando hay señal: storage.upload(blob, upsert)
 *       -> solo si devolvió OK: saveRecord('reportes_pdf', meta)
 *
 * Regenerar reemplaza: mismo path {evaluacion_id}/{tipo}.pdf, misma fila
 * (se reusa el id local para la pareja evaluacion_id+tipo).
 */

import { db } from '@/lib/db-offline';
import { getClient, saveRecord } from '@/lib/sync-engine';

const BUCKET = 'reportes';
const MAX_INTENTOS = 5;

// Estados de `subida` (entero: IndexedDB no indexa booleanos) — iguales a fotos
export const PENDIENTE = 0;
export const SUBIDA = 1;
export const OMITIDA = 2;   // modo prueba: nunca debe llegar al servidor
export const FALLIDA = 3;   // agotó reintentos o fallo permanente

export const TIPOS = ['diagnostico', 'plan_accion'];

let _subiendo = false;
let _promesaSubida = null;
let _iniciado = false;

// ---------------------------------------------------------------------------
// Escritura local
// ---------------------------------------------------------------------------

/**
 * Archiva un PDF recién generado. El binario queda en el celular de
 * inmediato; la subida es posterior y puede tardar hasta que haya señal.
 *
 * @param {Object} args
 * @param {string}  args.evaluacionId
 * @param {'diagnostico'|'plan_accion'} args.tipo
 * @param {Blob}    args.blob        salida de doc.output('blob')
 * @param {string}  args.tecnicoId
 * @param {boolean} [args.esPrueba]  copiado al crear, como en fotos
 */
export async function guardarReportePdf({ evaluacionId, tipo, blob, tecnicoId, esPrueba = false }) {
  if (!TIPOS.includes(tipo)) throw new Error(`Tipo de reporte desconocido: ${tipo}`);
  if (!evaluacionId || !blob) return null;

  // Regenerar reemplaza: se conserva el id de la pareja evaluación+tipo
  const previo = await db.reportes_pdf
    .where('[evaluacion_id+tipo]').equals([evaluacionId, tipo])
    .first();
  const id = previo?.id || crypto.randomUUID();

  const meta = {
    id,
    evaluacion_id: evaluacionId,
    tipo,
    storage_path: `${evaluacionId}/${tipo}.pdf`,
    generado_en: new Date().toISOString(),
    bytes: blob.size,
    tecnico_id: tecnicoId || previo?.tecnico_id || null,
    es_prueba: esPrueba,
    subida: esPrueba ? OMITIDA : PENDIENTE,
    error_count: 0,
    ultimo_error: null,
    updated_at: new Date().toISOString(),
  };

  await db.transaction('rw', db.reportes_pdf, db.reportes_blobs, async () => {
    await db.reportes_blobs.put({ id, blob });
    await db.reportes_pdf.put(meta);
  });

  if (!esPrueba && typeof navigator !== 'undefined' && navigator.onLine) syncReportes();
  return meta;
}

/** Borra en cascada los reportes de una evaluación (Dexie no tiene FK). */
export async function eliminarReportesDeEvaluacion(evaluacionId) {
  const reportes = await db.reportes_pdf.where('evaluacion_id').equals(evaluacionId).toArray();
  for (const r of reportes) {
    await db.transaction('rw', db.reportes_pdf, db.reportes_blobs, async () => {
      await db.reportes_blobs.delete(r.id);
      await db.reportes_pdf.delete(r.id);
    });
    if (r.subida === SUBIDA && !r.es_prueba) {
      const supabase = getClient();
      if (supabase) {
        try {
          await supabase.storage.from(BUCKET).remove([r.storage_path]);
          await supabase.from('reportes_pdf').delete().eq('id', r.id);
        } catch (e) { /* la fila remota cae por cascade al borrar la evaluación; el objeto queda en storage_huerfanos */ }
      }
    }
  }
}

// ---------------------------------------------------------------------------
// Subida
// ---------------------------------------------------------------------------

function esFalloPermanente(error) {
  const bruto = (error && (error.statusCode !== undefined ? error.statusCode : error.status));
  const n = typeof bruto === 'string' ? parseInt(bruto, 10) : bruto;
  return n === 400 || n === 401 || n === 403 || n === 413 || n === 415;
}

async function _subirPendientes() {
  const supabase = getClient();
  if (!supabase) return;              // modo prueba: no hay a dónde subir
  if (typeof navigator !== 'undefined' && !navigator.onLine) return;

  const pendientes = await db.reportes_pdf
    .where('subida').equals(PENDIENTE)
    .filter(r => !r.es_prueba && (r.error_count || 0) < MAX_INTENTOS)
    .toArray();

  if (pendientes.length === 0) return;

  _subiendo = true;

  // SECUENCIAL a propósito: en una red rural varias subidas en paralelo se
  // estorban y fallan todas juntas.
  for (const meta of pendientes) {
    const binario = await db.reportes_blobs.get(meta.id);
    if (!binario || !binario.blob) {
      await db.reportes_pdf.update(meta.id, { subida: FALLIDA, ultimo_error: 'Sin archivo local' });
      continue;
    }

    try {
      const { error } = await supabase.storage
        .from(BUCKET)
        .upload(meta.storage_path, binario.blob, {
          contentType: 'application/pdf',
          upsert: true, // regenerar reemplaza; y un reintento tras timeout no muere con 409
        });
      if (error) throw error;

      // El binario ya está arriba: recién ahora se encola la metadata.
      // SOLO columnas que existen en Postgres.
      await saveRecord('reportes_pdf', {
        id: meta.id,
        evaluacion_id: meta.evaluacion_id,
        tipo: meta.tipo,
        storage_path: meta.storage_path,
        generado_en: meta.generado_en,
        bytes: meta.bytes,
        tecnico_id: meta.tecnico_id,
      });

      // saveRecord hace put() y reemplaza la fila local: devolver lo que solo
      // vive en el celular.
      await db.reportes_pdf.update(meta.id, {
        subida: SUBIDA,
        error_count: 0,
        ultimo_error: null,
        es_prueba: meta.es_prueba,
      });
    } catch (e) {
      const permanente = esFalloPermanente(e);
      const intentos = (meta.error_count || 0) + 1;
      await db.reportes_pdf.update(meta.id, {
        subida: (permanente || intentos >= MAX_INTENTOS) ? FALLIDA : PENDIENTE,
        error_count: intentos,
        ultimo_error: String((e && e.message) || e).slice(0, 200),
      });
      if (typeof navigator !== 'undefined' && !navigator.onLine) break;
    }
  }

  _subiendo = false;
}

/** Reentrante: si ya hay una tanda subiendo, devuelve esa misma promesa. */
export function syncReportes() {
  if (_promesaSubida) return _promesaSubida;
  _promesaSubida = _subirPendientes()
    .catch(() => {})
    .then(() => { _promesaSubida = null; });
  return _promesaSubida;
}

/** Vuelve a poner en cola los que agotaron los reintentos. */
export async function retryReportesFallidos() {
  const fallidos = await db.reportes_pdf.where('subida').equals(FALLIDA).toArray();
  await Promise.all(
    fallidos.map(r => db.reportes_pdf.update(r.id, { subida: PENDIENTE, error_count: 0 }))
  );
  return syncReportes();
}

export function estaSubiendoReportes() {
  return _subiendo;
}

/** Arranca el listener de reconexión. Idempotente. */
export function initReporteSync() {
  if (_iniciado || typeof window === 'undefined') return;
  _iniciado = true;
  window.addEventListener('online', () => syncReportes());
  if (navigator.onLine) syncReportes();
}
