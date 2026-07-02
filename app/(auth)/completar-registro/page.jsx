'use client';
import { useState, useEffect } from 'react';
import { useRouter } from 'next/navigation';
import { createClient } from '@/lib/supabase';
import TopographicBg from '@/components/TopographicBg';

// Se llega aquí solo la primera vez, justo después de iniciar sesión con
// Google y no tener aún una fila en `usuarios`. Crea el registro (pendiente
// de aprobación) y avisa al administrador por Telegram.
export default function CompletarRegistroPage() {
  const [nombre, setNombre] = useState('');
  const [cargo, setCargo] = useState('');
  const [email, setEmail] = useState('');
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(false);
  const router = useRouter();
  const supabase = createClient();

  useEffect(() => {
    async function cargarUsuario() {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) return router.replace('/login');
      setEmail(user.email || '');
      setNombre(user.user_metadata?.full_name || user.user_metadata?.name || '');
    }
    cargarUsuario();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const handleEnviar = async () => {
    if (!nombre.trim() || !cargo.trim()) {
      setError('Completa tu nombre y tu cargo.');
      return;
    }
    setLoading(true);
    setError(null);
    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) { router.replace('/login'); return; }

      const { error: insertErr } = await supabase.from('usuarios').insert({
        id: user.id,
        email: user.email,
        nombre: nombre.trim(),
        cargo: cargo.trim(),
        rol: 'tecnico',
        activo: false,
      });
      if (insertErr) throw new Error(insertErr.message);

      fetch('/api/notificar', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', 'x-notify-key': process.env.NEXT_PUBLIC_NOTIFY_KEY || '' },
        body: JSON.stringify({ tipo: 'registro', nombre: nombre.trim(), email: user.email, cargo: cargo.trim() }),
      }).catch(() => {});

      router.push('/pendiente-aprobacion');
    } catch (e) {
      setError('No se pudo completar el registro. Intenta de nuevo.');
      console.error(e);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen relative flex items-center justify-center p-6 overflow-hidden">
      <TopographicBg />
      <div className="w-full max-w-sm relative z-10">
        <div className="card-glass p-8 flex flex-col gap-5">
          <div className="text-center">
            <h1 className="text-xl font-black text-white">Completa tu registro</h1>
            <p className="text-sm text-white/50 mt-1">{email}</p>
          </div>

          {error && (
            <div className="bg-red-950/50 border border-red-500/30 text-red-200 px-4 py-3 rounded-2xl text-xs font-semibold">
              {error}
            </div>
          )}

          <div className="flex flex-col gap-1.5">
            <label className="text-[10px] font-black text-white/60 uppercase tracking-widest pl-1">Nombre completo</label>
            <input
              type="text"
              value={nombre}
              onChange={(e) => setNombre(e.target.value)}
              className="w-full px-4 py-3.5 rounded-2xl bg-white/[0.04] border border-white/10 text-white placeholder-white/20 focus:outline-none focus:ring-2 focus:ring-pnn-verde text-sm font-medium"
            />
          </div>

          <div className="flex flex-col gap-1.5">
            <label className="text-[10px] font-black text-white/60 uppercase tracking-widest pl-1">Cargo</label>
            <input
              type="text"
              value={cargo}
              onChange={(e) => setCargo(e.target.value)}
              placeholder="Ej: Técnico de campo, Ingeniero ambiental..."
              className="w-full px-4 py-3.5 rounded-2xl bg-white/[0.04] border border-white/10 text-white placeholder-white/20 focus:outline-none focus:ring-2 focus:ring-pnn-verde text-sm font-medium"
            />
          </div>

          <button
            onClick={handleEnviar}
            disabled={loading}
            className="w-full py-4 rounded-2xl font-black text-sm uppercase tracking-wider bg-gradient-to-r from-[#03A64A] to-[#049DD9] text-white shadow-glow-green disabled:opacity-50"
          >
            {loading ? 'Enviando...' : 'Enviar solicitud'}
          </button>

          <p className="text-[10px] text-white/40 text-center leading-relaxed">
            Un administrador revisará tu solicitud antes de darte acceso.
          </p>
        </div>
      </div>
    </div>
  );
}
