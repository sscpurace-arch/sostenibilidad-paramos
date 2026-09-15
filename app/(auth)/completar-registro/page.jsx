'use client';
import { useState, useEffect } from 'react';
import { useRouter } from 'next/navigation';
import { createClient, getMockSession } from '@/lib/supabase';
import { db } from '@/lib/db-offline';
import TopographicBg from '@/components/TopographicBg';

/**
 * Dos casos llegan aquí:
 *
 * 1. Registro nuevo — primera vez tras entrar con Google, sin fila en
 *    `usuarios`. Se crea la fila (pendiente de aprobación) y se avisa al
 *    administrador por Telegram.
 *
 * 2. Completar datos — el usuario YA existe (registrado antes de que el
 *    cargo fuera obligatorio, o creado a mano) pero le falta nombre o cargo.
 *    Solo se actualizan esas dos columnas vía RPC `completar_perfil`: no se
 *    toca `activo` (un usuario aprobado no debe quedar desactivado) ni se
 *    dispara la notificación de "registro nuevo".
 *
 * El modo visitante no pasa por `usuarios`: se le devuelve al inicio.
 */
export default function CompletarRegistroPage() {
  const [nombre, setNombre] = useState('');
  const [cargo, setCargo] = useState('');
  const [email, setEmail] = useState('');
  const [existente, setExistente] = useState(null); // fila de `usuarios` si ya hay
  const [cargando, setCargando] = useState(true);
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(false);
  const router = useRouter();
  const supabase = createClient();

  useEffect(() => {
    async function cargarUsuario() {
      if (getMockSession()) { router.replace('/'); return; }
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) return router.replace('/login');
      setEmail(user.email || '');

      let fila = null;
      try {
        const { data } = await supabase.from('usuarios').select('id, nombre, cargo, activo').eq('id', user.id).maybeSingle();
        fila = data || null;
      } catch { /* sin red: se muestra el formulario igual */ }
      setExistente(fila);
      setNombre(fila?.nombre || user.user_metadata?.full_name || user.user_metadata?.name || '');
      setCargo(fila?.cargo || '');
      setCargando(false);
    }
    cargarUsuario();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const handleEnviar = async () => {
    if (!nombre.trim() || !cargo.trim()) {
      setError('Completa tus nombres y apellidos y tu cargo.');
      return;
    }
    setLoading(true);
    setError(null);
    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) { router.replace('/login'); return; }

      if (existente) {
        // Caso 2: solo nombre y cargo, de la propia fila
        const { error: rpcErr } = await supabase.rpc('completar_perfil', {
          p_nombre: nombre.trim(),
          p_cargo: cargo.trim(),
        });
        if (rpcErr) throw new Error(rpcErr.message);
        try {
          await db.perfil_tecnico.put({
            id: user.id, nombre: nombre.trim(), cargo: cargo.trim(), email: user.email,
            rol: existente.rol || null, actualizado_en: new Date().toISOString(),
          });
        } catch { /* silent */ }
        router.replace(existente.activo === false ? '/pendiente-aprobacion' : '/');
        return;
      }

      // Caso 1: registro nuevo, pendiente de aprobación
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
      setError(existente
        ? 'No se pudieron guardar tus datos. Revisa la señal e intenta de nuevo.'
        : 'No se pudo completar el registro. Intenta de nuevo.');
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
            <h1 className="text-xl font-black text-white">
              {existente ? 'Completa tus datos' : 'Completa tu registro'}
            </h1>
            <p className="text-sm text-white/50 mt-1">{email}</p>
            {existente && (
              <p className="text-xs text-white/60 mt-3 leading-relaxed">
                Tu nombre y cargo aparecen en los documentos que entregas al productor.
                Solo hay que llenarlos una vez.
              </p>
            )}
          </div>

          {error && (
            <div className="bg-red-950/50 border border-red-500/30 text-red-200 px-4 py-3 rounded-2xl text-xs font-semibold">
              {error}
            </div>
          )}

          <div className="flex flex-col gap-1.5">
            <label className="text-[10px] font-black text-white/60 uppercase tracking-widest pl-1">Nombres y apellidos</label>
            <input
              type="text"
              value={nombre}
              onChange={(e) => setNombre(e.target.value)}
              placeholder="Como aparece en tu documento"
              autoComplete="name"
              disabled={cargando}
              className="w-full px-4 py-3.5 rounded-2xl bg-white/[0.04] border border-white/10 text-white placeholder-white/20 focus:outline-none focus:ring-2 focus:ring-pnn-verde text-base font-medium disabled:opacity-50"
            />
          </div>

          <div className="flex flex-col gap-1.5">
            <label className="text-[10px] font-black text-white/60 uppercase tracking-widest pl-1">Cargo</label>
            <input
              type="text"
              value={cargo}
              onChange={(e) => setCargo(e.target.value)}
              placeholder="Ej: Técnico de campo, Ingeniero ambiental..."
              autoComplete="organization-title"
              disabled={cargando}
              className="w-full px-4 py-3.5 rounded-2xl bg-white/[0.04] border border-white/10 text-white placeholder-white/20 focus:outline-none focus:ring-2 focus:ring-pnn-verde text-base font-medium disabled:opacity-50"
            />
          </div>

          <button
            onClick={handleEnviar}
            disabled={loading || cargando}
            className="w-full py-4 rounded-2xl font-black text-sm uppercase tracking-wider bg-gradient-to-r from-[#03A64A] to-[#049DD9] text-white shadow-glow-green disabled:opacity-50"
          >
            {loading ? 'Guardando...' : (existente ? 'Guardar y continuar' : 'Enviar solicitud')}
          </button>

          {!existente && !cargando && (
            <p className="text-[10px] text-white/40 text-center leading-relaxed">
              Un administrador revisará tu solicitud antes de darte acceso.
            </p>
          )}
        </div>
      </div>
    </div>
  );
}
