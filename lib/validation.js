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

/**
 * Regla 3 de aplicación de la guía: todo indicador calificado en 2 o menos
 * debe tener al menos una fotografía de respaldo.
 *
 * Va aparte de crearSchemaEvaluacion a propósito. Zod valida la forma de los
 * datos del formulario; esto es una regla condicional que cruza tres fuentes
 * (calificación, fotos y motivo) y ninguna de las dos últimas vive en el
 * schema. Forzarla dentro de Zod la volvería ilegible.
 *
 * El escape por motivo es deliberado: un bloqueo absoluto en campo (celular
 * mojado, sin batería, el animal que no se deja fotografiar) empuja al
 * evaluador a subir la nota de 2 a 3 para poder cerrar la visita. Eso es un
 * sesgo silencioso en el dato, peor que una foto faltante documentada.
 *
 * @param {Array}  indicadores  catálogo completo
 * @param {Object} detalles     { [indicadorId]: { valor, motivo_sin_foto } }
 * @param {Object} fotosPorInd  { [indicadorId]: [...fotos] }
 * @returns {{ success: boolean, faltantes: Array<{indicador_id, nombre}> }}
 */
export function validarEvidenciaFotografica(indicadores, detalles, fotosPorInd = {}) {
  const UMBRAL = 2;
  const faltantes = [];

  indicadores.forEach(ind => {
    const det = detalles[ind.id];
    if (!det || typeof det.valor !== 'number' || det.valor > UMBRAL) return;

    const tieneFoto = (fotosPorInd[ind.id] || []).length > 0;
    const tieneMotivo = String(det.motivo_sin_foto || '').trim().length > 0;
    if (tieneFoto || tieneMotivo) return;

    faltantes.push({ indicador_id: ind.id, nombre: ind.nombre, valor: det.valor });
  });

  return { success: faltantes.length === 0, faltantes };
}
