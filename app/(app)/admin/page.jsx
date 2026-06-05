'use client';
import { useState, useEffect } from 'react';
import { createClient } from '@/lib/supabase';
import { useRouter } from 'next/navigation';
import AppHeader from '@/components/AppHeader';

const ADMIN_EMAIL = 'sscpurace@gmail.com';

function RolBadge({ rol }) {
  const styles = {
    admin:    'bg-pnn-verde/20 text-pnn-verde border-pnn-verde/40',
    tecnico:  'bg-pnn-azul/20 text-pnn-azul-claro border-pnn-azul/40',
    visitante:'bg-white/10 text-white/50 border-white/20',
  };
  const label = rol || 'técnico';
  const cls = styles[label.toLowerCase()] || styles.tecnico;
  return (
    <span className={`inline-flex items-center px-2 py-0.5 rounded-full border text-[10px] font-black uppercase tracking-wider ${cls}`}>
      {label}
    </span>
  );
}

function StatCard({ value, label, color = 'text-pnn-verde' }) {
  return (
    <div className="card-glass flex-1 p-3 text-center">
      <p className={`text-2xl font-black ${color}`}>{value}</p>
      <p className="text-[9px] text-white/50 font-semibold uppercase tracking-wider leading-tight mt-0.5">{label}</p>
    </div>
  );
}

