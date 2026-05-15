'use client';
import { useState, useEffect } from 'react';
import { db } from '@/lib/db-offline';
import { useRouter } from 'next/navigation';
import Link from 'next/link';

export default function BuscarPage() {
  const [query, setQuery] = useState('');
  const [productores, setProductores] = useState([]);
  const [loading, setLoading] = useState(true);
  const router = useRouter();

  useEffect(() => {
    cargarProductores();
  }, []);

  async function cargarProductores() {
    setLoading(true);
    try {
      const all = await db.productores.toArray();
      setProductores(all);
    } catch (e) {
      console.error('Error cargando productores de DB local:', e);
    } finally {
      setLoading(false);
    }
  }

  const filtered = productores.filter(p => 
    p.nombre_completo?.toLowerCase().includes(query.toLowerCase()) ||
    p.cedula?.includes(query)
  );

  return (
    <div className="flex flex-col gap-4 pb-20">
      <header className="flex justify-between items-center">
        <h1 className="text-2xl font-bold text-gray-800">Buscar Productor</h1>
      </header>

      <div className="relative group">
        <input
          type="text"
          placeholder="Toca aquí para buscar productor..."
          className="w-full p-5 pr-12 rounded-2xl border-2 border-gray-100 focus:border-[#2E7D32] focus:outline-none shadow-sm transition-all text-lg"
          value={query}
          onChange={(e) => setQuery(e.target.value)}
        />
        <div className="absolute right-5 top-5 text-gray-400 text-xl">🔍</div>
      </div>

      <div className="flex flex-col gap-3 mt-4">
        {!query && !loading && (
          <h2 className="text-xs font-bold text-gray-400 uppercase tracking-widest px-1">
            Lista Completa ({productores.length})
          </h2>
        )}
        {loading ? (
          <div className="text-center py-10 text-gray-400 italic">Cargando productores locales...</div>
        ) : filtered.length > 0 ? (
          filtered.map(p => (
            <div 
              key={p.id}
              onClick={() => router.push(`/calificacion/nueva/${p.id}`)}
              className="bg-white p-4 rounded-xl shadow-sm border border-gray-100 active:bg-gray-50 transition-colors"
            >
              <h3 className="font-bold text-gray-800">{p.nombre_completo}</h3>
              <p className="text-sm text-gray-500 font-mono">CC: {p.cedula}</p>
              <div className="flex gap-2 text-xs text-gray-400 mt-1">
                <span>{p.nombre_predio || 'Sin predio'}</span>
                <span>•</span>
                <span>{p.vereda || 'Sin vereda'}</span>
                <span>•</span>
                <span>{p.municipio}</span>
              </div>
            </div>
          ))
        ) : (
          <div className="text-center py-10">
            <p className="text-gray-400 mb-4">No se encontraron productores.</p>
            <Link 
              href="/nuevo-productor"
              className="text-[#2E7D32] font-bold border border-[#2E7D32] px-6 py-2 rounded-lg"
            >
              ¿Registrar nuevo?
            </Link>
          </div>
        )}
      </div>

      {/* Floating Action Button */}
      <button 
        onClick={() => router.push('/nuevo-productor')}
        className="fixed bottom-24 right-6 w-14 h-14 bg-[#2E7D32] text-white rounded-full shadow-xl flex items-center justify-center text-3xl font-light z-30"
      >
        +
      </button>
    </div>
  );
}
