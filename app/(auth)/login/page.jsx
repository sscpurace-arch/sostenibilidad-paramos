'use client';
import { useState, useEffect } from 'react';
import { createClient } from '@/lib/supabase';
import { useRouter } from 'next/navigation';
import Image from 'next/image';
import TopographicBg from '@/components/TopographicBg';

export default function LoginPage() {
  const [email, setEmail] = useState('sscpurace@gmail.com');
  const [password, setPassword] = useState('123');
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(false);
  const [showPassword, setShowPassword] = useState(false);
  const [attempts, setAttempts] = useState(0);
  const [cooldown, setCooldown] = useState(0);
  
  const router = useRouter();
  const supabase = createClient();

  useEffect(() => {
    if (cooldown <= 0) return;
    const timer = setInterval(() => {
      setCooldown((prev) => {
        if (prev <= 1) {
          setAttempts(0);
          return 0;
        }
        return prev - 1;
      });
    }, 1000);
    return () => clearInterval(timer);
  }, [cooldown]);

  const handleLogin = async () => {
    if (cooldown > 0) return;
    
    setLoading(true);
    setError(null);
    
    try {
      const { error } = await supabase.auth.signInWithPassword({
        email,
        password,
      });

      if (error) {
        const nextAttempts = attempts + 1;
        setAttempts(nextAttempts);
        if (nextAttempts >= 5) {
          setCooldown(30);
          setError('Demasiados intentos. Por favor espere 30 segundos.');
        } else {
          setError(error.message === 'Invalid login credentials' ? 'Credenciales inválidas' : error.message);
        }
      } else {
        setAttempts(0);
        window.location.href = '/';
      }
    } catch (e) {
      const nextAttempts = attempts + 1;
      setAttempts(nextAttempts);
      if (nextAttempts >= 5) {
        setCooldown(30);
        setError('Demasiados intentos. Por favor espere 30 segundos.');
      } else {
        setError('Error de conexión');
      }
    } finally {
      setLoading(false);
    }
  };

  const handleMockLogin = () => {
    document.cookie = "mock-user-session=" + JSON.stringify({ id: 'e81ba52c-23df-4f4e-808d-937fd606426c', email: 'sscpurace@gmail.com' }) + "; path=/; max-age=31536000;";
    localStorage.setItem('mock-user-session', 'true');
    window.location.href = '/';
  };

  return (
    <div className="min-h-screen relative flex items-center justify-center p-6 overflow-hidden">
      {/* Fondo topográfico animado */}
      <TopographicBg />

      {/* Capa de brillo ambiental de gradientes */}
      <div className="absolute top-[-10%] left-[-10%] w-[50%] h-[50%] rounded-full bg-pnn-verde/10 blur-[120px] pointer-events-none" />
      <div className="absolute bottom-[-10%] right-[-10%] w-[50%] h-[50%] rounded-full bg-pnn-azul/10 blur-[120px] pointer-events-none" />

      <div className="w-full max-w-sm flex flex-col items-center gap-6 relative z-10 animate-entry">
        {/* Fila de Logotipos en Glassmorphism */}
        <div className="flex items-center gap-5 bg-white/5 backdrop-blur-md p-4 rounded-3xl border border-white/10 shadow-2xl ring-1 ring-white/5">
          <div className="shrink-0 w-16 h-16 rounded-full overflow-hidden bg-white/5 p-1 ring-2 ring-white/20 shadow-inner">
            <Image
              src="/images/logo-purace.png"
              alt="PNN Puracé"
              width={64}
              height={64}
              className="w-full h-full object-cover"
              priority
            />
          </div>
          <div className="h-10 w-[1px] bg-white/20" />
          <div className="shrink-0 w-20 h-16 rounded-xl overflow-hidden bg-white/5 p-2 ring-1 ring-white/10 flex items-center justify-center">
            <Image
              src="/images/logo-pnn-nacional.png"
              alt="Parques Nacionales Naturales"
              width={70}
              height={70}
              className="w-full h-full object-contain"
              priority
            />
          </div>
        </div>

        {/* Card Principal de Login */}
        <div className="card-glass w-full p-8 flex flex-col gap-6 relative overflow-hidden">
          {/* Patrón de fondo sutil dentro de la card */}
          <div className="absolute inset-0 opacity-[0.02] pointer-events-none">
            <svg viewBox="0 0 100 100" fill="white" className="w-full h-full">
              <polygon points="50,10 90,90 10,90" />
            </svg>
          </div>

          <div className="text-center relative z-10">
            <h1 className="text-2xl font-black text-white leading-tight">PNN Puracé</h1>
            <p className="text-[10px] text-white/50 font-bold uppercase tracking-widest mt-1">
              Sostenibilidad Páramos
            </p>
          </div>

          <div className="flex flex-col gap-4 relative z-10">
            {error && (
              <div className="bg-red-950/50 border border-red-500/30 text-red-200 px-4 py-3 rounded-2xl text-xs font-semibold animate-shake">
                {error}
              </div>
            )}

            {/* Input de Email */}
            <div className="flex flex-col gap-1.5">
              <label className="text-[10px] font-black text-white/60 uppercase tracking-widest pl-1">
                Correo Electrónico
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
                  placeholder="tecnico@purace.org"
                  className="w-full pl-11 pr-4 py-3.5 rounded-2xl bg-white/[0.04] border border-white/10 text-white placeholder-white/20 focus:outline-none focus:ring-2 focus:ring-pnn-verde focus:border-transparent transition-all text-sm font-medium"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  disabled={cooldown > 0}
                />
              </div>
            </div>

            {/* Input de Contraseña */}
            <div className="flex flex-col gap-1.5">
              <label className="text-[10px] font-black text-white/60 uppercase tracking-widest pl-1">
                Contraseña de Acceso
              </label>
              <div className="relative">
                <span className="absolute inset-y-0 left-0 pl-4 flex items-center text-white/40">
                  <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
                    <rect width="18" height="11" x="3" y="11" rx="2" ry="2" />
                    <path d="M7 11V7a5 5 0 0 1 10 0v4" />
                  </svg>
                </span>
                <input
                  type={showPassword ? "text" : "password"}
                  placeholder="••••••••••••"
                  className="w-full pl-11 pr-12 py-3.5 rounded-2xl bg-white/[0.04] border border-white/10 text-white placeholder-white/20 focus:outline-none focus:ring-2 focus:ring-pnn-verde focus:border-transparent transition-all text-sm font-medium"
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  onKeyDown={(e) => e.key === 'Enter' && cooldown === 0 && handleLogin()}
                  disabled={cooldown > 0}
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

            <div className="text-right">
              <a
                href="#"
                onClick={(e) => {
                  e.preventDefault();
                  alert('Por favor contacte al administrador del sistema para restablecer su contraseña.');
                }}
                className="text-xs text-pnn-azul-claro hover:text-white transition-colors font-bold"
              >
                ¿Olvidaste tu contraseña?
              </a>
            </div>

            <button 
              onClick={handleLogin}
              disabled={loading || cooldown > 0}
              className="w-full py-4 rounded-2xl font-black text-sm uppercase tracking-wider bg-gradient-to-r from-[#03A64A] to-[#049DD9] text-white shadow-glow-green hover:shadow-card-hover hover:-translate-y-0.5 active:scale-[0.98] active:translate-y-0 transition-all duration-300 disabled:opacity-50 mt-2"
            >
              {cooldown > 0 
                ? `Bloqueado (${cooldown}s)` 
                : loading 
                  ? 'Ingresando...' 
                  : 'Ingresar'}
            </button>

            <button 
              type="button"
              onClick={handleMockLogin}
              className="w-full py-4 rounded-2xl font-black text-sm uppercase tracking-wider bg-white/5 border border-white/10 hover:bg-white/10 text-white shadow-md hover:-translate-y-0.5 active:scale-[0.98] active:translate-y-0 transition-all duration-300 mt-2"
            >
              Ingresar en Modo Pruebas (Local)
            </button>
          </div>
        </div>

        {/* Pie de página institucional */}
        <p className="text-[10px] text-white/30 font-bold uppercase tracking-widest text-center mt-2">
          Estrategia SSC — Convenio Páramos
        </p>
      </div>
    </div>
  );
}
