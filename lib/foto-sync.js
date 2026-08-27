/**
 * foto-sync — registro fotográfico de evidencia, offline-first.
 *
 * Canal SEPARADO del sync-engine, a propósito. `_runSyncQueue` es un bucle
 * homogéneo: agrupa por tabla y hace `from(tabla).upsert(lote)`. Subir a
 * Storage es otra API — sin batching, sin onConflict, con errores distintos y
 * que además debe ser secuencial (12 subidas en paralelo sobre 3G rural fallan
 * todas). Meterla ahí obligaría a ramificar el corazón del motor de sync.
 *
 * Aquí no se modifica ni una línea de sync-engine: solo se le pide el cliente
 * con getClient() y, cuando el binario ya está arriba, se le entrega la fila de
 * metadata con saveRecord() — que es un upsert normal y viaja por la cola de
 * siempre.
 *
 * Flujo:
 *   capturar -> comprimir -> Dexie (blob + thumb)   [ya visible offline]
 *     -> cuando hay señal: storage.upload(blob)
 *       -> solo si devolvió OK: saveRecord('fotos_evidencia', {...})
 *
 * El orden importa: la fila remota nunca se encola antes de que el objeto
 * exista en Storage, así nunca queda una ruta rota apuntando a la nada.
 */

import { db } from '@/lib/db-offline';
import { getClient, saveRecord } from '@/lib/sync-engine';
import { comprimirFoto, obtenerUbicacion } from '@/lib/foto-utils';

const BUCKET = 'evidencias';
const MAX_INTENTOS = 5;

// Estados de `subida` (entero: IndexedDB no indexa booleanos)
export const PENDIENTE = 0;
export const SUBIDA = 1;
export const OMITIDA = 2;   // modo prueba: nunca debe llegar al servidor
export const FALLIDA = 3;   // agotó reintentos o fallo permanente

let _subiendo = false;
let _promesaSubida = null;
let _listeners = new Set();
let _iniciado = false;

// ---------------------------------------------------------------------------
// Estado observable
// ---------------------------------------------------------------------------

async function contar() {
  const [pendientes, fallidas] = await Promise.all([
    db.fotos_evidencia.where('subida').equals(PENDIENTE).count(),
    db.fotos_evidencia.where('subida').equals(FALLIDA).count(),
  ]);
  return { pendientes, fallidas };
}

async function notificar() {
  let estado;
  try {
    estado = { subiendo: _subiendo, ...(await contar()) };
  } catch (e) {
    estado = { subiendo: _subiendo, pendientes: 0, fallidas: 0 };
  }
  _listeners.forEach(fn => { try { fn(estado); } catch (e) {} });
}

export function subscribeFotos(fn) {
  _listeners.add(fn);
  contar().then(c => fn({ subiendo: _subiendo, ...c })).catch(() => {});
  return () => _listeners.delete(fn);
}

// ---------------------------------------------------------------------------
// Escritura local
// ---------------------------------------------------------------------------

/**
 * Guarda una foto: comprime, saca ubicación y la deja en IndexedDB.
 *
 * Retorna la metadata. La foto ya es visible y utilizable en este punto — la
 * subida es un detalle posterior que puede tardar días si no hay señal.
 *
 * `es_prueba` se copia AL CREAR, no se lee después desde `evaluaciones`: la
 * evaluación de prueba puede haberse borrado para cuando toque subir.
 */
export async function guardarFoto({
  evaluacionId,
  indicadorId = null,
  tipo = 'indicador',
  tecnicoId,
  esPrueba = false,
  file,
  nota = null,
}) {
  const { blob, thumb, ancho, alto, bytes } = await comprimirFoto(file);
  const ubicacion = await obtenerUbicacion();

  const id = crypto.randomUUID();
  const meta = {
    id,
    evaluacion_id: evaluacionId,
    indicador_id: indicadorId,
    tipo,
    storage_path: `${tecnicoId}/${evaluacionId}/${id}.jpg`,
    nota,
    lat: ubicacion.lat,
    lng: ubicacion.lng,
    precision_m: ubicacion.precision_m,
    tomada_en: new Date().toISOString(),
    ancho,
    alto,
    bytes,
    tecnico_id: tecnicoId,
    es_prueba: esPrueba,
    subida: esPrueba ? OMITIDA : PENDIENTE,
    error_count: 0,
    updated_at: new Date().toISOString(),
  };

  await db.transaction('rw', db.fotos_evidencia, db.fotos_blobs, async () => {
    await db.fotos_blobs.put({ id, blob, thumb });
    await db.fotos_evidencia.put(meta);
  });

  notificar();
  if (!esPrueba && typeof navigator !== 'undefined' && navigator.onLine) syncFotos();

  return meta;
}

