/**
 * "No aplica" con calificación anterior (pedido de Santiago, 17-nov-2026).
 *
 * Si hoy un indicador se marca "No aplica" pero en la visita anterior sí se
 * calificó, para el puntaje, el radar y el diagnóstico se conserva la
 * calificación anterior: el indicador no queda vacío ni en 1.
 *
 * Lo que se GUARDA no cambia (valor null + no_aplica true, el CHECK de la base
 * lo exige): esto solo arma la vista "efectiva" para calcular y mostrar. Los
 * indicadores heredados llevan `heredado: true` para poder decirlo en pantalla
 * y dejarlos fuera del plan de acción (no son una meta de hoy).
 */
import { leerFecha } from './pdf-utils';

/** Mapa { indicador_id: valor } de las respuestas con puntaje numérico. */
function valoresNumericos(respuestas) {
  const out = {};
  (respuestas || []).forEach(r => {
    if (r && r.no_aplica !== true && typeof r.valor === 'number') out[Number(r.indicador_id)] = r.valor;
  });
  return out;
}

/**
 * @param {Object} detalles    { [indicadorId]: { valor, no_aplica, ... } } de la visita actual
 * @param {Array}  anteriores  respuestas de la visita anterior (filas de respuestas_indicadores)
 * @returns {Object} el mismo objeto si no hay nada que heredar; si no, una copia
 */
export function conCalificacionAnterior(detalles, anteriores) {
  if (!detalles || !Array.isArray(anteriores) || anteriores.length === 0) return detalles;
  const previo = valoresNumericos(anteriores);
  let cambio = false;
  const out = { ...detalles };
  Object.entries(detalles).forEach(([id, det]) => {
    const v = previo[Number(id)];
    if (det?.no_aplica === true && typeof v === 'number') {
      out[id] = { ...det, valor: v, no_aplica: false, heredado: true };
      cambio = true;
    }
  });
  return cambio ? out : detalles;
}

/**
 * Lo mismo para un historial completo (perfil del productor): recorre las
 * visitas de la más vieja a la más nueva y cada N/A toma el último puntaje
 * que tuvo ese indicador. Una visita real solo hereda de otra real.
 *
 * @param {Array} evaluaciones  [{ id, fecha, es_prueba }]
 * @param {Array} respuestas    filas de respuestas_indicadores de esas visitas
 * @returns {Array} respuestas con los N/A heredados reemplazados (copias)
 */
export function heredarEnHistorial(evaluaciones, respuestas) {
  if (!Array.isArray(respuestas) || respuestas.length === 0) return respuestas;
  const t = (f) => leerFecha(f)?.getTime() ?? 0;
  const orden = [...(evaluaciones || [])].sort((a, b) => t(a.fecha) - t(b.fecha));
  const porEval = {};
  respuestas.forEach(r => { (porEval[r.evaluacion_id] ||= []).push(r); });

  const previoReal = {};
  const previoTodo = {};
  const salida = [];
  const vistos = new Set();
  orden.forEach(ev => {
    const previo = ev.es_prueba ? previoTodo : previoReal;
    const propias = porEval[ev.id] || [];
    propias.forEach(r => {
      vistos.add(r);
      const ind = Number(r.indicador_id);
      if (r.no_aplica === true && typeof previo[ind] === 'number') {
        salida.push({ ...r, valor: previo[ind], no_aplica: false, heredado: true });
      } else {
        salida.push(r);
      }
    });
    const actuales = valoresNumericos(propias);
    Object.assign(previoTodo, actuales);
    if (!ev.es_prueba) Object.assign(previoReal, actuales);
  });
  // Respuestas de visitas que no vinieron en la lista: tal cual
  respuestas.forEach(r => { if (!vistos.has(r)) salida.push(r); });
  return salida;
}
