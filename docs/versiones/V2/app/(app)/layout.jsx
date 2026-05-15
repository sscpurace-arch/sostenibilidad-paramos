'use client';
import { useEffect } from 'react';
import { createClient } from '@/lib/supabase';
import { initSyncEngine } from '@/lib/sync-engine';
import OfflineBanner from '@/components/OfflineBanner';
import NavBar from '@/components/NavBar';

export default function AppLayout({ children }) {
  const supabase = createClient();

  useEffect(() => {
    initSyncEngine(supabase);
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
