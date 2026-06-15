'use client';
import { useEffect } from 'react';
import { createClient } from '@/lib/supabase';
import { initSyncEngine } from '@/lib/sync-engine';
import { prefetchDemoTiles } from '@/lib/tile-prefetch';
import OfflineBanner from '@/components/OfflineBanner';
import UpdateBanner from '@/components/UpdateBanner';
import NavBar from '@/components/NavBar';
import TopographicBg from '@/components/TopographicBg';
import AppHeader from '@/components/AppHeader';

export default function AppLayout({ children }) {
  useEffect(() => {
    const isMock = document.cookie.includes('mock-user-session') || !!localStorage.getItem('mock-user-session');
    const supabase = isMock ? null : createClient();
    initSyncEngine(supabase);

    // Preparar el modo offline en segundo plano mientras hay conexión:
    // teselas del mapa de la zona Puracé (idempotente) y datos críticos.
    if (navigator.onLine) {
      prefetchDemoTiles().catch(() => {});
      fetch('/seed-data.json').catch(() => {});
      fetch('/purace-boundary.json').catch(() => {});
    }
  }, []);

  return (
    <div className="min-h-screen pb-24 relative">
      {/* Fondo topográfico animado */}
      <TopographicBg />

      {/* Contenido principal */}
      <UpdateBanner />
      <OfflineBanner />
      <main className="relative z-10 p-4 max-w-md mx-auto">
        <AppHeader />
        {children}
      </main>
      <NavBar />
    </div>
  );
}