export default function AdminPage() {
  const [usuarios, setUsuarios]   = useState([]);
  const [globalStats, setGlobalStats] = useState({ users: 0, reales: 0, pruebas: 0 });
  const [loading, setLoading]     = useState(true);
  const [error, setError]         = useState(null);
  const supabase = createClient();
  const router   = useRouter();

  useEffect(() => {
    async function cargar() {
      // 1. Verificar auth
      const { data: { user: authUser } } = await supabase.auth.getUser();
      if (!authUser) { router.replace('/login'); return; }

      // 2. Verificar que es admin (por email o por rol en tabla)
      let esAdmin = authUser.email === ADMIN_EMAIL;
      if (!esAdmin) {
        const { data: ud } = await supabase
          .from('usuarios')
          .select('rol')
          .eq('id', authUser.id)
          .single();
        esAdmin = ud?.rol === 'admin';
      }
      if (!esAdmin) { router.replace('/'); return; }

      // 3. Traer todos los usuarios
      const { data: usersData, error: usersErr } = await supabase
        .from('usuarios')
        .select('id, nombre, email, rol, activo, created_at')
        .order('nombre');

      if (usersErr) { setError(usersErr.message); setLoading(false); return; }

      // 4. Traer todas las evaluaciones (solo campos necesarios)
      const { data: evalsData } = await supabase
        .from('evaluaciones')
        .select('tecnico_id, estado, es_prueba');

      // 5. Agrupar conteos por tecnico_id
      const countMap = {};
      (evalsData || []).forEach(e => {
        if (!countMap[e.tecnico_id]) {
          countMap[e.tecnico_id] = { total: 0, reales: 0, pruebas: 0, enviadas: 0 };
        }
        countMap[e.tecnico_id].total++;
        if (e.es_prueba) {
          countMap[e.tecnico_id].pruebas++;
        } else {
          countMap[e.tecnico_id].reales++;
          if (e.estado === 'enviada') countMap[e.tecnico_id].enviadas++;
        }
      });

      const enriched = (usersData || []).map(u => ({
        ...u,
        counts: countMap[u.id] || { total: 0, reales: 0, pruebas: 0, enviadas: 0 },
      }));

      const totalReales  = (evalsData || []).filter(e => !e.es_prueba).length;
      const totalPruebas = (evalsData || []).filter(e =>  e.es_prueba).length;

      setGlobalStats({ users: enriched.length, reales: totalReales, pruebas: totalPruebas });
      setUsuarios(enriched);
      setLoading(false);
    }

    cargar();
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return (
    <div className="flex flex-col gap-5 pb-10">
      <AppHeader title="Panel Admin" subtitle="Gestión de usuarios y actividad" />

      {loading && (
        <div className="card-glass p-8 text-center">
          <div className="w-8 h-8 border-2 border-pnn-verde border-t-transparent rounded-full animate-spin mx-auto mb-3" />
          <p className="text-white/50 text-sm">Cargando datos...</p>
        </div>
      )}

      {error && (
        <div className="card-glass p-4 border border-red-500/30 bg-red-950/20">
          <p className="text-red-300 text-sm font-semibold">Error: {error}</p>
        </div>
      )}

      {!loading && !error && (
        <>
          {/* ═══ Stats globales ═══ */}
          <div className="flex gap-3 animate-entry">
            <StatCard value={globalStats.users}   label="Usuarios" color="text-pnn-verde" />
            <StatCard value={globalStats.reales}  label="Calif. reales" color="text-pnn-azul-claro" />
            <StatCard value={globalStats.pruebas} label="Pruebas" color="text-acento-amarillo" />
          </div>

          {/* ═══ Lista de usuarios ═══ */}
          <section className="flex flex-col gap-3 animate-entry animate-entry-d1">
            <h2 className="text-xs font-black text-white/40 uppercase tracking-widest px-1">
              Usuarios registrados — {globalStats.users}
            </h2>

            {usuarios.map((u) => (
              <div
                key={u.id}
                className="card-glass p-4 flex flex-col gap-3"
              >
                {/* Fila superior: avatar + nombre + estado activo */}
                <div className="flex items-center gap-3">
                  {/* Avatar */}
                  <div className="shrink-0 w-10 h-10 rounded-full bg-gradient-to-br from-pnn-verde to-pnn-azul flex items-center justify-center text-white font-black text-base uppercase shadow-md">
                    {u.nombre ? u.nombre.charAt(0) : '?'}
                  </div>

                  {/* Nombre y email */}
                  <div className="flex-1 min-w-0">
                    <p className="text-white font-bold text-sm leading-tight truncate">{u.nombre}</p>
                    <p className="text-white/40 text-[11px] font-medium truncate">{u.email}</p>
                  </div>

                  {/* Indicador activo */}
                  <div className={`shrink-0 flex items-center gap-1 text-[10px] font-bold uppercase tracking-wider ${u.activo !== false ? 'text-pnn-verde' : 'text-red-400'}`}>
                    <span className={`w-2 h-2 rounded-full ${u.activo !== false ? 'bg-pnn-verde animate-pulse' : 'bg-red-400'}`} />
                    {u.activo !== false ? 'Activo' : 'Inactivo'}
                  </div>
                </div>

                {/* Fila inferior: rol + contadores */}
                <div className="flex items-center justify-between border-t border-white/[0.06] pt-3">
                  <RolBadge rol={u.rol} />

                  <div className="flex items-center gap-3">
                    {/* Calificaciones reales */}
                    <div className="text-center">
                      <p className="text-lg font-black text-pnn-azul-claro leading-none">{u.counts.reales}</p>
                      <p className="text-[9px] text-white/40 font-semibold uppercase tracking-wide">Reales</p>
                    </div>
                    <div className="w-px h-6 bg-white/10" />
                    {/* Calificaciones enviadas */}
                    <div className="text-center">
                      <p className="text-lg font-black text-pnn-verde leading-none">{u.counts.enviadas}</p>
                      <p className="text-[9px] text-white/40 font-semibold uppercase tracking-wide">Enviadas</p>
                    </div>
                    <div className="w-px h-6 bg-white/10" />
                    {/* Pruebas */}
                    <div className="text-center">
                      <p className="text-lg font-black text-acento-amarillo leading-none">{u.counts.pruebas}</p>
                      <p className="text-[9px] text-white/40 font-semibold uppercase tracking-wide">Pruebas</p>
                    </div>
                  </div>
                </div>
              </div>
            ))}

            {usuarios.length === 0 && (
              <div className="card-glass p-8 text-center">
                <p className="text-white/40 text-sm">Sin usuarios registrados aún.</p>
              </div>
            )}
          </section>
        </>
      )}
    </div>
  );
}
