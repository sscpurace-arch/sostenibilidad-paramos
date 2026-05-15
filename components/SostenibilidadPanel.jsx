'use client';
import RadarChart from '@/components/RadarChart';

/**
 * Panel de sostenibilidad: radar comparativo + promedios por dimensión.
 * Muestra empty state si no hay evaluaciones.
 */
export default function SostenibilidadPanel({ 
  ultimaEval, 
  todasEvals, 
  radarData, 
  indicadores, 
  dimensiones 
}) {
  return (
    <section className="bg-white p-6 rounded-2xl shadow-sm border border-gray-100">
      <div className="flex justify-between items-center mb-6">
        <h3 className="font-bold text-gray-700">Estado de Sostenibilidad</h3>
        {ultimaEval && (
          <div className="text-right">
            <p className="text-[10px] text-gray-400 uppercase font-black">Última Visita</p>
            <p className="text-lg font-black text-[#03A64A]">
              {new Date(ultimaEval.fecha).toLocaleDateString('es-ES', { day: 'numeric', month: 'short', year: 'numeric' })}
            </p>
          </div>
        )}
      </div>

      {ultimaEval ? (
        <div className="flex flex-col gap-6">
          <div className="w-full bg-gray-50 rounded-3xl p-2">
            <RadarChart
              labels={indicadores.map(i => i.nombre)}
              datasets={todasEvals.map((ev, idx) => ({
                name: `Evaluación ${todasEvals.length - idx}${ev.es_prueba ? ' (Prueba)' : ''}`,
                data: indicadores.map(i => {
                  const det = radarData?.find(d =>
                    d.evaluacion_id === ev.id &&
                    (d.indicador_id === i.id || parseInt(d.indicador_id) === i.id)
                  );
                  return det ? det.valor : 0;
                })
              }))}
              colors={['#03A64A', '#1976D2', '#F57C00', '#7B1FA2']}
              height={400}
              indicadores={indicadores}
              dimensiones={dimensiones}
            />
          </div>

          <div className="grid grid-cols-3 gap-2">
            {dimensiones.map(dim => {
              const indsInDim = indicadores.filter(i => i.dimension === dim.nombre);
              const scores = indsInDim
                .map(i => {
                  const det = radarData?.find(d => d.evaluacion_id === ultimaEval.id && (d.indicador_id === i.id || parseInt(d.indicador_id) === i.id));
                  return det ? det.valor : null;
                })
                .filter(s => s !== null);
              const avg = scores.length ? (scores.reduce((a, b) => a + b, 0) / scores.length).toFixed(1) : '0';
              return (
                <div key={dim.nombre} className="p-3 rounded-xl text-center" style={{ backgroundColor: dim.color + '15' }}>
                  <p className="text-[10px] font-bold uppercase" style={{ color: dim.color }}>{dim.nombre.substring(0, 5)}</p>
                  <p className="text-xl font-black" style={{ color: dim.color }}>{avg}</p>
                </div>
              );
            })}
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
  );
}
