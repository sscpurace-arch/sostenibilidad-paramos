'use client';

/**
 * Footer fijo con botones de guardar y finalizar.
 *
 * Compacto a propósito: antes eran dos filas de botones grandes y ocupaba
 * casi un tercio de la pantalla del celular, tapando los indicadores.
 */
export default function EvaluacionFooter({ onGuardarSalir, onFinalizar, onCancelar, todosCompletos, totalRespondidos, totalIndicadores, fotosFaltantes = 0 }) {
  return (
    // bottom-0: en esta pantalla la barra de navegación no se muestra (ver
    // Navbar.jsx), así que el pie ocupa el borde inferior con su margen seguro.
    <footer
      className="fixed bottom-0 left-0 right-0 px-3 pt-2.5 bg-white/95 backdrop-blur-md border-t border-gray-100 z-30"
      style={{ paddingBottom: 'calc(0.6rem + env(safe-area-inset-bottom))' }}
    >
      <div className="flex flex-col gap-1.5 max-w-md mx-auto">
        <div className="flex gap-2 w-full">
          <button
            onClick={onCancelar}
            aria-label="Cancelar"
            className="w-12 shrink-0 bg-red-50 text-red-600 rounded-xl font-bold text-base active:scale-95 transition-all border border-red-100 flex items-center justify-center"
          >
            ✕
          </button>
          <button
            onClick={onGuardarSalir}
            className="shrink-0 bg-gray-100 text-gray-700 px-3 rounded-xl font-bold text-xs active:scale-95 transition-all flex items-center justify-center gap-1"
          >
            💾 Guardar y salir
          </button>
          <button
            onClick={onFinalizar}
            className={`flex-1 py-3 rounded-xl font-black text-sm shadow-lg transition-all active:scale-95 ${
              todosCompletos
                ? 'bg-[#03A64A] text-white shadow-[0_6px_16px_rgba(3,166,74,0.35)]'
                : 'bg-gray-300 text-gray-500'
            }`}
          >
            {todosCompletos ? '✅ ENVIAR' : `Enviar ${totalRespondidos}/${totalIndicadores}`}
          </button>
        </div>

        {/* Aviso, no bloqueo: el botón sigue siendo pulsable. Al enviar se
            listan los indicadores sin foto y el técnico decide. */}
        {fotosFaltantes > 0 && (
          <p className="text-[11px] text-amber-700 text-center">
            📷 {fotosFaltantes === 1
              ? 'Un indicador sin foto'
              : `${fotosFaltantes} indicadores sin foto`}
          </p>
        )}
      </div>
    </footer>
  );
}
