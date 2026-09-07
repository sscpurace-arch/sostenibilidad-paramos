'use client';

/**
 * Red de seguridad de toda la app.
 *
 * Sin esto, cualquier fallo de una pantalla dejaba la ventana en blanco: el
 * técnico en campo no veía nada, no sabía si se habían perdido sus datos y la
 * única salida era cerrar la app. Lo capturado sigue guardado en el celular:
 * esta pantalla solo reemplaza al vacío.
 */
export default function ErrorApp({ error, reset }) {
  return (
    <div className="flex flex-col items-center justify-center py-20 gap-5 text-center px-6">
      <div className="text-5xl">⚠️</div>
      <h2 className="text-lg font-bold text-white">Algo falló en esta pantalla</h2>
      <p className="text-sm text-white/60 leading-relaxed">
        Tus datos siguen guardados en el celular. Puedes intentar de nuevo o volver al inicio.
      </p>
      <div className="flex flex-col gap-3 w-full max-w-xs">
        <button
          onClick={() => reset()}
          className="bg-[#03A64A] text-white py-3 px-8 rounded-xl font-bold shadow-lg active:scale-95 transition-all"
        >
          Reintentar
        </button>
        <button
          onClick={() => { window.location.href = '/'; }}
          className="bg-white/10 text-white py-3 px-8 rounded-xl font-bold border border-white/20 active:scale-95 transition-all"
        >
          Ir al inicio
        </button>
      </div>
      {error?.digest && (
        <p className="text-[10px] text-white/25 font-mono">ref: {error.digest}</p>
      )}
    </div>
  );
}
