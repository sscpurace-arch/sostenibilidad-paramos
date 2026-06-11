/**
 * Descarga explícita de datos para trabajar sin conexión.
 *
 * A diferencia del seed silencioso en sync-engine, esta función es disparada
 * por el usuario (botón "Preparar sin conexión"), reporta progreso y deja un
 * registro verificable en localStorage. Funciona igual en iPhone, Android y
 * escritorio; en iPhone es la única forma confiable de poblar el
 * almacenamiento de la app instalada (que está separado del de Safari).
 */
import { db } from './db-offline';
import { getClient } from './sync-engine';
import { prefetchDemoTiles } from './tile-prefetch';

const FLAG = 'offline-data-prepared-v1';

/** Estado de la última preparación offline. */
export function estadoOffline() {
  if (typeof window === 'undefined') return { listo: false };
  try {
    const raw = localStorage.getItem(FLAG);
    if (!raw) return { listo: false };
    const d = JSON.parse(raw);
    const diasDesde = Math.floor((Date.now() - new Date(d.fecha).getTime()) / 86400000);
    return { listo: true, fecha: d.fecha, totalProductores: d.totalProductores || 0, diasDesde };
  } catch {
    return { listo: false };
  }
}

/**
 * Descarga todo lo necesario para trabajar sin conexión, reportando avance.
 * @param {(pct:number, label:string)=>void} onProgress
 * @returns {Promise<{totalProductores:number}>}
 */
export async function prepararOffline(onProgress = () => {}) {
  if (typeof window === 'undefined' || !navigator.onLine) {
    throw new Error('SIN_CONEXION');
  }

  const supabase = getClient();
  let totalProductores = 0;

  if (supabase) {
    // ── Modo real: datos desde Supabase ──
    onProgress(3, 'Descargando indicadores…');
    const { data: inds } = await supabase.from('indicadores').select('*');
    if (inds?.length) await db.indicadores.bulkPut(inds);

    onProgress(8, 'Descargando productores…');
    const { data: prods } = await supabase.from('productores').select('*');
    if (prods?.length) {
      await db.productores.bulkPut(prods);
      totalProductores = prods.length;
    }
    onProgress(25, `${totalProductores} productores guardados`);

    onProgress(28, 'Descargando evaluaciones…');
    const { data: { user } } = await supabase.auth.getUser();
    if (user) {
      const { data: evals } = await supabase
        .from('evaluaciones').select('*').eq('tecnico_id', user.id);
      if (evals?.length) {
        await db.evaluaciones.bulkPut(evals);
        const borradorIds = evals.filter(e => e.estado === 'borrador').map(e => e.id);
        if (borradorIds.length) {
          const { data: resp } = await supabase
            .from('respuestas_indicadores').select('*').in('evaluacion_id', borradorIds);
          if (resp?.length) await db.respuestas_indicadores.bulkPut(resp);
        }
      }
    }
    onProgress(40, 'Evaluaciones listas');
  } else {
    // ── Modo prueba: datos desde el archivo local ──
    onProgress(10, 'Cargando datos de prueba…');
    const res = await fetch('/seed-data.json');
    if (!res.ok) throw new Error('No se pudo cargar seed-data.json');
    const seed = await res.json();
    if (seed.indicadores?.length) await db.indicadores.bulkPut(seed.indicadores);
    if (seed.productores?.length) {
      await db.productores.bulkPut(seed.productores);
      totalProductores = seed.productores.length;
    }
    if (seed.evaluaciones?.length) await db.evaluaciones.bulkPut(seed.evaluaciones);
    if (seed.respuestas_indicadores?.length) await db.respuestas_indicadores.bulkPut(seed.respuestas_indicadores);
    onProgress(40, 'Datos de prueba listos');
  }

  // ── Teselas del mapa de la zona Puracé (lo más pesado: 40% → 95%) ──
  onProgress(42, 'Descargando mapa de la zona…');
  await prefetchDemoTiles((done, total) => {
    if (total > 0) {
      const pct = 42 + Math.round((done / total) * 53);
      onProgress(Math.min(pct, 95), `Mapa: ${done} de ${total} teselas`);
    }
  });

  // ── Calentar el cascarón de la app (95% → 100%) ──
  onProgress(96, 'Guardando pantallas…');
  const rutas = ['/', '/buscar', '/en-proceso', '/nuevo-productor', '/calificacion', '/calificacion/nueva', '/mapa', '/mapa/detalle'];
  await Promise.all([
    // Documento HTML (para recargas con la pantalla abierta)
    ...rutas.map(u => fetch(u).catch(() => {})),
    // Payload RSC (para la navegación interna entre pantallas)
    ...rutas.map(u => fetch(u, { headers: { RSC: '1' } }).catch(() => {})),
  ]);

  if (totalProductores === 0) {
    totalProductores = await db.productores.count();
  }
  localStorage.setItem(FLAG, JSON.stringify({
    fecha: new Date().toISOString(),
    totalProductores,
  }));
  onProgress(100, 'Listo para trabajar sin conexión');
  return { totalProductores };
}
