'use client';
import { useState, useEffect } from 'react';
import { db } from '@/lib/db-offline';
import { subscribe } from '@/lib/sync-engine';
import { useRouter } from 'next/navigation';
import Link from 'next/link';

import IconNuevo from '@/components/icons/IconNuevo';

export default function BuscarPage() {
  const [query, setQuery] = useState('');
  const [debouncedQuery, setDebouncedQuery] = useState('');
  const [productores, setProductores] = useState([]);
  const [loading, setLoading] = useState(true);
  const router = useRouter();

  useEffect(() => {
    cargarProductores();
    // Recargar la lista cuando la descarga/sync termine de poblar la base local
    let prevSyncing = false;
    const unsub = subscribe(({ isSyncing }) => {
      if (prevSyncing && !isSyncing) cargarProductores();
      prevSyncing = isSyncing;
    });
    return unsub;
  }, []);

  useEffect(() => {
    const handler = setTimeout(() => {
      setDebouncedQuery(query);
    }, 300);
    return () => clearTimeout(handler);
  }, [query]);

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
    p.nombre_completo?.toLowerCase().includes(debouncedQuery.toLowerCase()) ||
    p.cedula?.includes(debouncedQuery)
  );

  return (
    <div className="flex flex-col gap-4 pb-20">
      <header className="flex justify-between items-center">
        <h1 className="text-2xl font-bold text-white">Buscar Productor</h1>
      </header>

      <div className="relative group">
        <input
          type="text"
          placeholder="Toca aquí para buscar productor..."
          className="w-full p-5 pr-12 rounded-2xl bg-white/95 backdrop-blur-sm border-2 border-white/20 focus:border-pnn-verde focus:outline-none shadow-card-premium transition-all text-lg text-gray-800 placeholder-gray-400"
          value={query}
          onChange={(e) => setQuery(e.target.value)}
        />
        <div className="absolute right-5 top-5 text-gray-400">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
            <circle cx="11" cy="11" r="8" />
            <line x1="21" y1="21" x2="16.65" y2="16.65" />
          </svg>
        </div>
      </div>

      <div className="flex flex-col gap-3 mt-2">
        {!query && !loading && (
          <h2 className="text-xs font-bold text-white/40 uppercase tracking-widest px-1">
            Lista Completa ({productores.length})
          </h2>
        )}
        {loading ? (
          <div className="text-center py-10 text-white/40 italic">Cargando productores locales...</div>
        ) : filtered.length > 0 ? (
          filtered.map(p => (
            <div 
              key={p.id}
              onClick={() => router.push(`/calificacion/nueva?productor=${p.id}`)}
              className="card-solid cursor-pointer"
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
            <p className="text-white/40 mb-4">No se encontraron productores.</p>
            <Link 
              href="/nuevo-productor"
              className="text-pnn-verde font-bold border border-pnn-verde px-6 py-2 rounded-lg hover:bg-pnn-verde/10 transition-colors"
            >
              ¿Registrar nuevo?
            </Link>
          </div>
        )}
      </div>

      {/* Floating Action Button */}
      <button 
        onClick={() => router.push('/nuevo-productor')}
        className="fixed bottom-24 right-6 w-14 h-14 bg-gradient-pnn text-white rounded-full shadow-[0_10px_30px_rgba(3,166,74,0.5)] border-[2px] border-[#0A2E1C] flex items-center justify-center z-30 hover:scale-110 active:scale-95 transition-all duration-300 group"
        title="Agregar Nuevo Productor"
      >
        <div className="text-white group-hover:rotate-90 transition-transform duration-300">
          <IconNuevo size={24} />
        </div>
      </button>
    </div>
  );
}
