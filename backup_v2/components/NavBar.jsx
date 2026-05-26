'use client';
import Link from 'next/link';
import { usePathname } from 'next/navigation';
import IconInicio from '@/components/icons/IconInicio';
import IconBuscar from '@/components/icons/IconBuscar';
import IconMapa from '@/components/icons/IconMapa';
import IconProceso from '@/components/icons/IconProceso';
import IconCalificar from '@/components/icons/IconCalificar';

export default function NavBar() {
  const pathname = usePathname();

  const leftLinks = [
    { name: 'Inicio', href: '/', CustomIcon: IconInicio },
    { name: 'Buscar', href: '/buscar', CustomIcon: IconBuscar },
  ];

  const rightLinks = [
    { name: 'Pendientes', href: '/en-proceso', CustomIcon: IconProceso },
    { name: 'Mapa', href: '/mapa', CustomIcon: IconMapa },
  ];

  const renderLink = (link) => {
    const isActive = pathname === link.href;
    return (
      <Link
        key={link.href}
        href={link.href}
        className="flex flex-col items-center justify-center gap-1 py-1 w-16 relative"
      >
        {/* Píldora activa de fondo - Más visible */}
        {isActive && (
          <div className="absolute inset-x-1 top-0 bottom-1 bg-white/[0.03] rounded-xl border border-white/[0.05]" />
        )}
        
        {/* Contenedor del ícono - Contraste mejorado */}
        <div className={`relative transition-all duration-300 ${
          isActive 
            ? 'text-pnn-verde scale-110 drop-shadow-[0_0_12px_rgba(3,166,74,0.7)]' 
            : 'text-white/70 hover:text-white/90'
        }`}>
          <link.CustomIcon size={isActive ? 28 : 24} />
        </div>
        
        {/* Label - Contraste mejorado */}
        <span className={`text-[9px] uppercase tracking-tighter relative transition-all duration-300 ${
          isActive 
            ? 'text-pnn-verde font-black' 
            : 'text-white/50 font-bold'
        }`}>
          {link.name}
        </span>

        {/* Punto indicador activo - Más brillante */}
        {isActive && (
          <div className="absolute -bottom-1 w-1.5 h-1.5 rounded-full bg-pnn-verde shadow-[0_0_10px_rgba(3,166,74,1)] animate-pulse" />
        )}
      </Link>
    );
  };

  return (
    <nav className="fixed bottom-0 left-0 right-0 z-40 pb-safe">
      {/* Botón Flotante Central (FAB) - Glow aumentado */}
      <div className="absolute left-1/2 -translate-x-1/2 -top-10 z-50 flex flex-col items-center group">
        <Link 
          href="/buscar"
          className="flex items-center justify-center w-16 h-16 bg-gradient-pnn rounded-full shadow-[0_10px_40px_rgba(3,166,74,0.6)] border-[4px] border-[#0A2E1C] hover:scale-110 active:scale-95 transition-all duration-500 relative z-10"
          title="Calificar Matriz de Sostenibilidad"
        >
          {/* Brillo interno */}
          <div className="absolute inset-0 bg-white/10 rounded-full blur-sm opacity-0 group-hover:opacity-100 transition-opacity" />
          
          <div className="text-white drop-shadow-[0_0_8px_rgba(255,255,255,0.6)] transition-transform duration-300">
            <IconCalificar size={38} />
          </div>
          
          {/* Efectos de pulsación */}
          <div className="absolute inset-0 rounded-full animate-ping bg-pnn-verde/30 -z-10" />
          <div className="absolute inset-0 rounded-full animate-pulse bg-pnn-verde/20 -z-10 scale-125" />
        </Link>

        {/* Letrero Curvo: Calificar indicadores - Máxima proximidad al círculo */}
        <div className="absolute bottom-[4px] w-[140px] h-[40px] pointer-events-none select-none z-0">
          <svg viewBox="0 0 140 40" className="w-full h-full overflow-visible">
            <defs>
              <path 
                id="curve-path" 
                d="M 10,2 A 60,60 0 0 0 130,2" 
              />
            </defs>
            <text className="fill-white font-black text-[8.5px] uppercase tracking-[0.18em]">
              <textPath 
                href="#curve-path" 
                startOffset="50%" 
                textAnchor="middle"
                className="drop-shadow-[0_1px_2px_rgba(0,0,0,1)]"
              >
                Calificar indicadores
              </textPath>
            </text>
          </svg>
        </div>
      </div>






      {/* Fondo frosted glass oscuro - Más profundo y definido */}
      <div className="absolute inset-0 bg-[#061A10]/95 backdrop-blur-2xl border-t border-white/[0.1] shadow-[0_-8px_30px_rgba(0,0,0,0.6)]" />
      
      {/* Contenedor de enlaces - Más centrados y compactos */}
      <div className="relative flex justify-center items-center px-2 py-2 gap-4">
        <div className="flex gap-4">
          {leftLinks.map(renderLink)}
        </div>
        
        {/* Espacio para el FAB - Ancho exacto del botón */}
        <div className="w-16" aria-hidden="true" />
        
        <div className="flex gap-4">
          {rightLinks.map(renderLink)}
        </div>
      </div>
    </nav>
  );
}
