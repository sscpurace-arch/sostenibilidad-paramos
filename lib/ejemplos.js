/**
 * Interruptor de las evaluaciones de EJEMPLO (las 10 borradores demo con
 * observaciones_generales = '__DEMO_BORRADOR__', ~28/29 indicadores).
 *
 * Sirven para mostrar la app en vivo, pero en trabajo de campo real estorban:
 * salían como "pendientes" en el inicio, en la barra y en En Proceso.
 *
 *   MOSTRAR_EJEMPLOS = false → ocultos (los datos siguen guardados: seed-data.json,
 *                              seed-demo.json y el celular; no se borra nada).
 *   MOSTRAR_EJEMPLOS = true  → se ven otra vez, como antes.
 *
 * Para prenderlos: cambiar a true, commit + push (Vercel despliega) y abrir la app.
 */
import { db } from './db-offline';

export const MOSTRAR_EJEMPLOS = false;

const MARCA_DEMO = '__DEMO_BORRADOR__';

/** ¿Esta evaluación es uno de los borradores de ejemplo? */
export function esEjemplo(ev) {
  return ev?.observaciones_generales === MARCA_DEMO;
}

/** Borradores reales del celular; los de ejemplo solo si el interruptor está prendido. */
export async function borradoresVisibles() {
  const borradores = await db.evaluaciones.where('estado').equals('borrador').toArray();
  return MOSTRAR_EJEMPLOS ? borradores : borradores.filter(ev => !esEjemplo(ev));
}
