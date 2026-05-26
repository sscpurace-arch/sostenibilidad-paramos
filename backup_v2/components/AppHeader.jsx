'use client';
import Image from 'next/image';

/**
 * Header institucional premium con logos PNN.
 * - Logo Puracé (izquierda) — identidad del parque local
 * - Logo PNN Nacional (derecha) — respaldo institucional
 * - Barra con gradiente verde→azul de fondo
 * - Glassmorphism sobre el fondo oscuro
 */
export default function AppHeader({ title, subtitle }) {
  return (
    <header className="relative -mx-4 -mt-4 mb-6 overflow-hidden">
      {/* Fondo gradiente */}
      <div className="bg-gradient-to-r from-[#028A3D] via-[#03A64A] to-[#049DD9] px-5 pt-5 pb-6">
        <div className="flex items-center justify-between">
          {/* Logo Puracé + Texto */}
          <div className="flex items-center gap-3">
            <div className="shrink-0 w-11 h-11 rounded-full overflow-hidden ring-2 ring-white/30 shadow-lg">
              <Image
                src="/images/logo-purace.png"
                alt="PNN Puracé"
                width={44}
                height={44}
                className="w-full h-full object-cover"
                priority
              />
            </div>
            <div className="min-w-0">
              <h1 className="text-base font-extrabold text-white leading-tight truncate drop-shadow-sm">
                {title || 'Sostenibilidad'}
              </h1>
              <p className="text-[11px] text-white/70 font-semibold leading-tight">
                {subtitle || 'PNN Puracé — Páramos'}
              </p>
            </div>
          </div>

          {/* Logo PNN Nacional */}
          <div className="shrink-0 w-14 h-14 rounded-lg overflow-hidden bg-white/10 backdrop-blur-sm p-1.5 ring-1 ring-white/20">
            <Image
              src="/images/logo-pnn-nacional.png"
              alt="Parques Nacionales Naturales"
              width={56}
              height={56}
              className="w-full h-full object-contain"
            />
          </div>
        </div>
      </div>
      {/* Curva inferior decorativa */}
      <div className="absolute bottom-0 left-0 right-0 h-4">
        <svg viewBox="0 0 400 16" preserveAspectRatio="none" className="w-full h-full">
          <path d="M0,0 Q200,16 400,0 L400,16 L0,16 Z" fill="#0D3B23" />
        </svg>
      </div>
    </header>
  );
}
