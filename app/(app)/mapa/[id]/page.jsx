'use client';
import { useState, useEffect } from 'react';
import { db } from '@/lib/db-offline';
import { useRouter } from 'next/navigation';
import dynamic from 'next/dynamic';

// Importar el mapa dinámicamente para evitar errores de SSR con Leaflet
const Map = dynamic(() => import('@/components/Map'), { 
  ssr: false,
  loading: () => <div className="h-full w-full bg-gray-100 animate-pulse flex items-center justify-center">Cargando mapa...</div>
});

export default function MapaPage({ params }) {
  const [productor, setProductor] = useState(null);
  const [loading, setLoading] = useState(true);
  const router = useRouter();

  useEffect(() => {
    async function cargarProductor() {
      const p = await db.productores.get(params.id);
      if (!p) {
        alert('Productor no encontrado');
        router.back();
        return;
      }
      setProductor(p);
      setLoading(false);
    }
    cargarProductor();
  }, [params.id, router]);

  if (loading) return <div className="p-10 text-center text-gray-400">Cargando datos del predio...</div>;

  const farmCoords = productor.ubicacion_lat && productor.ubicacion_lng 
    ? [parseFloat(productor.ubicacion_lat), parseFloat(productor.ubicacion_lng)] 
    : null;

  return (
    <div className="fixed inset-0 bg-white z-[60] flex flex-col h-screen">
      <header className="p-4 bg-white border-b border-gray-100 flex items-center gap-4">
        <button onClick={() => router.back()} className="text-gray-500 p-2 bg-gray-50 rounded-full">←</button>
        <div>
          <h1 className="font-bold text-gray-800 leading-tight">{productor.nombre_predio || 'Ubicación del Predio'}</h1>
          <p className="text-xs text-gray-400">{productor.nombre_completo}</p>
        </div>
      </header>

      <div className="flex-1 relative w-full h-full bg-gray-50">
        {farmCoords ? (
          <Map farmCoords={farmCoords} farmName={productor.nombre_predio || productor.nombre_completo} />
        ) : (
          <div className="p-10 text-center h-full flex flex-col items-center justify-center gap-4">
            <div className="text-6xl text-gray-300">📍</div>
            <h2 className="text-lg font-bold text-gray-700">Coordenadas no registradas</h2>
            <p className="text-sm text-gray-500 max-w-xs">
              Este productor no tiene coordenadas geográficas registradas en la base de datos.
            </p>
            <button 
              onClick={() => router.back()}
              className="mt-4 bg-[#03A64A] text-white px-6 py-2 rounded-lg font-bold"
            >
              Volver
            </button>
          </div>
        )}
      </div>

      {!farmCoords && (
        <div className="p-6 bg-yellow-50 text-yellow-800 text-xs font-medium border-t border-yellow-100">
          Nota: Para registrar coordenadas, debe editar el perfil del productor en la plataforma principal.
        </div>
      )}
    </div>
  );
}