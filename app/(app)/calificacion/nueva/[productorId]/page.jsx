'use client';
import { useState, useEffect, useCallback } from 'react';
import { db, DIMENSION_COLORS } from '@/lib/db-offline';
import { createClient } from '@/lib/supabase';
import { saveRecord, deleteRecord, deleteRecordBulk, waitForSync } from '@/lib/sync-engine';
import { useRouter } from 'next/navigation';

import ProductorInfoCard from '@/components/ProductorInfoCard';
import SostenibilidadPanel from '@/components/SostenibilidadPanel';
import HistorialEvals from '@/components/HistorialEvals';
import NuevaEvalForm from '@/components/NuevaEvalForm';

export default function PerfilProductorPage({ params }) {
  const [productor, setProductor] = useState(null);
  const [ultimaEval, setUltimaEval] = useState(null);
  const [todasEvals, setTodasEvals] = useState([]);
  const [radarData, setRadarData] = useState(null);
  const [indicadores, setIndicadores] = useState([]);
  const [dimensiones, setDimensiones] = useState([]);
  const [loading, setLoading] = useState(true);
  const [fechaNuevaEval, setFechaNuevaEval] = useState(new Date().toISOString().split('T')[0]);
  const [esPrueba, setEsPrueba] = useState(false);

  const router = useRouter();
  const supabase = createClient();

  const cargarDatos = useCallback(async () => {
    setLoading(true);
    const prod = await db.productores.get(params.productorId);
    if (!prod) return router.push('/buscar');
    setProductor(prod);

    const inds = await db.indicadores.orderBy('orden').toArray();
    setIndicadores(inds);
    setDimensiones([...new Set(inds.map(i => i.dimension))].map(nombre => ({
      nombre, color: DIMENSION_COLORS[nombre] || '#666'
    })));

    // 1. CARGAR SIEMPRE PRIMERO DE INDEXEDDB (Inmediato)
    try {
      const localEvals = await db.evaluaciones
        .where('finca_id').equals(params.productorId)
        .and(e => e.estado === 'enviada').reverse().sortBy('fecha');
      const limitEvals = localEvals.slice(0, 4);
      
      if (limitEvals.length > 0) {
        setUltimaEval(limitEvals[0]);
        setTodasEvals(limitEvals);
        const localRespuestas = await db.respuestas_indicadores
          .where('evaluacion_id').anyOf(limitEvals.map(e => e.id)).toArray();
        setRadarData(localRespuestas);
      } else {
        setUltimaEval(null);
        setTodasEvals([]);
        setRadarData([]);
      }
    } catch (e) {
      console.error('Error cargando datos locales:', e);
    }
    setLoading(false); // Quitar loader de inmediato para renderizar la UI con datos locales

    // 2. SINCRONIZAR CON SUPABASE EN SEGUNDO PLANO (Si hay conexión)
    if (navigator.onLine) {
      try {
        const { data: evals } = await supabase
          .from('evaluaciones').select('*')
          .eq('finca_id', params.productorId).eq('estado', 'enviada')
          .order('fecha', { ascending: false }).limit(4);

        if (evals && evals.length > 0) {
          // Guardar en IndexedDB para asegurar persistencia local
          await db.evaluaciones.bulkPut(evals);
          
          const { data: respuestas } = await supabase
            .from('respuestas_indicadores').select('*')
            .in('evaluacion_id', evals.map(e => e.id));
            
          if (respuestas && respuestas.length > 0) {
            await db.respuestas_indicadores.bulkPut(respuestas);
          }

          // Actualizar estado de React con los datos frescos
          setUltimaEval(evals[0]);
          setTodasEvals(evals);
          setRadarData(respuestas || []);
        }
      } catch (e) {
        console.error('Error sincronizando con Supabase en segundo plano:', e);
      }
    }
  }, [params.productorId, router, supabase]);

  useEffect(() => {
    cargarDatos();
  }, [cargarDatos]);

  const handleIniciar = async () => {
    const { data: { user } } = await supabase.auth.getUser();
    if (!user) return;
    const newEval = {
      id: crypto.randomUUID(), finca_id: params.productorId, tecnico_id: user.id,
      estado: 'borrador', fecha: new Date(fechaNuevaEval + 'T12:00:00').toISOString(), es_prueba: esPrueba
    };
    await saveRecord('evaluaciones', newEval);
    router.push(`/calificacion/${newEval.id}`);
  };

  const handleEliminar = async (evalId) => {
    try {
      console.log('🗑️ Intentando borrar evaluación:', evalId);
      
      // 1. Optimistic UI: Eliminar instantáneamente del estado local
      const nuevasEvals = todasEvals.filter(e => e.id !== evalId);
      setTodasEvals(nuevasEvals);
      setUltimaEval(nuevasEvals[0] || null);

      console.log('📦 Borrando de base local...');
      // 2. Obtener respuestas relacionadas
      const respuestas = await db.respuestas_indicadores.where('evaluacion_id').equals(evalId).toArray();
      const respIds = respuestas.map(r => r.id);
      
      // 3. Borrar en bloque (respuestas + evaluacion)
      if (respIds.length > 0) {
        await deleteRecordBulk('respuestas_indicadores', respIds);
      }
      
      const diag = await db.diagnosticos?.where('evaluacion_id').equals(evalId).first();
      if (diag) await deleteRecord('diagnosticos', diag.id);
      
      await deleteRecord('evaluaciones', evalId);
      
      console.log('⏳ Sincronización en segundo plano iniciada...');
      // Recargar datos localmente de forma determinista e inmediata
      await cargarDatos();
      
    } catch (e) { 
      console.error('❌ Error en handleEliminar:', e); 
      alert('Error crítico al eliminar la evaluación. Revisa la consola.'); 
      cargarDatos();
    }
  };

  if (loading) return <div className="p-10 text-center text-gray-400">Cargando perfil...</div>;

  return (
    <div className="flex flex-col gap-6 pb-20">
      <header className="flex items-center gap-2">
        <button onClick={() => router.back()} className="text-gray-500 p-2">←</button>
        <h1 className="text-xl font-bold">Perfil del Productor</h1>
      </header>

      <ProductorInfoCard productor={productor} onVerMapa={() => router.push(`/mapa/${productor.id}`)} />

      <SostenibilidadPanel
        ultimaEval={ultimaEval} todasEvals={todasEvals} radarData={radarData}
        indicadores={indicadores} dimensiones={dimensiones}
      />

      {todasEvals.length > 0 && (
        <section className="bg-white p-6 rounded-2xl shadow-sm border border-gray-100">
          <HistorialEvals evaluaciones={todasEvals} onEliminar={handleEliminar} />
        </section>
      )}

      <NuevaEvalForm
        fecha={fechaNuevaEval} onFechaChange={setFechaNuevaEval}
        esPrueba={esPrueba} onEsPruebaChange={setEsPrueba}
        onIniciar={handleIniciar}
      />
    </div>
  );
}
