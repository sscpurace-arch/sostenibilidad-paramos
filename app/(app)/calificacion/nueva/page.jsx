'use client';
import { useState, useEffect, useCallback, useRef, Suspense } from 'react';
import { abrirPantalla, leerParametro } from "@/lib/navegar";
import { db, DIMENSION_COLORS } from '@/lib/db-offline';
import { createClient } from '@/lib/supabase';
import { saveRecord, deleteRecord, deleteRecordBulk, guardarDesdeServidor } from '@/lib/sync-engine';
import { eliminarFotosDeEvaluacion } from '@/lib/foto-sync';
import { eliminarReportesDeEvaluacion } from '@/lib/reporte-sync';
import { useRouter, useSearchParams } from 'next/navigation';

import ProductorInfoCard from '@/components/ProductorInfoCard';
import SostenibilidadPanel from '@/components/SostenibilidadPanel';
import HistorialEvals from '@/components/HistorialEvals';
import NuevaEvalForm from '@/components/NuevaEvalForm';
import { usuarioActualId, estadoIAde } from '@/lib/pendientes';
import { esEjemplo } from '@/lib/ejemplos';
import { traerMisBorradores, contarRespuestas, agruparPorProductor } from '@/lib/borradores';
import { heredarEnHistorial } from '@/lib/calificacion-anterior';
import { fechaLegible } from '@/lib/pdf-utils';

