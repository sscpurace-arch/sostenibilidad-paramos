'use client';
import { useState, useEffect, useRef } from 'react';

export default function UpdateBanner() {
  const [updateReady, setUpdateReady] = useState(false);
  const [applying, setApplying] = useState(false);
  const reloadingRef = useRef(false);

  useEffect(() => {
    if (typeof navigator === 'undefined' || !('serviceWorker' in navigator)) return;

    let reg;
    let interval;

    // Recargar una sola vez cuando el nuevo SW toma control.
    const onControllerChange = () => {
      if (reloadingRef.current) return;
      reloadingRef.current = true;
      window.location.reload();
    };
    navigator.serviceWorker.addEventListener('controllerchange', onControllerChange);

    // Detecta si hay una versión en espera.
    // Solo muestra la barra si hay un SW activo previo (no la primera instalación).
    const checkWaiting = () => {
      if (reg?.waiting && navigator.serviceWorker.controller) {
        setUpdateReady(true);
      }
    };

    // Revisar automáticamente.
    const checkForUpdate = () => {
      if (reg) {
        reg.update().catch(() => {});
      }
    };

    const onVisibility = () => {
      if (document.visibilityState === 'visible') {
        checkForUpdate();
      }
    };

    navigator.serviceWorker.getRegistration().then((registration) => {
      if (!registration) return;
      reg = registration;

      // ¿Ya hay una versión en espera?
      checkWaiting();

      // Detectar nuevas versiones.
      reg.addEventListener('updatefound', () => {
        const nuevo = reg.installing;
        if (!nuevo) return;
        nuevo.addEventListener('statechange', () => {
          if (nuevo.state === 'installed') {
            checkWaiting();
          }
        });
      });

      // Revisar al abrir, al volver a primer plano y cada 30 min.
      checkForUpdate();
      document.addEventListener('visibilitychange', onVisibility);
      interval = setInterval(checkForUpdate, 30 * 60 * 1000);
    });

    return () => {
      navigator.serviceWorker.removeEventListener('controllerchange', onControllerChange);
      document.removeEventListener('visibilitychange', onVisibility);
      if (interval) clearInterval(interval);
    };
  }, []);

  const recargarUnaVez = () => {
    if (reloadingRef.current) return;
    reloadingRef.current = true;
    window.location.reload();
  };

  const aplicarActualizacion = async () => {
    setApplying(true);
    const registration = await navigator.serviceWorker.getRegistration();
    const waiting = registration?.waiting;

    if (waiting) {
      // Cuando la versión nueva quede activa, recargar.
      waiting.addEventListener('statechange', () => {
        if (waiting.state === 'activated') recargarUnaVez();
      });
      // Pedirle al service worker que active la versión nueva.
      waiting.postMessage({ type: 'SKIP_WAITING' });
    }

    // Red de seguridad: pase lo que pase, recargar en máximo 2.5 s.
    // (La versión nueva ya quedó activa con el mensaje de arriba.)
    setTimeout(recargarUnaVez, 2500);
  };

  if (!updateReady) return null;

  return (
    <div className="py-2 px-4 text-xs font-bold text-white bg-pnn-azul shadow-md flex items-center justify-between animate-pulse">
      <span className="flex items-center gap-2">
        <span className="w-2 h-2 rounded-full bg-white animate-ping" />
        ✨ Nueva versión disponible
      </span>
      <button
        onClick={aplicarActualizacion}
        disabled={applying}
        className="ml-4 bg-white text-pnn-azul px-3 py-1 rounded-full text-[10px] hover:bg-blue-50 transition-colors uppercase disabled:opacity-70"
      >
        {applying ? 'Actualizando…' : 'Actualizar ahora'}
      </button>
    </div>
  );
}
