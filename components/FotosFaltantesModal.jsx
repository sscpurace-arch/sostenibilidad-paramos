'use client';
import { createPortal } from 'react-dom';

/**
 * Aviso al enviar la calificación: indicadores calificados que quedaron sin
 * foto. No bloquea (taller 2026-09-07): el técnico decide si vuelve a tomar
 * las fotos o envía así. Guardar borrador nunca pasa por aquí.
 *
 * Portal a document.body: dentro de <main> (relative z-10) el overlay queda
 * bajo el navbar (z-40) y los taps caen en el menú.
 *
 * faltantes: [{ indicador_id, orden, nombre, valor, tiene_motivo }]
 */
export default function FotosFaltantesModal({ faltantes, onVolver, onEnviarSinFotos }) {
  if (typeof document === 'undefined') return null;
  const n = faltantes.length;

  return createPortal(
    <div
      className="fixed inset-0 z-[70] bg-black/60 backdrop-blur-sm flex items-end sm:items-center justify-center p-4"
      onClick={onVolver}
    >
      <div
        className="w-full max-w-md bg-white rounded-3xl shadow-2xl flex flex-col max-h-[88vh]"
        style={{ paddingBottom: 'env(safe-area-inset-bottom)' }}
        onClick={(e) => e.stopPropagation()}
        role="dialog"
        aria-modal="true"
      >
        <div className="p-6 pb-3 flex items-start gap-3">
          <span className="text-3xl leading-none">📷</span>
          <div className="flex-1 min-w-0">
            <h3 className="font-black text-gray-800 text-base leading-tight">
              {n === 1 ? 'Un indicador quedó sin foto' : `${n} indicadores quedaron sin foto`}
            </h3>
            <p className="text-xs text-gray-500 mt-1 leading-snug">
              Puedes enviar igual. Las fotos son la evidencia verificable de la visita:
              sirven para el seguimiento en la próxima visita y le dan contexto real al
              diagnóstico con IA.
            </p>
          </div>
        </div>

        <ul className="flex-1 overflow-y-auto px-6 flex flex-col gap-1.5">
          {faltantes.map((f) => (
            <li key={f.indicador_id} className="flex items-start gap-2 text-sm text-gray-800 bg-amber-50 border border-amber-100 rounded-xl px-3 py-2">
              <span className="shrink-0 font-black text-amber-700">{f.orden}.</span>
              <span className="flex-1 leading-snug">
                {f.nombre}
                <span className="text-gray-400 text-xs"> · {f.valor}/5</span>
                {f.tiene_motivo && (
                  <span className="block text-[11px] text-gray-500">Motivo anotado</span>
                )}
              </span>
            </li>
          ))}
        </ul>

        <div className="p-6 pt-4 flex flex-col gap-2">
          <button
            type="button"
            onClick={onVolver}
            className="w-full py-3.5 rounded-xl font-bold text-base text-white bg-[#03A64A] active:scale-95 transition-all shadow-md"
          >
            Volver a tomar fotos
          </button>
          <button
            type="button"
            onClick={onEnviarSinFotos}
            className="w-full py-3.5 rounded-xl font-bold text-base text-gray-700 bg-gray-100 border border-gray-200 active:scale-95 transition-all"
          >
            Enviar sin fotos
          </button>
        </div>
      </div>
    </div>,
    document.body
  );
}
