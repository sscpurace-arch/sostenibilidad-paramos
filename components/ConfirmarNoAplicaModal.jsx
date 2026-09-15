'use client';
import { createPortal } from 'react-dom';

/**
 * Aviso confirmable (no bloqueante) antes de marcar un indicador como
 * "No aplica". Todos los indicadores están pensados para calificarse; el
 * N/A existe solo para cuando el sistema productivo del predio no permite
 * medir algo (leche en un predio sin ordeño). El aviso frena el uso fácil
 * del N/A como salida cuando el dato es incómodo.
 *
 * Va en portal: dentro de <main> (relative z-10) cualquier overlay queda
 * atrapado bajo el navbar (z-40) y los taps caen en el menú.
 */
export default function ConfirmarNoAplicaModal({ indicador, onConfirmar, onVolver }) {
  if (typeof document === 'undefined') return null;

  return createPortal(
    <div
      className="fixed inset-0 z-[70] bg-black/60 backdrop-blur-sm flex items-end sm:items-center justify-center p-4"
      onClick={onVolver}
    >
      <div
        className="w-full max-w-md bg-white rounded-3xl shadow-2xl p-6 flex flex-col gap-4"
        style={{ paddingBottom: 'calc(1.5rem + env(safe-area-inset-bottom))' }}
        onClick={(e) => e.stopPropagation()}
        role="dialog"
        aria-modal="true"
      >
        <div className="flex items-start gap-3">
          <span className="text-3xl leading-none">⚠️</span>
          <div className="flex-1 min-w-0">
            <h3 className="font-black text-gray-800 text-base leading-tight">
              ¿Seguro que este indicador no aplica en este predio?
            </h3>
            <p className="text-xs text-gray-500 mt-1 leading-snug">
              {indicador?.orden ?? indicador?.id}. {indicador?.nombre}
            </p>
          </div>
        </div>

        <p className="text-sm text-gray-700 leading-relaxed">
          Todos los indicadores están pensados para calificarse. Marca <b>No aplica</b> solo
          si el sistema productivo realmente no lo permite (por ejemplo, litros de leche en
          un predio sin ordeño). El indicador queda por fuera del promedio: no vale 0 ni 1.
        </p>

        <p className="text-sm text-amber-800 bg-amber-50 border border-amber-200 rounded-xl px-3 py-2 leading-relaxed">
          Escribe el motivo en las observaciones del indicador.
        </p>

        <div className="flex flex-col gap-2 mt-1">
          <button
            type="button"
            onClick={onConfirmar}
            className="w-full py-3.5 rounded-xl font-bold text-base text-white bg-gray-800 active:scale-95 transition-all shadow-md"
          >
            Confirmar: no aplica
          </button>
          <button
            type="button"
            onClick={onVolver}
            className="w-full py-3.5 rounded-xl font-bold text-base text-[#03A64A] bg-green-50 border border-green-200 active:scale-95 transition-all"
          >
            Volver a calificar
          </button>
        </div>
      </div>
    </div>,
    document.body
  );
}