/** Solo una panorámica por visita: si ya había, la reemplaza. */
export async function guardarPanoramica(args) {
  const previas = await db.fotos_evidencia
    .where('evaluacion_id').equals(args.evaluacionId)
    .filter(f => f.tipo === 'panoramica')
    .toArray();

  const nueva = await guardarFoto({ ...args, tipo: 'panoramica', indicadorId: null });
  for (const p of previas) await eliminarFoto(p.id);
  return nueva;
}

export async function eliminarFoto(fotoId) {
  const meta = await db.fotos_evidencia.get(fotoId);

  await db.transaction('rw', db.fotos_evidencia, db.fotos_blobs, async () => {
    await db.fotos_blobs.delete(fotoId);
    await db.fotos_evidencia.delete(fotoId);
  });

  // Si ya estaba en el servidor, hay que borrarla también allá.
  // Si nunca subió, no hay nada que borrar remotamente.
  if (meta && meta.subida === SUBIDA && !meta.es_prueba) {
    const supabase = getClient();
    if (supabase) {
      try {
        await supabase.storage.from(BUCKET).remove([meta.storage_path]);
        await supabase.from('fotos_evidencia').delete().eq('id', fotoId);
      } catch (e) { /* el trigger de huérfanos deja el rastro para limpiar después */ }
    }
  }

  notificar();
}

/** Borra en cascada todas las fotos de una evaluación (Dexie no tiene FK). */
export async function eliminarFotosDeEvaluacion(evaluacionId) {
  const fotos = await db.fotos_evidencia.where('evaluacion_id').equals(evaluacionId).toArray();
  for (const f of fotos) await eliminarFoto(f.id);
}

// ---------------------------------------------------------------------------
// Lectura
// ---------------------------------------------------------------------------

/** Metadata de todas las fotos de una evaluación, agrupada por indicador. */
export async function listarFotosPorEvaluacion(evaluacionId) {
  const fotos = await db.fotos_evidencia.where('evaluacion_id').equals(evaluacionId).toArray();
  const porIndicador = {};
  let panoramica = null;

  for (const f of fotos) {
    if (f.tipo === 'panoramica') { panoramica = f; continue; }
    if (!porIndicador[f.indicador_id]) porIndicador[f.indicador_id] = [];
    porIndicador[f.indicador_id].push(f);
  }
  for (const k of Object.keys(porIndicador)) {
    porIndicador[k].sort((a, b) => (a.tomada_en < b.tomada_en ? -1 : 1));
  }
  return { porIndicador, panoramica };
}

/** Blob de la miniatura (o del full si no hay thumb). */
export async function obtenerThumb(fotoId) {
  const b = await db.fotos_blobs.get(fotoId);
  return (b && (b.thumb || b.blob)) || null;
}

/**
 * Blob de la foto completa. Si el local ya se purgó pero está en el servidor,
 * la baja con un signed URL.
 */
export async function obtenerFotoCompleta(fotoId) {
  const b = await db.fotos_blobs.get(fotoId);
  if (b && b.blob) return b.blob;

  const meta = await db.fotos_evidencia.get(fotoId);
  const supabase = getClient();
  if (!meta || meta.subida !== SUBIDA || !supabase) return (b && b.thumb) || null;

  try {
    const { data, error } = await supabase.storage.from(BUCKET).download(meta.storage_path);
    if (error) throw error;
    return data;
  } catch (e) {
    return (b && b.thumb) || null;
  }
}

// ---------------------------------------------------------------------------
// Subida
// ---------------------------------------------------------------------------

/**
 * ¿El error impide reintentar? Un archivo inválido o un path mal formado va a
 * fallar igual las 5 veces; solo gasta batería y datos del técnico.
 */
function esFalloPermanente(error) {
  const bruto = (error && (error.statusCode !== undefined ? error.statusCode : error.status));
  const n = typeof bruto === 'string' ? parseInt(bruto, 10) : bruto;
  return n === 400 || n === 401 || n === 403 || n === 413 || n === 415;
}

