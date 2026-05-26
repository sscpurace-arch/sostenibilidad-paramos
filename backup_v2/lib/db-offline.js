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

// Colores de dimensiones (antes en tabla dimensiones, ahora constante)
export const DIMENSION_COLORS = {
  'Ambiental': '#03A64A',
  'Socioeconómica': '#1565C0',
  'Productiva': '#E65100'
};
