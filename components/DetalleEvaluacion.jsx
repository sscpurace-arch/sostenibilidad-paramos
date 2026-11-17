'use client';
import { useState } from 'react';
import { documentosDeEvaluacion, abrirPdf } from '@/lib/reporte-sync';
import { fechaLegible } from '@/lib/pdf-utils';

const NOMBRE_DOC = { diagnostico: 'Diagnóstico de sostenibilidad', plan_accion: 'Plan de acción' };

const COLOR_PUNTAJE = (v) => v <= 1 ? '#DC2626' : v <= 2 ? '#EA580C' : v <= 3 ? '#D97706' : v <= 4 ? '#65A30D' : '#16A34A';

/**
 * Dentro del historial del productor (pedido 17-nov-2026): ver cómo se
 * calificó cada indicador en esa visita y abrir los PDF que se generaron.
 * Todo sale del celular; los PDF que no estén aquí se buscan en el servidor.
 */
export default function DetalleEvaluacion({ evaluacion, respuestas = [], indicadores = [], dimensiones = [], productor = null }) {
  const [verCalif, setVerCalif] = useState(false);
  const [docs, setDocs] = useState(null);        // null = sin cargar
  const [cargandoDocs, setCargandoDocs] = useState(false);
  const [verDocs, setVerDocs] = useState(false);

  const porIndicador = {};
  respuestas.forEach(r => { porIndicador[Number(r.indicador_id)] = r; });

  const alternarDocs = async () => {
    const abrir = !verDocs;
    setVerDocs(abrir);
    if (!abrir || docs) return;
    setCargandoDocs(true);
    try {
      setDocs(await documentosDeEvaluacion(evaluacion.id));
    } catch {
      setDocs([]);
    } finally {
      setCargandoDocs(false);
    }
  };

  const nombreArchivo = (tipo) => {
    const base = (productor?.nombre_completo || 'productor').toLowerCase().normalize('NFD')
      .replace(/[̀-ͯ]/g, '').replace(/[^a-z0-9]+/g, '-');
    return `${tipo === 'plan_accion' ? 'plan-accion' : 'diagnostico'}-${base}.pdf`;
  };

  return (
    <div className="flex flex-col gap-2">
      <div className="flex flex-wrap gap-2">
        <button
          onClick={() => setVerCalif(v => !v)}
          className="text-xs font-bold text-gray-700 bg-white border border-gray-200 px-3 py-1.5 rounded-lg"
        >
          {verCalif ? '▲ Ocultar calificaciones' : '▼ Ver calificaciones'}
        </button>
        <button
          onClick={alternarDocs}
          className="text-xs font-bold text-gray-700 bg-white border border-gray-200 px-3 py-1.5 rounded-lg"
        >
          {verDocs ? '▲ Ocultar documentos' : '📄 Documentos generados'}
        </button>
      </div>

      {verCalif && (
        <div className="bg-white rounded-xl border border-gray-100 p-3 flex flex-col gap-3">
          {respuestas.length === 0 ? (
            <p className="text-xs text-gray-400">No hay calificaciones de esta visita en el celular. Abre el productor con señal para traerlas.</p>
          ) : dimensiones.map(dim => {
            const inds = indicadores.filter(i => i.dimension === dim.nombre);
            if (inds.length === 0) return null;
            return (
              <div key={dim.nombre}>
                <p className="text-[10px] font-black uppercase tracking-wider mb-1" style={{ color: dim.color }}>{dim.nombre}</p>
                <ul className="flex flex-col gap-1">
                  {inds.map(ind => {
                    const r = porIndicador[ind.id];
                    const numero = r && typeof r.valor === 'number' ? r.valor : null;
                    return (
                      <li key={ind.id} className="flex items-start gap-2">
                        <span className="text-[10px] text-gray-400 w-5 text-right shrink-0 mt-0.5">{ind.orden}.</span>
                        <span className="text-xs text-gray-700 flex-1 leading-snug">
                          {ind.nombre}
                          {r?.heredado && <span className="block text-[10px] text-blue-700">No aplicó; se conserva la calificación anterior</span>}
                          {r?.observacion && <span className="block text-[10px] text-gray-400 italic">{r.observacion}</span>}
                        </span>
                        {numero !== null ? (
                          <span className="text-xs font-black text-white rounded-md px-2 py-0.5 shrink-0" style={{ backgroundColor: COLOR_PUNTAJE(numero) }}>{numero}</span>
                        ) : r?.no_aplica ? (
                          <span className="text-[10px] font-bold text-gray-500 bg-gray-100 rounded-md px-2 py-0.5 shrink-0">N/A</span>
                        ) : (
                          <span className="text-[10px] text-gray-300 shrink-0">—</span>
                        )}
                      </li>
                    );
                  })}
                </ul>
              </div>
            );
          })}
        </div>
      )}

      {verDocs && (
        <div className="bg-white rounded-xl border border-gray-100 p-3 flex flex-col gap-2">
          {cargandoDocs ? (
            <p className="text-xs text-gray-400">Buscando documentos…</p>
          ) : !docs || docs.length === 0 ? (
            <p className="text-xs text-gray-500 leading-snug">
              Todavía no hay PDF guardados de esta visita. Se guardan cuando se descargan desde
              <strong> Ver resultados</strong> (diagnóstico) o desde la pestaña <strong>Plan de Acción</strong>.
              {typeof navigator !== 'undefined' && !navigator.onLine && ' Sin señal solo se ven los de este celular.'}
            </p>
          ) : docs.map(d => (
            <button
              key={d.tipo}
              onClick={() => d.blob && abrirPdf(d.blob, nombreArchivo(d.tipo))}
              disabled={!d.blob}
              className="flex items-center gap-3 text-left px-3 py-2.5 rounded-xl border border-gray-200 active:bg-gray-50 disabled:opacity-50"
            >
              <span className="text-xl">📄</span>
              <span className="flex-1">
                <span className="block text-sm font-bold text-gray-800">{NOMBRE_DOC[d.tipo] || d.tipo}</span>
                <span className="block text-[10px] text-gray-400">Generado el {fechaLegible(d.generado_en, { mes: 'short' })}</span>
              </span>
              <span className="text-xs font-bold text-pnn-azul">Abrir</span>
            </button>
          ))}
          <p className="text-[10px] text-gray-400">Visita del {fechaLegible(evaluacion.fecha)}</p>
        </div>
      )}
    </div>
  );
}
