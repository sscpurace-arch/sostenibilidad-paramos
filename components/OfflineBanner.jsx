'use client';
import { useState, useEffect } from 'react';
import { subscribe, getState, syncQueue } from '@/lib/sync-engine';

export default function OfflineBanner() {
  const [state, setState] = useState(getState());
  const [isOnline, setIsOnline] = useState(true);
  const [isMock, setIsMock] = useState(false);

  useEffect(() => {
    // Detectar modo prueba
    setIsMock(!!localStorage.getItem('mock-user-session'));

    setState(getState());
    const unsub = subscribe(setState);

    setIsOnline(navigator.onLine);
    const handleOnline = () => setIsOnline(true);
    const handleOffline = () => setIsOnline(false);

    window.addEventListener('online', handleOnline);
    window.addEventListener('offline', handleOffline);

    return () => {
      unsub();
      window.removeEventListener('online', handleOnline);
      window.removeEventListener('offline', handleOffline);
    };
  }, []);

  // Modo prueba: banner fijo informativo, sin cola de sync
  if (isMock) {
    return (
      <div className="text-center py-2 px-4 text-xs font-bold text-amber-900 bg-amber-300 shadow-md flex items-center justify-center gap-2">
        <span className="w-2 h-2 rounded-full bg-amber-600 animate-pulse" />
        Modo Prueba — Los datos no se guardan en el sistema real
      </div>
    );
  }

  // Sin conexión
  if (!isOnline) {
    return (
      <div className="text-center py-2 px-4 text-xs font-bold text-white bg-red-500 shadow-md">
        📡 Sin conexión — Modo Offline activado
      </div>
    );
  }

  // Online con cola limpia
  if (!state.isSyncing && state.pendingCount === 0) return null;

  // Sincronizando o pendientes
  return (
    <div className="text-center py-2 px-4 text-xs font-bold text-white bg-amber-500 shadow-md flex items-center justify-between">
      <div className="flex items-center justify-center flex-1">
        {state.isSyncing ? (
          <span className="flex items-center gap-2">
            <svg className="animate-spin h-4 w-4 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
              <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" />
              <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z" />
            </svg>
            Sincronizando {state.pendingCount} cambios...
          </span>
        ) : (
          <span>⏳ {state.pendingCount} cambios pendientes</span>
        )}
      </div>

      {!state.isSyncing && state.pendingCount > 0 && (
        <button
          onClick={() => syncQueue()}
          className="ml-4 bg-white text-amber-600 px-3 py-1 rounded-full text-[10px] hover:bg-amber-50 transition-colors uppercase"
        >
          Sincronizar ahora
        </button>
      )}
    </div>
  );
}
