'use client';
import { useState, useEffect, useRef, useCallback, Suspense } from 'react';
import { db, DIMENSION_COLORS } from '@/lib/db-offline';
import { saveRecord } from '@/lib/sync-engine';
import useOfflineSync from '@/lib/hooks/useOfflineSync';
import { crearSchemaEvaluacion } from '@/lib/validation';
import { useFotos } from '@/lib/hooks/useFotos';
import { createClient } from '@/lib/supabase';
import { useRouter, useSearchParams } from 'next/navigation';

import IndicadorCard from '@/components/IndicadorCard';
import ResultadosEvaluacion from '@/components/ResultadosEvaluacion';
import EvaluacionHeader from '@/components/EvaluacionHeader';
import EvaluacionFooter from '@/components/EvaluacionFooter';
import ValidationBanner from '@/components/ValidationBanner';
import PanoramicaCard from '@/components/PanoramicaCard';

// Ruta estática + parámetro por query (?id=EVAL) para funcionar sin conexión.
function EvaluacionContent() {
  const searchParams = useSearchParams();
  const evalId = searchParams.get('id');

  const [evaluacion, setEvaluacion] = useState(null);
  const [productor, setProductor] = useState(null);
  const [indicadores, setIndicadores] = useState([]);
  const [dimensiones, setDimensiones] = useState([]);
  const [detalles, setDetalles] = useState({});
  const [loading, setLoading] = useState(true);
  const [errorCarga, setErrorCarga] = useState(null);
  const [showResults, setShowResults] = useState(false);
  const [lastResults, setLastResults] = useState(null);
  const [validationErrors, setValidationErrors] = useState({});
  const [showErrors, setShowErrors] = useState(false);
  const [autoSaveMsg, setAutoSaveMsg] = useState(null);
  const [tecnicoNombre, setTecnicoNombre] = useState('Técnico');
  const [fotosFaltantes, setFotosFaltantes] = useState([]);

  const detallesRef = useRef(detalles);
  const dirtyRef = useRef(false);

  /**
   * Id de la fila de cada indicador, en un ref y no en el estado.
   *
   * Cada handler hacía `detalles[ind]?.id || crypto.randomUUID()`. Dos
   * escrituras en el mismo tick (elegir puntaje y escribir enseguida) leen el
   * mismo estado sin id y acuñan UUIDs distintos, con lo que el indicador
   * termina con dos filas y la evaluación queda con datos contradictorios.
   * El ref se actualiza al instante, así que la segunda escritura ya ve el id.
   */
  const idsRef = useRef({});
  const idDeIndicador = useCallback((indId) => {
    const k = String(indId);
    if (!idsRef.current[k]) idsRef.current[k] = crypto.randomUUID();
    return idsRef.current[k];
  }, []);
  const router = useRouter();
  const supabase = createClient();
  const { pendingCount } = useOfflineSync();

  // Evidencia fotográfica. El hook tolera evaluacion === null mientras carga.
  const fotos = useFotos(evalId, {
    tecnicoId: evaluacion?.tecnico_id,
    esPrueba: !!evaluacion?.es_prueba,
  });

  useEffect(() => { detallesRef.current = detalles; }, [detalles]);

  // ─── Autosave cada 30 segundos ──────────────────────────
  useEffect(() => {
    const interval = setInterval(async () => {
      if (!dirtyRef.current) return;
      try {
        const entries = Object.entries(detallesRef.current).filter(([_, d]) => d.valor);
        for (const [indId, det] of entries) {
          await saveRecord('respuestas_indicadores', {
            id: det.id || idsRef.current[indId], evaluacion_id: evalId,
            indicador_id: indId, valor: det.valor, observacion: det.observacion || '',
            motivo_sin_foto: det.motivo_sin_foto || null, entradas: det.entradas || null
          });
        }
        dirtyRef.current = false;
        setAutoSaveMsg('Guardado automático ✓');
        setTimeout(() => setAutoSaveMsg(null), 2000);
      } catch (e) { console.error('[autosave] Error:', e); }
    }, 30000);
    return () => clearInterval(interval);
  }, [evalId]);

  useEffect(() => {
    async function cargarDatos() {
      setLoading(true);
      setErrorCarga(null);
      if (!evalId) {
        setLoading(false);
        setErrorCarga('No se indicó qué calificación abrir.');
        return;
      }

      // Si la calificación no está en el celular, buscarla en el servidor antes
      // de rendirse. Devolver al inicio en silencio —lo que hacía antes— parece
      // que la app "se saliera sola" y no deja pista de qué pasó.
      let eval_ = await db.evaluaciones.get(evalId);
      if (!eval_ && navigator.onLine) {
        try {
          const { data } = await supabase
            .from('evaluaciones').select('*').eq('id', evalId).maybeSingle();
          if (data) {
            await db.evaluaciones.put(data);
            eval_ = data;
            const { data: resp } = await supabase
              .from('respuestas_indicadores').select('*').eq('evaluacion_id', evalId);
            if (resp?.length > 0) await db.respuestas_indicadores.bulkPut(resp);
          }
        } catch (e) { console.error('Error buscando la calificación en el servidor:', e); }
      }
      if (!eval_) {
        setLoading(false);
        setErrorCarga(navigator.onLine
          ? 'No se encontró esta calificación. Puede que se haya borrado o que aún no esté en este celular.'
          : 'Esta calificación no está en el celular y no hay conexión para buscarla.');
        return;
      }
      setEvaluacion(eval_);

      const [prodLocal, inds, existingDets] = await Promise.all([
        db.productores.get(eval_.finca_id),
        db.indicadores.orderBy('orden').toArray(),
        db.respuestas_indicadores.where('evaluacion_id').equals(eval_.id).toArray()
      ]);

      // El productor puede faltar localmente. No es motivo para cerrar la
      // calificación: se intenta traer y, si no se puede, se sigue con el
      // nombre en blanco en vez de romper la pantalla entera.
      let prod = prodLocal;
      if (!prod && navigator.onLine) {
        try {
          const { data } = await supabase
            .from('productores').select('*').eq('id', eval_.finca_id).maybeSingle();
          if (data) { await db.productores.put(data); prod = data; }
        } catch (e) { console.error('Error buscando el productor en el servidor:', e); }
      }
      setProductor(prod || { id: eval_.finca_id, nombre_completo: 'Productor sin datos locales' });
      setIndicadores(inds);
      setDimensiones([...new Set(inds.map(i => i.dimension))].map(nombre => ({
        nombre, color: DIMENSION_COLORS[nombre] || '#666'
      })));

      const detMap = {};
      idsRef.current = {};
      existingDets.forEach(d => {
        idsRef.current[String(d.indicador_id)] = d.id;
        detMap[d.indicador_id] = {
          id: d.id, valor: d.valor, observacion: d.observacion,
          motivo_sin_foto: d.motivo_sin_foto || '', entradas: d.entradas || null
        };
      });
      setDetalles(detMap);

      const prevEvals = await db.evaluaciones
        .where('finca_id').equals(eval_.finca_id)
        .and(e => e.estado === 'enviada' && e.id !== eval_.id)
        .reverse().sortBy('fecha');
      if (prevEvals.length > 0) {
        setLastResults(await db.respuestas_indicadores.where('evaluacion_id').equals(prevEvals[0].id).toArray());
      }
      // Cargar nombre del técnico
      const isMock = !!localStorage.getItem('mock-user-session');
      if (isMock) {
        setTecnicoNombre('Usuario Prueba');
      } else {
        try {
          const { data: { user } } = await supabase.auth.getUser();
          if (user) {
            const { data: userData } = await supabase.from('usuarios').select('nombre').eq('id', user.id).single();
            setTecnicoNombre(userData?.nombre || user.user_metadata?.nombre || user.email?.split('@')[0] || 'Técnico');
          }
        } catch { /* silencioso */ }
      }

      setLoading(false);
    }

    cargarDatos();
  }, [evalId, router, supabase]);

  // ─── Handlers ───────────────────────────────────────────
  const handleScoreChange = useCallback(async (indId, score) => {
    const recordId = idDeIndicador(indId);
    setDetalles(prev => ({ ...prev, [indId]: { ...prev[indId], id: recordId, valor: score } }));
    dirtyRef.current = true;
    if (validationErrors[indId]) setValidationErrors(prev => { const n = { ...prev }; delete n[indId]; return n; });
    await saveRecord('respuestas_indicadores', {
      id: recordId, evaluacion_id: evalId, indicador_id: indId,
      valor: score, observacion: detalles[indId]?.observacion || '',
      motivo_sin_foto: detalles[indId]?.motivo_sin_foto || null,
      entradas: detalles[indId]?.entradas || null
    });
  }, [detalles, evalId, validationErrors, idDeIndicador]);

  const handleObservationChange = useCallback(async (indId, text) => {
    const recordId = idDeIndicador(indId);
    setDetalles(prev => ({ ...prev, [indId]: { ...prev[indId], id: recordId, observacion: text } }));
    dirtyRef.current = true;
    if (detalles[indId]?.valor) {
      await saveRecord('respuestas_indicadores', {
        id: recordId, evaluacion_id: evalId, indicador_id: indId,
        valor: detalles[indId].valor, observacion: text,
        motivo_sin_foto: detalles[indId]?.motivo_sin_foto || null,
        entradas: detalles[indId]?.entradas || null
      });
    }
  }, [detalles, evalId, idDeIndicador]);

  // Por qué no se pudo tomar la foto de un indicador crítico (ver validation.js)
  const handleMotivoSinFotoChange = useCallback(async (indId, text) => {
    const recordId = idDeIndicador(indId);
    setDetalles(prev => ({ ...prev, [indId]: { ...prev[indId], id: recordId, motivo_sin_foto: text } }));
    dirtyRef.current = true;
    if (detalles[indId]?.valor) {
      await saveRecord('respuestas_indicadores', {
        id: recordId, evaluacion_id: evalId, indicador_id: indId,
        valor: detalles[indId].valor, observacion: detalles[indId]?.observacion || '',
        motivo_sin_foto: text, entradas: detalles[indId]?.entradas || null
      });
    }
  }, [detalles, evalId, idDeIndicador]);

  /**
   * Una calculadora aplicó su resultado: puntaje, desglose y entradas crudas
   * entran juntos, en una sola escritura.
   *
   * Las entradas se guardan además del resumen textual para que el dato sea
   * auditable y se pueda recalcular si una fórmula cambia.
   */
  const handleCalculoAplicado = useCallback(async (indId, { valor, observacion, entradas }) => {
    const recordId = idDeIndicador(indId);
    setDetalles(prev => ({
      ...prev,
      [indId]: { ...prev[indId], id: recordId, valor, observacion, entradas }
    }));
    dirtyRef.current = true;
    if (validationErrors[indId]) setValidationErrors(prev => { const n = { ...prev }; delete n[indId]; return n; });
    await saveRecord('respuestas_indicadores', {
      id: recordId, evaluacion_id: evalId, indicador_id: indId,
      valor, observacion, entradas,
      motivo_sin_foto: detalles[indId]?.motivo_sin_foto || null
    });
  }, [detalles, evalId, validationErrors, idDeIndicador]);

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

    // Evidencia fotográfica desactivada temporalmente como bloqueo (taller 2026-09-07):
    // las fotos quedan opcionales, no impiden enviar la calificación.
    setFotosFaltantes([]);

    await saveRecord('evaluaciones', { ...evaluacion, estado: 'enviada' });

    const avgs = calculateAverages(detalles);
    const puntajeGlobal = (
      Object.values(avgs).reduce((a, b) => a + parseFloat(b), 0) /
      Object.values(avgs).length
    ).toFixed(1);

    fetch('/api/notificar', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'x-notify-key': process.env.NEXT_PUBLIC_NOTIFY_KEY || '',
      },
      body: JSON.stringify({
        productor: productor.nombre_completo,
        fecha: new Date(evaluacion.fecha).toLocaleDateString('es-CO'),
        puntaje: `${puntajeGlobal} / 5`,
        sector: productor.sector,
        tecnico: tecnicoNombre,
        es_prueba: !!evaluacion.es_prueba,
      }),
    }).catch(() => {});

    setShowResults(true);
  };

  const handleGuardarSalir = async () => {
    for (const [indId, det] of Object.entries(detalles).filter(([_, d]) => d.valor)) {
      await saveRecord('respuestas_indicadores', {
        id: det.id || idsRef.current[indId], evaluacion_id: evalId,
        indicador_id: indId, valor: det.valor, observacion: det.observacion || '',
        motivo_sin_foto: det.motivo_sin_foto || null, entradas: det.entradas || null
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

  // Antes esto era un router.push('/') mudo: la app se devolvía sola al inicio
  // y no había forma de saber por qué.
  if (errorCarga) {
    return (
      <div className="flex flex-col items-center justify-center py-20 gap-5 text-center px-6">
        <div className="text-5xl">⚠️</div>
        <h2 className="text-lg font-bold text-white">No se pudo abrir la calificación</h2>
        <p className="text-sm text-white/60 leading-relaxed">{errorCarga}</p>
        <div className="flex flex-col gap-3 w-full max-w-xs">
          <button
            onClick={() => location.reload()}
            className="bg-[#03A64A] text-white py-3 px-8 rounded-xl font-bold shadow-lg active:scale-95 transition-all"
          >
            Reintentar
          </button>
          <button
            onClick={() => router.push('/buscar')}
            className="bg-white/10 text-white py-3 px-8 rounded-xl font-bold border border-white/20 active:scale-95 transition-all"
          >
            Volver a la lista
          </button>
        </div>
      </div>
    );
  }

  // Estado vacío: cargó pero no hay indicadores (problema de datos/conexión)
  if (!loading && indicadores.length === 0) {
    return (
      <div className="flex flex-col items-center justify-center py-20 gap-5 text-center px-6">
        <div className="text-5xl">⚠️</div>
        <h2 className="text-lg font-bold text-white">No se pudieron cargar los indicadores</h2>
        <p className="text-sm text-white/60">Verifica tu conexión e intenta de nuevo.</p>
        <button
          onClick={() => location.reload()}
          className="bg-[#03A64A] text-white py-3 px-8 rounded-xl font-bold shadow-lg active:scale-95 transition-all"
        >
          Reintentar
        </button>
      </div>
    );
  }

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
        evaluacionId={evalId}
        evaluacion={evaluacion}
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

      {fotos.aviso && (
        <div className="bg-amber-50 border border-amber-200 rounded-xl p-3 flex items-start gap-2">
          <span className="text-amber-600 shrink-0">⚠</span>
          <p className="text-xs text-amber-800 leading-relaxed flex-1">{fotos.aviso}</p>
          <button onClick={fotos.descartarAviso} className="text-amber-500 text-lg leading-none px-1">✕</button>
        </div>
      )}

      <PanoramicaCard
        foto={fotos.panoramica}
        url={fotos.panoramica ? fotos.urls[fotos.panoramica.id] : null}
        onAgregar={fotos.agregarPanoramica}
        onBorrar={fotos.borrar}
        guardando={fotos.guardando}
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
                fotos={fotos.porIndicador[ind.id] || []}
                fotoUrls={fotos.urls}
                onAgregarFoto={fotos.agregar}
                onBorrarFoto={fotos.borrar}
                guardandoFoto={fotos.guardando}
                motivoSinFoto={detalles[ind.id]?.motivo_sin_foto}
                onMotivoSinFotoChange={(t) => handleMotivoSinFotoChange(ind.id, t)}
                entradas={detalles[ind.id]?.entradas}
                onCalculoAplicado={(r) => handleCalculoAplicado(ind.id, r)}
              />
            </div>
          ))}
        </div>
      ))}

      {showErrors && (
        <ValidationBanner
          errorCount={Object.keys(validationErrors).length}
          fotosFaltantes={fotosFaltantes}
        />
      )}

      <EvaluacionFooter
        onGuardarSalir={handleGuardarSalir} onFinalizar={handleFinalizar}
        onCancelar={handleCancelar}
        todosCompletos={todosCompletos} totalRespondidos={totalRespondidos}
        totalIndicadores={totalIndicadores}
        fotosFaltantes={fotosFaltantes.length}
      />

    </div>
  );
}

export default function EvaluacionPage() {
  return (
    <Suspense fallback={<div className="p-10 text-center text-gray-400">Cargando evaluación...</div>}>
      <EvaluacionContent />
    </Suspense>
  );
}
