'use client';
import { useState, useEffect, useCallback, Suspense } from 'react';
import { db, DIMENSION_COLORS } from '@/lib/db-offline';
import { createClient } from '@/lib/supabase';
import { saveRecord, deleteRecord, deleteRecordBulk, waitForSync } from '@/lib/sync-engine';
import { eliminarFotosDeEvaluacion } from '@/lib/foto-sync';
import { useRouter, useSearchParams } from 'next/navigation';

import ProductorInfoCard from '@/components/ProductorInfoCard';
import SostenibilidadPanel from '@/components/SostenibilidadPanel';
import HistorialEvals from '@/components/HistorialEvals';
import NuevaEvalForm from '@/components/NuevaEvalForm';

// Ruta estática + parámetro por query (?productor=ID) para que funcione sin
// conexión: las rutas dinámicas de App Router exigen datos del servidor y se
// rompen offline. El id se lee en el cliente y los datos salen de IndexedDB.
function PerfilProductorContent() {
  const searchParams = useSearchParams();
  const productorId = searchParams.get('productor');

  const [productor, setProductor] = useState(null);
  const [ultimaEval, setUltimaEval] = useState(null);
  const [todasEvals, setTodasEvals] = useState([]);
  const [radarData, setRadarData] = useState(null);
  const [indicadores, setIndicadores] = useState([]);
  const [dimensiones, setDimensiones] = useState([]);
  const [loading, setLoading] = useState(true);
  const [errorCarga, setErrorCarga] = useState(null);
  const [fechaNuevaEval, setFechaNuevaEval] = useState(new Date().toISOString().split('T')[0]);
  const [esPrueba, setEsPrueba] = useState(false);
  const [receptorEsOtro, setReceptorEsOtro] = useState(false);
  const [receptorNombre, setReceptorNombre] = useState('');
  const [receptorCedula, setReceptorCedula] = useState('');
  const [receptorParentesco, setReceptorParentesco] = useState('');

  const router = useRouter();
  const supabase = createClient();

  const cargarDatos = useCallback(async () => {
    setLoading(true);
    setErrorCarga(null);
    if (!productorId) {
      setLoading(false);
      setErrorCarga('No se indicó qué productor abrir.');
      return;
    }

    // El productor puede faltar en la base local: descarga incompleta, creado
    // en otro celular, o caché a medio actualizar. Antes se devolvía al usuario
    // a la lista sin decir nada y parecía que la app simplemente no abría al
    // productor. Ahora se busca en el servidor y solo se avisa si tampoco está.
    let prod = await db.productores.get(productorId);
    if (!prod && navigator.onLine) {
      try {
        const { data } = await supabase
          .from('productores').select('*').eq('id', productorId).maybeSingle();
        if (data) {
          await db.productores.put(data);
          prod = data;
        }
      } catch (e) { console.error('Error buscando el productor en el servidor:', e); }
    }
    if (!prod) {
      setLoading(false);
      setErrorCarga(navigator.onLine
        ? 'No se encontró este productor. Puede que aún no se haya descargado a este celular.'
        : 'Este productor no está descargado en el celular y no hay conexión para buscarlo.');
      return;
    }
    setProductor(prod);

    const inds = await db.indicadores.orderBy('orden').toArray();
    setIndicadores(inds);
    setDimensiones([...new Set(inds.map(i => i.dimension))].map(nombre => ({
      nombre, color: DIMENSION_COLORS[nombre] || '#666'
    })));

    // 1. CARGAR SIEMPRE PRIMERO DE INDEXEDDB (Inmediato)
    try {
      const localEvals = await db.evaluaciones
        .where('finca_id').equals(productorId)
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
          .eq('finca_id', productorId).eq('estado', 'enviada')
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
  }, [productorId, router, supabase]);

  useEffect(() => {
    cargarDatos();
  }, [cargarDatos]);

  const handleIniciar = async () => {
    const isMock = typeof window !== 'undefined' && !!localStorage.getItem('mock-user-session');
    let userId = 'e81ba52c-23df-4f4e-808d-937fd606426c';
    if (!isMock) {
      const { data: { user } } = await supabase.auth.getUser();
      // Sin sesión el botón no hacía absolutamente nada y el técnico se quedaba
      // tocándolo sin entender. Mejor decirlo.
      if (!user) {
        alert('No se pudo confirmar tu sesión. Cierra y vuelve a abrir la app, o entra de nuevo con tu correo.');
        return;
      }
      userId = user.id;
    }
    const newEval = {
      id: crypto.randomUUID(), finca_id: productorId, tecnico_id: userId,
      estado: 'borrador', fecha: new Date(fechaNuevaEval + 'T12:00:00').toISOString(),
      es_prueba: isMock || esPrueba,
      receptor_es_otro: receptorEsOtro,
      receptor_nombre: receptorEsOtro ? receptorNombre.trim() : '',
      receptor_cedula: receptorEsOtro ? receptorCedula.trim() : '',
      receptor_parentesco: receptorEsOtro ? receptorParentesco.trim() : '',
    };
    await saveRecord('evaluaciones', newEval);
    router.push(`/calificacion?id=${newEval.id}`);
  };

  const handleEliminar = async (evalId) => {
    try {
      // 1. Optimistic UI: Eliminar instantáneamente del estado local
      const nuevasEvals = todasEvals.filter(e => e.id !== evalId);
      setTodasEvals(nuevasEvals);
      setUltimaEval(nuevasEvals[0] || null);

      // 2. Obtener respuestas relacionadas
      const respuestas = await db.respuestas_indicadores.where('evaluacion_id').equals(evalId).toArray();
      const respIds = respuestas.map(r => r.id);

      // 3. Borrar en bloque (respuestas + evaluacion)
      if (respIds.length > 0) {
        await deleteRecordBulk('respuestas_indicadores', respIds);
      }

      const diag = await db.diagnosticos?.where('evaluacion_id').equals(evalId).first();
      if (diag) await deleteRecord('diagnosticos', diag.id);

      // Dexie no tiene claves foráneas: las fotos hay que borrarlas a mano o
      // quedan blobs ocupando espacio sin nada que los referencie.
      await eliminarFotosDeEvaluacion(evalId);

      await deleteRecord('evaluaciones', evalId);

      // Recargar datos localmente de forma determinista e inmediata
      await cargarDatos();

    } catch (e) {
      console.error('❌ Error en handleEliminar:', e);
      alert('Error crítico al eliminar la evaluación. Revisa la consola.');
      cargarDatos();
    }
  };

  if (loading) return <div className="p-10 text-center text-gray-400">Cargando perfil...</div>;

  // Nunca devolver al usuario al inicio en silencio: si algo faltó, se dice
  // qué faltó y se le dan las dos salidas útiles.
  if (errorCarga || !productor) {
    return (
      <div className="flex flex-col items-center justify-center py-20 gap-5 text-center px-6">
        <div className="text-5xl">⚠️</div>
        <h2 className="text-lg font-bold text-white">No se pudo abrir el productor</h2>
        <p className="text-sm text-white/60 leading-relaxed">{errorCarga}</p>
        <div className="flex flex-col gap-3 w-full max-w-xs">
          <button
            onClick={() => cargarDatos()}
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

  return (
    <div className="flex flex-col gap-6 pb-20">
      <header className="flex items-center gap-2">
        <button onClick={() => router.back()} className="text-gray-500 p-2">←</button>
        <h1 className="text-xl font-bold">Perfil del Productor</h1>
      </header>

      <ProductorInfoCard productor={productor} onVerMapa={() => router.push(`/mapa/detalle?id=${productor.id}`)} />

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
        receptorEsOtro={receptorEsOtro} onReceptorEsOtroChange={setReceptorEsOtro}
        receptorNombre={receptorNombre} onReceptorNombreChange={setReceptorNombre}
        receptorCedula={receptorCedula} onReceptorCedulaChange={setReceptorCedula}
        receptorParentesco={receptorParentesco} onReceptorParentescoChange={setReceptorParentesco}
        onIniciar={handleIniciar}
      />
    </div>
  );
}

export default function PerfilProductorPage() {
  return (
    <Suspense fallback={<div className="p-10 text-center text-gray-400">Cargando perfil...</div>}>
      <PerfilProductorContent />
    </Suspense>
  );
}
