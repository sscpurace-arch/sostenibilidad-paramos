'use client';
import { useState, useEffect } from 'react';
import { prepararOffline, estadoOffline } from '@/lib/data-prefetch';

function SignalIcon() {
  return (
    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M2 20h.01" /><path d="M7 20v-4" /><path d="M12 20v-8" /><path d="M17 20V8" /><path d="M22 4v16" />
    </svg>
  );
}

function fechaCorta(iso) {
  try {
    return new Date(iso).toLocaleDateString('es-CO', { day: 'numeric', month: 'short', hour: '2-digit', minute: '2-digit' });
  } catch { return ''; }
}

export default function PrepararOffline() {
  const [estado, setEstado] = useState({ listo: false });
  const [progreso, setProgreso] = useState(null); // { pct, label } | null
  const [error, setError] = useState(null);
  const [online, setOnline] = useState(true);

  useEffect(() => {
    setEstado(estadoOffline());
    setOnline(navigator.onLine);
    const on = () => setOnline(true);
    const off = () => setOnline(false);
    window.addEventListener('online', on);
    window.addEventListener('offline', off);
    return () => {
      window.removeEventListener('online', on);
      window.removeEventListener('offline', off);
    };
  }, []);

  async function iniciar() {
    setError(null);
    if (!navigator.onLine) {
      setError('Necesitas conexión a internet para preparar los datos.');
      return;
    }
    setProgreso({ pct: 0, label: 'Iniciando…' });
    try {
      await prepararOffline((pct, label) => setProgreso({ pct, label }));
      setEstado(estadoOffline());
      setProgreso(null);
    } catch (e) {
      setError(
        e?.message === 'SIN_CONEXION'
          ? 'Necesitas conexión a internet para preparar los datos.'
          : 'Hubo un problema al descargar. Revisa tu conexión e intenta de nuevo.'
      );
      setProgreso(null);
    }
  }

  const descargando = progreso !== null;
  const vencido = estado.listo && estado.diasDesde >= 6;

  return (
    <section className="card-glass p-5 relative overflow-hidden animate-entry animate-entry-d2">
      <div className="relative z-10 flex items-start gap-3">
        <div className="icon-circle icon-circle-blue text-white shrink-0 w-10 h-10">
          <SignalIcon />
        </div>
        <div className="flex-1 min-w-0">
          <h3 className="font-bold text-white text-sm">Guardar datos en celular</h3>

          {/* Estado: descargando */}
          {descargando ? (
            <div className="mt-2">
              <p className="text-xs text-white/70 mb-1.5">{progreso.label}</p>
              <div className="w-full h-2.5 rounded-full bg-white/15 overflow-hidden">
                <div
                  className="h-full bg-pnn-verde transition-all duration-300 ease-out"
                  style={{ width: `${progreso.pct}%` }}
                />
              </div>
              <p className="text-[11px] text-white/50 mt-1 font-mono">{progreso.pct}%</p>
            </div>
          ) : estado.listo ? (
            /* Estado: listo */
            <>
              <p className="text-xs text-white/60 leading-relaxed mt-1">
                ✓ Datos guardados en tu celular. {estado.totalProductores} productores y el mapa listos para usar sin internet.
              </p>
              <p className="text-[11px] text-white/40 mt-0.5">
                Actualizado: {fechaCorta(estado.fecha)}
              </p>
              {vencido && (
                <p className="text-[11px] text-acento-amarillo font-semibold mt-1.5">
                  ⚠ Han pasado varios días. Vuelve a preparar los datos para no perderlos.
                </p>
              )}
              <button
                onClick={iniciar}
                disabled={!online}
                className="mt-2.5 text-xs font-bold text-pnn-verde border border-pnn-verde/60 px-4 py-1.5 rounded-lg hover:bg-pnn-verde/10 active:scale-95 transition disabled:opacity-40 disabled:cursor-not-allowed"
              >
                Actualizar datos
              </button>
            </>
          ) : (
            /* Estado: sin preparar */
            <>
              <p className="text-xs text-white/60 leading-relaxed mt-1">
                Descarga los productores y el mapa para poder calificar sin señal en el campo.
              </p>
              <button
                onClick={iniciar}
                disabled={!online}
                className="mt-2.5 w-full text-sm font-bold text-white bg-gradient-pnn px-4 py-2.5 rounded-xl shadow-md active:scale-95 transition disabled:opacity-40 disabled:cursor-not-allowed"
              >
                📥 Preparar para trabajar sin conexión
              </button>
            </>
          )}

          {!online && !descargando && (
            <p className="text-[11px] text-white/40 mt-1.5">Conéctate a internet para preparar o actualizar.</p>
          )}
          {error && <p className="text-[11px] text-red-300 mt-1.5">{error}</p>}
        </div>
      </div>
    </section>
  );
}
