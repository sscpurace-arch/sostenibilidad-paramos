'use client';
import { useRef, useState } from 'react';

/**
 * FotoEvidencia — captura y galería de fotos para un indicador.
 *
 * Se usa de pie en potrero, con frío, lluvia y guantes, mientras se conversa
 * con el productor. Por eso: botones altos (56 px), nada de menús anidados, y
 * la cámara nativa del celular en vez de una vista propia con getUserMedia —
 * reimplementar enfoque, exposición y flash sería peor que la cámara que el
 * guardaparques ya sabe usar.
 *
 * `capture` y `multiple` son contradictorios en la misma etiqueta, así que van
 * dos botones separados: disparar ahora, o traer de la galería.
 */
export default function FotoEvidencia({
  fotos = [],
  urls = {},
  onAgregar,
  onBorrar,
  guardando = false,
  obligatoria = false,   // el indicador está en 1 o 2 y no tiene foto
  compacto = false,
}) {
  const inputCamara = useRef(null);
  const inputGaleria = useRef(null);
  const [visor, setVisor] = useState(null);   // foto abierta a pantalla completa

  const manejarArchivos = (e) => {
    const files = e.target.files;
    if (files && files.length > 0) onAgregar(files);
    e.target.value = '';   // permite volver a elegir el mismo archivo
  };

  return (
    <div className={compacto ? '' : 'mt-3'}>
      <input
        ref={inputCamara}
        type="file"
        accept="image/*"
        capture="environment"
        onChange={manejarArchivos}
        className="hidden"
      />
      <input
        ref={inputGaleria}
        type="file"
        accept="image/*"
        multiple
        onChange={manejarArchivos}
        className="hidden"
      />

      <div className="flex gap-2">
        <button
          type="button"
          onClick={() => inputCamara.current?.click()}
          disabled={guardando}
          className={`flex-1 h-14 rounded-xl font-bold text-sm flex items-center justify-center gap-2 transition-all active:scale-95 disabled:opacity-50 ${
            obligatoria
              ? 'bg-amber-500 text-white shadow-md shadow-amber-200'
              : 'bg-gray-50 text-gray-700 border border-gray-200'
          }`}
        >
          <span className="text-lg">📷</span>
          {guardando ? 'Guardando…' : 'Tomar foto'}
        </button>
        <button
          type="button"
          onClick={() => inputGaleria.current?.click()}
          disabled={guardando}
          className="h-14 w-14 shrink-0 rounded-xl bg-gray-50 border border-gray-200 text-lg flex items-center justify-center active:scale-95 transition-all disabled:opacity-50"
          aria-label="Elegir de la galería"
        >
          🖼
        </button>
      </div>

      {obligatoria && (
        <p className="text-[11px] text-amber-700 mt-1.5 flex items-start gap-1 leading-snug">
          <span className="shrink-0">⚠</span>
          Las calificaciones de 1 o 2 necesitan al menos una foto de respaldo.
        </p>
      )}

      {fotos.length > 0 && (
        <div className="flex gap-2 mt-2.5 overflow-x-auto pb-1">
          {fotos.map((foto) => (
            <button
              key={foto.id}
              type="button"
              onClick={() => setVisor(foto)}
              className="relative shrink-0 w-16 h-16 rounded-lg overflow-hidden border border-gray-200 bg-gray-100"
            >
              {urls[foto.id] ? (
                // eslint-disable-next-line @next/next/no-img-element
                <img src={urls[foto.id]} alt="Evidencia" className="w-full h-full object-cover" />
              ) : (
                <span className="w-full h-full flex items-center justify-center text-gray-300 text-xs">…</span>
              )}
              {foto.subida !== 1 && (
                <span
                  className="absolute bottom-0.5 right-0.5 w-2 h-2 rounded-full bg-amber-400 ring-1 ring-white"
                  title="Pendiente de subir"
                />
              )}
            </button>
          ))}
        </div>
      )}

      {visor && (
        <VisorFoto
          foto={visor}
          url={urls[visor.id]}
          onCerrar={() => setVisor(null)}
          onBorrar={async () => {
            await onBorrar(visor.id);
            setVisor(null);
          }}
        />
      )}
    </div>
  );
}

function VisorFoto({ foto, url, onCerrar, onBorrar }) {
  const [confirmando, setConfirmando] = useState(false);

  return (
    <div className="fixed inset-0 z-[9999] bg-black/95 flex flex-col">
      <div className="flex items-center justify-between p-4 text-white shrink-0">
        <button type="button" onClick={onCerrar} className="text-2xl leading-none px-2 py-1">✕</button>
        <span className="text-xs text-white/60">
          {foto.subida === 1 ? 'Sincronizada' : 'Pendiente de subir'}
        </span>
      </div>

      <div className="flex-1 flex items-center justify-center p-4 min-h-0">
        {url ? (
          // eslint-disable-next-line @next/next/no-img-element
          <img src={url} alt="Evidencia" className="max-w-full max-h-full object-contain" />
        ) : (
          <p className="text-white/50 text-sm">No se pudo cargar la imagen</p>
        )}
      </div>

      <div className="p-4 shrink-0">
        {foto.lat != null && (
          <p className="text-[11px] text-white/40 text-center mb-3">
            {foto.lat.toFixed(5)}, {foto.lng.toFixed(5)}
            {foto.precision_m ? ` · ±${Math.round(foto.precision_m)} m` : ''}
          </p>
        )}
        {confirmando ? (
          <div className="flex gap-2">
            <button
              type="button"
              onClick={() => setConfirmando(false)}
              className="flex-1 h-12 rounded-xl bg-white/10 text-white font-bold text-sm"
            >
              Cancelar
            </button>
            <button
              type="button"
              onClick={onBorrar}
              className="flex-1 h-12 rounded-xl bg-[#D80025] text-white font-bold text-sm"
            >
              Sí, borrar
            </button>
          </div>
        ) : (
          <button
            type="button"
            onClick={() => setConfirmando(true)}
            className="w-full h-12 rounded-xl bg-white/10 text-white/80 font-bold text-sm"
          >
            Borrar foto
          </button>
        )}
      </div>
    </div>
  );
}
