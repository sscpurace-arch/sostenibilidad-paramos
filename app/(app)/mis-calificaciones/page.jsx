'use client';
import { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import { createClient, getMockSession } from '@/lib/supabase';
import { db } from '@/lib/db-offline';
import { obtenerPerfilTecnico } from '@/lib/perfil';
import { cargarDelServidor, cargarDelCelular } from '@/lib/panel-calificaciones';
import PanelCalificaciones from '@/components/PanelCalificaciones';

/**
 * "Mis calificaciones": las evaluaciones que hizo el técnico que tiene la
 * sesión abierta, organizadas por vereda y municipio, con sus totales.
 *
 * Con señal las cifras vienen de la base (panel_calificaciones). Sin señal, o
 * si la base no responde, se muestra lo que hay en el celular: el técnico en
 * campo no se queda sin ver su trabajo.
 */
export default function MisCalificacionesPage() {
  const router = useRouter();
  const supabase = createClient();
  const [datos, setDatos] = useState(null);
  const [abribles, setAbribles] = useState(new Set());
  const [error, setError] = useState(null);

  useEffect(() => {
    let vivo = true;
    async function cargar() {
      const mock = !!getMockSession();
      let perfil = null;
      try { perfil = await obtenerPerfilTecnico(mock ? null : supabase); } catch { /* sin sesión */ }
      const miId = mock ? null : perfil?.id;
      if (!mock && !miId) {
        if (vivo) setError('No se pudo identificar tu sesión. Cierra y vuelve a abrir la app.');
        return;
      }

      let resultado = null;
      if (!mock && navigator.onLine) {
        try {
          resultado = await cargarDelServidor(supabase);
          // El administrador recibe todo del servidor; aquí solo lo suyo.
          resultado.evaluaciones = resultado.evaluaciones.filter(e => e.tecnico_id === miId);
        } catch { /* se cae al celular */ }
      }
      if (!resultado) {
        try { resultado = await cargarDelCelular(miId, mock); }
        catch {
          if (vivo) setError('No se pudieron leer las calificaciones de este celular.');
          return;
        }
      }

      // Solo se puede abrir lo que está guardado en este celular
      let locales = new Set();
      try {
        const encontradas = await db.evaluaciones.bulkGet(resultado.evaluaciones.map(e => e.id));
        locales = new Set(encontradas.filter(Boolean).map(e => e.id));
      } catch { /* sin acceso a IndexedDB */ }

      if (!vivo) return;
      setAbribles(locales);
      setDatos(resultado);
    }
    cargar();
    return () => { vivo = false; };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const abrir = (ev) => {
    router.push(ev.estado === 'enviada'
      ? `/calificacion?id=${ev.id}&resultados=1`
      : `/calificacion?id=${ev.id}`);
  };

  return (
    <div className="flex flex-col gap-4 pb-10">
      <div className="animate-entry">
        <h2 className="text-2xl font-black text-white drop-shadow-sm">Mis calificaciones</h2>
        <p className="text-xs text-white/60 font-medium mt-0.5">
          Las evaluaciones que has hecho, por vereda y municipio.
        </p>
      </div>

      {error && (
        <div className="card-glass p-4 border border-red-500/30 bg-red-950/20">
          <p className="text-red-300 text-sm font-semibold">{error}</p>
        </div>
      )}

      {!error && !datos && (
        <div className="card-glass p-8 text-center">
          <div className="w-8 h-8 border-2 border-pnn-verde border-t-transparent rounded-full animate-spin mx-auto mb-3" />
          <p className="text-white/50 text-sm">Cargando tus calificaciones…</p>
        </div>
      )}

      {datos && datos.evaluaciones.length === 0 && (
        <div className="card-glass p-8 text-center">
          <p className="text-white/70 text-sm font-semibold">Aún no tienes calificaciones.</p>
          <p className="text-white/40 text-xs mt-1">Cuando evalúes una finca aparecerá aquí.</p>
        </div>
      )}

      {datos && datos.evaluaciones.length > 0 && (
        <PanelCalificaciones
          datos={datos}
          onAbrir={abrir}
          puedeAbrir={ev => abribles.has(ev.id)}
        />
      )}
    </div>
  );
}
