'use client';
import { useState, useEffect, useRef } from 'react';
import { createPortal } from 'react-dom';
import RadarChart from '@/components/RadarChart';
import PlanAccionSMART from '@/components/PlanAccionSMART';
import FirmaDigital from '@/components/FirmaDigital';
import { useDiagnostico } from '@/lib/hooks/useDiagnostico';
import { descargarDiagnosticoPdf } from '@/lib/pdf-diagnostico';
import { saveRecord } from '@/lib/sync-engine';

export default function ResultadosEvaluacion({
  evaluacionId,
  evaluacion,
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
  const [descargandoPdf, setDescargandoPdf] = useState(false);
  const [firmaTecnico, setFirmaTecnico] = useState(evaluacion?.firma_tecnico || '');
  const [firmaProductor, setFirmaProductor] = useState(evaluacion?.firma_productor || '');
  const { diagnostico, isLoading, isStale, error: errorIA, generarNuevo } = useDiagnostico(evaluacionId);
  // Espejo: si firmaTecnico se guarda y luego firmaProductor, el segundo guardado
  // no debe pisar el primero con el `evaluacion` prop (que nunca se refresca aquí).
  const firmasRef = useRef({ firma_tecnico: evaluacion?.firma_tecnico || '', firma_productor: evaluacion?.firma_productor || '' });

  const guardarFirma = async (campo, dataUrl) => {
    firmasRef.current = { ...firmasRef.current, [campo]: dataUrl };
    if (campo === 'firma_tecnico') setFirmaTecnico(dataUrl);
    else setFirmaProductor(dataUrl);
    if (!evaluacion) return;
    await saveRecord('evaluaciones', { ...evaluacion, ...firmasRef.current });
  };

  const handleDescargarPdf = async () => {
    setDescargandoPdf(true);
    try {
      await descargarDiagnosticoPdf({ diagnostico, productor, evaluacion });
    } catch (e) {
      console.error('Error generando PDF del diagnóstico:', e);
    } finally {
      setDescargandoPdf(false);
    }
  };
  // Portal a document.body: dentro de <main> (relative z-10) el overlay queda
  // ATRAPADO bajo el navbar (z-40) — los taps de "Finalizar" caían en los links del menú.
  const [mounted, setMounted] = useState(false);
  useEffect(() => setMounted(true), []);

  if (!mounted) return null;

  return createPortal(
    <div className="fixed inset-0 bg-white z-[60] flex flex-col">
      {/* Contenido scrolleable; el botón Finalizar vive en un pie fijo siempre visible */}
      <div className="flex-1 overflow-y-auto p-6 pb-4">
      <div className="max-w-xl mx-auto flex flex-col">
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

      {/* Tab: Resultados — se mantiene montado (display:contents/none) para no perder estado al alternar */}
      <div className={tab === 'resultados' ? 'contents' : 'hidden'}>
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
                onClick={() => generarNuevo({ productor, detalles, lastResults })}
                disabled={isLoading}
                className={`w-full py-4 rounded-2xl font-bold flex items-center justify-center gap-2 transition-all shadow-lg ${
                  isLoading ? 'bg-gray-100 text-gray-400 cursor-not-allowed' : 'bg-gradient-to-r from-blue-600 to-indigo-600 text-white active:scale-95'
                }`}
              >
                {isLoading ? (
                  <><span className="animate-spin text-xl">✨</span> Analizando...</>
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
                  <h3 className="font-bold text-blue-900 flex-1">Diagnóstico Inteligente</h3>
                  {diagnostico.score_global > 0 && (
                    <div className="text-center bg-white rounded-xl px-3 py-1.5 border border-blue-100 shadow-sm">
                      <p className="text-lg font-black text-blue-700 leading-none">{Number(diagnostico.score_global).toFixed(1)}</p>
                      <p className="text-[8px] text-blue-400 font-bold uppercase tracking-wider leading-none mt-0.5">/ 5</p>
                    </div>
                  )}
                </div>

                {/* Comparación visual con la evaluación anterior — por dimensión */}
                {lastAvgs && (
                  <div className="bg-white/70 rounded-xl p-3 mb-4 border border-blue-100">
                    <h4 className="text-[10px] font-black uppercase text-blue-400 mb-2 tracking-widest">Evolución desde la visita anterior</h4>
                    <div className="grid grid-cols-3 gap-2">
                      {dimensiones.map(d => {
                        const actual = parseFloat(currentAvgs[d.nombre]) || 0;
                        const anterior = parseFloat(lastAvgs[d.nombre]) || 0;
                        const diff = actual - anterior;
                        const signo = diff > 0.05 ? '↑' : diff < -0.05 ? '↓' : '→';
                        const color = diff > 0.05 ? '#16A34A' : diff < -0.05 ? '#DC2626' : '#9CA3AF';
                        return (
                          <div key={d.nombre} className="text-center">
                            <p className="text-[8px] uppercase font-bold text-gray-400 truncate">{d.nombre.split(' ')[0].substring(0, 6)}</p>
                            <p className="text-xs font-black" style={{ color }}>
                              {signo} {Math.abs(diff).toFixed(1)}
                            </p>
                          </div>
                        );
                      })}
                    </div>
                  </div>
                )}

                <p className="text-sm text-blue-800 leading-relaxed mb-6 italic">
                  &ldquo;{diagnostico.texto}&rdquo;
                </p>
                <div className="space-y-4">
                  <div>
                    <h4 className="text-[10px] font-black uppercase text-green-600 mb-2 tracking-widest">Fortalezas</h4>
                    <div className="flex flex-wrap gap-2">
                      {diagnostico.recomendaciones.fortalezas.map((f, i) => (
                        <span key={i} className="text-[11px] bg-white text-green-700 px-3 py-1 rounded-full border border-green-100 font-medium">✓ {f}</span>
                      ))}
                    </div>
                  </div>
                  {diagnostico.recomendaciones.debilidades?.length > 0 && (
                    <div>
                      <h4 className="text-[10px] font-black uppercase text-orange-500 mb-2 tracking-widest">Aspectos a Mejorar</h4>
                      <div className="flex flex-wrap gap-2">
                        {diagnostico.recomendaciones.debilidades.map((d, i) => (
                          <span key={i} className="text-[11px] bg-white text-orange-700 px-3 py-1 rounded-full border border-orange-100 font-medium">! {d}</span>
                        ))}
                      </div>
                    </div>
                  )}
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

                <button
                  onClick={handleDescargarPdf}
                  disabled={descargandoPdf}
                  className="w-full mt-5 py-3 rounded-xl font-bold text-sm flex items-center justify-center gap-2 bg-white border-2 border-blue-200 text-blue-700 active:scale-95 transition-all disabled:opacity-50"
                >
                  {descargandoPdf ? 'Generando PDF...' : (<><span>📄</span> Descargar PDF para el productor</>)}
                </button>
              </div>
            )}
            {errorIA && (
              <div className="mt-3 flex flex-col items-center gap-2">
                <p className="text-center text-xs text-red-500 font-medium">⚠️ {errorIA}</p>
                <button onClick={() => generarNuevo({ productor, detalles, lastResults })} disabled={isLoading} className="text-xs font-bold text-blue-600 underline hover:no-underline disabled:opacity-50">
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
      </div>

      {/* Tab: Plan de Acción — montado siempre; el form persiste al alternar de pestaña */}
      <div className={tab === 'plan' ? 'contents' : 'hidden'}>
        <PlanAccionSMART
          indicadores={indicadores}
          detalles={detalles}
          evaluacionId={evaluacionId}
          evaluacion={evaluacion}
          productor={productor}
        />
      </div>

      {/* Firmas — visibles en ambas pestañas, se guardan solas al terminar el trazo */}
      <div className="bg-gray-50 rounded-2xl p-4 border border-gray-100 mt-2">
        <h3 className="text-xs font-black uppercase text-gray-400 mb-3 text-center tracking-widest">Firmas de la visita</h3>
        <div className="grid grid-cols-2 gap-3">
          <FirmaDigital
            label="Técnico"
            valorGuardado={firmaTecnico}
            onGuardar={(v) => guardarFirma('firma_tecnico', v)}
          />
          <FirmaDigital
            label={evaluacion?.receptor_es_otro && evaluacion?.receptor_nombre
              ? `${evaluacion.receptor_nombre.split(' ')[0]} (${evaluacion.receptor_parentesco || 'receptor'})`
              : 'Productor'}
            valorGuardado={firmaProductor}
            onGuardar={(v) => guardarFirma('firma_productor', v)}
          />
        </div>
      </div>

      </div>
      </div>

      {/* Pie fijo: siempre alcanzable, con margen para la barra del navegador móvil */}
      <div
        className="flex-shrink-0 px-6 pt-3 bg-white border-t border-gray-100"
        style={{ paddingBottom: 'calc(0.75rem + env(safe-area-inset-bottom))' }}
      >
        <button
          onClick={onVolver}
          className="w-full max-w-xl mx-auto block bg-gray-800 text-white py-4 rounded-2xl font-bold text-lg shadow-xl active:scale-95 transition-all"
        >
          Finalizar y Salir
        </button>
      </div>
    </div>,
    document.body
  );
}
