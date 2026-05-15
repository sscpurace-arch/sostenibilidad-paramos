import { z } from 'zod';

/**
 * Genera un schema Zod para validar que TODOS los indicadores tengan calificación.
 * Se usa al momento de FINALIZAR (enviar) la evaluación.
 * 
 * @param {Array} indicadores - Lista de indicadores con { id, nombre, rango_min, rango_max }
 * @returns {{ validate: Function, schema: z.ZodObject }}
 */
export function crearSchemaEvaluacion(indicadores) {
  const shape = {};

  indicadores.forEach(ind => {
    const min = ind.rango_min ?? 1;
    const max = ind.rango_max ?? 5;

    shape[String(ind.id)] = z
      .number({
        required_error: `"${ind.nombre}" es obligatorio`,
        invalid_type_error: `"${ind.nombre}" debe ser un número`
      })
      .int()
      .min(min, `"${ind.nombre}" debe ser al menos ${min}`)
      .max(max, `"${ind.nombre}" no puede superar ${max}`);
  });

  const schema = z.object(shape);

  /**
   * Valida los detalles (mapa indicador_id -> { valor })
   * @param {Object} detalles - { [indicadorId]: { valor, observacion } }
   * @returns {{ success: boolean, errors: Object, faltantes: string[] }}
   */
  function validate(detalles) {
    const data = {};
    indicadores.forEach(ind => {
      const det = detalles[ind.id];
      data[String(ind.id)] = det?.valor ?? undefined;
    });

    const result = schema.safeParse(data);

    if (result.success) {
      return { success: true, errors: {}, faltantes: [] };
    }

    const errors = {};
    const faltantes = [];

    result.error.issues.forEach(issue => {
      const indId = issue.path[0];
      errors[indId] = issue.message;
      const ind = indicadores.find(i => String(i.id) === indId);
      if (ind) faltantes.push(ind.nombre);
    });

    return { success: false, errors, faltantes };
  }

  return { validate, schema };
}
