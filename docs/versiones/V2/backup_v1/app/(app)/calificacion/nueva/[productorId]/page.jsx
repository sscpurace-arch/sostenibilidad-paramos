'use client';
import { useState, useEffect } from 'react';
import { db } from '@/lib/db-offline';
import { createClient } from '@/lib/supabase';
import { agregarACola, procesarCola } from '@/lib/sync';
import { useRouter } from 'next/navigation';
import RadarChart from '@/components/RadarChart';

export default function PerfilProductorPage({ params }) {
  const [productor, setProductor] = useState(null);
  const [ultimaCal, setUltimaCal] = useState(null);
  const [todasCals, setTodasCals] = useState([]);
  const [radarData, setRadarData] = useState(null);
  const [indicadores, setIndicadores] = useState([]);
  const [dimensiones, setDimensiones] = useState([]);
  const [loading, setLoading] = useState(true);
  const [fechaNuevaCal, setFechaNuevaCal] = useState(new Date().toISOString().split('T')[0]);
  const [esPrueba, setEsPrueba] = useState(false);
  const router = useRouter();
  const supabase = createClient();

  useEffect(() => {
    cargarDatos();
  }, [params.productorId]);

  async function cargarDatos() {
    setLoading(true);
    const prod = await db.productores.get(params.productorId);
    if (!prod) {
      router.push('/buscar');
      return;
    }
    setProductor(prod);

    // Cargar indicadores y dimensiones (catálogos siempre en Dexie)
    const [inds, dims] = await Promise.all([
      db.indicadores.orderBy('orden').toArray(),
      db.dimensiones.toArray()
    ]);
    setIndicadores(inds);
    setDimensiones(dims);

    // Cargar calificaciones y detalles — directo de Supabase si online
    try {
      if (navigator.onLine) {
        const { data: cals } = await supabase
          .from('calificaciones')
          .select('*')
          .eq('productor_id', params.productorId)
          .eq('estado', 'completada')
          .order('fecha_fin', { ascending: false })
          .limit(4);

        if (cals && cals.length > 0) {
          setUltimaCal(cals[0]);
          setTodasCals(cals);
          
          const calIds = cals.map(c => c.id);
          const { data: detalles } = await supabase
            .from('calificacion_detalle')
            .select('*')
            .in('calificacion_id', calIds);
          setRadarData(detalles || []);
        } else {
          setUltimaCal(null);
          setTodasCals([]);
          setRadarData([]);
        }
      } else {
        // Fallback offline: Dexie
        const cals = await db.calificaciones
          .where('productor_id').equals(params.productorId)
          .and(c => c.estado === 'completada')
          .reverse()
          .sortBy('fecha_fin');
          
        const limitCals = cals.slice(0, 4);
        if (limitCals.length > 0) {
          setUltimaCal(limitCals[0]);
          setTodasCals(limitCals);
          
          const calIds = limitCals.map(c => c.id);
          const detalles = await db.calificacion_detalle
            .where('calificacion_id').anyOf(calIds)
            .toArray();
          setRadarData(detalles);
        }
      }
    } catch (e) {
      console.error('Error cargando calificaciones:', e);
    }
    setLoading(false);
  }

  const handleIniciar = async () => {
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return;

    const newCal = {
      id: crypto.randomUUID(),
      productor_id: params.productorId,
      usuario_id: user.id,
      estado: 'en_proceso',
      fecha_inicio: new Date(fechaNuevaCal + 'T12:00:00').toISOString(),
      es_prueba: esPrueba
    };

    await db.calificaciones.add(newCal);
    await agregarACola('calificaciones', 'INSERT', newCal);
    if (navigator.onLine) await procesarCola(supabase);

    router.push(`/calificacion/${newCal.id}`);
  };

  const handleEliminar = async (calId) => {
    if (!confirm('¿Estás seguro de eliminar esta evaluación? Esta acción no se puede deshacer.')) return;

    try {
      // Eliminar de Dexie
      await db.calificacion_detalle.where('calificacion_id').equals(calId).delete();
      await db.calificaciones.delete(calId);

      // Agregar a cola para Supabase (necesitaríamos que sync.js maneje DELETE, por ahora simulamos o lo hacemos directo si hay red)
      if (navigator.onLine) {
        await supabase.from('calificacion_detalle').delete().eq('calificacion_id', calId);
        await supabase.from('calificaciones').delete().eq('id', calId);
      } else {
        await agregarACola('calificaciones', 'DELETE', { id: calId });
      }

      // Recargar
      cargarDatos();
    } catch (e) {
      console.error('Error eliminando:', e);
      alert('Error al eliminar');
    }
  };

  if (loading) return <div className="p-10 text-center text-gray-400">Cargando perfil...</div>;

  return (
    <div className="flex flex-col gap-6 pb-20">
      <header className="flex items-center gap-2">
        <button onClick={() => router.back()} className="text-gray-500 p-2">←</button>
        <h1 className="text-xl font-bold">Perfil del Productor</h1>
      </header>

      <section className="bg-white p-6 rounded-2xl shadow-sm border border-gray-100">
        <h2 className="text-2xl font-bold text-[#2E7D32]">{productor.nombre_completo}</h2>
        <p className="text-sm text-gray-500 mt-1">CC: {productor.cedula}</p>
        <div className="grid grid-cols-2 gap-4 mt-6">
          <div>
            <p className="text-[10px] text-gray-400 uppercase font-bold">Predio</p>
            <p className="text-sm">{productor.nombre_predio || '-'}</p>
          </div>
          <div>
            <p className="text-[10px] text-gray-400 uppercase font-bold">Vereda</p>
            <p className="text-sm">{productor.vereda || '-'}</p>
          </div>
        </div>
        
        <button 
          onClick={() => router.push(`/mapa/${productor.id}`)}
          className="mt-6 w-full flex items-center justify-center gap-2 py-3 border-2 border-[#2E7D32]/20 rounded-xl text-[#2E7D32] font-bold text-sm hover:bg-green-50 active:scale-95 transition-all"
        >
          📍 Ver ubicación del predio
        </button>
        
        {productor.ubicacion_lat && productor.ubicacion_lng && (
          <div className="mt-2 text-center">
            <p className="text-[10px] text-gray-400 font-mono">
              LAT: {productor.ubicacion_lat} | LNG: {productor.ubicacion_lng}
            </p>
          </div>
        )}
      </section>

      <section className="bg-white p-6 rounded-2xl shadow-sm border border-gray-100">
        <div className="flex justify-between items-center mb-6">
          <h3 className="font-bold text-gray-700">Estado de Sostenibilidad</h3>
          {ultimaCal && (
            <div className="text-right">
              <p className="text-[10px] text-gray-400 uppercase font-black">Última Visita</p>
              <p className="text-lg font-black text-[#2E7D32]">
                {new Date(ultimaCal.fecha_fin).toLocaleDateString('es-ES', { day: 'numeric', month: 'short', year: 'numeric' })}
              </p>
            </div>
          )}
        </div>

        {ultimaCal ? (
          <div className="flex flex-col gap-6">
            <div className="w-full bg-gray-50 rounded-3xl p-2">
              <RadarChart 
                labels={indicadores.map(i => i.nombre)}
                datasets={todasCals.map((cal, idx) => ({
                  name: `Calificación ${todasCals.length - idx}${cal.es_prueba ? ' (Prueba)' : ''}`,
                  data: indicadores.map(i => {
                    const det = radarData?.find(d => 
                      d.calificacion_id === cal.id && 
                      (d.indicador_id === i.id || parseInt(d.indicador_id) === i.id)
                    );
                    return det ? det.puntaje : 0;
                  })
                }))}
                colors={['#2E7D32', '#1976D2', '#F57C00', '#7B1FA2']}
                height={400}
                indicadores={indicadores}
                dimensiones={dimensiones}
              />
            </div>
            
            <div className="grid grid-cols-3 gap-2">
              {dimensiones.map(dim => {
                const indsInDim = indicadores.filter(i => i.dimension_id === dim.id);
                const scores = indsInDim
                  .map(i => {
                    const det = radarData?.find(d => d.calificacion_id === ultimaCal.id && (d.indicador_id === i.id || parseInt(d.indicador_id) === i.id));
                    return det ? det.puntaje : null;
                  })
                  .filter(s => s !== null);
                const avg = scores.length ? (scores.reduce((a,b) => a+b,0) / scores.length).toFixed(1) : '0';
                return (
                  <div key={dim.id} className="p-3 rounded-xl text-center" style={{ backgroundColor: dim.color + '15' }}>
                    <p className="text-[10px] font-bold uppercase" style={{ color: dim.color }}>{dim.nombre.substring(0, 5)}</p>
                    <p className="text-xl font-black" style={{ color: dim.color }}>{avg}</p>
                  </div>
                );
              })}
            </div>

            <div className="mt-4 pt-4 border-t border-gray-100">
              <h4 className="text-[10px] text-gray-400 uppercase font-black mb-3">Historial de Evaluaciones</h4>
              <div className="flex flex-col gap-2">
                {todasCals.map((cal, idx) => (
                  <div key={cal.id} className="flex items-center justify-between p-3 bg-gray-50 rounded-xl">
                    <div>
                      <p className="text-sm font-bold text-gray-700">
                        Calificación {todasCals.length - idx}
                        {cal.es_prueba && <span className="ml-2 text-[8px] bg-amber-100 text-amber-700 px-1.5 py-0.5 rounded-full uppercase">Prueba</span>}
                      </p>
                      <p className="text-[10px] text-gray-400">
                        {new Date(cal.fecha_fin || cal.fecha_inicio).toLocaleDateString('es-ES', { day: 'numeric', month: 'long', year: 'numeric' })}
                      </p>
                    </div>
                    <button 
                      onClick={() => handleEliminar(cal.id)}
                      className="p-2 text-red-400 hover:text-red-600 hover:bg-red-50 rounded-lg transition-colors"
                    >
                      <svg xmlns="http://www.w3.org/2000/svg" className="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                      </svg>
                    </button>
                  </div>
                ))}
              </div>
            </div>
          </div>
        ) : (
          <div className="py-20 text-center text-gray-400 bg-gray-50 rounded-3xl border-2 border-dashed border-gray-100">
            <p className="text-6xl mb-4">🌱</p>
            <p className="font-medium">Sin evaluaciones previas</p>
            <p className="text-xs px-10">Este será el punto de partida para medir el avance.</p>
          </div>
        )}
      </section>

      <section className="bg-white p-6 rounded-2xl shadow-sm border border-gray-100">
        <h3 className="font-bold text-gray-700 mb-4">Nueva Evaluación</h3>
        <div className="flex flex-col gap-4">
          <div>
            <label className="block text-[10px] text-gray-400 uppercase font-bold mb-1">Fecha de Visita</label>
            <input 
              type="date" 
              value={fechaNuevaCal}
              onChange={(e) => setFechaNuevaCal(e.target.value)}
              className="w-full bg-gray-50 border-2 border-gray-100 rounded-xl px-4 py-3 text-sm focus:border-[#2E7D32] outline-none transition-colors"
            />
          </div>
          <div className="flex items-center gap-2 py-2">
            <input 
              type="checkbox" 
              id="esPrueba"
              checked={esPrueba}
              onChange={(e) => setEsPrueba(e.target.checked)}
              className="w-5 h-5 rounded border-gray-300 text-[#2E7D32] focus:ring-[#2E7D32]"
            />
            <label htmlFor="esPrueba" className="text-sm font-medium text-gray-700">Esta es una calificación de prueba</label>
          </div>
          <button 
            onClick={handleIniciar}
            className="bg-[#2E7D32] text-white py-4 rounded-xl font-bold text-lg shadow-lg active:scale-95 transition-all"
          >
            Iniciar Calificación
          </button>
        </div>
      </section>
    </div>
  );
}
