import { useState, useEffect, useCallback } from 'react';
import { db } from '@/lib/db-offline';
import { createClient } from '@/lib/supabase';

const SEVEN_DAYS_MS = 7 * 24 * 60 * 60 * 1000;

export function useDiagnostico(evaluacionId) {
  const [diagnostico, setDiagnostico] = useState(null);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState(null);
  const [isStale, setIsStale] = useState(false);

  // useMemo no es estrictamente necesario aquí ya que createClient() está optimizado
  // en lib/supabase.js, pero guardamos la referencia localmente en el hook.
  const supabase = createClient();

  const cargarLocal = useCallback(async () => {
    try {
      const diagLocal = await db.diagnosticos.where('evaluacion_id').equals(evaluacionId).first();
      if (diagLocal) {
        setDiagnostico(diagLocal);
        
        // Verificar si es stale (> 7 dias)
        const fechaDiag = new Date(diagLocal.fecha).getTime();
        const ahora = new Date().getTime();
        setIsStale(ahora - fechaDiag > SEVEN_DAYS_MS);
      }
    } catch (err) {
      console.error('Error leyendo diagnóstico local:', err);
    }
  }, [evaluacionId]);

  const fetchRemote = useCallback(async () => {
    try {
      const { data, error } = await supabase
        .from('diagnosticos')
        .select('*')
        .eq('evaluacion_id', evaluacionId)
        .single();
        
      if (data) {
        await db.diagnosticos.put(data); // Actualizar IndexedDB
        setDiagnostico(data);
        
        const fechaDiag = new Date(data.fecha).getTime();
        const ahora = new Date().getTime();
        setIsStale(ahora - fechaDiag > SEVEN_DAYS_MS);
      }
    } catch (err) {
      // Silencioso: Si falla la red, el cargarLocal() ya tiene los datos si existían
    }
  }, [evaluacionId, supabase]);

  useEffect(() => {
    if (!evaluacionId) {
      setIsLoading(false);
      return;
    }
    
    let isMounted = true;
    
    const init = async () => {
      setIsLoading(true);
      
      // Siempre cargar primero lo local para renderizado inmediato
      await cargarLocal();
      
      // Si hay red, traer el último de Supabase en background
      if (typeof window !== 'undefined' && window.navigator.onLine) {
        await fetchRemote();
      }
      
      if (isMounted) setIsLoading(false);
    };

    init();
    
    return () => { isMounted = false; };
  }, [evaluacionId, cargarLocal, fetchRemote]);

  const generarNuevo = async () => {
    if (typeof window !== 'undefined' && !window.navigator.onLine) {
      const errMsg = 'Necesitas conexión a internet para generar un nuevo diagnóstico con IA';
      setError(errMsg);
      throw new Error(errMsg);
    }

    setIsLoading(true);
    setError(null);
    try {
      const { data, error: fnError } = await supabase.functions.invoke('generar-diagnostico', {
        body: { evaluacion_id: evaluacionId }
      });

      if (fnError) throw new Error(fnError.message || JSON.stringify(fnError));
      if (data?.success === false) throw new Error(data.error || 'Error desconocido del servidor');
      if (!data?.diagnostico_id) throw new Error('No se recibió ID de diagnóstico');
      
      // Traer el nuevo de DB y guardarlo en local
      await fetchRemote();
    } catch (err) {
      console.error('Error generando IA:', err);
      setError(err.message || 'Error desconocido');
      throw err;
    } finally {
      setIsLoading(false);
    }
  };

  return { diagnostico, isLoading, isStale, error, generarNuevo };
}
