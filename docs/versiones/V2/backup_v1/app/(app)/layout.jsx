'use client';
import { useEffect } from 'react';
import { createClient } from '@/lib/supabase';
import { inicializarDatosLocales, configurarSincronizacionAutomatica } from '@/lib/sync';
import OfflineBanner from '@/components/OfflineBanner';
import NavBar from '@/components/NavBar';

export default function AppLayout({ children }) {
  const supabase = createClient();

  useEffect(() => {
    // Sincronización inicial
    inicializarDatosLocales(supabase);
    
    // Configurar sincronización automática
    const cleanup = configurarSincronizacionAutomatica(supabase);
    return cleanup;
  }, []);

  return (
    <div className="min-h-screen bg-[#F5F5F5] pb-20">
      <OfflineBanner />
      <main className="p-4 max-w-md mx-auto">
        {children}
      </main>
      <NavBar />
    </div>
  );
}
