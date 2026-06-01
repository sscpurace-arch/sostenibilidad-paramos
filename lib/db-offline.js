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


// Colores de dimensiones (antes en tabla dimensiones, ahora constante)
export const DIMENSION_COLORS = {
  'Ambiental': '#03A64A',
  'Socioeconómica': '#1565C0',
  'Productiva': '#E65100'
};
