/**
 * Borradores (evaluaciones empezadas y sin enviar) de un técnico.
 *
 * Dos problemas de campo (19-nov-2026):
 *  1. "Iniciar calificación" creaba SIEMPRE una evaluación nueva. Con mala señal
 *     el técnico volvía al perfil, la volvía a iniciar y quedaban 2 o 3 borradores
 *     del mismo productor (uno con 29 respuestas, otros vacíos).
 *  2. Un borrador que estaba en el servidor pero no en ESTE equipo (por ejemplo
 *     empezado en el celular y revisado en el computador) no aparecía en
 *     «Pendientes» ni en el perfil del productor, porque esas pantallas leen
 *     solo lo guardado en el equipo y los borradores no se bajan al abrir la app.
 *
 * Aquí no se borra ni se fusiona nada: solo se TRAEN los borradores propios
 * (sin pisar lo que esté pendiente de subir, ver guardarDesdeServidor) y se
 * AGRUPAN por productor para mostrarlos sin repetir, con el más avanzado primero.
 */
import { db } from './db-offline';
import { createClient, getMockSession } from './supabase';
import { guardarDesdeServidor, deleteRecord, deleteRecordBulk } from './sync-engine';
import { eliminarFotosDeEvaluacion } from './foto-sync';

const TANDA = 20; // 20 evaluaciones × 29 respuestas = 580 filas, bajo el tope de 1.000

const PREFIJO_EJEMPLOS = 'de000000-'; // borradores de ejemplo del admin (lib/ejemplos.js)

function anioDe(fecha) {
  const d = new Date(fecha);
  return Number.isNaN(d.getTime()) ? null : d.getUTCFullYear();
}

/**
 * Regla de Santiago (20-nov-2026): un productor tiene como máximo dos
 * evaluaciones, la línea base y la de 2026. Un borrador REAL cuyo productor ya
 * tiene una evaluación REAL enviada del mismo año es un sobrante: no es algo
 * «en curso» ni «pendiente». `enviadas` = evaluaciones enviadas conocidas.
 */
export function borradorRedundante(borrador, enviadas) {
  if (!borrador || borrador.es_prueba) return false;
  const anio = anioDe(borrador.fecha);
  if (anio == null) return false;
  return enviadas.some(e =>
    e.finca_id === borrador.finca_id && !e.es_prueba && anioDe(e.fecha) === anio);
}

/** Quita de la lista los borradores sobrantes (ver borradorRedundante). */
export async function sinBorradoresRedundantes(borradores) {
  if (!borradores.length) return borradores;
  const enviadas = await db.evaluaciones.where('estado').equals('enviada').toArray();
  return borradores.filter(b => !borradorRedundante(b, enviadas));
}

/** Borra una evaluación (borrador) con todo lo suyo. Sube el borrado al servidor. */
async function borrarBorrador(id) {
  const respIds = (await db.respuestas_indicadores.where('evaluacion_id').equals(id).toArray()).map(r => r.id);
  const planIds = (await db.planes_accion.where('evaluacion_id').equals(id).toArray()).map(p => p.id);
  if (respIds.length && !(await deleteRecordBulk('respuestas_indicadores', respIds))) return false;
  if (planIds.length && !(await deleteRecordBulk('planes_accion', planIds))) return false;
  await eliminarFotosDeEvaluacion(id);
  return deleteRecord('evaluaciones', id);
}

/**
 * Trae del servidor los borradores REALES de este técnico (todos, o solo los de
 * un productor) con sus respuestas y los guarda en el equipo. De paso deja el
 * equipo al día con el servidor:
 *  - copias viejas: un borrador que está en el equipo pero ya no en el servidor
 *    (se borró o se envió desde otro lado) y no tiene nada por subir, se quita
 *    del equipo. Eran las evaluaciones «en curso» que no existían y que dejaban
 *    a un productor con tres.
 *  - sobrantes: un borrador de un productor que ya tiene su evaluación enviada
 *    de ese año se borra (también del servidor).
 * No hace nada sin señal o en modo prueba. @returns {Promise<boolean>} true si
 * cambió algo en el equipo.
 */
