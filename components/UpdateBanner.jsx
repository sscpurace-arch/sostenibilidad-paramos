'use client';
import { useState, useEffect, useRef } from 'react';
import { getState } from '@/lib/sync-engine';

// Barra superior que avisa cuando hay una versión nueva de la app lista
// (un nuevo service worker quedó "en espera"). Al presionar "Actualizar",
// se le ordena al SW activarse y la app recarga una sola vez.
// Los datos offline viven en IndexedDB, así que la recarga no los pierde.
export default function UpdateBanner() {
  const [updateReady, setUpdateReady] = useState(false);
  const [applying, setApplying] = useState(false);
  const reloadingRef = useRef(false);

  useEffect(() => {
    if (typeof navigator === 'undefined' || !('serviceWorker' in navigator)) return;

    let reg;
    let interval;

    // Cuando el SW nuevo toma control, recargar una sola vez.
    const onControllerChange = () => {
      if (reloadingRef.current) return;
      reloadingRef.current = true;
      window.location.reload();
    };
    navigator.serviceWorker.addEventListener('controllerchange', onControllerChange);

    // Marca "actualización lista" solo si es una actualización real
    // (ya hay un SW controlando la página), no la primera instalación.
    const markIfWaiting = (worker) => {
      if (worker && navigator.serviceWorker.controller) {
        setUpdateReady(true);
      }
    };

    const checkForUpdate = () => {
      if (reg) reg.update().catch(() => {});
    };

    // Revisar al volver la pestaña a primer plano.
    const onVisibility = () => {
      if (document.visibilityState === 'visible') checkForUpdate();
    };

    navigator.serviceWorker.getRegistration().then((registration) => {
      if (!registration) return;
      reg = registration;

      // ¿Ya hay una versión en espera al cargar?
      if (reg.waiting) markIfWaiting(reg.waiting);

      // Detectar nuevas versiones que se instalen mientras la app está abierta.
      reg.addEventListener('updatefound', () => {
        const nuevo = reg.installing;
        if (!nuevo) return;
        nuevo.addEventListener('statechange', () => {
          if (nuevo.state === 'installed') markIfWaiting(reg.waiting || nuevo);
        });
      });

      // Revisión automática: al montar, al volver a primer plano y cada ~30 min.
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

  const aplicarActualizacion = () => {
    setApplying(true);
    navigator.serviceWorker.getRegistration().then((reg) => {
      const worker = reg && reg.waiting;
      if (!worker) {
        // No hay versión en espera (caso raro): recargar de todos modos.
        window.location.reload();
        return;
      }
      // Cortesía: si hay una sincronización en curso, esperar a que termine
      // antes de activar (los datos están a salvo en IndexedDB de todos modos).
      const enviar = () => worker.postMessage({ type: 'SKIP_WAITING' });
      if (getState().isSyncing) {
        const t = setInterval(() => {
          if (!getState().isSyncing) {
            clearInterval(t);
            enviar();
          }
        }, 500);
        // Tope de seguridad: aplicar pasados 8 s aunque siga "sincronizando".
        setTimeout(() => {
          clearInterval(t);
          enviar();
        }, 8000);
      } else {
        enviar();
      }
    });
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
