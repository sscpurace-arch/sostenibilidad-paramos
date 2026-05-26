'use client';
import Image from 'next/image';

/**
 * Marca de agua sutil con el venado del logo de PNN Puracé.
 * Se muestra en la esquina inferior derecha de todas las pantallas.
 * Opacity 0.03 — solo visible si prestas atención.
 * pointer-events: none — no interfiere con la interactividad.
 */
export default function Watermark() {
  return (
    <div 
      className="fixed bottom-20 right-2 z-0 pointer-events-none select-none"
      aria-hidden="true"
    >
      <Image
        src="/images/logo-purace.png"
        alt=""
        width={120}
        height={120}
        className="opacity-[0.03]"
        priority={false}
      />
    </div>
  );
}
