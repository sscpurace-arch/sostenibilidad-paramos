'use client';
import { useState, useEffect, useMemo } from 'react';
import { db } from '@/lib/db-offline';
import { useRouter } from 'next/navigation';
import dynamic from 'next/dynamic';

// Importar el mapa dinámicamente para evitar errores de SSR con Leaflet
const MultiMap = dynamic(() => import('@/components/MultiMap'), { 
  ssr: false,
  loading: () => (
    <div className="h-full w-full bg-gray-100 animate-pulse flex flex-col items-center justify-center gap-4">
      <div className="text-4xl">🗺️</div>
      <div className="text-gray-400 font-bold">Cargando mapa global...</div>
    </div>
  )
});

export default function MapaGlobalPage() {
  const [productores, setProductores] = useState([]);
  const [loading, setLoading] = useState(true);
  const router = useRouter();

  useEffect(() => {
    async function cargarDatos() {
      try {
        const all = await db.productores.toArray();
        setProductores(all);
      } catch (e) {
        console.error('Error cargando productores:', e);
      } finally {
        setLoading(false);
      }
    }
    cargarDatos();
  }, []);

  // Procesar productores para asignar colores por vereda
  const productoresConColor = useMemo(() => {
    const veredasUnicas = [...new Set(productores.map(p => p.vereda || 'Sin registrar'))].sort();
    
    // Generar una paleta de colores HSL usando la Proporción Áurea para máxima distinción
    const veredaColors = {};
    const GOLDEN_RATIO_CONJUGATE = 0.618033988749895;
    let hue = Math.random(); // Empezar en un punto aleatorio o fijo
    
    veredasUnicas.forEach((vereda, index) => {
      // La proporción áurea distribuye los colores de forma muy uniforme en el círculo cromático
      const h = (index * 137.5) % 360; 
      veredaColors[vereda] = `hsl(${h}, 80%, 45%)`;
    });

    return productores.map(p => ({
      ...p,
      color: veredaColors[p.vereda || 'Sin registrar']
    }));
  }, [productores]);

  if (loading) return (
    <div className="fixed inset-0 bg-white flex items-center justify-center">
      <div className="text-gray-400 animate-bounce">Cargando productores...</div>
    </div>
  );

  return (
    <div className="fixed inset-0 bg-white z-[60] flex flex-col h-screen">
      <header className="p-4 bg-white border-b border-gray-100 flex items-center justify-between">
        <div className="flex items-center gap-4">
          <button onClick={() => router.back()} className="text-gray-500 p-2 bg-gray-50 rounded-full active:scale-90 transition-transform">←</button>
          <div>
            <h1 className="font-black text-gray-800 text-lg leading-tight">Mapa de Productores</h1>
            <p className="text-[10px] text-gray-400 font-bold uppercase tracking-widest">
              {productoresConColor.filter(p => p.ubicacion_lat).length} ubicaciones registradas
            </p>
          </div>
        </div>
        <div className="bg-green-50 text-[#2E7D32] text-[10px] px-3 py-1 rounded-full font-black">
          SISTEMA DE MONITOREO
        </div>
      </header>

      <div className="flex-1 relative w-full h-full bg-gray-50 overflow-hidden">
        <MultiMap producers={productoresConColor} />
      </div>

      <div className="p-4 bg-white border-t border-gray-100 flex items-center justify-between text-[10px] text-gray-400 font-medium">
        <span>© PNN Puracé - Sostenibilidad</span>
        <span className="flex items-center gap-1">
          <span className="w-1.5 h-1.5 bg-green-500 rounded-full animate-pulse"></span>
          Datos sincronizados
        </span>
      </div>
    </div>
  );
}
