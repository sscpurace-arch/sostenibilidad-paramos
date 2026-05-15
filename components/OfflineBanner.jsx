'use client';
import { useState, useEffect } from 'react';
import { subscribe, getState, syncQueue } from '@/lib/sync-engine';

export default function OfflineBanner() {
  const [state, setState] = useState(getState());
  const [isOnline, setIsOnline] = useState(true);

  useEffect(() => {
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

  if (!state.isSyncing && state.pendingCount === 0 && isOnline) return null;

  return (
    <div className={`text-center py-2 px-4 text-xs font-bold text-white shadow-md flex items-center justify-between z-50 sticky top-0
      ${!isOnline ? 'bg-red-500' : state.isSyncing ? 'bg-blue-500' : 'bg-amber-500'}`}
    >
      <div className="flex items-center justify-center flex-1">
        {!isOnline && <span>📡 Sin conexión — Modo Offline activado</span>}
        
        {isOnline && state.isSyncing && (
          <span className="flex items-center gap-2">
            <svg className="animate-spin h-4 w-4 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"><circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle><path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path></svg>
            Sincronizando {state.pendingCount} cambios...
          </span>
        )}
        
        {isOnline && !state.isSyncing && state.pendingCount > 0 && (
          <span>⏳ {state.pendingCount} cambios pendientes</span>
        )}
      </div>

      {isOnline && !state.isSyncing && state.pendingCount > 0 && (
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