async function _subirPendientes() {
  const supabase = getClient();
  if (!supabase) return;              // modo prueba: no hay a dónde subir
  if (typeof navigator !== 'undefined' && !navigator.onLine) return;

  const pendientes = await db.fotos_evidencia
    .where('subida').equals(PENDIENTE)
    .filter(f => !f.es_prueba && (f.error_count || 0) < MAX_INTENTOS)
    .toArray();

  if (pendientes.length === 0) return;

  _subiendo = true;
  notificar();

  // SECUENCIAL a propósito: en una red rural, 12 subidas en paralelo se
  // estorban y fallan todas juntas. Una a la vez tarda más pero termina.
  for (const meta of pendientes) {
    const binario = await db.fotos_blobs.get(meta.id);
    if (!binario || !binario.blob) {
      // Sin blob no hay nada que subir; la metadata quedó huérfana
      await db.fotos_evidencia.update(meta.id, { subida: FALLIDA });
      continue;
    }

    try {
      const { error } = await supabase.storage
        .from(BUCKET)
        .upload(meta.storage_path, binario.blob, {
          contentType: 'image/jpeg',
          // upsert: si un intento anterior se cortó por timeout pero en
          // realidad sí llegó, el reintento no debe morir con un 409
          upsert: true,
        });
      if (error) throw error;

      // El binario ya está arriba: recién ahora se encola la metadata, para que
      // nunca exista una fila en Postgres apuntando a un objeto inexistente.
      //
      // El payload lleva SOLO columnas que existen en Postgres: `subida`,
      // `error_count` y `purgada` son estado local y harían fallar el upsert.
      await saveRecord('fotos_evidencia', {
        id: meta.id,
        evaluacion_id: meta.evaluacion_id,
        indicador_id: meta.indicador_id,
        tipo: meta.tipo,
        storage_path: meta.storage_path,
        nota: meta.nota,
        lat: meta.lat,
        lng: meta.lng,
        precision_m: meta.precision_m,
        tomada_en: meta.tomada_en,
        ancho: meta.ancho,
        alto: meta.alto,
        bytes: meta.bytes,
        tecnico_id: meta.tecnico_id,
      });

      // saveRecord hace put(), que reemplaza la fila local entera: hay que
      // devolver los campos que solo viven en el celular y que el payload no
      // lleva, o se pierden.
      await db.fotos_evidencia.update(meta.id, {
        subida: SUBIDA,
        error_count: 0,
        es_prueba: meta.es_prueba,
        purgada: meta.purgada || false,
      });
    } catch (e) {
      const permanente = esFalloPermanente(e);
      const intentos = (meta.error_count || 0) + 1;
      await db.fotos_evidencia.update(meta.id, {
        subida: (permanente || intentos >= MAX_INTENTOS) ? FALLIDA : PENDIENTE,
        error_count: intentos,
        ultimo_error: String((e && e.message) || e).slice(0, 200),
      });
      // Si se cayó la red, no tiene sentido seguir con las demás
      if (typeof navigator !== 'undefined' && !navigator.onLine) break;
    }
    notificar();
  }

  _subiendo = false;
  notificar();
}

/** Reentrante: si ya hay una tanda subiendo, devuelve esa misma promesa. */
export function syncFotos() {
  if (_promesaSubida) return _promesaSubida;
  _promesaSubida = _subirPendientes()
    .catch(() => {})
    .then(() => { _promesaSubida = null; });
  return _promesaSubida;
}

/**
 * Vuelve a poner en cola las que agotaron los reintentos.
 * El blob nunca se borró, así que no se perdió ninguna evidencia.
 */
export async function retryFotosFallidas() {
  const fallidas = await db.fotos_evidencia.where('subida').equals(FALLIDA).toArray();
  await Promise.all(
    fallidas.map(f => db.fotos_evidencia.update(f.id, { subida: PENDIENTE, error_count: 0 }))
  );
  notificar();
  return syncFotos();
}

// ---------------------------------------------------------------------------
// Mantenimiento
// ---------------------------------------------------------------------------

/**
 * Libera espacio borrando el binario grande de fotos que ya están a salvo en el
 * servidor, conservando miniatura y metadata. La galería se sigue viendo; el
 * original se recupera con un signed URL cuando haga falta.
 *
 * Solo toca fotos con subida === SUBIDA. Si esa condición se relajara, se
 * perdería evidencia que nunca llegó al servidor.
 */
export async function purgarBlobsSubidos({ diasMinimos = 7 } = {}) {
  const corte = Date.now() - diasMinimos * 24 * 60 * 60 * 1000;
  const candidatas = await db.fotos_evidencia.where('subida').equals(SUBIDA).toArray();

  let liberados = 0;
  for (const meta of candidatas) {
    if (meta.purgada) continue;
    if (new Date(meta.tomada_en).getTime() > corte) continue;

    const evaluacion = await db.evaluaciones.get(meta.evaluacion_id);
    if (!evaluacion || evaluacion.estado !== 'enviada') continue;

    const binario = await db.fotos_blobs.get(meta.id);
    if (!binario || !binario.blob) continue;

    await db.fotos_blobs.put({ id: meta.id, blob: null, thumb: binario.thumb });
    await db.fotos_evidencia.update(meta.id, { purgada: true });
    liberados += meta.bytes || 0;
  }
  return liberados;
}

/** Arranca el listener de reconexión. Idempotente. */
export function initFotoSync() {
  if (_iniciado || typeof window === 'undefined') return;
  _iniciado = true;
  window.addEventListener('online', () => syncFotos());
  if (navigator.onLine) syncFotos();
}
