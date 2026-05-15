import Dexie from 'dexie';

export const db = new Dexie('SostenibilidadParamos');

db.version(3).stores({
  productores: 'id, cedula, nombre_completo, vereda, municipio',
  dimensiones: 'id',
  indicadores: 'id, dimension_id, orden',
  calificaciones: 'id, productor_id, usuario_id, estado',
  calificacion_detalle: 'id, calificacion_id, indicador_id',
  sync_queue: '++localId, tabla, operacion, sincronizado, timestamp'
});
