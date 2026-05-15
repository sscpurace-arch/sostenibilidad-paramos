'use client';
import { useState, useEffect } from 'react';
import { db } from '@/lib/db-offline';
import { useRouter } from 'next/navigation';

export default function EnProcesoPage() {
  const [items, setItems] = useState([]);
  const [loading, setLoading] = useState(true);
  const router = useRouter();

  useEffect(() => {
    cargarPendientes();
  }, []);

  async function cargarPendientes() {
    setLoading(true);
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
      <h1 className="text-2xl font-bold text-gray-800">En Proceso</h1>

      <div className="flex flex-col gap-3">
        {loading ? (
          <div className="text-center py-10 text-gray-400">Cargando pendientes...</div>
        ) : items.length > 0 ? (
          items.map(item => (
            <div key={item.id} className="bg-white p-4 rounded-xl shadow-sm border border-gray-100">
              <div className="flex justify-between items-start mb-2">
                <div>
                  <h3 className="font-bold text-gray-800">{item.productor?.nombre_completo || 'Desconocido'}</h3>
                  <p className="text-xs text-gray-400">{item.productor?.vereda} - {item.productor?.municipio}</p>
                </div>
                <span className="text-[10px] bg-blue-50 text-blue-600 px-2 py-1 rounded-full font-bold">
                  {new Date(item.fecha).toLocaleDateString()}
                </span>
              </div>
              
              <div className="flex items-center gap-3 mt-4">
                <div className="flex-1 h-2 bg-gray-100 rounded-full overflow-hidden">
                  <div 
                    className="h-full bg-blue-500" 
                    style={{ width: `${(item.respondidos / 29) * 100}%` }}
                  ></div>
                </div>
                <span className="text-xs font-bold text-gray-500">{item.respondidos} / 29</span>
              </div>

              <button 
                onClick={() => router.push(`/calificacion/${item.id}`)}
                className="w-full mt-4 bg-blue-50 text-blue-600 py-3 rounded-lg font-bold text-sm"
              >
                Continuar Evaluación →
              </button>
            </div>
          ))
        ) : (
          <div className="text-center py-20">
            <p className="text-gray-400 mb-6 text-sm">No tienes evaluaciones en curso actualmente.</p>
            <button 
              onClick={() => router.push('/buscar')}
              className="bg-[#03A64A] text-white px-8 py-3 rounded-xl font-bold shadow-md"
            >
              Iniciar Evaluación
            </button>
          </div>
        )}
      </div>
    </div>
  );
}
