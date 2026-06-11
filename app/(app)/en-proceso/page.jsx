'use client';
import { useState, useEffect } from 'react';
import { db } from '@/lib/db-offline';
import { useRouter } from 'next/navigation';

export default function EnProcesoPage() {
  const [items, setItems] = useState([]);
  const [loading, setLoading] = useState(true);
  const [totalIndicadores, setTotalIndicadores] = useState(29);
  const router = useRouter();

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
    setLoading(false);
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
    </div>
  );
}
