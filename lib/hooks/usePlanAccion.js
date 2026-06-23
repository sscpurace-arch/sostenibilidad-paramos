import { useState, useEffect, useCallback } from 'react';
import { db } from '@/lib/db-offline';
import { saveRecord } from '@/lib/sync-engine';
import { createClient } from '@/lib/supabase';

export function usePlanAccion(evaluacionId) {
  const [planes, setPlanes] = useState({});
  const [isLoading, setIsLoading] = useState(true);
  const [isLoadingIA, setIsLoadingIA] = useState(false);
  const [error, setError] = useState(null);
  const [planGuardado, setPlanGuardado] = useState(false);
  const supabase = createClient();

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

  const guardarPlan = async (indicadorId, planData) => {
    const id = planes[indicadorId]?.id || crypto.randomUUID();
    const record = {
      id,
      evaluacion_id: evaluacionId,
      indicador_id: Number(indicadorId),
      meta: planData.meta || '',
      plazo: planData.plazo || '',
      notas: planData.notas || '',
      sugerida_por_ia: planData.sugerida_por_ia || false,
    };
    await saveRecord('planes_accion', record);
    setPlanes(prev => ({ ...prev, [indicadorId]: record }));
    setPlanGuardado(true);
    setTimeout(() => setPlanGuardado(false), 3000);
  };

  return { planes, isLoading, isLoadingIA, error, setError, sugerirConIA, guardarPlan, planGuardado };
}
