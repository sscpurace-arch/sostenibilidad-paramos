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
      const errMsg = 'El diagnóstico con IA requiere conexión. Podrás generarlo cuando vuelva la señal.';
      setError(errMsg);
      setIsLoading(false);
      return; // No lanzar — dejar al componente mostrar el error con botón Reintentar
    }

    setIsLoading(true);
    setError(null);
    const isMock = typeof window !== 'undefined' && !!localStorage.getItem('mock-user-session');
    try {
      console.log('Iniciando generación de diagnóstico para evaluación:', evaluacionId);

      const { data, error: fnError } = await supabase.functions.invoke('generar-diagnostico', {
        body: { evaluacion_id: evaluacionId, is_mock: isMock }
      });

      // Verificar si la función devolvió un error HTTP (status no-2xx)
      if (fnError) {
        console.error('Error de función:', fnError);
        const msg = fnError.message || fnError.msg || JSON.stringify(fnError);
        throw new Error(`Error de servidor (${fnError.status || 'unknown'}): ${msg}`);
      }

      // Verificar respuesta de la función
      if (!data) {
        console.error('Respuesta vacía de la función');
        throw new Error('La función devolvió una respuesta vacía');
      }

      if (data?.success === false) {
        const errMsg = data.error || 'Error desconocido del servidor';
        console.error('Error retornado por función:', errMsg);
        throw new Error(errMsg);
      }

      if (!data?.diagnostico_id) {
        console.error('No se recibió diagnostico_id en respuesta:', data);
        throw new Error('No se recibió ID de diagnóstico');
      }

      console.log('Diagnóstico generado exitosamente:', data.diagnostico_id);

      // Traer el nuevo de DB y guardarlo en local
      await fetchRemote();
    } catch (err) {
      console.error('Error generando IA:', err);

      // Mensajes de error más específicos
      let userMsg = 'Error al generar el diagnóstico. Intenta de nuevo.';
      if (err.message.includes('Missing Auth') || err.message.includes('Invalid token')) {
        userMsg = 'Tu sesión expiró. Por favor, inicia sesión nuevamente.';
      } else if (err.message.includes('Configuración')) {
        userMsg = 'Error de configuración del servidor. Contacta al administrador.';
      } else if (err.message.includes('no encontrada')) {
        userMsg = 'La evaluación no existe o fue eliminada.';
      } else if (err.message.includes('Gemini')) {
        userMsg = 'Error al procesar la solicitud con IA. Intenta de nuevo en un momento.';
      }

      setError(userMsg);
    } finally {
      setIsLoading(false);
    }
  };

  return { diagnostico, isLoading, isStale, error, generarNuevo };
}
