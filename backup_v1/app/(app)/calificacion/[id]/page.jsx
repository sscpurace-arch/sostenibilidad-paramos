'use client';
import { useState, useEffect } from 'react';
import { db } from '@/lib/db-offline';
import { createClient } from '@/lib/supabase';
import { agregarACola, procesarCola } from '@/lib/sync';
import { useRouter } from 'next/navigation';
import IndicadorCard from '@/components/IndicadorCard';
import RadarChart from '@/components/RadarChart';

export default function EvaluacionPage({ params }) {
  const [calificacion, setCalificacion] = useState(null);
  const [productor, setProductor] = useState(null);
  const [indicadores, setIndicadores] = useState([]);
  const [dimensiones, setDimensiones] = useState([]);
  const [detalles, setDetalles] = useState({});
  const [loading, setLoading] = useState(true);
  const [showResults, setShowResults] = useState(false);
  const [lastResults, setLastResults] = useState(null);
  
  const router = useRouter();
  const supabase = createClient();

  useEffect(() => {
    cargarDatos();
  }, [params.id]);

  async function cargarDatos() {
    setLoading(true);
    const cal = await db.calificaciones.get(params.id);
    if (!cal) return router.push('/');
    setCalificacion(cal);

    const [prod, inds, dims, existingDets] = await Promise.all([
      db.productores.get(cal.productor_id),
      db.indicadores.orderBy('orden').toArray(),
      db.dimensiones.toArray(),
      db.calificacion_detalle.where('calificacion_id').equals(cal.id).toArray()
    ]);

    setProductor(prod);
    setIndicadores(inds);
    setDimensiones(dims);

    // Convertir detalles a mapa id_indicador -> { id, puntaje, observacion }
    const detMap = {};
    existingDets.forEach(d => {
      detMap[d.indicador_id] = { id: d.id, puntaje: d.puntaje, observacion: d.observacion };
    });
    setDetalles(detMap);

    // Buscar evaluación anterior para comparación
    const prevCals = await db.calificaciones
      .where('productor_id').equals(cal.productor_id)
      .and(c => c.estado === 'completada' && c.id !== cal.id)
      .reverse()
      .sortBy('fecha_fin');
    
    if (prevCals.length > 0) {
      const prevDets = await db.calificacion_detalle.where('calificacion_id').equals(prevCals[0].id).toArray();
      setLastResults(prevDets);
    }

    setLoading(false);
  }

  const handleScoreChange = async (indId, score) => {
    const recordId = detalles[indId]?.id || crypto.randomUUID();
    const updated = { ...detalles, [indId]: { ...detalles[indId], id: recordId, puntaje: score } };
    setDetalles(updated);
    
    const record = {
      id: recordId,
      calificacion_id: params.id,
      indicador_id: indId,
      puntaje: score,
      observacion: updated[indId]?.observacion || '',
      updated_at: new Date().toISOString()
    };

    await db.calificacion_detalle.put(record);
    await agregarACola('calificacion_detalle', 'INSERT', record);
    if (navigator.onLine) procesarCola(supabase);
  };

  const handleObservationChange = async (indId, text) => {
    const recordId = detalles[indId]?.id || crypto.randomUUID();
    const updated = { ...detalles, [indId]: { ...detalles[indId], id: recordId, observacion: text } };
    setDetalles(updated);
    
    if (updated[indId]?.puntaje) {
      const record = {
        id: recordId,
        calificacion_id: params.id,
        indicador_id: indId,
        puntaje: updated[indId].puntaje,
        observacion: text,
        updated_at: new Date().toISOString()
      };
      await db.calificacion_detalle.put(record);
      await agregarACola('calificacion_detalle', 'INSERT', record);
    }
  };

  const calculateAverages = (dets) => {
    const results = {};
    dimensiones.forEach(d => {
      const indsInDim = indicadores.filter(i => i.dimension_id === d.id);
      const scores = indsInDim.map(i => dets[i.id]?.puntaje).filter(s => s);
      results[d.id] = scores.length > 0 ? (scores.reduce((a, b) => a + b, 0) / scores.length).toFixed(1) : 0;
    });
    return results;
  };

  const handleFinalizar = async () => {
    const now = new Date().toISOString();
    await db.calificaciones.update(params.id, {
      estado: 'completada',
      fecha_fin: now
    });
    await agregarACola('calificaciones', 'UPDATE', { id: params.id, estado: 'completada', fecha_fin: now });
    if (navigator.onLine) await procesarCola(supabase);
    setShowResults(true);
  };

  if (loading) return <div className="p-10 text-center text-gray-400">Cargando evaluación...</div>;

  const totalRespondidos = Object.keys(detalles).filter(id => detalles[id].puntaje).length;
  const progreso = (totalRespondidos / 29) * 100;

  if (showResults) {
    const currentAvgs = calculateAverages(detalles);
    const lastAvgs = lastResults ? calculateAverages(
      lastResults.reduce((acc, d) => ({ ...acc, [d.indicador_id]: { puntaje: d.puntaje } }), {})
    ) : null;

    return (
      <div className="fixed inset-0 bg-white z-50 p-6 flex flex-col overflow-y-auto">
        <div className="text-center mb-8">
          <div className="w-16 h-16 bg-green-100 text-[#2E7D32] rounded-full flex items-center justify-center text-3xl mx-auto mb-4">✓</div>
          <h1 className="text-2xl font-bold text-gray-800">Evaluación Completada</h1>
          <p className="text-gray-500">{productor.nombre_completo}</p>
        </div>

        <div className="bg-gray-50 rounded-2xl p-4 mb-6">
          <h3 className="font-bold text-center mb-4 text-gray-600">Resultados por Indicador</h3>
          <div className="mb-6">
            <RadarChart 
              labels={indicadores.map(i => i.nombre)}
              datasets={[
                ...(lastAvgs ? [{
                  name: 'Anterior',
                  data: indicadores.map(i => {
                    const prev = lastResults?.find(d => d.indicador_id === i.id || parseInt(d.indicador_id) === i.id);
                    return prev ? prev.puntaje : 0;
                  })
                }] : []),
                {
                  name: 'Actual',
                  data: indicadores.map(i => {
                    const det = detalles[i.id];
                    return det?.puntaje || 0;
                  })
                }
              ]}
              colors={lastAvgs ? ['#94a3b8', '#42A5F5'] : ['#42A5F5']}
              height={400}
            />
          </div>
          <div className="grid grid-cols-3 gap-2">
            {dimensiones.map(d => (
              <div key={d.id} className="text-center p-2 bg-white rounded-lg border border-gray-100">
                <p className="text-[10px] uppercase font-bold" style={{ color: d.color }}>{d.nombre.substring(0, 5)}</p>
                <p className="text-xl font-black" style={{ color: d.color }}>{currentAvgs[d.id]}</p>
              </div>
            ))}
          </div>
        </div>

        <button 
          onClick={() => router.push('/')}
          className="bg-[#2E7D32] text-white py-4 rounded-xl font-bold text-lg shadow-lg mt-auto"
        >
          Volver al inicio
        </button>
      </div>
    );
  }

  return (
    <div className="flex flex-col gap-4 pb-32">
      <header className="sticky top-0 bg-[#F5F5F5] pt-2 pb-4 z-20 border-b border-gray-200">
        <div className="flex justify-between items-end mb-1">
          <h1 className="font-bold text-gray-800 text-sm truncate max-w-[200px]">{productor.nombre_completo}</h1>
          <span className="text-xs font-bold text-[#2E7D32]">{totalRespondidos} / 29</span>
        </div>
        <div className="w-full bg-gray-200 h-2 rounded-full overflow-hidden">
          <div 
            className="bg-[#2E7D32] h-full transition-all duration-300"
            style={{ width: `${progreso}%` }}
          ></div>
        </div>
      </header>

      {dimensiones.map(dim => (
        <div key={dim.id} className="flex flex-col gap-4 mt-2">
          <div className="bg-[#2E7D32]/10 p-2 rounded text-[#2E7D32] font-black text-xs uppercase tracking-wider">
            Dimensión {dim.nombre}
          </div>
          {indicadores.filter(i => i.dimension_id === dim.id).map(ind => (
            <IndicadorCard 
              key={ind.id}
              indicador={ind}
              score={detalles[ind.id]?.puntaje}
              onScoreChange={(s) => handleScoreChange(ind.id, s)}
              observation={detalles[ind.id]?.observacion}
              onObservationChange={(t) => handleObservationChange(ind.id, t)}
            />
          ))}
        </div>
      ))}

      <footer className="fixed bottom-16 left-0 right-0 p-4 bg-white/90 backdrop-blur-md border-t border-gray-100 flex gap-2 z-20">
        <button 
          onClick={() => router.push('/')}
          className="flex-1 bg-gray-100 text-gray-600 py-3 rounded-xl font-bold text-sm"
        >
          Guardar y salir
        </button>
        <button 
          onClick={handleFinalizar}
          disabled={totalRespondidos === 0}
          className="flex-1 bg-[#2E7D32] text-white py-3 rounded-xl font-bold text-sm shadow-md disabled:opacity-30"
        >
          Finalizar
        </button>
      </footer>
    </div>
  );
}
