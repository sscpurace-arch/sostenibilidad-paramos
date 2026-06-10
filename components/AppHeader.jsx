'use client';
import Image from 'next/image';
import { useState, useEffect } from 'react';
import { createClient, getMockSession, clearMockSession } from '@/lib/supabase';
import { useRouter } from 'next/navigation';

/**
 * Header institucional premium con logos PNN y menú hamburguesa.
 * - Logo Puracé (izquierda) — identidad del parque local
 * - Logo PNN Nacional (derecha) — respaldo institucional
 * - Menú hamburguesa — acceso a perfil y logout
 * - Barra con gradiente verde→azul de fondo
 * - Glassmorphism sobre el fondo oscuro
 */
export default function AppHeader({ title, subtitle }) {
  const [menuOpen, setMenuOpen] = useState(false);
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(false);
  const [isMock, setIsMock] = useState(false);
  const [logoParqueVisible, setLogoParqueVisible] = useState(true);
  const [logoPnnVisible, setLogoPnnVisible] = useState(true);
  const supabase = createClient();
  const router = useRouter();

  useEffect(() => {
    const mockSession = getMockSession();
    setIsMock(!!mockSession);

    if (mockSession) {
      setUser({ nombre: 'Modo Prueba', email: 'demo@purace.test', rol: 'Visitante' });
      return;
    }

    async function getSessionUser() {
      const { data: { user: authUser } } = await supabase.auth.getUser();
      if (authUser) {
        try {
          // Buscar primero por id, luego por email como respaldo
          let { data: userData } = await supabase
            .from('usuarios')
            .select('nombre, rol')
            .eq('id', authUser.id)
            .single();

          if (!userData?.rol) {
            const { data: byEmail } = await supabase
              .from('usuarios')
              .select('nombre, rol')
              .eq('email', authUser.email)
              .single();
            if (byEmail) userData = byEmail;
          }

          const rolFinal = userData?.rol || authUser.user_metadata?.rol
            || (authUser.email === 'sscpurace@gmail.com' ? 'admin' : 'Técnico');
          setUser({
            email: authUser.email,
            nombre: userData?.nombre || authUser.user_metadata?.nombre || authUser.email.split('@')[0],
            rol: rolFinal
          });
        } catch {
          const rolFinal = authUser.user_metadata?.rol
            || (authUser.email === 'sscpurace@gmail.com' ? 'admin' : 'Técnico');
          setUser({
            email: authUser.email,
            nombre: authUser.user_metadata?.nombre || authUser.email.split('@')[0],
            rol: rolFinal
          });
        }
      }
    }
    getSessionUser();
  }, [supabase]);

  const handleSalirPrueba = () => {
    clearMockSession();
    window.location.href = '/login';
  };

  const handleLogout = async () => {
    setLoading(true);
    try {
      await supabase.auth.signOut();
      router.push('/login');
      router.refresh();
    } catch (e) {
      console.error('Error cerrando sesión:', e);
    } finally {
      setLoading(false);
      setMenuOpen(false);
    }
  };

  return (
    <header className="sticky top-0 z-40 -mx-4 -mt-4 mb-6 overflow-visible">
      {/* Fondo gradiente */}
      <div className="bg-gradient-to-r from-[#028A3D] via-[#03A64A] to-[#049DD9] px-5 pt-5 pb-6">
        <div className="flex items-center justify-between">
          {/* Logo Puracé + Texto */}
          <div className="flex items-center gap-3">
            {logoParqueVisible && (
              <div className="shrink-0 w-11 h-11 rounded-full overflow-hidden ring-2 ring-white/30 shadow-lg">
                <Image
                  src="/images/logo-purace.png"
                  alt="PNN Puracé"
                  width={44}
                  height={44}
                  className="w-full h-full object-cover"
                  priority
                  onError={() => setLogoParqueVisible(false)}
                />
              </div>
            )}
            <div className="min-w-0">
              <h1 className="text-base font-extrabold text-white leading-tight truncate drop-shadow-sm">
                {title || 'Sostenibilidad'}
              </h1>
              <p className="text-[11px] text-white/70 font-semibold leading-tight">
                {subtitle || 'PNN Puracé — Páramos'}
              </p>
              {isMock && (
                <span className="mt-1 inline-flex items-center gap-1 px-2 py-0.5 rounded-full bg-amber-400/90 text-amber-950 text-[9px] font-black uppercase tracking-widest shadow">
                  <span className="w-1 h-1 rounded-full bg-amber-950 animate-pulse" />
                  Modo Prueba
                </span>
              )}
            </div>
          </div>

          <div className="flex items-center gap-3">
            {/* Logo PNN Nacional */}
            {logoPnnVisible && (
              <div className="shrink-0 w-11 h-11 rounded-lg overflow-hidden bg-white/10 backdrop-blur-sm p-1 ring-1 ring-white/20">
                <Image
                  src="/images/logo-pnn-nacional.png"
                  alt="Parques Nacionales Naturales"
                  width={44}
                  height={44}
                  className="w-full h-full object-contain"
                  onError={() => setLogoPnnVisible(false)}
                />
              </div>
            )}

            {/* Botón de Menú Hamburguesa */}
            <button
              onClick={() => setMenuOpen(!menuOpen)}
              className="w-11 h-11 flex items-center justify-center rounded-lg bg-white/10 backdrop-blur-sm ring-1 ring-white/20 hover:bg-white/20 transition-all text-white"
              aria-label="Abrir menú"
            >
              <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
                <line x1="3" y1="12" x2="21" y2="12" />
                <line x1="3" y1="6" x2="21" y2="6" />
                <line x1="3" y1="18" x2="21" y2="18" />
              </svg>
            </button>
          </div>
        </div>
      </div>
      
      {/* Curva inferior decorativa */}
      <div className="absolute bottom-0 left-0 right-0 h-4 z-10">
        <svg viewBox="0 0 400 16" preserveAspectRatio="none" className="w-full h-full">
          <path d="M0,0 Q200,16 400,0 L400,16 L0,16 Z" fill="#0D3B23" />
        </svg>
      </div>

      {/* Menú Desplegable (Modal Flotante con Glassmorphism) */}
      {menuOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-sm animate-fade-in">
          <div 
            className="w-full max-w-sm rounded-3xl bg-[#0d2a1c]/90 border border-white/10 p-6 shadow-2xl backdrop-blur-xl relative text-white animate-scale-up"
            onClick={(e) => e.stopPropagation()}
          >
            {/* Botón de cerrar modal */}
            <button 
              onClick={() => setMenuOpen(false)}
              className="absolute top-4 right-4 text-white/60 hover:text-white p-2 rounded-full hover:bg-white/5 transition-all"
            >
              <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
                <line x1="18" y1="6" x2="6" y2="18" />
                <line x1="6" y1="6" x2="18" y2="18" />
              </svg>
            </button>

            <div className="flex flex-col items-center text-center mt-4">
              {/* Círculo de usuario con inicial */}
              <div className="w-16 h-16 rounded-full bg-pnn-verde flex items-center justify-center text-white text-2xl font-black mb-4 shadow-lg ring-4 ring-white/10 uppercase">
                {user?.nombre ? user.nombre.charAt(0) : 'U'}
              </div>

              <h2 className="text-xl font-black text-white">{user?.nombre || 'Técnico Puracé'}</h2>
              <p className="text-sm text-white/50 font-medium mt-1">{user?.email || 'Cargando correo...'}</p>
              
              <div className="mt-2 px-3 py-1 bg-white/5 border border-white/10 rounded-full text-xs font-bold text-pnn-azul-claro uppercase tracking-widest">
                Rol: {user?.rol || 'Evaluador'}
              </div>

              <div className="w-full border-t border-white/5 my-6"></div>

              {/* Botón Panel Admin — solo para administrador */}
              {!isMock && (user?.rol === 'admin' || user?.email === 'sscpurace@gmail.com') && (
                <button
                  onClick={() => { router.push('/admin'); setMenuOpen(false); }}
                  className="w-full mb-3 bg-pnn-verde/10 hover:bg-pnn-verde/20 border border-pnn-verde/30 text-pnn-verde font-bold py-3 px-6 rounded-2xl transition-all flex items-center justify-center gap-2"
                >
                  <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
                    <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z" />
                  </svg>
                  <span>Panel de Administración</span>
                </button>
              )}

              {isMock ? (
                <button
                  onClick={handleSalirPrueba}
                  className="w-full bg-amber-500 hover:bg-amber-600 text-white font-bold py-4 px-6 rounded-2xl shadow-lg transition-all flex items-center justify-center gap-2"
                >
                  <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
                    <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4" />
                    <polyline points="16 17 21 12 16 7" />
                    <line x1="21" y1="12" x2="9" y2="12" />
                  </svg>
                  <span>Salir del modo prueba</span>
                </button>
              ) : (
                <button
                  onClick={handleLogout}
                  disabled={loading}
                  className="w-full bg-[#D80025] hover:bg-red-700 disabled:opacity-50 text-white font-bold py-4 px-6 rounded-2xl shadow-lg transition-all flex items-center justify-center gap-2"
                >
                  {loading ? (
                    <span>Cerrando sesión...</span>
                  ) : (
                    <>
                      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
                        <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4" />
                        <polyline points="16 17 21 12 16 7" />
                        <line x1="21" y1="12" x2="9" y2="12" />
                      </svg>
                      <span>Cerrar Sesión</span>
                    </>
                  )}
                </button>
              )}
            </div>
          </div>
        </div>
      )}
    </header>
  );
}
