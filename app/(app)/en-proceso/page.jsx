'use client';
import { useState, useEffect } from 'react';
import { db } from '@/lib/db-offline';
import { createClient, getMockSession, MOCK_USER } from '@/lib/supabase';
import { useEnLinea } from '@/lib/hooks/useEnLinea';
import { useRouter } from 'next/navigation';

// Evaluaciones enviadas en estos últimos días sin diagnóstico con IA: las que
// se cerraron en finca sin señal. Más atrás no se listan (histórico viejo).
const DIAS_PENDIENTES = 60;

export default function EnProcesoPage() {
  const [items, setItems] = useState([]);
  const [sinDiagnostico, setSinDiagnostico] = useState([]);
  const [loading, setLoading] = useState(true);
  const [totalIndicadores, setTotalIndicadores] = useState(29);
  const router = useRouter();
  const enLinea = useEnLinea();

  useEffect(() => {
    cargarPendientes();
  }, []);

  async function cargarPendientes() {
    setLoading(true);
    const indCount = await db.indicadores.count();
    const totalInd = indCount > 0 ? indCount : 29;
    setTotalIndicadores(totalInd);

    const evals = await db.evaluaciones
      .where('estado').equals('borrador')
      .reverse()
      .toArray();

    const results = await Promise.all(evals.map(async (e) => {
      const prod = await db.productores.get(e.finca_id);
      const detCount = await db.respuestas_indicadores.where('evaluacion_id').equals(e.id).count();
      return { ...e, productor: prod, respondidos: detCount };
    }));

    setItems(results);
    await cargarSinDiagnostico();
    setLoading(false);
  }

  async function cargarSinDiagnostico() {
    try {
      // Solo las del usuario de este celular (funciona sin señal: lib/supabase.js)
      let uid = MOCK_USER.id;
      if (!getMockSession()) {
        const { data } = await createClient().auth.getUser();
        uid = data?.user?.id || null;
      }
      if (!uid) return;

      const desde = Date.now() - DIAS_PENDIENTES * 24 * 60 * 60 * 1000;
      const enviadas = await db.evaluaciones
        .where('estado').equals('enviada')
        .and(e => e.tecnico_id === uid && new Date(e.fecha).getTime() >= desde)
        .toArray();

      const conDiagnostico = new Set(
        (await db.diagnosticos.toArray()).map(d => d.evaluacion_id)
      );
      const faltan = enviadas
        .filter(e => !conDiagnostico.has(e.id))
        .sort((a, b) => String(b.fecha).localeCompare(String(a.fecha)));

      setSinDiagnostico(await Promise.all(faltan.map(async (e) => ({
        ...e,
        productor: await db.productores.get(e.finca_id),
      }))));
    } catch { /* si falla, la sección simplemente no aparece */ }
  }

  return (
    <div className="flex flex-col gap-4 pb-20">
      <h1 className="text-2xl font-bold text-white">En Proceso</h1>

      <div className="flex flex-col gap-3">
        {loading ? (
          <div className="text-center py-10 text-white/40">Cargando pendientes...</div>
        ) : items.length > 0 ? (
          items.map(item => (
            <div key={item.id} className="card-solid">
              <div className="flex justify-between items-start mb-2">
                <div>
                  <h3 className="font-bold text-gray-800">{item.productor?.nombre_completo || 'Desconocido'}</h3>
                  <p className="text-xs text-gray-400">{item.productor?.vereda} - {item.productor?.municipio}</p>
                </div>
                <span className="text-[10px] bg-pnn-azul/10 text-pnn-azul px-2 py-1 rounded-full font-bold">
                  {new Date(item.fecha).toLocaleDateString()}
                </span>
              </div>

              <div className="flex items-center gap-3 mt-4">
                <div className="flex-1 h-2 bg-gray-100 rounded-full overflow-hidden">
                  <div
                    className="h-full bg-gradient-to-r from-pnn-azul to-pnn-azul-claro rounded-full transition-all duration-500"
                    style={{ width: `${(item.respondidos / totalIndicadores) * 100}%` }}
                  ></div>
                </div>
                <span className="text-xs font-bold text-gray-500">{item.respondidos} / {totalIndicadores}</span>
              </div>

              <button
                onClick={() => router.push(`/calificacion?id=${item.id}`)}
                className="w-full mt-4 bg-pnn-azul/10 text-pnn-azul py-3 rounded-xl font-bold text-sm hover:bg-pnn-azul/20 transition-colors"
              >
                Continuar Evaluación →
              </button>
            </div>
          ))
        ) : (
          <div className="text-center py-20">
            <p className="text-white/40 mb-6 text-sm">No tienes evaluaciones en curso actualmente.</p>
            <button
              onClick={() => router.push('/buscar')}
              className="btn-primary"
            >
              Iniciar Evaluación
            </button>
          </div>
        )}
      </div>

      {!loading && sinDiagnostico.length > 0 && (
        <div className="flex flex-col gap-3 mt-2">
          <div>
            <h2 className="text-lg font-bold text-white">Diagnóstico pendiente</h2>
            <p className="text-xs text-white/60">
              Evaluaciones enviadas sin señal: falta generar el diagnóstico con IA y su PDF.
            </p>
          </div>
          {sinDiagnostico.map(item => (
            <div key={item.id} className="card-solid">
              <div className="flex justify-between items-start">
                <div>
                  <h3 className="font-bold text-gray-800">{item.productor?.nombre_completo || 'Desconocido'}</h3>
                  <p className="text-xs text-gray-400">{item.productor?.vereda} - {item.productor?.municipio}</p>
                </div>
                <span className="text-[10px] bg-amber-100 text-amber-800 px-2 py-1 rounded-full font-bold">
                  {new Date(item.fecha).toLocaleDateString()}
                </span>
              </div>
              <button
                onClick={() => router.push(`/calificacion?id=${item.id}&resultados=1`)}
                disabled={!enLinea}
                className="w-full mt-4 py-3 rounded-xl font-bold text-sm transition-colors bg-amber-100 text-amber-900 hover:bg-amber-200 disabled:bg-gray-100 disabled:text-gray-400"
              >
                {enLinea ? '✨ Generar diagnóstico →' : '⏳ Necesita señal'}
              </button>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
