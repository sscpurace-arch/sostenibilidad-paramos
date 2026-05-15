import { db } from './db-offline';

export async function inicializarDatosLocales(supabase) {
  if (!navigator.onLine) return;

  try {
    console.log('Descargando datos desde Supabase...');
    
    // 1. Dimensiones
    const { data: dims } = await supabase.from('dimensiones').select('*');
    if (dims) await db.dimensiones.bulkPut(dims);

    // 2. Indicadores
    const { data: inds } = await supabase.from('indicadores').select('*');
    if (inds) await db.indicadores.bulkPut(inds);

    // 3. Productores
    const { data: prods } = await supabase.from('productores').select('*');
    if (prods) await db.productores.bulkPut(prods);

    // 4. Calificaciones
    const { data: cals } = await supabase.from('calificaciones').select('*');
    if (cals) await db.calificaciones.bulkPut(cals);

    // 5. Detalles de calificación
    const { data: dets } = await supabase.from('calificacion_detalle').select('*');
    if (dets) await db.calificacion_detalle.bulkPut(dets);

    console.log(`Sincronización inicial completada: ${prods?.length} productores, ${cals?.length} calificaciones, ${dets?.length} detalles.`);
  } catch (error) {
    console.error('Error en sincronización inicial:', error);
  }
}

export async function agregarACola(tabla, operacion, payload) {
  await db.sync_queue.add({
    tabla,
    operacion,
    payload,
    sincronizado: 0,
    timestamp: new Date().toISOString()
  });
}

export async function procesarCola(supabase) {
  if (!navigator.onLine) return { exito: 0, pendientes: 0 };

  const pendientes = await db.sync_queue.where('sincronizado').equals(0).toArray();
  let exitoCount = 0;

  for (const item of pendientes) {
    try {
      const { tabla, operacion, payload } = item;
      let res;
      
      if (operacion === 'INSERT') {
        res = await supabase.from(tabla).upsert(payload);
      } else if (operacion === 'UPDATE') {
        res = await supabase.from(tabla).update(payload).eq('id', payload.id);
      } else if (operacion === 'DELETE') {
        res = await supabase.from(tabla).delete().eq('id', payload.id);
      }
      
      if (res && !res.error) {
        await db.sync_queue.update(item.localId, { sincronizado: 1 });
        exitoCount++;
      }
    } catch (e) {
      console.error('Error sincronizando item:', e);
    }
  }

  return { exito: exitoCount, pendientes: pendientes.length - exitoCount };
}

export function configurarSincronizacionAutomatica(supabase) {
  const handleOnline = () => {
    console.log('Recuperada conexión. Sincronizando...');
    procesarCola(supabase);
  };
  
  window.addEventListener('online', handleOnline);
  return () => window.removeEventListener('online', handleOnline);
}
