'use client';
import { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import { createClient } from '@/lib/supabase';
import TopographicBg from '@/components/TopographicBg';

export default function PendienteAprobacionPage() {
  const [verificando, setVerificando] = useState(false);
  const router = useRouter();
  const supabase = createClient();

  useEffect(() => {
    async function chequearYaAprobado() {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) return router.replace('/login');
      const { data: ud } = await supabase.from('usuarios').select('activo').eq('id', user.id).maybeSingle();
      if (ud?.activo) router.replace('/');
    }
    chequearYaAprobado();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const handleVerificar = async () => {
    setVerificando(true);
    const { data: { user } } = await supabase.auth.getUser();
    if (user) {
      const { data: ud } = await supabase.from('usuarios').select('activo').eq('id', user.id).maybeSingle();
      if (ud?.activo) { router.replace('/'); return; }
    }
    setVerificando(false);
  };

  const handleSalir = async () => {
    await supabase.auth.signOut();
    router.push('/login');
  };

  return (
    <div className="min-h-screen relative flex items-center justify-center p-6 overflow-hidden">
      <TopographicBg />
      <div className="w-full max-w-sm relative z-10 text-center">
        <div className="card-glass p-8 flex flex-col items-center gap-4">
          <div className="w-16 h-16 rounded-full bg-amber-400/20 border border-amber-400/40 flex items-center justify-center text-3xl">⏳</div>
          <h1 className="text-xl font-black text-white">Registro pendiente</h1>
          <p className="text-sm text-white/60 leading-relaxed">
            Tu solicitud fue enviada. Un administrador de PNN Puracé debe aprobarla antes de que puedas usar la app.
          </p>
          <button
            onClick={handleVerificar}
            disabled={verificando}
            className="w-full py-3.5 rounded-2xl font-black text-sm uppercase tracking-wider bg-gradient-to-r from-[#03A64A] to-[#049DD9] text-white disabled:opacity-50"
          >
            {verificando ? 'Verificando...' : 'Ya me aprobaron, verificar'}
          </button>
          <button onClick={handleSalir} className="text-xs text-white/40 font-bold uppercase tracking-wider">
            Cerrar sesión
          </button>
        </div>
      </div>
    </div>
  );
}
