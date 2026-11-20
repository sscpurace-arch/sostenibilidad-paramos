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
import { guardarDesdeServidor } from './sync-engine';

const TANDA = 20; // 20 evaluaciones × 29 respuestas = 580 filas, bajo el tope de 1.000

/**
 * Trae del servidor los borradores REALES de este técnico (todos, o solo los de
 * un productor) con sus respuestas y los guarda en el equipo. No hace nada sin
 * señal o en modo prueba. @returns {Promise<boolean>} true si guardó algo.
 */
export async function traerMisBorradores(uid, productorId = null) {
  try {
    if (!uid || getMockSession()) return false;
    if (typeof navigator !== 'undefined' && !navigator.onLine) return false;

    const supabase = createClient();
    let consulta = supabase
      .from('evaluaciones').select('*')
      .eq('tecnico_id', uid).eq('estado', 'borrador').eq('es_prueba', false);
    if (productorId) consulta = consulta.eq('finca_id', productorId);

    const { data: evals, error } = await consulta;
    if (error || !evals || evals.length === 0) return false;
    await guardarDesdeServidor('evaluaciones', evals);

    for (let i = 0; i < evals.length; i += TANDA) {
      const ids = evals.slice(i, i + TANDA).map(e => e.id);
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
