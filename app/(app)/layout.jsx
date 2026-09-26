'use client';
import { useEffect } from 'react';
import { createClient } from '@/lib/supabase';
import { initSyncEngine, datosIniciales } from '@/lib/sync-engine';
import { initFotoSync } from '@/lib/foto-sync';
import { initReporteSync } from '@/lib/reporte-sync';
import { pedirPersistencia } from '@/lib/foto-utils';
import { prefetchDemoTiles } from '@/lib/tile-prefetch';
import { calentarPantallas } from '@/lib/data-prefetch';
import { enviarNotificacionesPendientes } from '@/lib/notificar';
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
    initFotoSync();
    initReporteSync();

    // Avisos de Telegram que quedaron en cola por falta de señal
    enviarNotificacionesPendientes();
    window.addEventListener('online', enviarNotificacionesPendientes);

    // Sin esto, Android puede desalojar IndexedDB cuando se llene el disco y
    // llevarse fotos que todavía no han subido.
    pedirPersistencia().catch(() => {});

    // Preparar el modo offline en segundo plano mientras hay conexión:
    // teselas del mapa de la zona Puracé (idempotente) y datos críticos.
    if (navigator.onLine) {
      // Después de cargar los productores: la zona sale de sus coordenadas
      datosIniciales().then(() => prefetchDemoTiles()).catch(() => {});
      if (isMock) fetch('/seed-demo.json').catch(() => {});
      fetch('/purace-boundary.json').catch(() => {});
      // Guardar las pantallas apenas hay señal, sin esperar a que el usuario
      // toque "Preparar sin conexión". Con señal intermitente —lo normal en el
      // páramo— una pantalla sin guardar se cae al respaldo "Sin conexión".
      calentarPantallas().catch(() => {});
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