// Ruta estática + parámetro por query (?productor=ID) para que funcione sin
// conexión: las rutas dinámicas de App Router exigen datos del servidor y se
// rompen offline. El id se lee en el cliente y los datos salen de IndexedDB.
function PerfilProductorContent() {
  const searchParams = useSearchParams();
  const productorId = leerParametro(searchParams, 'productor');

  const [productor, setProductor] = useState(null);
  const [ultimaEval, setUltimaEval] = useState(null);
  const [todasEvals, setTodasEvals] = useState([]);
  const [borradores, setBorradores] = useState([]); // propios sin enviar, el más avanzado primero
  const iniciandoRef = useRef(false);               // evita crear dos evaluaciones con dos toques
  const [radarData, setRadarData] = useState(null);
  const [indicadores, setIndicadores] = useState([]);
  const [dimensiones, setDimensiones] = useState([]);
  const [loading, setLoading] = useState(true);
  const [errorCarga, setErrorCarga] = useState(null);
  // Fecha LOCAL, no toISOString(): esa es UTC y después de las 7 pm en
  // Colombia (UTC-5) proponía el día siguiente como fecha de la visita.
  const [fechaNuevaEval, setFechaNuevaEval] = useState(() => {
    const d = new Date();
    const mm = String(d.getMonth() + 1).padStart(2, '0');
    const dd = String(d.getDate()).padStart(2, '0');
    return `${d.getFullYear()}-${mm}-${dd}`;
  });
  const [esPrueba, setEsPrueba] = useState(false);
  const [receptorEsOtro, setReceptorEsOtro] = useState(false);
  const [receptorNombre, setReceptorNombre] = useState('');
  const [receptorCedula, setReceptorCedula] = useState('');
  const [receptorParentesco, setReceptorParentesco] = useState('');

  // Quién soy y qué le falta a mis evaluaciones (diagnóstico con IA / plan):
  // el historial deja abrirlas para completarlas cuando haya señal.
  const [miId, setMiId] = useState(null);
  const [estadoIA, setEstadoIA] = useState({});

  const router = useRouter();
  const supabase = createClient();

  useEffect(() => { usuarioActualId().then(setMiId); }, []);
  useEffect(() => {
    if (todasEvals.length === 0) { setEstadoIA({}); return; }
    estadoIAde(todasEvals.map(e => e.id)).then(setEstadoIA).catch(() => {});
  }, [todasEvals]);

  const cargarDatosInterno = useCallback(async () => {
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

    // Lo que se muestra sale SIEMPRE del celular. Lo que baja del servidor se
    // guarda primero en el celular (sin pisar lo pendiente) y se vuelve a
    // leer: antes la lista del servidor reemplazaba la local y una visita
    // enviada sin señal, aún sin subir, desaparecía del historial.
    const cargarLocal = async () => {
      // Borradores propios de este productor (empezados y sin enviar), el más
      // avanzado primero. Antes el perfil solo mostraba las enviadas y un
      // borrador adelantado "no existía" aquí (19-nov-2026).
      try {
        const uid = await usuarioActualId();
        const propios = (await db.evaluaciones
          .where('finca_id').equals(productorId)
          .and(e => e.estado === 'borrador' && !esEjemplo(e)
            && (!uid || !e.tecnico_id || e.tecnico_id === uid))
          .toArray());
        const cuentas = await contarRespuestas(propios.map(e => e.id));
        setBorradores(agruparPorProductor(
          propios.map(e => ({ ...e, respondidos: cuentas.get(e.id) || 0 }))
        ).flatMap(g => [g.principal, ...g.otros]));
      } catch (e) { console.error('Error leyendo los borradores del productor:', e); }

      const localEvals = await db.evaluaciones
        .where('finca_id').equals(productorId)
        .and(e => e.estado === 'enviada').reverse().sortBy('fecha');
      const limitEvals = localEvals.slice(0, 4);

      if (limitEvals.length > 0) {
        // "Última evaluación" del productor = la última REAL; una de prueba
        // solo cuenta si no hay ninguna real.
        setUltimaEval(limitEvals.find(e => !e.es_prueba) || limitEvals[0]);
        setTodasEvals(limitEvals);
        // Todas las visitas del productor (no solo las 4 del radar): un N/A
        // hereda el último puntaje que tuvo ese indicador, aunque sea de una
        // visita más vieja (17-nov-2026). Solo para mostrar; lo guardado no cambia.
        const localRespuestas = await db.respuestas_indicadores
          .where('evaluacion_id').anyOf(localEvals.map(e => e.id)).toArray();
        const mostradas = new Set(limitEvals.map(e => e.id));
        setRadarData(heredarEnHistorial(localEvals, localRespuestas).filter(r => mostradas.has(r.evaluacion_id)));
      } else {
        setUltimaEval(null);
        setTodasEvals([]);
        setRadarData([]);
      }
    };

    // 1. CARGAR SIEMPRE PRIMERO DE INDEXEDDB (Inmediato)
    try {
      await cargarLocal();
    } catch (e) {
      console.error('Error cargando datos locales:', e);
    }
    setLoading(false); // Quitar loader de inmediato para renderizar la UI con datos locales

    // 2. SINCRONIZAR CON SUPABASE EN SEGUNDO PLANO (Si hay conexión)
    if (navigator.onLine) {
      // Borradores propios de este productor que estén en el servidor y no en
      // este equipo (p. ej. empezados en el celular y revisados en el computador).
      try {
        if (await traerMisBorradores(await usuarioActualId(), productorId)) await cargarLocal();
      } catch (e) { console.error('Error trayendo los borradores del servidor:', e); }

      try {
        const { data: evals } = await supabase
          .from('evaluaciones').select('*')
          .eq('finca_id', productorId).eq('estado', 'enviada')
          .order('fecha', { ascending: false }).limit(4);

        if (evals && evals.length > 0) {
          // Guardar en IndexedDB para asegurar persistencia local
          await guardarDesdeServidor('evaluaciones', evals);

          const { data: respuestas } = await supabase
            .from('respuestas_indicadores').select('*')
            .in('evaluacion_id', evals.map(e => e.id));

          if (respuestas && respuestas.length > 0) {
            await guardarDesdeServidor('respuestas_indicadores', respuestas);
          }

          // Actualizar la pantalla con lo que quedó en el celular
          await cargarLocal();
        }
      } catch (e) {
        console.error('Error sincronizando con Supabase en segundo plano:', e);
      }
    }
  }, [productorId, router, supabase]);

  // Nunca dejar la pantalla en "Cargando perfil…" para siempre: si la lectura
  // de los datos del celular falla, se dice el motivo (antes una falla aquí
  // dejaba el cargador girando sin explicación).
  const cargarDatos = useCallback(async () => {
    try {
      await cargarDatosInterno();
    } catch (e) {
      console.error('Error cargando el perfil:', e);
      setErrorCarga(`No se pudieron leer los datos guardados en el celular. (${String(e?.message || e).slice(0, 120)})`);
      setLoading(false);
    }
  }, [cargarDatosInterno]);

  useEffect(() => {
    cargarDatos();
  }, [cargarDatos]);

  const handleIniciar = async () => {
    if (iniciandoRef.current) return; // ya se está creando: un segundo toque no crea otra
    iniciandoRef.current = true;
    const isMock = typeof window !== 'undefined' && !!localStorage.getItem('mock-user-session');

    // Si ya hay una evaluación en borrador de este productor (del mismo tipo:
    // real o de prueba), se CONTINÚA esa en vez de crear otra. Con mala señal
    // el técnico volvía y la iniciaba de nuevo: quedaban 2 y 3 borradores
    // repetidos del mismo productor.
    const quierePrueba = isMock || esPrueba;
    const existente = borradores.find(b => !!b.es_prueba === quierePrueba);
    if (existente) {
      abrirPantalla(`/calificacion?id=${existente.id}`);
      return;
    }

    let userId = 'e81ba52c-23df-4f4e-808d-937fd606426c';
    if (!isMock) {
      const { data: { user } } = await supabase.auth.getUser();
      // Sin sesión el botón no hacía absolutamente nada y el técnico se quedaba
      // tocándolo sin entender. Mejor decirlo.
      if (!user) {
        iniciandoRef.current = false;
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
    // Si no quedó en el celular, abrir el formulario daría "no se encontró la
    // evaluación" y el técnico no sabría por qué.
    if (!(await saveRecord('evaluaciones', newEval))) {
      iniciandoRef.current = false;
      alert('No se pudo crear la calificación en el celular. Lee el aviso rojo de arriba y vuelve a intentarlo.');
      return;
    }
    abrirPantalla(`/calificacion?id=${newEval.id}`);
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
        if (!(await deleteRecordBulk('respuestas_indicadores', respIds))) throw new Error('NO_GUARDADO');
      }

      // El plan de acción también es hijo de la evaluación: si se queda, su
      // cambio pendiente intenta subir y el servidor lo rechaza para siempre.
      const planes = await db.planes_accion.where('evaluacion_id').equals(evalId).primaryKeys();
      if (planes.length > 0 && !(await deleteRecordBulk('planes_accion', planes))) throw new Error('NO_GUARDADO');

      const diag = await db.diagnosticos?.where('evaluacion_id').equals(evalId).first();
      if (diag && !(await deleteRecord('diagnosticos', diag.id))) throw new Error('NO_GUARDADO');

      // Dexie no tiene claves foráneas: las fotos hay que borrarlas a mano o
      // quedan blobs ocupando espacio sin nada que los referencie.
      await eliminarFotosDeEvaluacion(evalId);
      await eliminarReportesDeEvaluacion(evalId);

      if (!(await deleteRecord('evaluaciones', evalId))) throw new Error('NO_GUARDADO');

      // Recargar datos localmente de forma determinista e inmediata
      await cargarDatos();

    } catch (e) {
      console.error('❌ Error en handleEliminar:', e);
      // Se corta en el primer paso que no quedó guardado en el celular, para
      // no dejar la evaluación a medio borrar sin decirlo.
      alert(e?.message === 'NO_GUARDADO'
        ? 'No se pudo terminar de borrar la evaluación en el celular. Lee el aviso rojo de arriba y vuelve a intentarlo.'
        : 'No se pudo borrar la evaluación. Cierra y vuelve a abrir la app, y vuelve a intentarlo.');
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

      <ProductorInfoCard productor={productor} onVerMapa={() => abrirPantalla(`/mapa/detalle?id=${productor.id}`)} />

      <SostenibilidadPanel
        ultimaEval={ultimaEval} todasEvals={todasEvals} radarData={radarData}
        indicadores={indicadores} dimensiones={dimensiones}
        productor={productor}
      />

      {todasEvals.length > 0 && (
        <section className="bg-white p-6 rounded-2xl shadow-sm border border-gray-100">
          <HistorialEvals
            evaluaciones={todasEvals}
            onEliminar={handleEliminar}
            estadoIA={estadoIA}
            puedeAbrir={(ev) => !!miId && ev.tecnico_id === miId}
            // Borrar: solo lo propio o lo de prueba. Desde oct-2026 todos ven
            // la línea base de los demás; antes el bote aparecía también ahí.
            puedeBorrar={(ev) => !!ev.es_prueba
              || (typeof window !== 'undefined' && !!localStorage.getItem('mock-user-session'))
              || (!!miId && ev.tecnico_id === miId)}
            onAbrir={(ev) => abrirPantalla(`/calificacion?id=${ev.id}&resultados=1`)}
            respuestas={radarData || []}
            indicadores={indicadores}
            dimensiones={dimensiones}
            productor={productor}
          />
        </section>
      )}

      {borradores.length > 0 && (
        <section className="bg-white p-6 rounded-2xl shadow-sm border border-amber-200">
          <h3 className="font-bold text-gray-700 mb-1">Evaluación en curso</h3>
          <p className="text-[11px] text-gray-500 leading-snug mb-4">
            Ya empezaste una evaluación de este productor y no se ha enviado. Continúala en vez de iniciar otra:
            al tocar «Iniciar Calificación» abajo también se abre esta.
          </p>
          <div className="flex flex-col gap-3">
            {borradores.map((b, i) => (
              <div key={b.id} className="bg-amber-50/60 border border-amber-100 rounded-xl p-3">
                <div className="flex justify-between items-center gap-2">
                  <p className="text-xs font-bold text-gray-700">
                    {i === 0 ? 'Más avanzada' : 'Borrador repetido'}{b.es_prueba ? ' · de prueba' : ''}
                  </p>
                  <span className="text-[10px] text-gray-500 font-semibold">
                    {fechaLegible(b.fecha, { mes: 'short' })}
                  </span>
                </div>
                <div className="flex items-center gap-3 mt-2">
                  <div className="flex-1 h-2 bg-gray-200 rounded-full overflow-hidden">
                    <div
                      className="h-full bg-[#03A64A] rounded-full"
                      style={{ width: `${Math.min(100, (b.respondidos / (indicadores.length || 29)) * 100)}%` }}
                    />
                  </div>
                  <span className="text-xs font-bold text-gray-500">{b.respondidos} / {indicadores.length || 29}</span>
                </div>
                <button
                  onClick={() => abrirPantalla(`/calificacion?id=${b.id}`)}
                  className="w-full mt-3 bg-[#03A64A] text-white py-3 rounded-xl font-bold text-sm active:scale-95 transition-all"
                >
                  Continuar evaluación →
                </button>
              </div>
            ))}
          </div>
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
