import { useState, useEffect, useCallback, useRef } from 'react';
import { db } from '@/lib/db-offline';
import { saveRecord, deleteRecord } from '@/lib/sync-engine';
import { createClient } from '@/lib/supabase';

export function usePlanAccion(evaluacionId) {
  const [planes, setPlanes] = useState({});       // { [indicadorId]: record } — espejo de IndexedDB
  const [isLoading, setIsLoading] = useState(true);
  const [isLoadingIA, setIsLoadingIA] = useState(false);
  const [error, setError] = useState(null);
  const [savingState, setSavingState] = useState('idle'); // idle | saving | saved
  const supabase = createClient();
  const savedTimer = useRef(null);

  const cargarPlanes = useCallback(async () => {
    try {
      const arr = await db.planes_accion
        .where('evaluacion_id').equals(evaluacionId)
        .toArray();
      const map = {};
      arr.forEach(p => { map[p.indicador_id] = p; });
      setPlanes(map);
    } catch (err) {
      console.error('[usePlanAccion] Error cargando planes:', err);
    }
  }, [evaluacionId]);

  useEffect(() => {
    if (!evaluacionId) { setIsLoading(false); return; }
    setIsLoading(true);
    cargarPlanes().finally(() => setIsLoading(false));
  }, [evaluacionId, cargarPlanes]);

  useEffect(() => () => clearTimeout(savedTimer.current), []);

  const sugerirConIA = async (indicadoresConScore, productor) => {
    if (typeof window !== 'undefined' && !window.navigator.onLine) {
      setError('Las sugerencias de IA requieren conexión a internet.');
      return null;
    }
    setIsLoadingIA(true);
    setError(null);
    const isMock = typeof window !== 'undefined' && !!localStorage.getItem('mock-user-session');
    try {
      const { data, error: fnError } = await supabase.functions.invoke('sugerir-plan-accion', {
        body: {
          evaluacion_id: evaluacionId,
          is_mock: isMock,
          indicadores_debiles: indicadoresConScore,
          productor: {
            nombre: productor?.nombre_completo,
            municipio: productor?.municipio,
            vereda: productor?.vereda,
          },
        },
      });

      if (fnError) throw new Error(fnError.message || 'Error de servidor');
      if (!data?.success) throw new Error(data?.error || 'Error desconocido del servidor');

      return data.planes;
    } catch (err) {
      console.error('[usePlanAccion] Error IA:', err);
      setError('No se pudieron generar sugerencias. Puedes completar el plan manualmente.');
      return null;
    } finally {
      setIsLoadingIA(false);
    }
  };

  // Guarda (upsert) un plan. Offline-first: IndexedDB primero, luego sync.
  // El espejo `planes` se actualiza de inmediato para que la UI sea la fuente única.
  const guardarPlan = useCallback(async (indicadorId, planData) => {
    const key = Number(indicadorId);
    const id = planes[key]?.id || crypto.randomUUID();
    const record = {
      id,
      evaluacion_id: evaluacionId,
      indicador_id: key,
      meta: planData.meta || '',
      plazo: planData.plazo || '',
      notas: planData.notas || '',
      sugerida_por_ia: !!planData.sugerida_por_ia,
    };
    setSavingState('saving');
    setPlanes(prev => ({ ...prev, [key]: record }));
    await saveRecord('planes_accion', record);
    setSavingState('saved');
    clearTimeout(savedTimer.current);
    savedTimer.current = setTimeout(() => setSavingState('idle'), 2000);
  }, [planes, evaluacionId]);

  // Elimina el plan de un indicador (al quitarlo del listado). Evita registros huérfanos.
  const eliminarPlan = useCallback(async (indicadorId) => {
    const key = Number(indicadorId);
    const existing = planes[key];
    setPlanes(prev => {
      const next = { ...prev };
      delete next[key];
      return next;
    });
    if (existing?.id) {
      await deleteRecord('planes_accion', existing.id);
    }
  }, [planes]);

  return { planes, isLoading, isLoadingIA, error, setError, savingState, sugerirConIA, guardarPlan, eliminarPlan };
}
