'use client';

/**
 * Footer fijo con botones de guardar y finalizar.
 */
export default function EvaluacionFooter({ onGuardarSalir, onFinalizar, onCancelar, todosCompletos, totalRespondidos, totalIndicadores }) {
  return (
    <footer className="fixed bottom-16 left-0 right-0 p-4 bg-white/95 backdrop-blur-md border-t border-gray-100 z-20">
      <div className="flex flex-col gap-3 max-w-md mx-auto">
        <div className="flex gap-2 w-full">
          <button
            onClick={onCancelar}
            className="flex-1 bg-red-50 text-red-600 py-3 rounded-xl font-bold text-sm active:scale-95 transition-all border border-red-100 flex items-center justify-center gap-2"
          >
            ✕ Cancelar
          </button>
          <button
            onClick={onGuardarSalir}
            className="flex-1 bg-gray-100 text-gray-600 py-3 rounded-xl font-bold text-sm active:scale-95 transition-all flex items-center justify-center gap-2"
          >
            💾 Guardar y salir
          </button>
        </div>
        
        <button
          onClick={onFinalizar}
          className={`w-full py-4 rounded-xl font-black text-base shadow-lg transition-all active:scale-95 ${
            todosCompletos
              ? 'bg-[#03A64A] text-white shadow-[0_8px_20px_rgba(3,166,74,0.4)]'
              : 'bg-gray-300 text-gray-500'
          }`}
        >
          {todosCompletos ? '✅ ENVIAR CALIFICACIÓN FINAL' : `Enviar (${totalRespondidos}/${totalIndicadores})`}
        </button>
      </div>
    </footer>
  );
}

