'use client';
import { useState, useEffect } from 'react';
import { usePlanAccion } from '@/lib/hooks/usePlanAccion';
import { DIMENSION_COLORS } from '@/lib/db-offline';

const SCORE_COLOR = (s) => s <= 1 ? '#DC2626' : s <= 2 ? '#EA580C' : '#D97706';
const SCORE_LABEL = (s) => s <= 1 ? 'Muy bajo' : s <= 2 ? 'Bajo' : 'Regular';

// Calcula fecha ISO (yyyy-mm-dd) a partir de hoy + N meses
function fechaDesdeMeses(meses) {
  const d = new Date();
  d.setMonth(d.getMonth() + meses);
  return d.toISOString().split('T')[0];
}

export default function PlanAccionSMART({ indicadores, detalles, evaluacionId, productor }) {
  const indicadoresDebiles = [...indicadores]
    .filter(i => detalles[i.id]?.valor)
    .sort((a, b) => (detalles[a.id]?.valor || 0) - (detalles[b.id]?.valor || 0))
    .slice(0, 5);

  const { planes, isLoading, isLoadingIA, error, setError, sugerirConIA, guardarPlan, planGuardado } =
    usePlanAccion(evaluacionId);

  // Estado local del formulario: { [indicadorId]: { meta, plazo, notas, sugerida_por_ia } }
  const [form, setForm] = useState({});
  const [guardando, setGuardando] = useState(false);
  const [iaSugerencias, setIaSugerencias] = useState({}); // { [id]: { unidad, acciones_clave } }

  // Inicializar form con planes guardados al cargar
  useEffect(() => {
    if (!isLoading && Object.keys(planes).length > 0) {
      const init = {};
      Object.entries(planes).forEach(([indId, p]) => {
        init[indId] = { meta: p.meta, plazo: p.plazo, notas: p.notas, sugerida_por_ia: p.sugerida_por_ia };
      });
      setForm(init);
    }
  }, [isLoading, planes]);

  const handleField = (indId, field, value) => {
    setForm(prev => ({ ...prev, [indId]: { ...prev[indId], [field]: value } }));
  };

  const handleSugerirIA = async () => {
    const payload = indicadoresDebiles.map(i => ({
      id: i.id,
      nombre: i.nombre,
      descripcion: i.descripcion,
      dimension: i.dimension,
      score: detalles[i.id]?.valor,
    }));

    const sugerencias = await sugerirConIA(payload, productor);
    if (!sugerencias) return;

    const extras = {};
    setForm(prev => {
      const next = { ...prev };
      sugerencias.forEach(s => {
        const id = String(s.indicador_id);
        // Solo pre-rellenar si el técnico no ha escrito nada
        if (!next[id]?.meta) {
          next[id] = {
            ...next[id],
            meta: s.meta || '',
            plazo: s.plazo_meses ? fechaDesdeMeses(s.plazo_meses) : next[id]?.plazo || '',
            sugerida_por_ia: true,
          };
        }
        if (s.unidad || s.acciones_clave) {
          extras[id] = { unidad: s.unidad, acciones_clave: s.acciones_clave || [] };
        }
      });
      return next;
    });
    setIaSugerencias(extras);
  };

  const handleGuardar = async () => {
    setGuardando(true);
    try {
      for (const ind of indicadoresDebiles) {
        const data = form[ind.id];
        if (data?.meta?.trim()) {
          await guardarPlan(ind.id, data);
        }
      }
    } finally {
      setGuardando(false);
    }
  };

  const planesGuardadosCount = indicadoresDebiles.filter(i => planes[i.id]?.meta).length;
  const formConMeta = indicadoresDebiles.filter(i => form[i.id]?.meta?.trim()).length;

  if (isLoading) {
    return <div className="text-center py-12 text-gray-400 text-sm">Cargando plan...</div>;
  }

  return (
    <div className="flex flex-col gap-4 pb-6">

      {/* Header explicativo */}
      <div className="bg-amber-50 border border-amber-200 rounded-2xl p-4">
        <p className="text-xs text-amber-800 font-medium leading-relaxed">
          <span className="font-black">5 indicadores más débiles</span> identificados automáticamente.
          Define una meta SMART para cada uno — o usa IA para sugerir metas.
        </p>
      </div>

      {/* Botón Sugerir con IA */}
      <button
        onClick={handleSugerirIA}
        disabled={isLoadingIA}
        className={`w-full py-3.5 rounded-2xl font-bold flex items-center justify-center gap-2 transition-all shadow-md ${
          isLoadingIA
            ? 'bg-gray-100 text-gray-400 cursor-not-allowed'
            : 'bg-gradient-to-r from-indigo-600 to-blue-600 text-white active:scale-95'
        }`}
      >
        {isLoadingIA ? (
          <><span className="animate-spin text-lg">✨</span> Generando sugerencias...</>
        ) : (
          <><span>✨</span> Sugerir metas con IA</>
        )}
      </button>

      {error && (
        <div className="bg-red-50 border border-red-200 rounded-xl px-4 py-3 flex items-start gap-2">
          <span className="text-red-500 text-sm">⚠️</span>
          <p className="text-xs text-red-700 flex-1">{error}</p>
          <button onClick={() => setError(null)} className="text-red-400 text-xs font-bold">✕</button>
        </div>
      )}

      {/* Tarjetas por indicador */}
      {indicadoresDebiles.map((ind, idx) => {
        const score = detalles[ind.id]?.valor || 0;
        const color = DIMENSION_COLORS[ind.dimension] || '#666';
        const scoreColor = SCORE_COLOR(score);
        const f = form[ind.id] || {};
        const extra = iaSugerencias[ind.id];
        const guardado = !!planes[ind.id]?.meta;

        return (
          <div key={ind.id} className="bg-white rounded-2xl border border-gray-100 shadow-sm overflow-hidden">
            {/* Cabecera del indicador */}
            <div className="flex items-center gap-3 px-4 py-3 border-b border-gray-50">
              <div
                className="w-7 h-7 rounded-full flex items-center justify-center text-white text-xs font-black flex-shrink-0"
                style={{ backgroundColor: scoreColor }}
              >
                {idx + 1}
              </div>
              <div className="flex-1 min-w-0">
                <p className="text-sm font-bold text-gray-800 leading-tight">{ind.nombre}</p>
                <div className="flex items-center gap-2 mt-0.5">
                  <span className="text-[10px] font-bold uppercase" style={{ color }}>{ind.dimension}</span>
                  <span className="text-[10px] text-gray-400">·</span>
                  <span className="text-[10px] font-bold" style={{ color: scoreColor }}>
                    {score}/5 — {SCORE_LABEL(score)}
                  </span>
                  {guardado && (
                    <span className="ml-auto text-[10px] bg-green-100 text-green-700 px-2 py-0.5 rounded-full font-bold">✓ guardado</span>
                  )}
                </div>
              </div>
            </div>

            {/* Sugerencia IA — unidad + acciones */}
            {extra && (
              <div className="bg-indigo-50 px-4 py-2.5 border-b border-indigo-100">
                {extra.unidad && (
                  <p className="text-[10px] text-indigo-700 font-bold uppercase tracking-wider mb-1">
                    Unidad: {extra.unidad}
                  </p>
                )}
                {extra.acciones_clave?.length > 0 && (
                  <ul className="space-y-0.5">
                    {extra.acciones_clave.map((a, i) => (
                      <li key={i} className="text-[11px] text-indigo-800 flex gap-1.5">
                        <span className="text-indigo-400 font-bold">•</span>{a}
                      </li>
                    ))}
                  </ul>
                )}
              </div>
            )}

            {/* Formulario SMART */}
            <div className="px-4 py-3 flex flex-col gap-3">
              {/* Meta */}
              <div>
                <label className="text-[10px] font-black uppercase text-gray-400 tracking-widest block mb-1">
                  Meta SMART *
                </label>
                <textarea
                  value={f.meta || ''}
                  onChange={e => handleField(ind.id, 'meta', e.target.value)}
                  placeholder={`¿Qué se va a lograr? (ej: Plantar 30 árboles nativos en potreros antes de diciembre)`}
                  rows={2}
                  className="w-full text-sm text-gray-700 border border-gray-200 rounded-xl px-3 py-2 resize-none focus:outline-none focus:ring-2 focus:ring-indigo-200 placeholder:text-gray-300"
                />
                {f.sugerida_por_ia && f.meta && (
                  <p className="text-[10px] text-indigo-500 mt-0.5">✨ Sugerida por IA — puedes editarla</p>
                )}
              </div>

              {/* Plazo */}
              <div>
                <label className="text-[10px] font-black uppercase text-gray-400 tracking-widest block mb-1">
                  Plazo objetivo
                </label>
                <input
                  type="date"
                  value={f.plazo || ''}
                  onChange={e => handleField(ind.id, 'plazo', e.target.value)}
                  className="w-full text-sm text-gray-700 border border-gray-200 rounded-xl px-3 py-2 focus:outline-none focus:ring-2 focus:ring-indigo-200"
                />
              </div>

              {/* Notas opcionales */}
              <div>
                <label className="text-[10px] font-black uppercase text-gray-400 tracking-widest block mb-1">
                  Notas / observaciones
                </label>
                <input
                  type="text"
                  value={f.notas || ''}
                  onChange={e => handleField(ind.id, 'notas', e.target.value)}
                  placeholder="Observaciones adicionales (opcional)"
                  className="w-full text-sm text-gray-700 border border-gray-200 rounded-xl px-3 py-2 focus:outline-none focus:ring-2 focus:ring-indigo-200 placeholder:text-gray-300"
                />
              </div>
            </div>
          </div>
        );
      })}

      {/* Botón Guardar */}
      <button
        onClick={handleGuardar}
        disabled={guardando || formConMeta === 0}
        className={`w-full py-4 rounded-2xl font-bold text-base shadow-lg transition-all ${
          guardando || formConMeta === 0
            ? 'bg-gray-100 text-gray-400 cursor-not-allowed'
            : 'bg-[#03A64A] text-white active:scale-95'
        }`}
      >
        {guardando ? 'Guardando...' : `Guardar plan (${formConMeta} indicador${formConMeta !== 1 ? 'es' : ''})`}
      </button>

      {planGuardado && (
        <div className="bg-green-50 border border-green-200 rounded-xl px-4 py-3 text-center animate-in fade-in duration-300">
          <p className="text-sm font-bold text-green-700">✓ Plan guardado exitosamente</p>
          <p className="text-xs text-green-600 mt-0.5">
            {planesGuardadosCount} de 5 indicadores con meta definida
          </p>
        </div>
      )}

      {planesGuardadosCount > 0 && !planGuardado && (
        <p className="text-center text-xs text-gray-400">
          {planesGuardadosCount} de 5 indicadores con meta guardada
        </p>
      )}
    </div>
  );
}
