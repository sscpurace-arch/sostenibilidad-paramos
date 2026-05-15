'use client';
import { useState, useEffect } from 'react';
import { db } from '@/lib/db-offline';
import { createClient } from '@/lib/supabase';
import { useRouter } from 'next/navigation';

export default function Dashboard() {
  const [user, setUser] = useState(null);
  const [stats, setStats] = useState({ total: 0, pendientes: 0, completadas: 0 });
  const router = useRouter();
  const supabase = createClient();

  useEffect(() => {
    cargarDatos();
  }, []);

  async function cargarDatos() {
    const { data: { user: authUser } } = await supabase.auth.getUser();
    if (authUser) {
      // usuarios no está en Dexie — usar datos de auth directamente
      try {
        const { data: userData } = await supabase.from('usuarios').select('nombre').eq('id', authUser.id).single();
        setUser(userData || { nombre: authUser.email.split('@')[0] });
      } catch {
        setUser({ nombre: authUser.email.split('@')[0] });
      }
    }

    const [total, pendientes] = await Promise.all([
      db.productores.count(),
      db.evaluaciones.where('estado').equals('borrador').count(),
    ]);

    setStats({ total, pendientes, completadas: 0 });
  }

  return (
    <div className="flex flex-col gap-6 pb-10">
      <header className="flex justify-between items-start">
        <div>
          <h1 className="text-2xl font-black text-gray-800">Hola, {user?.nombre?.split(' ')[0]}</h1>
          <p className="text-sm text-gray-500">PNN Puracé — Sostenibilidad</p>
        </div>
        <div className="w-10 h-10 bg-[#03A64A] rounded-full flex items-center justify-center text-white font-bold">
          {user?.nombre?.[0] || 'E'}
        </div>
      </header>

      <section className="bg-[#03A64A] text-white p-6 rounded-3xl shadow-xl shadow-green-100 relative overflow-hidden">
        <div className="relative z-10">
          <h2 className="text-xl font-black mb-2">Acuerdos de Conservación</h2>
          <p className="text-sm opacity-90 leading-relaxed font-medium">
            Esta herramienta permite medir el avance de los acuerdos de conservación en el territorio a través de la Matriz de Sostenibilidad, facilitando el seguimiento técnico y la toma de decisiones para la preservación de nuestros páramos.
          </p>
        </div>
        <div className="absolute -right-6 -bottom-6 text-9xl opacity-10 font-black">🌿</div>
      </section>

      <div className="flex flex-col gap-3">
        <button 
          onClick={() => router.push('/buscar')}
          className="w-full bg-white text-[#03A64A] py-5 rounded-2xl font-bold text-lg shadow-sm border border-gray-100 flex items-center px-6 gap-4 active:scale-[0.98] transition-transform text-left"
        >
          <span className="text-2xl">📋</span>
          <span>Calificar Matriz de Productor</span>
        </button>

        <button 
          onClick={() => router.push('/en-proceso')}
          className="w-full bg-white text-gray-700 py-5 rounded-2xl font-bold text-lg shadow-sm border border-gray-100 flex items-center px-6 gap-4 active:scale-[0.98] transition-transform text-left"
        >
          <span className="text-2xl">⏳</span>
          <span>Calificaciones en Proceso</span>
        </button>

        <button 
          onClick={() => router.push('/base-datos')}
          className="w-full bg-white text-gray-700 py-5 rounded-2xl font-bold text-lg shadow-sm border border-gray-100 flex items-center px-6 gap-4 active:scale-[0.98] transition-transform text-left"
        >
          <span className="text-2xl">👥</span>
          <span>Base de Datos de Productores</span>
        </button>
      </div>


      
      <section className="bg-blue-600 rounded-2xl p-5 text-white shadow-lg shadow-blue-100 relative overflow-hidden">
        <div className="relative z-10">
          <h3 className="font-bold text-lg mb-1">Modo Offline Activo</h3>
          <p className="text-xs opacity-90 leading-relaxed">Puedes calificar sin señal. Los datos se guardan en tu celular y se subirán cuando tengas internet.</p>
        </div>
        <div className="absolute -right-4 -bottom-4 text-8xl opacity-10 font-black">📡</div>
      </section>
    </div>
  );
}
