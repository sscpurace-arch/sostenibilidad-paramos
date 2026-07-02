'use client';
import { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import { createClient } from '@/lib/supabase';
import TopographicBg from '@/components/TopographicBg';
import Image from 'next/image';

// Layout aparte del resto de la app: los supervisores no necesitan el motor
// de sincronización offline-first ni el menú de calificar en campo — solo
// visualización. Se valida el rol aquí; si no es supervisor/admin, se saca.
export default function SupervisorLayout({ children }) {
  const [autorizado, setAutorizado] = useState(false);
  const [nombre, setNombre] = useState('');
  const router = useRouter();
  const supabase = createClient();

  useEffect(() => {
    async function verificar() {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) return router.replace('/login');

      const { data: ud } = await supabase.from('usuarios').select('nombre, rol').eq('id', user.id).single();
      const rol = ud?.rol || (user.email === 'sscpurace@gmail.com' ? 'admin' : null);
      if (rol !== 'supervisor' && rol !== 'admin') return router.replace('/');

      setNombre(ud?.nombre || user.email?.split('@')[0] || 'Supervisor');
      setAutorizado(true);
    }
    verificar();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const handleLogout = async () => {
    await supabase.auth.signOut();
    router.push('/login');
  };

  if (!autorizado) {
    return (
      <div className="min-h-screen flex items-center justify-center relative">
        <TopographicBg />
        <p className="text-white/50 text-sm relative z-10">Verificando acceso...</p>
      </div>
    );
  }

  return (
    <div className="min-h-screen relative">
      <TopographicBg />
      <header className="relative z-10 bg-gradient-to-r from-[#028A3D] via-[#03A64A] to-[#049DD9] px-5 pt-5 pb-6 flex items-center justify-between">
        <div className="flex items-center gap-3">
          <div className="shrink-0 w-11 h-11 rounded-full overflow-hidden ring-2 ring-white/30 shadow-lg bg-white/10">
            <Image src="/images/logo-purace.png" alt="PNN Puracé" width={44} height={44} className="w-full h-full object-cover" priority />
          </div>
          <div>
            <h1 className="text-base font-extrabold text-white leading-tight">Dashboard Ejecutivo</h1>
            <p className="text-[11px] text-white/70 font-semibold">Hola, {nombre}</p>
          </div>
        </div>
        <button
          onClick={handleLogout}
          className="text-[10px] font-bold uppercase tracking-widest text-white/70 hover:text-white bg-white/10 px-3 py-2 rounded-lg"
        >
          Salir
        </button>
      </header>
      <main className="relative z-10 p-4 max-w-2xl mx-auto pb-10">
        {children}
      </main>
    </div>
  );
}
