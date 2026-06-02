'use client';
import { useState, useEffect, useRef, useCallback } from 'react';
import { db, DIMENSION_COLORS } from '@/lib/db-offline';
import { saveRecord } from '@/lib/sync-engine';
import useOfflineSync from '@/lib/hooks/useOfflineSync';
import { crearSchemaEvaluacion } from '@/lib/validation';
import { useRouter } from 'next/navigation';

import IndicadorCard from '@/components/IndicadorCard';
import ResultadosEvaluacion from '@/components/ResultadosEvaluacion';
import EvaluacionHeader from '@/components/EvaluacionHeader';
import EvaluacionFooter from '@/components/EvaluacionFooter';
import ValidationBanner from '@/components/ValidationBanner';

export default function EvaluacionPage({ params }) {
  const [evaluacion, setEvaluacion] = useState(null);
  const [productor, setProductor] = useState(null);
  const [indicadores, setIndicadores] = useState([]);
  const [dimensiones, setDimensiones] = useState([]);
  const [detalles, setDetalles] = useState({});
  const [loading, setLoading] = useState(true);
  const [showResults, setShowResults] = useState(false);
  const [lastResults, setLastResults] = useState(null);
  const [validationErrors, setValidationErrors] = useState({});
  const [showErrors, setShowErrors] = useState(false);
  const [autoSaveMsg, setAutoSaveMsg] = useState(null);

  const detallesRef = useRef(detalles);
  const dirtyRef = useRef(false);
  const router = useRouter();
  const { pendingCount } = useOfflineSync();

  useEffect(() => { detallesRef.current = detalles; }, [detalles]);

  // ─── Autosave cada 30 segundos ──────────────────────────
  useEffect(() => {
    const interval = setInterval(async () => {
      if (!dirtyRef.current) return;
      try {
        const entries = Object.entries(detallesRef.current).filter(([_, d]) => d.valor);
        for (const [indId, det] of entries) {
          await saveRecord('respuestas_indicadores', {
            id: det.id, evaluacion_id: params.id,
            indicador_id: indId, valor: det.valor, observacion: det.observacion || ''
          });
        }
        dirtyRef.current = false;
        setAutoSaveMsg('Guardado automático ✓');
        setTimeout(() => setAutoSaveMsg(null), 2000);
      } catch (e) { console.error('[autosave] Error:', e); }
    }, 30000);
    return () => clearInterval(interval);
  }, [params.id]);

  useEffect(() => {
    async function cargarDatos() {
      setLoading(true);
      const eval_ = await db.evaluaciones.get(params.id);
      if (!eval_) return router.push('/');
      setEvaluacion(eval_);

      const [prod, inds, existingDets] = await Promise.all([
        db.productores.get(eval_.finca_id),
        db.indicadores.orderBy('orden').toArray(),
        db.respuestas_indicadores.where('evaluacion_id').equals(eval_.id).toArray()
      ]);

      setProductor(prod);
      setIndicadores(inds);
      setDimensiones([...new Set(inds.map(i => i.dimension))].map(nombre => ({
        nombre, color: DIMENSION_COLORS[nombre] || '#666'
      })));

      const detMap = {};
      existingDets.forEach(d => { detMap[d.indicador_id] = { id: d.id, valor: d.valor, observacion: d.observacion }; });
      setDetalles(detMap);

      const prevEvals = await db.evaluaciones
        .where('finca_id').equals(eval_.finca_id)
        .and(e => e.estado === 'enviada' && e.id !== eval_.id)
        .reverse().sortBy('fecha');
      if (prevEvals.length > 0) {
        setLastResults(await db.respuestas_indicadores.where('evaluacion_id').equals(prevEvals[0].id).toArray());
      }
      setLoading(false);
    }

    cargarDatos();
  }, [params.id, router]);

  // ─── Handlers ───────────────────────────────────────────
  const handleScoreChange = useCallback(async (indId, score) => {
    const recordId = detalles[indId]?.id || crypto.randomUUID();
    setDetalles(prev => ({ ...prev, [indId]: { ...prev[indId], id: recordId, valor: score } }));
    dirtyRef.current = true;
    if (validationErrors[indId]) setValidationErrors(prev => { const n = { ...prev }; delete n[indId]; return n; });
    await saveRecord('respuestas_indicadores', {
      id: recordId, evaluacion_id: params.id, indicador_id: indId,
      valor: score, observacion: detalles[indId]?.observacion || ''
    });
  }, [detalles, params.id, validationErrors]);

  const handleObservationChange = useCallback(async (indId, text) => {
    const recordId = detalles[indId]?.id || crypto.randomUUID();
    setDetalles(prev => ({ ...prev, [indId]: { ...prev[indId], id: recordId, observacion: text } }));
    dirtyRef.current = true;
    if (detalles[indId]?.valor) {
      await saveRecord('respuestas_indicadores', {
        id: recordId, evaluacion_id: params.id, indicador_id: indId,
        valor: detalles[indId].valor, observacion: text
      });
    }
  }, [detalles, params.id]);

  const handleFinalizar = async () => {
    const { validate } = crearSchemaEvaluacion(indicadores);
    const result = validate(detalles);
    if (!result.success) {
      setValidationErrors(result.errors);
      setShowErrors(true);
      const el = document.getElementById(`ind-${Object.keys(result.errors)[0]}`);
      if (el) el.scrollIntoView({ behavior: 'smooth', block: 'center' });
      return;
    }
    await saveRecord('evaluaciones', { ...evaluacion, estado: 'enviada' });

    const avgs = calculateAverages(detalles);
    const puntajeGlobal = (
      Object.values(avgs).reduce((a, b) => a + parseFloat(b), 0) /
      Object.values(avgs).length
    ).toFixed(1);

    fetch('/api/notificar', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        productor: productor.nombre_completo,
        fecha: new Date(evaluacion.fecha).toLocaleDateString('es-CO'),
        puntaje: `${puntajeGlobal} / 5`,
        sector: productor.sector,
      }),
    }).catch(() => {});

    setShowResults(true);
  };

  const handleGuardarSalir = async () => {
    for (const [indId, det] of Object.entries(detalles).filter(([_, d]) => d.valor)) {
      await saveRecord('respuestas_indicadores', {
        id: det.id, evaluacion_id: params.id,
        indicador_id: indId, valor: det.valor, observacion: det.observacion || ''
      });
    }
    router.push('/');
  };

  const handleCancelar = () => {
    if (window.confirm('¿Está seguro de cancelar? Se perderán los cambios no guardados en esta sesión.')) {
      router.push('/');
    }
  };

  // ─── Render ─────────────────────────────────────────────

  if (loading) return <div className="p-10 text-center text-gray-400">Cargando evaluación...</div>;

  const totalRespondidos = Object.keys(detalles).filter(id => detalles[id]?.valor).length;
  const totalIndicadores = indicadores.length;
  const todosCompletos = totalRespondidos === totalIndicadores;

  const calculateAverages = (dets) => {
    const results = {};
    dimensiones.forEach(d => {
      const scores = indicadores.filter(i => i.dimension === d.nombre).map(i => dets[i.id]?.valor).filter(s => s);
      results[d.nombre] = scores.length > 0 ? (scores.reduce((a, b) => a + b, 0) / scores.length).toFixed(1) : 0;
    });
    return results;
  };

  if (showResults) {
    const currentAvgs = calculateAverages(detalles);
    const lastAvgs = lastResults ? calculateAverages(
      lastResults.reduce((acc, d) => ({ ...acc, [d.indicador_id]: { valor: d.valor } }), {})
    ) : null;
    return (
      <ResultadosEvaluacion
        evaluacionId={params.id}
        productor={productor} indicadores={indicadores} dimensiones={dimensiones}
        detalles={detalles} lastResults={lastResults}
        currentAvgs={currentAvgs} lastAvgs={lastAvgs}
        onVolver={() => router.push('/')}
      />
    );
  }

  return (
    <div className="flex flex-col gap-4 pb-36">
      <EvaluacionHeader
        nombreProductor={productor.nombre_completo}
        totalRespondidos={totalRespondidos} totalIndicadores={totalIndicadores}
        todosCompletos={todosCompletos} autoSaveMsg={autoSaveMsg} pendingCount={pendingCount}
      />

      {dimensiones.map(dim => (
        <div key={dim.nombre} className="flex flex-col gap-3 mt-2">
          <div className="bg-[#2E7D32]/10 p-2 rounded text-[#2E7D32] font-black text-xs uppercase tracking-wider">
            Dimensión {dim.nombre}
          </div>
          {indicadores.filter(i => i.dimension === dim.nombre).map(ind => (
            <div key={ind.id} id={`ind-${ind.id}`}>
              <IndicadorCard
                indicador={ind} score={detalles[ind.id]?.valor}
                onScoreChange={(s) => handleScoreChange(ind.id, s)}
                observation={detalles[ind.id]?.observacion}
                onObservationChange={(t) => handleObservationChange(ind.id, t)}
                showError={showErrors && !detalles[ind.id]?.valor}
              />
            </div>
          ))}
        </div>
      ))}

      {showErrors && <ValidationBanner errorCount={Object.keys(validationErrors).length} />}

      <EvaluacionFooter
        onGuardarSalir={handleGuardarSalir} onFinalizar={handleFinalizar}
        onCancelar={handleCancelar}
        todosCompletos={todosCompletos} totalRespondidos={totalRespondidos}
        totalIndicadores={totalIndicadores}
      />

    </div>
  );
}
