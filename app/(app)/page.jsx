'use client';
import { useState, useEffect } from 'react';
import { db } from '@/lib/db-offline';
import { createClient } from '@/lib/supabase';
import { subscribe } from '@/lib/sync-engine';
import { useRouter } from 'next/navigation';
function SignalIcon() {
  return (
    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M2 20h.01" />
      <path d="M7 20v-4" />
      <path d="M12 20v-8" />
      <path d="M17 20V8" />
      <path d="M22 4v16" />
    </svg>
  );
}

export default function Dashboard() {
  const [user, setUser] = useState(null);
  const [stats, setStats] = useState({ total: 0, pendientes: 0, completadas: 0 });
  const router = useRouter();
  const supabase = createClient();

  useEffect(() => {
    async function cargarDatos() {
      const { data: { user: authUser } } = await supabase.auth.getUser();
      if (authUser) {
        try {
          const { data: userData } = await supabase.from('usuarios').select('nombre').eq('id', authUser.id).single();
          setUser(userData || { nombre: authUser.user_metadata?.nombre || authUser.email.split('@')[0] });
        } catch {
          setUser({ nombre: authUser.user_metadata?.nombre || authUser.email.split('@')[0] });
        }
      }

      const [total, pendientes, completadas] = await Promise.all([
        db.productores.count(),
        db.evaluaciones.where('estado').equals('borrador').count(),
        db.evaluaciones.where('estado').equals('enviada').count(),
      ]);

      setStats({ total, pendientes, completadas });
    }

    cargarDatos();

    // Recargar stats cuando el sync engine termine de descargar datos de Supabase
    let prevSyncing = false;
    const unsub = subscribe(({ isSyncing }) => {
      if (prevSyncing && !isSyncing) cargarDatos();
      prevSyncing = isSyncing;
    });
    return unsub;
  }, [supabase]);

  return (
    <div className="flex flex-col gap-5 pb-10">
      {/* ═══ Personalized Greeting ═══ */}
      {user && (
        <div className="animate-entry">
          <h2 className="text-2xl font-black text-white drop-shadow-sm">
            Hola, {user.nombre?.split(' ')[0] || 'Técnico'}
          </h2>
        </div>
      )}

      {/* ═══ Hero Card — Glassmorphism ═══ */}
      <section className="card-glass p-6 relative overflow-hidden animate-entry">
        {/* Patrón topográfico interno */}
        <div className="absolute inset-0 opacity-[0.04]">
          <svg viewBox="0 0 400 200" preserveAspectRatio="xMidYMid slice" className="w-full h-full">
            <g stroke="white" fill="none" strokeWidth="1">
              <path d="M0,30 Q100,10 200,40 T400,30" />
              <path d="M0,60 Q100,40 200,70 T400,55" />
              <path d="M0,90 Q100,75 200,100 T400,85" />
              <path d="M0,120 Q100,105 200,130 T400,115" />
              <path d="M0,150 Q100,135 200,160 T400,145" />
              <path d="M0,180 Q100,165 200,190 T400,175" />
            </g>
          </svg>
        </div>

        <div className="relative z-10">
          <h2 className="text-xl font-black text-white mb-2 drop-shadow-sm">
            Acuerdos de Conservación
          </h2>
          <p className="text-sm text-white/70 leading-relaxed font-medium">
            Mide el avance de los acuerdos de conservación a través de la Matriz 
            de Sostenibilidad para la preservación de nuestros páramos.
          </p>
        </div>

        {/* Decoración: montaña abstracta */}
        <div className="absolute -right-8 -bottom-4 w-32 h-32 opacity-[0.08]">
          <svg viewBox="0 0 100 100" fill="white">
            <polygon points="50,10 90,90 10,90" />
            <polygon points="70,30 100,90 40,90" />
          </svg>
        </div>
      </section>

      {/* ═══ Stats rápidas ═══ */}
      <div className="flex gap-3 animate-entry animate-entry-d1">
        <div className="card-glass flex-1 p-3 text-center">
          <p className="text-2xl font-black text-pnn-verde">{stats.total}</p>
          <p className="text-[10px] text-white/50 font-semibold uppercase tracking-wider">Productores</p>
        </div>
        <div className="card-glass flex-1 p-3 text-center">
          <p className="text-2xl font-black text-pnn-azul-claro">{stats.pendientes}</p>
          <p className="text-[10px] text-white/50 font-semibold uppercase tracking-wider">Pendientes</p>
        </div>
        <div className="card-glass flex-1 p-3 text-center">
          <p className="text-2xl font-black text-acento-amarillo">{stats.completadas}</p>
          <p className="text-[10px] text-white/50 font-semibold uppercase tracking-wider">Completas</p>
        </div>
      </div>


      {/* ═══ Offline Status Card ═══ */}
      <section className="card-glass p-5 relative overflow-hidden animate-entry animate-entry-d2">
        <div className="relative z-10 flex items-start gap-3">
          <div className="icon-circle icon-circle-blue text-white shrink-0 w-10 h-10">
            <SignalIcon />
          </div>
          <div>
            <h3 className="font-bold text-white text-sm">Modo Offline Activo</h3>
            <p className="text-xs text-white/50 leading-relaxed mt-1">
              Puedes calificar sin señal. Los datos se guardan en tu celular y se subirán cuando tengas internet.
            </p>
          </div>
        </div>
      </section>
    </div>
  );
}
