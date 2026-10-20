/**
 * Qué falta por generar de las evaluaciones ya enviadas.
 *
 * Una evaluación enviada sin señal queda cerrada, pero su diagnóstico con IA y
 * su plan de acción necesitan internet. Hasta ahora no había forma clara de ver
 * que eso faltaba (prueba de campo, 20-oct-2026): esta lista alimenta el aviso
 * de la barra, la pestaña «Pendientes» y el historial del perfil del productor.
 *
 * Todo sale de lo guardado en el celular, así que funciona sin señal.
 */
import { db } from './db-offline';
import { createClient, getMockSession, MOCK_USER } from './supabase';

// Más atrás no se avisa (histórico viejo).
export const DIAS_PENDIENTES = 60;

/** Id del usuario de este celular (sirve sin señal: ver lib/supabase.js). */
export async function usuarioActualId() {
  try {
    if (getMockSession()) return MOCK_USER.id;
    const { data } = await createClient().auth.getUser();
    return data?.user?.id || null;
  } catch {
    return null;
  }
}

/**
 * Para cada evaluación, si ya tiene diagnóstico con IA y si ya tiene plan de
 * acción en este celular. @returns {Promise<Record<string,{diagnostico:boolean, plan:boolean}>>}
 */
export async function estadoIAde(evalIds) {
  const ids = new Set(evalIds);
  const [diags, planes] = await Promise.all([
    db.diagnosticos.toArray(),
    db.planes_accion.toArray(),
  ]);
  const conDiag = new Set(diags.map(d => d.evaluacion_id).filter(id => ids.has(id)));
  const conPlan = new Set(planes.map(p => p.evaluacion_id).filter(id => ids.has(id)));
  const out = {};
  for (const id of ids) out[id] = { diagnostico: conDiag.has(id), plan: conPlan.has(id) };
  return out;
}

/**
 * Evaluaciones ENVIADAS de este usuario (últimos DIAS_PENDIENTES días) a las que
 * todavía les falta el diagnóstico con IA o el plan de acción.
 * @returns {Promise<Array<{ev:object, sinDiagnostico:boolean, sinPlan:boolean}>>}
 */
export async function pendientesDeIA(uid) {
  if (!uid) return [];
  const desde = Date.now() - DIAS_PENDIENTES * 24 * 60 * 60 * 1000;
  const enviadas = await db.evaluaciones
    .where('estado').equals('enviada')
    .and(e => e.tecnico_id === uid && new Date(e.fecha).getTime() >= desde)
    .toArray();
  if (enviadas.length === 0) return [];

  const estado = await estadoIAde(enviadas.map(e => e.id));
  return enviadas
    .map(ev => ({ ev, sinDiagnostico: !estado[ev.id].diagnostico, sinPlan: !estado[ev.id].plan }))
    .filter(x => x.sinDiagnostico || x.sinPlan)
    .sort((a, b) => String(b.ev.fecha).localeCompare(String(a.ev.fecha)));
}

/** Cuántas cosas esperan al técnico: borradores sin enviar + enviadas sin IA/plan. */
export async function contarPendientes() {
  try {
    const uid = await usuarioActualId();
    const borradores = await db.evaluaciones.where('estado').equals('borrador').count();
    const sinIA = (await pendientesDeIA(uid)).length;
    return borradores + sinIA;
  } catch {
    return 0;
  }
}
