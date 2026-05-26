'use client';
import { useState, useEffect, useCallback } from 'react';
import { subscribe, getState } from '../sync-engine';

/**
 * Hook para monitorear el estado de sincronización offline.
 * NUNCA lanza errores al componente padre.
 * 
 * @returns {{ isSyncing: boolean, pendingCount: number, lastSyncAt: Date|null }}
 */
export default function useOfflineSync() {
  const [state, setState] = useState({
    isSyncing: false,
    pendingCount: 0,
    lastSyncAt: null
  });

  const safeSetState = useCallback((newState) => {
    try { setState(newState); } catch (e) { /* silent */ }
  }, []);

  useEffect(() => {
    try {
      safeSetState(getState());
    } catch (e) { /* silent */ }

    let unsubscribe;
    try {
      unsubscribe = subscribe(safeSetState);
    } catch (e) { /* silent */ }

    return () => {
      try { unsubscribe?.(); } catch (e) { /* silent */ }
    };
  }, [safeSetState]);

  return state;
}
