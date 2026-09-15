import { z } from 'zod';

/**
 * ¿Este indicador ya quedó resuelto por el evaluador?
 *
 * Dos formas válidas: un puntaje numérico, o "No aplica" (valor null +
 * no_aplica true). Antes bastaba `det.valor` truthy; con N/A eso dejaba el
 * indicador como "sin calificar" y bloqueaba el envío.
 *
 * @param {Object|undefined} det - { valor, no_aplica, ... }
 */
export function estaCalificado(det) {
  if (!det) return false;
  return det.no_aplica === true || typeof det.valor === 'number';
}

/**
 * Promedio de una dimensión, con la regla de N/A: se excluye del
 * denominador. Nunca vale 0 ni 1 — eso hundiría el puntaje del predio sin
 * razón cuando el sistema productivo simplemente no permite medir algo.
 *
 * Devuelve null si ningún indicador de la dimensión tiene puntaje (todos N/A
 * o sin calificar), para que quien lo muestre decida cómo (un "—", no un 0).
 *
 * @param {Array}  indicadores catálogo completo
 * @param {Object} detalles    { [indicadorId]: { valor, no_aplica } }
 * @param {string} dimension   nombre de la dimensión
 * @returns {number|null}
 */
export function promedioDimension(indicadores, detalles, dimension) {
  const puntajes = indicadores
    .filter(i => i.dimension === dimension)
    .map(i => detalles[i.id]?.valor)
    .filter(v => typeof v === 'number');
  if (puntajes.length === 0) return null;
  return puntajes.reduce((a, b) => a + b, 0) / puntajes.length;
}

/**
 * Promedio global = promedio de los promedios por dimensión que sí tienen
 * dato. Una dimensión toda en N/A no entra (misma lógica: no vale 0).
 *
 * @param {Object} promedios { [dimension]: number|null|string }
 * @returns {number|null}
 */
export function promedioGlobal(promedios) {
  const validos = Object.values(promedios)
    .map(v => (typeof v === 'string' ? parseFloat(v) : v))
    .filter(v => typeof v === 'number' && !isNaN(v));
  if (validos.length === 0) return null;
  return validos.reduce((a, b) => a + b, 0) / validos.length;
}

/** Formato de un promedio para pantalla: una decimal, o "—" si no hay dato. */
export function formatoPromedio(valor) {
  return typeof valor === 'number' ? valor.toFixed(1) : '—';
}

/**
 * Genera un schema Zod para validar que TODOS los indicadores estén resueltos
 * (puntaje en rango, o "No aplica"). Se usa al FINALIZAR (enviar).
 *
 * @param {Array} indicadores - Lista de indicadores con { id, nombre, rango_min, rango_max }
 * @returns {{ validate: Function, schema: z.ZodObject }}
 */
export function crearSchemaEvaluacion(indicadores) {
  const shape = {};

  indicadores.forEach(ind => {
    const min = ind.rango_min ?? 1;
    const max = ind.rango_max ?? 5;

    const puntaje = z
      .number({
        required_error: `"${ind.nombre}" es obligatorio`,
        invalid_type_error: `"${ind.nombre}" debe ser un número`
      })
      .int()
      .min(min, `"${ind.nombre}" debe ser al menos ${min}`)
      .max(max, `"${ind.nombre}" no puede superar ${max}`);

    // "No aplica" cuenta como resuelto: valor null con la marca explícita.
    const noAplica = z.object({ no_aplica: z.literal(true) });

    shape[String(ind.id)] = z.union([puntaje, noAplica], {
      error: () => `"${ind.nombre}" es obligatorio`
    });
  });

  const schema = z.object(shape);

  /**
   * Valida los detalles (mapa indicador_id -> { valor, no_aplica })
   * @param {Object} detalles - { [indicadorId]: { valor, observacion, no_aplica } }
   * @returns {{ success: boolean, errors: Object, faltantes: string[] }}
   */
  function validate(detalles) {
    const data = {};
    indicadores.forEach(ind => {
      const det = detalles[ind.id];
      if (det?.no_aplica === true) data[String(ind.id)] = { no_aplica: true };
      else data[String(ind.id)] = det?.valor ?? undefined;
    });

    const result = schema.safeParse(data);

    if (result.success) {
      return { success: true, errors: {}, faltantes: [] };
    }

    const errors = {};
    const faltantes = [];

    result.error.issues.forEach(issue => {
      const indId = String(issue.path[0]);
      if (errors[indId]) return; // una unión puede emitir varios issues por campo
      errors[indId] = issue.message;
      const ind = indicadores.find(i => String(i.id) === indId);
      if (ind) faltantes.push(ind.nombre);
    });

    return { success: false, errors, faltantes };
  }

  return { validate, schema };
}

/**
 * Evidencia fotográfica: qué indicadores calificados quedaron sin foto.
 *
 * Historia corta. La regla 3 de la guía exigía foto para todo puntaje ≤ 2 y
 * BLOQUEABA el envío. En el taller del 7-sep-2026 el bloqueo se quitó
 * (commit 7fd4ffa): con lluvia, sin batería o con el animal que no se deja,
 * el técnico terminaba subiendo la nota de 2 a 3 para poder cerrar — un sesgo
 * silencioso en el dato, peor que una foto faltante.
 *
 * Ahora la regla es AVISO, no bloqueo, y cubre cualquier indicador calificado
 * (no solo ≤ 2): al enviar se lista lo que falta y el técnico decide. Los
 * indicadores en "No aplica" no piden foto. Si el técnico ya escribió por qué
 * no pudo tomarla, se conserva esa señal (`tiene_motivo`) para mostrarla.
 *
 * Va aparte de crearSchemaEvaluacion a propósito: Zod valida la forma de los
 * datos; esto cruza calificación con fotos, que no viven en el schema.
 *
 * @param {Array}  indicadores  catálogo completo
 * @param {Object} detalles     { [indicadorId]: { valor, no_aplica, motivo_sin_foto } }
 * @param {Object} fotosPorInd  { [indicadorId]: [...fotos] }
 * @returns {{ success: boolean, faltantes: Array<{indicador_id, orden, nombre, valor, tiene_motivo}> }}
 */
export function validarEvidenciaFotografica(indicadores, detalles, fotosPorInd = {}) {
  const faltantes = [];

  indicadores.forEach(ind => {
    const det = detalles[ind.id];
    if (!det || det.no_aplica === true || typeof det.valor !== 'number') return;

    const tieneFoto = (fotosPorInd[ind.id] || []).length > 0;
    if (tieneFoto) return;

    faltantes.push({
      indicador_id: ind.id,
      orden: ind.orden ?? ind.id,
      nombre: ind.nombre,
      valor: det.valor,
      tiene_motivo: String(det.motivo_sin_foto || '').trim().length > 0,
    });
  });

  return { success: faltantes.length === 0, faltantes };
}
