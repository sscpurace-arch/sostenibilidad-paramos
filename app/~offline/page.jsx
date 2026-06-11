'use client';

// Página de respaldo que muestra el service worker cuando se intenta
// abrir una ruta sin conexión y no hay versión cacheada.
export default function OfflinePage() {
  return (
    <div className="min-h-screen flex flex-col items-center justify-center gap-4 p-6 text-center">
      <img
        src="/icon-192x192.png"
        alt="Sostenibilidad Páramos"
        className="w-20 h-20 rounded-2xl shadow-lg"
      />
      <h1 className="text-xl font-extrabold">Sin conexión</h1>
      <p className="text-sm opacity-80 max-w-xs">
        No hay internet y esta pantalla aún no se ha guardado en el dispositivo.
        Tus datos capturados están seguros y se sincronizarán al volver la conexión.
      </p>
      <button
        onClick={() => { window.location.href = '/'; }}
        className="mt-2 px-6 py-3 rounded-xl bg-[#03A64A] text-white font-bold shadow-md active:scale-95 transition"
      >
        Reintentar
      </button>
    </div>
  );
}
