'use client';
import { useState } from 'react';
import RadarChart from '@/components/RadarChart';
import PlanAccionSMART from '@/components/PlanAccionSMART';
import { useDiagnostico } from '@/lib/hooks/useDiagnostico';

export default function ResultadosEvaluacion({
  evaluacionId,
  productor,
  indicadores,
  dimensiones,
  detalles,
  lastResults,
  currentAvgs,
  lastAvgs,
  onVolver
}) {
  const [tab, setTab] = useState('resultados');
  const { diagnostico, isLoading, isStale, error: errorIA, generarNuevo } = useDiagnostico(evaluacionId);

  return (
    <div className="fixed inset-0 bg-white z-50 p-6 flex flex-col overflow-y-auto">
      <div className="text-center mb-4">
        <div className="w-12 h-12 bg-green-100 text-[#03A64A] rounded-full flex items-center justify-center text-2xl mx-auto mb-2">✓</div>
        <h1 className="text-xl font-bold text-gray-800">Evaluación Completada</h1>
        <p className="text-sm text-gray-500">{productor.nombre_completo}</p>
      </div>

      {/* Tabs */}
      <div className="flex rounded-xl overflow-hidden border border-gray-200 mb-5 flex-shrink-0">
        <button
          className={`flex-1 py-2.5 text-sm font-bold transition-colors ${tab === 'resultados' ? 'bg-[#03A64A] text-white' : 'bg-white text-gray-500'}`}
          onClick={() => setTab('resultados')}
        >
          Resultados
        </button>
        <button
          className={`flex-1 py-2.5 text-sm font-bold transition-colors ${tab === 'plan' ? 'bg-[#03A64A] text-white' : 'bg-white text-gray-500'}`}
          onClick={() => setTab('plan')}
        >
          Plan de Acción
        </button>
      </div>

      {/* Tab: Resultados */}
      {tab === 'resultados' && (
        <>
          {/* Radar y Promedios */}
          <div className="bg-gray-50 rounded-2xl p-4 mb-6 border border-gray-100">
            <h3 className="text-xs font-black uppercase text-gray-400 mb-4 text-center tracking-widest">Balance de Sostenibilidad</h3>
            <div className="mb-4">
              <RadarChart
                labels={indicadores.map(i => i.nombre)}
                datasets={[
                  ...(lastAvgs ? [{
                    name: 'Anterior',
                    data: indicadores.map(i => {
                      const prev = lastResults?.find(d => d.indicador_id === i.id || parseInt(d.indicador_id) === i.id);
                      return prev ? prev.valor : 0;
                    })
                  }] : []),
                  { name: 'Actual', data: indicadores.map(i => detalles[i.id]?.valor || 0) }
                ]}
                colors={lastAvgs ? ['#94a3b8', '#42A5F5'] : ['#42A5F5']}
                height={300}
              />
            </div>
            <div className="grid grid-cols-3 gap-2">
              {dimensiones.map(d => (
                <div key={d.nombre} className="text-center p-2 bg-white rounded-lg border border-gray-100">
                  <p className="text-[9px] uppercase font-bold" style={{ color: d.color }}>{d.nombre.split(' ')[0].substring(0, 6)}</p>
                  <p className="text-lg font-black" style={{ color: d.color }}>{currentAvgs[d.nombre]}</p>
                </div>
              ))}
            </div>
          </div>

          {/* Diagnóstico IA */}
          <div className="mb-6">
            {!diagnostico ? (
              <button
                onClick={generarNuevo}
                disabled={isLoading}
                className={`w-full py-4 rounded-2xl font-bold flex items-center justify-center gap-2 transition-all shadow-lg ${
                  isLoading ? 'bg-gray-100 text-gray-400 cursor-not-allowed' : 'bg-gradient-to-r from-blue-600 to-indigo-600 text-white active:scale-95'
                }`}
              >
                {isLoading ? (
                  <><span className="animate-spin text-xl">✨</span> Analizando con Gemini...</>
                ) : (
                  <><span>✨</span> Generar Diagnóstico con IA</>
                )}
              </button>
            ) : (
              <div className="bg-gradient-to-br from-blue-50 to-indigo-50 rounded-2xl p-6 border-2 border-blue-100 animate-in fade-in slide-in-from-bottom-4 duration-500 relative">
                {isStale && (
                  <div className="absolute -top-3 left-4 bg-amber-100 border border-amber-300 text-amber-800 text-[10px] px-3 py-1 rounded-full font-bold uppercase flex items-center gap-1 shadow-sm">
                    <span>⚠️</span> Generado offline el {new Date(diagnostico.fecha).toLocaleDateString()}
                  </div>
                )}
                <div className="flex items-center gap-2 mb-4 mt-2">
                  <span className="text-2xl">✨</span>
                  <h3 className="font-bold text-blue-900">Diagnóstico Inteligente</h3>
                  <span className="ml-auto bg-blue-600 text-white text-[10px] px-2 py-0.5 rounded-full font-bold uppercase tracking-tighter">Gemini 2.5</span>
                </div>
                <p className="text-sm text-blue-800 leading-relaxed mb-6 italic">
                  &ldquo;{diagnostico.texto}&rdquo;
                </p>
                <div className="space-y-4">
                  <div>
                    <h4 className="text-[10px] font-black uppercase text-blue-400 mb-2 tracking-widest">Fortalezas</h4>
                    <div className="flex flex-wrap gap-2">
                      {diagnostico.recomendaciones.fortalezas.map((f, i) => (
                        <span key={i} className="text-[11px] bg-white text-green-700 px-3 py-1 rounded-full border border-green-100 font-medium">✓ {f}</span>
                      ))}
                    </div>
                  </div>
                  <div>
                    <h4 className="text-[10px] font-black uppercase text-amber-500 mb-2 tracking-widest">Recomendaciones Clave</h4>
                    <ul className="space-y-2">
                      {diagnostico.recomendaciones.acciones.map((a, i) => (
                        <li key={i} className="text-xs text-gray-700 flex gap-2">
                          <span className="text-blue-500 font-bold">•</span> {a}
                        </li>
                      ))}
                    </ul>
                  </div>
                </div>
              </div>
            )}
            {errorIA && (
              <div className="mt-3 flex flex-col items-center gap-2">
                <p className="text-center text-xs text-red-500 font-medium">⚠️ {errorIA}</p>
                <button onClick={generarNuevo} disabled={isLoading} className="text-xs font-bold text-blue-600 underline hover:no-underline disabled:opacity-50">
                  Reintentar
                </button>
              </div>
            )}
          </div>

          {/* CTA para ir al plan */}
          <button
            onClick={() => setTab('plan')}
            className="w-full border-2 border-[#03A64A] text-[#03A64A] py-3 rounded-2xl font-bold text-sm active:scale-95 transition-all mb-4"
          >
            Ver Plan de Acción →
          </button>
        </>
      )}

      {/* Tab: Plan de Acción */}
      {tab === 'plan' && (
        <PlanAccionSMART
          indicadores={indicadores}
          detalles={detalles}
          evaluacionId={evaluacionId}
          productor={productor}
        />
      )}

      <button
        onClick={onVolver}
        className="w-full bg-gray-800 text-white py-4 rounded-2xl font-bold text-lg shadow-xl active:scale-95 transition-all mt-auto"
      >
        Finalizar y Salir
      </button>
    </div>
  );
}
