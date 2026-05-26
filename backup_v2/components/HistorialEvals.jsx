'use client';
import { useState } from 'react';

/**
 * Lista del historial de evaluaciones con botón de eliminar de dos pasos.
 */
export default function HistorialEvals({ evaluaciones, onEliminar }) {
  const [confirmandoId, setConfirmandoId] = useState(null);

  if (!evaluaciones || evaluaciones.length === 0) return null;

  return (
    <div className="mt-4 pt-4 border-t border-gray-100">
      <h4 className="text-[10px] text-gray-400 uppercase font-black mb-3">Historial de Evaluaciones</h4>
      <div className="flex flex-col gap-2">
        {evaluaciones.map((ev, idx) => (
          <div key={ev.id} className="flex items-center justify-between p-3 bg-gray-50 rounded-xl">
            <div>
              <p className="text-sm font-bold text-gray-700">
                Evaluación {evaluaciones.length - idx}
                {ev.es_prueba && <span className="ml-2 text-[8px] bg-amber-100 text-amber-700 px-1.5 py-0.5 rounded-full uppercase">Prueba</span>}
              </p>
              <p className="text-[10px] text-gray-400">
                {new Date(ev.fecha).toLocaleDateString('es-ES', { day: 'numeric', month: 'long', year: 'numeric' })}
              </p>
            </div>
            
            {confirmandoId === ev.id ? (
              <div className="flex items-center gap-2 animate-in fade-in zoom-in duration-200">
                <button
                  onClick={() => setConfirmandoId(null)}
                  className="px-3 py-1 text-[10px] font-bold text-gray-500 bg-gray-200 rounded hover:bg-gray-300 transition-colors"
                >
                  Cancelar
                </button>
                <button
                  onClick={() => {
                    setConfirmandoId(null);
                    onEliminar(ev.id);
                  }}
                  className="px-3 py-1 text-[10px] font-bold text-white bg-red-500 rounded hover:bg-red-600 transition-colors"
                >
                  Sí, borrar
                </button>
              </div>
            ) : (
              <button
                onClick={() => setConfirmandoId(ev.id)}
                className="p-2 text-red-400 hover:text-red-600 hover:bg-red-50 rounded-lg transition-colors"
              >
                <svg xmlns="http://www.w3.org/2000/svg" className="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                </svg>
              </button>
            )}
          </div>
        ))}
      </div>
    </div>
  );
}
