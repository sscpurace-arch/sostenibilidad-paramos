'use client';

/**
 * Footer fijo con botones de guardar y finalizar.
 */
export default function EvaluacionFooter({ onGuardarSalir, onFinalizar, todosCompletos, totalRespondidos, totalIndicadores }) {
  return (
    <footer className="fixed bottom-16 left-0 right-0 p-4 bg-white/95 backdrop-blur-md border-t border-gray-100 z-20">
      <div className="flex gap-2 max-w-md mx-auto">
        <button
          onClick={onGuardarSalir}
          className="flex-1 bg-gray-100 text-gray-600 py-3 rounded-xl font-bold text-sm active:scale-95 transition-all"
        >
          💾 Guardar y salir
        </button>
        <button
          onClick={onFinalizar}
          className={`flex-1 py-3 rounded-xl font-bold text-sm shadow-md transition-all active:scale-95 ${
            todosCompletos
              ? 'bg-[#03A64A] text-white'
              : 'bg-gray-300 text-gray-500'
          }`}
        >
          {todosCompletos ? '✅ Enviar evaluación' : `Enviar (${totalRespondidos}/${totalIndicadores})`}
        </button>
      </div>
    </footer>
  );
}
