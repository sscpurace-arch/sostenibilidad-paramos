'use client';
import { useRef, useState, useEffect, useCallback } from 'react';

/**
 * Captura de firma con el dedo (o mouse) sobre un canvas.
 * Autoguarda como PNG base64 al soltar el trazo (con pequeño debounce),
 * mismo patrón de autosave silencioso del resto de la app.
 */
export default function FirmaDigital({ label, valorGuardado, onGuardar }) {
  const canvasRef = useRef(null);
  const dibujando = useRef(false);
  const [tieneTrazo, setTieneTrazo] = useState(!!valorGuardado);

  const getCtx = () => canvasRef.current?.getContext('2d');

  // Redibuja la firma ya guardada (al cargar o al cambiar de indicador/tab)
  useEffect(() => {
    const canvas = canvasRef.current;
    if (!canvas) return;
    const ctx = getCtx();
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    if (valorGuardado) {
      const img = new Image();
      img.onload = () => ctx.drawImage(img, 0, 0, canvas.width, canvas.height);
      img.src = valorGuardado;
      setTieneTrazo(true);
    } else {
      setTieneTrazo(false);
    }
  }, [valorGuardado]);

  const posicion = (e, canvas) => {
    const rect = canvas.getBoundingClientRect();
    const punto = e.touches ? e.touches[0] : e;
    return {
      x: ((punto.clientX - rect.left) / rect.width) * canvas.width,
      y: ((punto.clientY - rect.top) / rect.height) * canvas.height,
    };
  };

  const iniciarTrazo = (e) => {
    e.preventDefault();
    const canvas = canvasRef.current;
    const ctx = getCtx();
    const { x, y } = posicion(e, canvas);
    ctx.beginPath();
    ctx.moveTo(x, y);
    ctx.lineWidth = 2.5;
    ctx.lineCap = 'round';
    ctx.strokeStyle = '#1F2937';
    dibujando.current = true;
  };

  const trazar = (e) => {
    if (!dibujando.current) return;
    e.preventDefault();
    const canvas = canvasRef.current;
    const ctx = getCtx();
    const { x, y } = posicion(e, canvas);
    ctx.lineTo(x, y);
    ctx.stroke();
    setTieneTrazo(true);
  };

  const terminarTrazo = useCallback(() => {
    if (!dibujando.current) return;
    dibujando.current = false;
    const canvas = canvasRef.current;
    onGuardar(canvas.toDataURL('image/png'));
  }, [onGuardar]);

  const limpiar = () => {
    const canvas = canvasRef.current;
    const ctx = getCtx();
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    setTieneTrazo(false);
    onGuardar('');
  };

  return (
    <div className="flex flex-col gap-1.5">
      <div className="flex items-center justify-between">
        <label className="text-[10px] font-black uppercase text-gray-400 tracking-widest">{label}</label>
        {tieneTrazo && (
          <button type="button" onClick={limpiar} className="text-[10px] font-bold text-red-400 hover:text-red-500">
            Borrar
          </button>
        )}
      </div>
      <canvas
        ref={canvasRef}
        width={320}
        height={130}
        className="w-full bg-gray-50 border-2 border-dashed border-gray-200 rounded-xl touch-none"
        style={{ height: '110px' }}
        onMouseDown={iniciarTrazo}
        onMouseMove={trazar}
        onMouseUp={terminarTrazo}
        onMouseLeave={terminarTrazo}
        onTouchStart={iniciarTrazo}
        onTouchMove={trazar}
        onTouchEnd={terminarTrazo}
      />
      {!tieneTrazo && (
        <p className="text-[10px] text-gray-300 text-center -mt-8 pointer-events-none">Firme aquí con el dedo</p>
      )}
    </div>
  );
}
