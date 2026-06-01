'use client';
import { useState } from 'react';
import { createClient } from '@/lib/supabase';
import Image from 'next/image';
import TopographicBg from '@/components/TopographicBg';

export default function LoginPage() {
  const [showAdmin, setShowAdmin] = useState(false);
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(false);
  const [attempts, setAttempts] = useState(0);
  const [cooldown, setCooldown] = useState(0);

  const supabase = createClient();

  // Cooldown timer
  useState(() => {
    if (cooldown <= 0) return;
    const timer = setInterval(() => {
      setCooldown((prev) => {
        if (prev <= 1) { setAttempts(0); return 0; }
        return prev - 1;
      });
    }, 1000);
    return () => clearInterval(timer);
  }, [cooldown]);

  const handleMockLogin = () => {
    document.cookie =
      'mock-user-session=' +
      JSON.stringify({ id: 'e81ba52c-23df-4f4e-808d-937fd606426c', email: 'prueba@test.local' }) +
      '; path=/; max-age=31536000;';
    localStorage.setItem('mock-user-session', 'true');
    window.location.href = '/';
  };

  const handleLogin = async () => {
    if (cooldown > 0) return;
    setLoading(true);
    setError(null);
    try {
      const { error } = await supabase.auth.signInWithPassword({ email, password });
      if (error) {
        const next = attempts + 1;
        setAttempts(next);
        if (next >= 5) {
          setCooldown(30);
          setError('Demasiados intentos. Espera 30 segundos.');
        } else {
          setError(error.message === 'Invalid login credentials' ? 'Credenciales inválidas' : error.message);
        }
      } else {
        setAttempts(0);
        window.location.href = '/';
      }
    } catch {
      setError('Error de conexión');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen relative flex items-center justify-center p-6 overflow-hidden">
      <TopographicBg />

      {/* Luces ambientales */}
      <div className="absolute top-[-10%] left-[-10%] w-[50%] h-[50%] rounded-full bg-pnn-verde/10 blur-[120px] pointer-events-none" />
      <div className="absolute bottom-[-10%] right-[-10%] w-[50%] h-[50%] rounded-full bg-pnn-azul/10 blur-[120px] pointer-events-none" />

      <div className="w-full max-w-sm flex flex-col items-center gap-6 relative z-10 animate-entry">

        {/* Logos */}
        <div className="flex items-center gap-5 bg-white/5 backdrop-blur-md p-4 rounded-3xl border border-white/10 shadow-2xl ring-1 ring-white/5">
          <div className="shrink-0 w-16 h-16 rounded-full overflow-hidden bg-white/5 p-1 ring-2 ring-white/20 shadow-inner">
            <Image src="/images/logo-purace.png" alt="PNN Puracé" width={64} height={64} className="w-full h-full object-cover" priority />
          </div>
          <div className="h-10 w-[1px] bg-white/20" />
          <div className="shrink-0 w-20 h-16 rounded-xl overflow-hidden bg-white/5 p-2 ring-1 ring-white/10 flex items-center justify-center">
            <Image src="/images/logo-pnn-nacional.png" alt="Parques Nacionales" width={70} height={70} className="w-full h-full object-contain" priority />
          </div>
        </div>

        {/* Card principal */}
        <div className="card-glass w-full p-8 flex flex-col gap-6 relative overflow-hidden">
          {/* Patrón fondo */}
          <div className="absolute inset-0 opacity-[0.02] pointer-events-none">
            <svg viewBox="0 0 100 100" fill="white" className="w-full h-full">
              <polygon points="50,10 90,90 10,90" />
            </svg>
          </div>

          {/* Título e info */}
          <div className="relative z-10 flex flex-col gap-3">
            <div className="text-center">
              <h1 className="text-2xl font-black text-white leading-tight">Sostenibilidad Páramos</h1>
              <p className="text-[10px] text-white/50 font-bold uppercase tracking-widest mt-1">
                PNN Puracé — Estrategia SSC
              </p>
            </div>

            {/* Badge modo prueba */}
            <div className="flex justify-center">
              <span className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-amber-400/20 border border-amber-400/40 text-amber-300 text-[10px] font-black uppercase tracking-widest">
                <span className="w-1.5 h-1.5 rounded-full bg-amber-400 animate-pulse" />
                Versión de Prueba
              </span>
            </div>

            <p className="text-sm text-white/60 leading-relaxed text-center font-medium">
              Herramienta para medir el avance de los acuerdos de conservación a través de la{' '}
              <span className="text-white/80 font-semibold">Matriz de Sostenibilidad</span> del Parque Nacional Natural Puracé.
            </p>

            <p className="text-xs text-white/40 text-center leading-relaxed bg-white/5 rounded-2xl px-4 py-3 border border-white/10">
              Estás viendo una versión de prueba. Puedes explorarla libremente — los datos que ingreses{' '}
              <span className="text-amber-300/80 font-semibold">quedan marcados como prueba</span> y no afectan la base de datos real.
            </p>
          </div>

          {/* Botones principales */}
          <div className="relative z-10 flex flex-col gap-3">
            {/* Botón prueba — prominente */}
            <button
              onClick={handleMockLogin}
              className="w-full py-4 rounded-2xl font-black text-sm uppercase tracking-wider bg-gradient-to-r from-[#03A64A] to-[#049DD9] text-white shadow-glow-green hover:shadow-card-hover hover:-translate-y-0.5 active:scale-[0.98] transition-all duration-300"
            >
              🌿 Entrar a probarla
            </button>

            {/* Botón admin — secundario */}
            <button
              type="button"
              onClick={() => { setShowAdmin(!showAdmin); setError(null); }}
              className="w-full py-3 rounded-2xl font-bold text-xs uppercase tracking-wider bg-white/5 border border-white/10 hover:bg-white/10 text-white/60 hover:text-white/80 transition-all duration-300"
            >
              {showAdmin ? '✕ Cerrar' : '🔐 Entrada Administrador'}
            </button>
          </div>

          {/* Formulario admin — colapsable */}
          {showAdmin && (
            <div className="relative z-10 flex flex-col gap-4 border-t border-white/10 pt-5 animate-entry">
              <p className="text-[10px] text-white/40 font-bold uppercase tracking-widest text-center">
                Acceso Administrador
              </p>

              {error && (
                <div className="bg-red-950/50 border border-red-500/30 text-red-200 px-4 py-3 rounded-2xl text-xs font-semibold">
                  {error}
                </div>
              )}

              {/* Email */}
              <div className="flex flex-col gap-1.5">
                <label className="text-[10px] font-black text-white/60 uppercase tracking-widest pl-1">
                  Correo
                </label>
                <div className="relative">
                  <span className="absolute inset-y-0 left-0 pl-4 flex items-center text-white/40">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
                      <rect width="20" height="16" x="2" y="4" rx="2" />
                      <path d="m22 7-8.97 5.7a1.94 1.94 0 0 1-2.06 0L2 7" />
                    </svg>
                  </span>
                  <input
                    type="email"
                    placeholder="admin@purace.org"
                    className="w-full pl-11 pr-4 py-3.5 rounded-2xl bg-white/[0.04] border border-white/10 text-white placeholder-white/20 focus:outline-none focus:ring-2 focus:ring-pnn-verde focus:border-transparent transition-all text-sm font-medium"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    disabled={cooldown > 0}
                    autoComplete="email"
                  />
                </div>
              </div>

              {/* Contraseña */}
              <div className="flex flex-col gap-1.5">
                <label className="text-[10px] font-black text-white/60 uppercase tracking-widest pl-1">
                  Contraseña
                </label>
                <div className="relative">
                  <span className="absolute inset-y-0 left-0 pl-4 flex items-center text-white/40">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
                      <rect width="18" height="11" x="3" y="11" rx="2" ry="2" />
                      <path d="M7 11V7a5 5 0 0 1 10 0v4" />
                    </svg>
                  </span>
                  <input
                    type={showPassword ? 'text' : 'password'}
                    placeholder="••••••••••••"
                    className="w-full pl-11 pr-12 py-3.5 rounded-2xl bg-white/[0.04] border border-white/10 text-white placeholder-white/20 focus:outline-none focus:ring-2 focus:ring-pnn-verde focus:border-transparent transition-all text-sm font-medium"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    onKeyDown={(e) => e.key === 'Enter' && cooldown === 0 && handleLogin()}
                    disabled={cooldown > 0}
                    autoComplete="current-password"
                  />
                  <button
                    type="button"
                    onClick={() => setShowPassword(!showPassword)}
                    className="absolute inset-y-0 right-0 pr-4 flex items-center text-white/40 hover:text-white transition-colors"
                  >
                    {showPassword ? (
                      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
                        <path d="M9.88 9.88a3 3 0 1 0 4.24 4.24" />
                        <path d="M10.73 5.08A10.43 10.43 0 0 1 12 5c7 0 10 7 10 7a13.16 13.16 0 0 1-1.67 2.68" />
                        <path d="M6.61 6.61A13.52 13.52 0 0 0 2 12s3 7 10 7a9.74 9.74 0 0 0 5.39-1.61" />
                        <line x1="2" y1="2" x2="22" y2="22" />
                      </svg>
                    ) : (
                      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
                        <path d="M2 12s3-7 10-7 10 7 10 7-3 7-10 7-10-7-10-7Z" />
                        <circle cx="12" cy="12" r="3" />
                      </svg>
                    )}
                  </button>
                </div>
              </div>

              <button
                onClick={handleLogin}
                disabled={loading || cooldown > 0}
                className="w-full py-4 rounded-2xl font-black text-sm uppercase tracking-wider bg-gradient-to-r from-[#03A64A] to-[#049DD9] text-white shadow-glow-green hover:-translate-y-0.5 active:scale-[0.98] transition-all duration-300 disabled:opacity-50"
              >
                {cooldown > 0 ? `Bloqueado (${cooldown}s)` : loading ? 'Ingresando...' : 'Ingresar'}
              </button>
            </div>
          )}
        </div>

        <p className="text-[10px] text-white/30 font-bold uppercase tracking-widest text-center mt-2">
          Estrategia SSC — Convenio Páramos
        </p>
      </div>
    </div>
  );
}
