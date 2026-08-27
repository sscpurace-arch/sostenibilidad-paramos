'use client';
import { useRef, useState } from 'react';

/**
 * PanoramicaCard — la foto general del predio, a nivel de visita.
 *
 * Va al inicio del formulario, antes de la primera dimensión: es lo primero
 * que hace el técnico al llegar, así que debe ser lo primero en el scroll.
 * (No cabe en EvaluacionHeader, que es sticky y no tiene alto disponible.)
 */
export default function PanoramicaCard({ foto, url, onAgregar, onBorrar, guardando = false }) {
  const input = useRef(null);
  const [confirmando, setConfirmando] = useState(false);

  const manejarArchivo = (e) => {
    const file = e.target.files?.[0];
    if (file) onAgregar(file);
    e.target.value = '';
  };

  return (
    <div className="bg-white rounded-xl p-4 shadow-sm border-2 border-gray-100 mb-4">
      <div className="flex items-start justify-between gap-2 mb-1">
        <h3 className="font-bold text-gray-800 text-sm leading-tight">
          Panorámica del predio
        </h3>
        {foto && (
          <span className="shrink-0 w-5 h-5 bg-green-100 text-[#03A64A] rounded-full flex items-center justify-center text-[10px]">
            ✓
          </span>
        )}
      </div>
      <p className="text-xs text-gray-500 mb-3 leading-relaxed">
        Una vista general del predio al llegar. Queda asociada a toda la visita.
      </p>

      <input
        ref={input}
        type="file"
        accept="image/*"
        capture="environment"
        onChange={manejarArchivo}
        className="hidden"
      />

      {foto && url ? (
        <div className="flex flex-col gap-2">
          <div className="relative w-full aspect-video rounded-lg overflow-hidden bg-gray-100 border border-gray-200">
            {/* eslint-disable-next-line @next/next/no-img-element */}
            <img src={url} alt="Panorámica del predio" className="w-full h-full object-cover" />
            {foto.subida !== 1 && (
              <span className="absolute top-2 right-2 text-[10px] bg-amber-400 text-amber-950 font-bold px-2 py-0.5 rounded-full">
                Sin subir
              </span>
            )}
          </div>
          {confirmando ? (
            <div className="flex gap-2">
              <button
                type="button"
                onClick={() => setConfirmando(false)}
                className="flex-1 h-11 rounded-lg bg-gray-50 border border-gray-200 text-gray-700 font-bold text-xs"
              >
                Cancelar
              </button>
              <button
                type="button"
                onClick={async () => { await onBorrar(foto.id); setConfirmando(false); }}
                className="flex-1 h-11 rounded-lg bg-[#D80025] text-white font-bold text-xs"
              >
                Sí, borrar
              </button>
            </div>
          ) : (
            <div className="flex gap-2">
              <button
                type="button"
                onClick={() => input.current?.click()}
                disabled={guardando}
                className="flex-1 h-11 rounded-lg bg-gray-50 border border-gray-200 text-gray-700 font-bold text-xs disabled:opacity-50"
              >
                Repetir foto
              </button>
              <button
                type="button"
                onClick={() => setConfirmando(true)}
                className="h-11 px-4 rounded-lg bg-gray-50 border border-gray-200 text-gray-500 font-bold text-xs"
              >
                Borrar
              </button>
            </div>
          )}
        </div>
      ) : (
        <button
          type="button"
          onClick={() => input.current?.click()}
          disabled={guardando}
          className="w-full h-14 rounded-xl bg-gray-50 border border-gray-200 text-gray-700 font-bold text-sm flex items-center justify-center gap-2 active:scale-95 transition-all disabled:opacity-50"
        >
          <span className="text-lg">📷</span>
          {guardando ? 'Guardando…' : 'Tomar panorámica'}
        </button>
      )}
    </div>
  );
}
