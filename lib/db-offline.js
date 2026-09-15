import Dexie from 'dexie';

export const db = new Dexie('SostenibilidadParamos');

// V3: Schema original
db.version(3).stores({
  productores: 'id, cedula, nombre_completo, vereda, municipio',
  dimensiones: 'id',
  indicadores: 'id, dimension_id, orden',
  calificaciones: 'id, productor_id, usuario_id, estado',
  calificacion_detalle: 'id, calificacion_id, indicador_id',
  sync_queue: '++localId, tabla, operacion, sincronizado, timestamp'
});

// V4: Normalización de schema
db.version(4).stores({
  dimensiones: null,
  indicadores: 'id, dimension_id, dimension, orden',
  calificaciones: null,
  calificacion_detalle: null,
  evaluaciones: 'id, finca_id, tecnico_id, estado',
  respuestas_indicadores: 'id, evaluacion_id, indicador_id',
});

// V5: Sync engine mejorado
db.version(5).stores({
  sync_queue: '++localId, tabla, sync_pending, updated_at'
}).upgrade(tx => {
  // Limpiar cola antigua — se re-sincroniza al iniciar
  return tx.table('sync_queue').clear();
});

// V6: Diagnosticos IA offline
db.version(6).stores({
  diagnosticos: 'id, evaluacion_id, fecha'
});

// V7: Deduplicar productores por cédula
db.version(7).stores({}).upgrade(async tx => {
  const productores = await tx.table('productores').toArray();
  const validCedulas = {};
  const toDelete = [];

  for (const p of productores) {
    if (!p.cedula) continue;
    if (!validCedulas[p.cedula]) {
      validCedulas[p.cedula] = p;
    } else {
      const kept = validCedulas[p.cedula];
      const dropped = p;
      toDelete.push(dropped.id);
      
      // Reasignar evaluaciones
      await tx.table('evaluaciones')
        .where('finca_id').equals(dropped.id)
        .modify({ finca_id: kept.id });
    }
  }

  if (toDelete.length > 0) {
    await tx.table('productores').bulkDelete(toDelete);
  }
});

// V8: Deduplicar evaluaciones por finca_id y fecha
db.version(8).stores({}).upgrade(async tx => {
  const evals = await tx.table('evaluaciones').toArray();
  const seen = {};
  const toDeleteEvalIds = [];

  for (const ev of evals) {
    if (!ev.finca_id || !ev.fecha) continue;
    
    // Normalizar la fecha (solo año-mes-día) para evitar pequeñas variaciones de formato/zona horaria
    const dateStr = ev.fecha.includes('T') ? ev.fecha.split('T')[0] : ev.fecha;
    const key = `${ev.finca_id}_${dateStr}`;

    if (!seen[key]) {
      seen[key] = ev;
    } else {
      // Si ya vimos una evaluación para este productor en esta fecha, marcamos la duplicada para borrar
      const kept = seen[key];
      const dropped = ev;
      
      // Preferimos mantener la que tenga ID que ya está sincronizada o la que se haya creado primero
      // Por defecto, marcamos la actual (dropped) para borrar
      toDeleteEvalIds.push(dropped.id);
    }
  }

  if (toDeleteEvalIds.length > 0) {
    await tx.table('evaluaciones').bulkDelete(toDeleteEvalIds);
    
    // También borrar las respuestas de las evaluaciones que eliminamos
    const respuestas = await tx.table('respuestas_indicadores').toArray();
    const toDeleteRespIds = respuestas
      .filter(r => toDeleteEvalIds.includes(r.evaluacion_id))
      .map(r => r.id);
      
    if (toDeleteRespIds.length > 0) {
      await tx.table('respuestas_indicadores').bulkDelete(toDeleteRespIds);
    }
  }
});


// V9: Plan de acción SMART por evaluación
db.version(9).stores({
  planes_accion: 'id, evaluacion_id, indicador_id'
});


// V10: Registro fotográfico de evidencia (R4, taller 31-jul-2026)
// Dos tablas a propósito: IndexedDB deserializa la fila completa en cada lectura,
// así que si el blob viviera junto a la metadata, listar 12 miniaturas traería
// varios MB a memoria. `fotos_evidencia` es liviana y se consulta; `fotos_blobs`
// guarda los binarios y solo se lee por id.
//
// subida: 0 = pendiente · 1 = subida · 2 = omitida (modo prueba) · 3 = fallo permanente
// (entero, no booleano: IndexedDB no indexa booleanos)
db.version(10).stores({
  fotos_evidencia: 'id, evaluacion_id, indicador_id, [evaluacion_id+indicador_id], subida, tipo',
  fotos_blobs: 'id'
});

// V11: Ajustes de campo tras el taller de Paletará, 7-sep-2026.
// Se declara de una vez todo lo que esa tanda necesita, para no encadenar
// tres versiones seguidas en celulares que ya tienen datos en campo:
//  - reportes_pdf / reportes_blobs: los PDF generados (diagnóstico y plan de
//    acción), mismo diseño que fotos_evidencia / fotos_blobs — metadata
//    liviana aparte del binario. `subida` con los mismos estados que fotos.
//  - perfil_tecnico: nombre y cargo del usuario, para mostrarlos sin señal.
// `respuestas_indicadores` gana `no_aplica` y `productores` gana las
// hectáreas, pero ninguna es índice: Dexie no necesita declararlas.
db.version(11).stores({
  reportes_pdf: 'id, evaluacion_id, [evaluacion_id+tipo], subida',
  reportes_blobs: 'id',
  perfil_tecnico: 'id'
});

// Colores de dimensiones (antes en tabla dimensiones, ahora constante)
export const DIMENSION_COLORS = {
  'Ambiental': '#03A64A',
  'Socioeconómica': '#1565C0',
  'Productiva': '#E65100'
};
