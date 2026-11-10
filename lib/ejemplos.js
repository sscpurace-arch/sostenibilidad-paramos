/**
 * Evaluaciones de EJEMPLO (borradores demo con observaciones_generales =
 * '__DEMO_BORRADOR__', ~28 de 29 indicadores ya calificados).
 *
 * Sirven para mostrar la app en vivo. Quién las ve:
 *   - El ADMINISTRADOR (rol 'admin') siempre: salen como pendientes y, al abrir
 *     el inicio, la app deja guardados 4 ejemplos propios con 28 de 29
 *     indicadores listos para terminar (sembrarEjemplosAdmin).
 *   - Los técnicos nunca, salvo que MOSTRAR_EJEMPLOS_A_TODOS sea true (para una
 *     demo en vivo con cuentas de técnico: cambiar a true, commit + push).
 *
 * Todos son es_prueba: nunca suben a Supabase. Ocultar no borra nada.
 */
import { db } from './db-offline';
import { createClient, getMockSession } from './supabase';

export const MOSTRAR_EJEMPLOS_A_TODOS = false;

const MARCA_DEMO = '__DEMO_BORRADOR__';

/** ¿Esta evaluación es uno de los borradores de ejemplo? */
export function esEjemplo(ev) {
  return ev?.observaciones_generales === MARCA_DEMO;
}

/** ¿El usuario de este celular es administrador? (sirve sin señal: perfil guardado) */
async function esAdminActual() {
  try {
    if (getMockSession()) return false;
    const { data } = await createClient().auth.getUser();
    const uid = data?.user?.id;
    if (!uid) return false;
    const perfil = await db.perfil_tecnico.get(uid);
    return perfil?.rol === 'admin';
  } catch {
    return false;
  }
}

/** Borradores que debe ver este usuario: los reales y, si le toca, los de ejemplo. */
export async function borradoresVisibles() {
  const borradores = await db.evaluaciones.where('estado').equals('borrador').toArray();
  if (MOSTRAR_EJEMPLOS_A_TODOS || await esAdminActual()) return borradores;
  return borradores.filter(ev => !esEjemplo(ev));
}

// Ids fijos: así sembrar es idempotente (no se duplican ni se pisa lo que el
// administrador ya haya avanzado en un ejemplo).
const IDS_EJEMPLOS_ADMIN = [1, 2, 3, 4].map(n => `de000000-0000-4000-8000-00000000000${n}`);
const VALORES = [4, 3, 5, 4, 2, 4, 3, 5, 4, 3, 4, 5, 3, 4];

/**
 * Deja guardados 4 borradores de ejemplo con todos los indicadores calificados
 * menos el último, para que el administrador los termine en vivo. Solo corre
 * para el admin; no hace nada si ya existen.
 */
export async function sembrarEjemplosAdmin(perfil) {
  try {
    if (perfil?.rol !== 'admin' || !perfil?.id) return;

    const existentes = await db.evaluaciones.bulkGet(IDS_EJEMPLOS_ADMIN);
    const faltan = IDS_EJEMPLOS_ADMIN.filter((_, i) => !existentes[i]);
    if (faltan.length === 0) return;

    const [productores, borradores, indicadores] = await Promise.all([
      db.productores.toArray(),
      db.evaluaciones.where('estado').equals('borrador').toArray(),
      db.indicadores.toArray(),
    ]);
    if (productores.length === 0 || indicadores.length < 2) return;

    // Productores que aún no tienen un borrador en curso, en orden estable
    const ocupados = new Set(borradores.map(b => b.finca_id));
    const libres = productores
      .filter(p => !ocupados.has(p.id))
      .sort((a, b) => String(a.id).localeCompare(String(b.id)));

    // Se califican todos los indicadores menos el último (queda libre para terminar)
    const ids = indicadores.map(i => i.id).sort((a, b) => a - b);
    const calificados = ids.slice(0, -1);

    const ahora = new Date().toISOString();
    const evals = [];
    const respuestas = [];
    faltan.forEach((evalId, n) => {
      const productor = libres[n];
      if (!productor) return;
      evals.push({
        id: evalId,
        finca_id: productor.id,
        tecnico_id: perfil.id,
        estado: 'borrador',
        fecha: ahora,
        observaciones_generales: MARCA_DEMO,
        es_prueba: true,
        created_at: ahora,
        updated_at: ahora,
      });
      calificados.forEach((indId, k) => {
        respuestas.push({
          id: `${evalId}-r${indId}`,
          evaluacion_id: evalId,
          indicador_id: indId,
          valor: VALORES[(k + n * 3) % VALORES.length],
          observacion: null,
          es_prueba: true,
          updated_at: ahora,
        });
      });
    });

    if (evals.length) {
      await db.evaluaciones.bulkPut(evals);
      await db.respuestas_indicadores.bulkPut(respuestas);
    }
  } catch (e) {
    console.error('[ejemplos] No se pudieron preparar los ejemplos del administrador:', e);
  }
}
