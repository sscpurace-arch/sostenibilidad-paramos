'use client';
import { useRef, useState, useEffect, useCallback } from 'react';
import { createPortal } from 'react-dom';

/**
 * Firma a pantalla completa, un firmante a la vez (técnico → productor).
 * Pensado para el campo: canvas grande, se puede girar el teléfono para tener
 * más espacio (el canvas se reajusta solo), y cada firma se puede omitir.
 *
 * pasos: [{ key: 'firma_tecnico', label: 'Firma del técnico' }, ...]
 * valores: { firma_tecnico, firma_productor } — firmas ya existentes
 * onGuardar(key, dataUrl): se llama al confirmar cada firma (autosave)
 * onCerrar(): cierra el modal
 */
export default function FirmaModal({ pasos, valores, onGuardar, onCerrar }) {
  const [indice, setIndice] = useState(0);
  const canvasRef = useRef(null);
  const contenedorRef = useRef(null);
  const dibujando = useRef(false);
  const [tieneTrazo, setTieneTrazo] = useState(false);
  const tieneTrazoRef = useRef(false);
  tieneTrazoRef.current = tieneTrazo;

  const paso = pasos[indice];
  const esUltimo = indice >= pasos.length - 1;

  const getCtx = () => canvasRef.current?.getContext('2d');

  const configurarEstilo = (ctx) => {
    ctx.lineWidth = 3;
    ctx.lineCap = 'round';
    ctx.lineJoin = 'round';
    ctx.strokeStyle = '#1F2937';
  };

  // Ajusta la resolución interna del canvas a su tamaño real en pantalla (nítido
  // en cualquier orientación) y redibuja lo que corresponda: la firma previa de
  // este paso, o —al girar el teléfono— el trazo que ya iba haciendo.
  const ajustarCanvas = useCallback((preservarTrazoActual) => {
    const canvas = canvasRef.current;
    const cont = contenedorRef.current;
    if (!canvas || !cont) return;
    const dpr = window.devicePixelRatio || 1;
    const w = cont.clientWidth;
    const h = cont.clientHeight;
    if (w === 0 || h === 0) return;
    let snapshot = null;
    if (preservarTrazoActual && tieneTrazoRef.current) snapshot = canvas.toDataURL();
    canvas.width = Math.round(w * dpr);
    canvas.height = Math.round(h * dpr);
    const ctx = canvas.getContext('2d');
    ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
    configurarEstilo(ctx);
    const fuente = snapshot || valores?.[paso.key];
    if (fuente) {
      const img = new Image();
      img.onload = () => ctx.drawImage(img, 0, 0, w, h);
      img.src = fuente;
    }
  }, [paso.key, valores]);

  // Al montar, al cambiar de paso y al rotar / redimensionar la ventana
  useEffect(() => {
    ajustarCanvas(false);
    setTieneTrazo(!!valores?.[paso.key]);
    const onResize = () => ajustarCanvas(true);
    window.addEventListener('resize', onResize);
    window.addEventListener('orientationchange', onResize);
    return () => {
      window.removeEventListener('resize', onResize);
      window.removeEventListener('orientationchange', onResize);
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [indice, ajustarCanvas]);

  const posicion = (e) => {
    const rect = canvasRef.current.getBoundingClientRect();
    return { x: e.clientX - rect.left, y: e.clientY - rect.top };
  };

  const iniciar = (e) => {
    e.preventDefault();
    const canvas = canvasRef.current;
    try { canvas.setPointerCapture(e.pointerId); } catch { /* algunos navegadores */ }
    const ctx = getCtx();
    const { x, y } = posicion(e);
    ctx.beginPath();
    ctx.moveTo(x, y);
    ctx.lineTo(x + 0.1, y + 0.1); // deja un punto aunque solo toque sin arrastrar
    ctx.stroke();
    dibujando.current = true;
    setTieneTrazo(true);
  };

  const mover = (e) => {
    if (!dibujando.current) return;
    e.preventDefault();
    const ctx = getCtx();
    const { x, y } = posicion(e);
    ctx.lineTo(x, y);
    ctx.stroke();
  };

  const soltar = () => { dibujando.current = false; };

  const borrar = () => {
    const canvas = canvasRef.current;
    const ctx = getCtx();
    ctx.save();
    ctx.setTransform(1, 0, 0, 1, 0, 0);
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    ctx.restore();
    setTieneTrazo(false);
  };

  // Recorta la firma a su contorno real y la reduce (máx. 600px). El canvas es
  // enorme (pantalla completa) y en su mayoría transparente; sin esto el PNG
  // pesaría megas y el PDF aplastaría la firma vertical en la casilla ancha.
  const exportarFirma = () => {
    const src = canvasRef.current;
    const { width, height } = src;
    if (!width || !height) return '';
    const datos = src.getContext('2d').getImageData(0, 0, width, height).data;
    let minX = width, minY = height, maxX = 0, maxY = 0, hay = false;
    for (let y = 0; y < height; y++) {
      for (let x = 0; x < width; x++) {
        if (datos[(y * width + x) * 4 + 3] > 0) {
          hay = true;
          if (x < minX) minX = x;
          if (x > maxX) maxX = x;
          if (y < minY) minY = y;
          if (y > maxY) maxY = y;
        }
      }
    }
    if (!hay) return '';
    const pad = 14;
    minX = Math.max(0, minX - pad);
    minY = Math.max(0, minY - pad);
    maxX = Math.min(width - 1, maxX + pad);
    maxY = Math.min(height - 1, maxY + pad);
    const cw = maxX - minX + 1;
    const ch = maxY - minY + 1;
    const escala = Math.min(1, 600 / Math.max(cw, ch));
    const off = document.createElement('canvas');
    off.width = Math.round(cw * escala);
    off.height = Math.round(ch * escala);
    off.getContext('2d').drawImage(src, minX, minY, cw, ch, 0, 0, off.width, off.height);
    return off.toDataURL('image/png');
  };

  // Solo sobrescribe si hay trazo nuevo; un paso dejado vacío NO borra una firma
  // previa (para eso está el botón Borrar explícito).
  const guardarPasoActual = () => {
    if (!tieneTrazoRef.current) return;
    const firma = exportarFirma();
    if (firma) onGuardar(paso.key, firma);
  };

  const continuar = () => {
    guardarPasoActual();
    if (esUltimo) onCerrar();
    else setIndice((i) => i + 1);
  };

  const omitir = () => {
    if (esUltimo) onCerrar();
    else setIndice((i) => i + 1);
  };

  const cerrar = () => {
    guardarPasoActual();
    onCerrar();
  };

  if (typeof document === 'undefined') return null;

  return createPortal(
    <div className="fixed inset-0 z-[70] bg-white flex flex-col">
      {/* Cabecera */}
      <div className="flex items-center gap-3 px-4 py-3 border-b border-gray-100 flex-shrink-0">
        <div className="flex-1 min-w-0">
          <p className="text-sm font-bold text-gray-800 truncate">{paso.label}</p>
          <p className="text-[11px] text-gray-400">
            Firma {indice + 1} de {pasos.length} · puede girar el teléfono para más espacio
          </p>
        </div>
        <button onClick={cerrar} className="text-gray-400 text-2xl leading-none px-2" aria-label="Cerrar">✕</button>
      </div>

      {/* Área de firma (ocupa todo el espacio disponible) */}
      <div ref={contenedorRef} className="flex-1 relative bg-gray-50 overflow-hidden">
        <canvas
          ref={canvasRef}
          className="absolute inset-0 w-full h-full"
          style={{ touchAction: 'none' }}
          onPointerDown={iniciar}
          onPointerMove={mover}
          onPointerUp={soltar}
          onPointerCancel={soltar}
          onPointerLeave={soltar}
        />
        {!tieneTrazo && (
          <div className="absolute inset-0 flex items-center justify-center pointer-events-none">
            <p className="text-gray-300 text-base">Firme aquí con el dedo</p>
          </div>
        )}
      </div>

      {/* Acciones */}
      <div
        className="flex items-center gap-2 px-4 py-3 border-t border-gray-100 flex-shrink-0"
        style={{ paddingBottom: 'calc(0.75rem + env(safe-area-inset-bottom))' }}
      >
        <button
          onClick={borrar}
          disabled={!tieneTrazo}
          className="px-4 py-3 rounded-xl font-bold text-sm text-gray-600 bg-gray-100 active:scale-95 transition-all disabled:opacity-40"
        >
          Borrar
        </button>
        <button
          onClick={omitir}
          className="px-4 py-3 rounded-xl font-bold text-sm text-gray-400 active:scale-95 transition-all"
        >
          Omitir
        </button>
        <button
          onClick={continuar}
          className="flex-1 py-3 rounded-xl font-bold text-sm text-white bg-[#03A64A] active:scale-95 transition-all shadow-md"
        >
          {esUltimo ? 'Terminar ✓' : 'Continuar →'}
        </button>
      </div>
    </div>,
    document.body
  );
}
