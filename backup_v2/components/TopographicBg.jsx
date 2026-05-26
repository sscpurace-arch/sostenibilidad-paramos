'use client';

/**
 * Fondo decorativo con líneas topográficas animadas.
 * Evoca los mapas de contorno del páramo colombiano.
 * pointer-events: none — no interfiere con la interactividad.
 * Opacity 4% — sutil, solo ambiental.
 */
export default function TopographicBg() {
  return (
    <div className="topo-bg" aria-hidden="true">
      <svg viewBox="0 0 800 1200" preserveAspectRatio="xMidYMid slice">
        <g className="topo-lines" stroke="rgba(255,255,255,0.6)" fill="none" strokeLinecap="round">
          {/* Capa 1 — Líneas principales (más gruesas) */}
          <path d="M-50,80 Q150,40 300,90 T600,70 T850,100" strokeWidth="1.5" />
          <path d="M-30,180 Q200,140 350,200 T650,160 T870,190" strokeWidth="1.2" />
          <path d="M-50,300 Q100,260 280,320 T580,280 T850,310" strokeWidth="1.5" />
          <path d="M-20,420 Q180,380 350,440 T620,400 T860,430" strokeWidth="1.2" />
          <path d="M-40,550 Q130,510 300,560 T590,530 T850,560" strokeWidth="1.5" />
          <path d="M-30,680 Q200,640 370,700 T640,660 T870,690" strokeWidth="1.2" />
          <path d="M-50,800 Q100,770 280,820 T570,790 T850,810" strokeWidth="1.5" />
          <path d="M-20,930 Q170,890 340,950 T630,910 T860,940" strokeWidth="1.2" />
          <path d="M-40,1060 Q140,1020 310,1080 T600,1040 T850,1070" strokeWidth="1.5" />
          <path d="M-30,1160 Q190,1130 360,1180 T650,1150 T870,1170" strokeWidth="1.2" />

          {/* Capa 2 — Líneas secundarias (más finas, offset) */}
          <path d="M-60,130 Q180,100 320,140 T630,120 T870,145" strokeWidth="0.7" opacity="0.5" />
          <path d="M-40,250 Q160,220 310,260 T610,240 T860,255" strokeWidth="0.7" opacity="0.5" />
          <path d="M-50,370 Q140,340 290,380 T590,360 T850,375" strokeWidth="0.7" opacity="0.5" />
          <path d="M-30,490 Q190,460 340,500 T640,480 T870,495" strokeWidth="0.7" opacity="0.5" />
          <path d="M-60,620 Q120,590 280,630 T580,610 T850,625" strokeWidth="0.7" opacity="0.5" />
          <path d="M-40,750 Q170,720 330,760 T620,740 T860,755" strokeWidth="0.7" opacity="0.5" />
          <path d="M-50,870 Q130,840 300,880 T600,860 T850,875" strokeWidth="0.7" opacity="0.5" />
          <path d="M-30,1000 Q180,970 350,1010 T640,990 T870,1005" strokeWidth="0.7" opacity="0.5" />
          <path d="M-60,1120 Q150,1090 320,1130 T610,1110 T850,1125" strokeWidth="0.7" opacity="0.5" />

          {/* Capa 3 — Curvas cerradas (formaciones montañosas) */}
          <ellipse cx="600" cy="300" rx="120" ry="50" strokeWidth="0.8" opacity="0.4" />
          <ellipse cx="620" cy="300" rx="80" ry="32" strokeWidth="0.6" opacity="0.3" />
          <ellipse cx="200" cy="700" rx="100" ry="40" strokeWidth="0.8" opacity="0.4" />
          <ellipse cx="215" cy="700" rx="60" ry="24" strokeWidth="0.6" opacity="0.3" />
          <ellipse cx="450" cy="1000" rx="90" ry="35" strokeWidth="0.8" opacity="0.4" />
        </g>
      </svg>
    </div>
  );
}
