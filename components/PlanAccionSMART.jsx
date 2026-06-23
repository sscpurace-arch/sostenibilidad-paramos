'use client';
import { useState, useEffect, useRef, useMemo } from 'react';
import { usePlanAccion } from '@/lib/hooks/usePlanAccion';
import { DIMENSION_COLORS } from '@/lib/db-offline';

const SCORE_COLOR = (s) => s <= 1 ? '#DC2626' : s <= 2 ? '#EA580C' : s <= 3 ? '#D97706' : '#65A30D';
const SCORE_LABEL = (s) => s <= 1 ? 'Muy bajo' : s <= 2 ? 'Bajo' : s <= 3 ? 'Regular' : 'Aceptable';

// Calcula fecha ISO (yyyy-mm-dd) a partir de hoy + N meses
function fechaDesdeMeses(meses) {
  const d = new Date();
  d.setMonth(d.getMonth() + meses);
  return d.toISOString().split('T')[0];
}

const AUTOSAVE_MS = 700;

export default function PlanAccionSMART({ indicadores, detalles, evaluacionId, productor }) {
  // Indicadores respondidos, ordenados de menor a mayor puntaje
  const ordenadosPorScore = useMemo(() => (
    [...indicadores]
      .filter(i => detalles[i.id]?.valor)
      .sort((a, b) => (detalles[a.id]?.valor || 0) - (detalles[b.id]?.valor || 0))
  ), [indicadores, detalles]);

  const top5Ids = useMemo(() => ordenadosPorScore.slice(0, 5).map(i => i.id), [ordenadosPorScore]);

  const { planes, isLoading, isLoadingIA, error, setError, savingState, sugerirConIA, guardarPlan, eliminarPlan } =
    usePlanAccion(evaluacionId);

  // Indicadores en el plan: top-5 por defecto + los que el técnico agregue/tengan plan guardado
  const [seleccionados, setSeleccionados] = useState([]);
  const [form, setForm] = useState({}); // { [id]: { meta, plazo, notas, sugerida_por_ia } }
  const [iaSugerencias, setIaSugerencias] = useState({}); // { [id]: { unidad, acciones_clave } }
  const [mostrarSelector, setMostrarSelector] = useState(false);
  const inicializado = useRef(false);
  const timers = useRef({});

  // Inicialización ÚNICA cuando terminó de cargar: form + selección desde lo guardado.
  useEffect(() => {
    if (isLoading || inicializado.current) return;
    const init = {};
    Object.entries(planes).forEach(([indId, p]) => {
      init[indId] = { meta: p.meta, plazo: p.plazo, notas: p.notas, sugerida_por_ia: p.sugerida_por_ia };
    });
    setForm(init);
    const guardadosIds = Object.keys(planes).map(Number);
    setSeleccionados([...new Set([...top5Ids, ...guardadosIds])]);
    inicializado.current = true;
  }, [isLoading, planes, top5Ids]);

  useEffect(() => () => Object.values(timers.current).forEach(clearTimeout), []);

  const programarGuardado = (indId) => {
    clearTimeout(timers.current[indId]);
    timers.current[indId] = setTimeout(() => {
      setForm(prev => {
        const data = prev[indId];
        if (data?.meta?.trim()) guardarPlan(indId, data);
        return prev;
      });
    }, AUTOSAVE_MS);
  };

  const handleField = (indId, field, value) => {
    setForm(prev => {
      const cur = prev[indId] || {};
      const next = { ...cur, [field]: value };
      // Si el técnico edita la meta a mano, deja de contar como sugerencia de IA
      if (field === 'meta') next.sugerida_por_ia = false;
      return { ...prev, [indId]: next };
    });
    programarGuardado(indId);
  };

  const guardarAhora = (indId) => {
    clearTimeout(timers.current[indId]);
    const data = form[indId];
    if (data?.meta?.trim()) guardarPlan(indId, data);
  };

  const agregarIndicador = (indId) => {
    const id = Number(indId);
    if (!seleccionados.includes(id)) setSeleccionados(prev => [...prev, id]);
    setMostrarSelector(false);
  };

  const quitarIndicador = async (indId) => {
    const id = Number(indId);
    const tieneMeta = !!form[id]?.meta?.trim();
    if (tieneMeta && !window.confirm('Este indicador tiene una meta. ¿Quitarlo del plan y borrarla?')) return;
    clearTimeout(timers.current[id]);
    setSeleccionados(prev => prev.filter(x => x !== id));
    setForm(prev => { const n = { ...prev }; delete n[id]; return n; });
    setIaSugerencias(prev => { const n = { ...prev }; delete n[id]; return n; });
    await eliminarPlan(id);
  };

  const handleSugerirIA = async () => {
    const indsPlan = seleccionados
      .map(id => indicadores.find(i => i.id === id))
      .filter(Boolean);
    const payload = indsPlan.map(i => ({
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
        const id = Number(s.indicador_id);
        // Solo pre-rellenar si el técnico no ha escrito su propia meta
        if (!next[id]?.meta?.trim()) {
          next[id] = {
            ...next[id],
            meta: s.meta || '',
            plazo: s.plazo_meses ? fechaDesdeMeses(s.plazo_meses) : next[id]?.plazo || '',
            sugerida_por_ia: true,
          };
          if (s.meta?.trim()) guardarPlan(id, next[id]);
        }
        if (s.unidad || s.acciones_clave) {
          extras[id] = { unidad: s.unidad, acciones_clave: s.acciones_clave || [] };
        }
      });
      return next;
    });
    setIaSugerencias(prev => ({ ...prev, ...extras }));
  };

  const indsSeleccionados = seleccionados
    .map(id => indicadores.find(i => i.id === id))
    .filter(Boolean);

  const disponiblesParaAgregar = ordenadosPorScore.filter(i => !seleccionados.includes(i.id));
  const conMeta = seleccionados.filter(id => form[id]?.meta?.trim()).length;

  if (isLoading) {
    return <div className="text-center py-12 text-gray-400 text-sm">Cargando plan...</div>;
  }

  return (
    <div className="flex flex-col gap-4 pb-6">

      {/* Header explicativo + estado de guardado */}
      <div className="bg-amber-50 border border-amber-200 rounded-2xl p-4 flex items-start justify-between gap-3">
        <p className="text-xs text-amber-800 font-medium leading-relaxed flex-1">
          <span className="font-black">Indicadores prioritarios</span> (los más bajos, marcados automáticamente).
          Define una meta SMART para cada uno — o usa IA para sugerirlas. Puedes agregar o quitar indicadores.
        </p>
        {savingState !== 'idle' && (
          <span className={`text-[10px] font-bold whitespace-nowrap mt-0.5 ${savingState === 'saved' ? 'text-green-600' : 'text-amber-600'}`}>
            {savingState === 'saving' ? 'Guardando…' : 'Guardado ✓'}
          </span>
        )}
      </div>

      {/* Botón Sugerir con IA */}
      <button
        onClick={handleSugerirIA}
        disabled={isLoadingIA || indsSeleccionados.length === 0}
        className={`w-full py-3.5 rounded-2xl font-bold flex items-center justify-center gap-2 transition-all shadow-md ${
          isLoadingIA || indsSeleccionados.length === 0
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
      {indsSeleccionados.map((ind, idx) => {
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
                    <span className="text-[10px] bg-green-100 text-green-700 px-2 py-0.5 rounded-full font-bold">✓</span>
                  )}
                </div>
              </div>
              <button
                onClick={() => quitarIndicador(ind.id)}
                className="text-gray-300 hover:text-red-400 text-lg leading-none px-1 flex-shrink-0"
                aria-label="Quitar indicador del plan"
              >
                ✕
              </button>
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
              <div>
                <label className="text-[10px] font-black uppercase text-gray-400 tracking-widest block mb-1">
                  Meta SMART *
                </label>
                <textarea
                  value={f.meta || ''}
                  onChange={e => handleField(ind.id, 'meta', e.target.value)}
                  onBlur={() => guardarAhora(ind.id)}
                  placeholder="¿Qué se va a lograr, cuánto y para cuándo? (ej: Plantar 30 árboles nativos en potreros en 6 meses)"
                  rows={2}
                  className="w-full text-sm text-gray-700 border border-gray-200 rounded-xl px-3 py-2 resize-none focus:outline-none focus:ring-2 focus:ring-indigo-200 placeholder:text-gray-300"
                />
                {f.sugerida_por_ia && f.meta && (
                  <p className="text-[10px] text-indigo-500 mt-0.5">✨ Sugerida por IA — puedes editarla</p>
                )}
              </div>

              <div>
                <label className="text-[10px] font-black uppercase text-gray-400 tracking-widest block mb-1">
                  Plazo objetivo
                </label>
                <input
                  type="date"
                  value={f.plazo || ''}
                  onChange={e => handleField(ind.id, 'plazo', e.target.value)}
                  onBlur={() => guardarAhora(ind.id)}
                  className="w-full text-sm text-gray-700 border border-gray-200 rounded-xl px-3 py-2 focus:outline-none focus:ring-2 focus:ring-indigo-200"
                />
              </div>

              <div>
                <label className="text-[10px] font-black uppercase text-gray-400 tracking-widest block mb-1">
                  Notas / observaciones
                </label>
                <input
                  type="text"
                  value={f.notas || ''}
                  onChange={e => handleField(ind.id, 'notas', e.target.value)}
                  onBlur={() => guardarAhora(ind.id)}
                  placeholder="Observaciones adicionales (opcional)"
                  className="w-full text-sm text-gray-700 border border-gray-200 rounded-xl px-3 py-2 focus:outline-none focus:ring-2 focus:ring-indigo-200 placeholder:text-gray-300"
                />
              </div>
            </div>
          </div>
        );
      })}

      {/* Agregar otro indicador */}
      {disponiblesParaAgregar.length > 0 && (
        mostrarSelector ? (
          <div className="bg-white rounded-2xl border border-gray-200 shadow-sm p-3">
            <p className="text-[10px] font-black uppercase text-gray-400 tracking-widest mb-2">Agregar indicador</p>
            <div className="flex flex-col gap-1 max-h-60 overflow-y-auto">
              {disponiblesParaAgregar.map(i => {
                const sc = detalles[i.id]?.valor || 0;
                return (
                  <button
                    key={i.id}
                    onClick={() => agregarIndicador(i.id)}
                    className="flex items-center gap-2 text-left px-3 py-2 rounded-xl hover:bg-gray-50 active:bg-gray-100"
                  >
                    <span
                      className="w-6 h-6 rounded-full flex items-center justify-center text-white text-[10px] font-black flex-shrink-0"
                      style={{ backgroundColor: SCORE_COLOR(sc) }}
                    >
                      {sc}
                    </span>
                    <span className="text-sm text-gray-700 flex-1 leading-tight">{i.nombre}</span>
                    <span className="text-[10px] font-bold uppercase" style={{ color: DIMENSION_COLORS[i.dimension] || '#666' }}>
                      {i.dimension}
                    </span>
                  </button>
                );
              })}
            </div>
            <button onClick={() => setMostrarSelector(false)} className="w-full text-xs text-gray-400 font-bold mt-2 py-1">
              Cancelar
            </button>
          </div>
        ) : (
          <button
            onClick={() => setMostrarSelector(true)}
            className="w-full border-2 border-dashed border-gray-300 text-gray-500 py-3 rounded-2xl font-bold text-sm active:scale-95 transition-all"
          >
            + Agregar otro indicador
          </button>
        )
      )}

      {/* Resumen — el guardado es automático */}
      <p className="text-center text-xs text-gray-400 mt-1">
        {conMeta > 0
          ? `${conMeta} de ${indsSeleccionados.length} indicadores con meta definida · se guarda automáticamente`
          : 'Define al menos una meta para empezar el plan'}
      </p>
    </div>
  );
}