export async function traerMisBorradores(uid, productorId = null) {
  try {
    if (!uid || getMockSession()) return false;
    if (typeof navigator !== 'undefined' && !navigator.onLine) return false;

    // Lo pendiente de subir se lee ANTES de preguntar al servidor: si algo se
    // sube justo mientras tanto, ya figuraba aquí y no se confunde con sobrante.
    const enCola = await db.sync_queue.where('sync_pending').equals(1).toArray();
    const protegidos = new Set();
    for (const item of enCola) {
      if (item.payload?.id) protegidos.add(item.payload.id);
      if (item.payload?.evaluacion_id) protegidos.add(item.payload.evaluacion_id);
    }

    const supabase = createClient();
    let consulta = supabase
      .from('evaluaciones').select('*')
      .eq('tecnico_id', uid).eq('estado', 'borrador').eq('es_prueba', false);
    if (productorId) consulta = consulta.eq('finca_id', productorId);

    const { data: evals, error } = await consulta;
    if (error || !evals) return false;
    let cambio = false;

    // 1. Copias viejas en el equipo
    const enServidor = new Set(evals.map(e => e.id));
    const locales = await db.evaluaciones
      .where('estado').equals('borrador')
      .and(e => e.tecnico_id === uid && !e.es_prueba && !String(e.id).startsWith(PREFIJO_EJEMPLOS)
        && (!productorId || e.finca_id === productorId))
      .toArray();
    const dudosas = locales.filter(ev => !enServidor.has(ev.id) && !protegidos.has(ev.id));
    if (dudosas.length) {
      // Solo se quita lo que NO existe en el servidor en ningún estado: un
      // borrador enviado desde otro equipo sigue existiendo (como enviada) y
      // su copia local no es una copia vieja.
      const { data: existentes, error: errEx } = await supabase
        .from('evaluaciones').select('id').in('id', dudosas.map(e => e.id));
      if (!errEx) {
        const existen = new Set((existentes || []).map(e => e.id));
        for (const ev of dudosas) {
          if (existen.has(ev.id)) continue;
          // Solo del equipo: no hay nada que borrar en el servidor ni en Storage
          const fotos = await db.fotos_evidencia.where('evaluacion_id').equals(ev.id).toArray();
          if (fotos.length) await db.fotos_blobs.bulkDelete(fotos.map(f => f.id));
          await db.fotos_evidencia.where('evaluacion_id').equals(ev.id).delete();
          await db.respuestas_indicadores.where('evaluacion_id').equals(ev.id).delete();
          await db.evaluaciones.delete(ev.id);
          cambio = true;
        }
      }
    }

    if (evals.length === 0) return cambio;

    // 2. Sobrantes: ya hay una enviada real de ese año
    const productores = [...new Set(evals.map(e => e.finca_id))];
    const { data: enviadasSrv, error: errEnv } = await supabase
      .from('evaluaciones').select('finca_id, fecha, es_prueba')
      .eq('estado', 'enviada').eq('es_prueba', false).in('finca_id', productores);
    const vigentes = [];
    if (errEnv) {
      vigentes.push(...evals); // sin saber si hay enviada, no se borra nada
    } else {
      const enviadasLocal = await db.evaluaciones.where('estado').equals('enviada').toArray();
      const enviadas = [...(enviadasSrv || []), ...enviadasLocal];
      for (const ev of evals) {
        if (!borradorRedundante(ev, enviadas)) { vigentes.push(ev); continue; }
        if (protegidos.has(ev.id)) { vigentes.push(ev); continue; } // tiene cambios sin subir: no se toca
        if (await borrarBorrador(ev.id)) cambio = true; else vigentes.push(ev);
      }
    }

    // 3. Guardar el resto
    if (vigentes.length === 0) return cambio;
    await guardarDesdeServidor('evaluaciones', vigentes);
    for (let i = 0; i < vigentes.length; i += TANDA) {
      const ids = vigentes.slice(i, i + TANDA).map(e => e.id);
      const { data: respuestas, error: errResp } = await supabase
        .from('respuestas_indicadores').select('*').in('evaluacion_id', ids);
      if (errResp) continue; // lo que no baje ahora baja la próxima vez
      if (respuestas?.length) await guardarDesdeServidor('respuestas_indicadores', respuestas);
    }
    return true;
  } catch (e) {
    console.error('[borradores] No se pudieron traer los borradores del servidor:', e);
    return false;
  }
}

/** Cuántas respuestas tiene cada evaluación en este equipo. @returns {Promise<Map<string,number>>} */
export async function contarRespuestas(evalIds) {
  const cuentas = new Map();
  await Promise.all(evalIds.map(async id => {
    cuentas.set(id, await db.respuestas_indicadores.where('evaluacion_id').equals(id).count());
  }));
  return cuentas;
}

/** El de más avance primero; a igual avance, el más reciente. */
function masAvanzadoPrimero(a, b) {
  return (b.respondidos ?? 0) - (a.respondidos ?? 0)
    || String(b.fecha || '').localeCompare(String(a.fecha || ''));
}

/**
 * Agrupa borradores por productor. Cada elemento de `items` debe traer
 * { id, finca_id, fecha, respondidos }.
 * @returns {Array<{ finca_id:string, principal:object, otros:object[] }>} los
 *   grupos más recientes primero.
 */
export function agruparPorProductor(items) {
  const porProductor = new Map();
  for (const it of items) {
    if (!porProductor.has(it.finca_id)) porProductor.set(it.finca_id, []);
    porProductor.get(it.finca_id).push(it);
  }
  return [...porProductor.entries()]
    .map(([finca_id, lista]) => {
      const ordenada = [...lista].sort(masAvanzadoPrimero);
      return { finca_id, principal: ordenada[0], otros: ordenada.slice(1) };
    })
    .sort((a, b) => String(b.principal.fecha || '').localeCompare(String(a.principal.fecha || '')));
}
