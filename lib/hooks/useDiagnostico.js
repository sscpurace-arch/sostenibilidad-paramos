import { useState, useEffect, useCallback } from 'react';
import { db } from '@/lib/db-offline';
import { syncQueue } from '@/lib/sync-engine';
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
      // (en modo prueba no: los diagnósticos de prueba solo existen en local)
      const esMock = typeof window !== 'undefined' && !!localStorage.getItem('mock-user-session');
      if (typeof window !== 'undefined' && window.navigator.onLine && !esMock) {
        await fetchRemote();
      }
      
      if (isMounted) setIsLoading(false);
    };

    init();
    
    return () => { isMounted = false; };
  }, [evaluacionId, cargarLocal, fetchRemote]);

  // datosLocales: { productor, detalles, fecha } — necesario en modo prueba,
  // donde la evaluación vive solo en IndexedDB y el servidor no puede consultarla.
  const generarNuevo = async (datosLocales = null) => {
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
      // La función de IA lee la evaluación y sus respuestas DESDE EL SERVIDOR.
      // Una evaluación hecha sin señal solo está en el celular hasta que sube:
      // si el técnico pide el diagnóstico apenas vuelve la señal, la función
      // respondía "evaluación no encontrada". Primero se sube lo pendiente.
      // Hay evaluaciones que NO están (ni estarán) en el servidor: las de
      // prueba (nunca suben por diseño) y las que no han podido subir. Para
      // esas los datos viajan con la petición y el diagnóstico se guarda solo
      // en este celular. Antes el servidor las buscaba, no las hallaba y el
      // diagnóstico fallaba siempre.
      let soloLocal = false;
      if (!isMock) {
        try { await syncQueue(); } catch { /* si no sube, se usan los datos locales */ }
        try {
          const ev = await db.evaluaciones.get(evaluacionId);
          if (ev?.es_prueba) {
            soloLocal = true;
          } else {
            const pendientes = await db.sync_queue
              .where('sync_pending').equals(1)
              .filter(i => i.tabla === 'evaluaciones' && i.payload?.id === evaluacionId)
              .count();
            soloLocal = pendientes > 0;
          }
        } catch { /* sin Dexie: se intenta contra el servidor */ }
      }
      console.log('Iniciando generación de diagnóstico para evaluación:', evaluacionId, soloLocal ? '(datos locales)' : '');

      const body = { evaluacion_id: evaluacionId, is_mock: isMock };
      if (soloLocal) body.solo_local = true;

      // Evaluación anterior (lo que la pantalla ya muestra como "Anterior" / ↑↓):
      // se envía SIEMPRE que exista, para que el texto de la IA compare de verdad
      // y no diga "primera visita" cuando sí hay histórico. En modo prueba es la
      // única forma de que la función conozca la anterior (no está en Supabase).
      if (Array.isArray(datosLocales?.lastResults) && datosLocales.lastResults.length) {
        body.respuestas_previas = datosLocales.lastResults
          .filter((r) => r?.indicador_id != null && (r?.valor != null || r?.no_aplica === true))
          .map((r) => ({ indicador_id: Number(r.indicador_id), valor: r.valor ?? null, no_aplica: r.no_aplica === true }));
      }

      if ((isMock || soloLocal) && datosLocales) {
        body.datos_locales = {
          productor: {
            nombre_completo: datosLocales.productor?.nombre_completo,
            municipio: datosLocales.productor?.municipio,
            vereda: datosLocales.productor?.vereda,
            nombre_predio: datosLocales.productor?.nombre_predio,
          },
          // Los N/A también viajan: la IA debe saber que no aplica, no leerlo
          // como indicador faltante ni como cero.
          respuestas: Object.entries(datosLocales.detalles || {})
            .filter(([, d]) => typeof d?.valor === 'number' || d?.no_aplica === true)
            .map(([indId, d]) => ({
              indicador_id: Number(indId),
              valor: d.no_aplica ? null : d.valor,
              no_aplica: d.no_aplica === true,
              observacion: d.observacion || null,
            })),
          fecha: datosLocales.fecha || new Date().toISOString(),
        };
      }

      const { data, error: fnError } = await supabase.functions.invoke('generar-diagnostico', { body });

      // Verificar si la función devolvió un error HTTP (status no-2xx)
      if (fnError) {
        console.error('Error de función:', fnError);
        // En una respuesta no-2xx, supabase-js solo trae un mensaje genérico
        // ("Edge Function returned a non-2xx status code"): el motivo real que
        // manda la función está en el cuerpo de la respuesta.
        let msg = fnError.message || fnError.msg || JSON.stringify(fnError);
        try {
          const cuerpo = await fnError.context?.json?.();
          if (cuerpo?.error) msg = cuerpo.error;
        } catch { /* sin cuerpo legible */ }
        throw new Error(`Error de servidor (${fnError.status || fnError.context?.status || 'unknown'}): ${msg}`);
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

      if (data?.diagnostico) {
        // Modo prueba: el servidor devuelve el diagnóstico completo → guardar solo local
        const record = { id: crypto.randomUUID(), ...data.diagnostico };
        await db.diagnosticos.put(record);
        setDiagnostico(record);
        setIsStale(false);
        console.log('Diagnóstico (modo prueba) guardado localmente');
      } else if (data?.diagnostico_id) {
        console.log('Diagnóstico generado exitosamente:', data.diagnostico_id);
        // Traer el nuevo de DB y guardarlo en local
        await fetchRemote();
      } else {
        console.error('No se recibió diagnóstico en respuesta:', data);
        throw new Error('No se recibió ID de diagnóstico');
      }
    } catch (err) {
      console.error('Error generando IA:', err);

      // Mensajes de error más específicos
      let userMsg = 'Error al generar el diagnóstico. Intenta de nuevo.';
      const cortePorRed = err.name === 'FunctionsFetchError' || err.name === 'AbortError' ||
        /failed to fetch|network|timeout|abort|load failed/i.test(err.message || '');
      if (cortePorRed) {
        userMsg = 'No hay conexión estable con el servidor. La evaluación está guardada; intenta de nuevo cuando tengas mejor señal.';
      } else if (err.message.includes('Missing Auth') || err.message.includes('Invalid token')) {
        userMsg = 'Tu sesión expiró. Por favor, inicia sesión nuevamente.';
      } else if (err.message.includes('Configuración')) {
        userMsg = 'Error de configuración del servidor. Contacta al administrador.';
      } else if (err.message.includes('no encontrada') || err.message.includes('Error cargando evaluación')) {
        userMsg = 'La evaluación todavía no ha subido al servidor. Espera a que termine de sincronizar (mira la franja de estado arriba) e intenta de nuevo.';
      } else if (err.message.includes('Rate limit') || err.message.includes('429')) {
        userMsg = 'Se hicieron demasiadas solicitudes seguidas. Espera un minuto e intenta de nuevo.';
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
