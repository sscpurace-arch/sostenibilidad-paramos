/**
 * perfil — nombre y cargo del funcionario que usa la app.
 *
 * Se guarda en IndexedDB (tabla `perfil_tecnico`, Dexie v11) para que salga
 * sin señal: el nombre va en el saludo, en el pie de los PDF y como snapshot
 * en cada evaluación que se envía. Con señal se refresca desde `usuarios`.
 *
 * El modo visitante no pasa por `usuarios`: devuelve un perfil fijo.
 */
import { db } from '@/lib/db-offline';
import { getMockSession } from '@/lib/supabase';

export const PERFIL_VISITANTE = { id: 'visitante', nombre: 'Modo Prueba', cargo: 'Visitante', email: 'demo@purace.test', rol: 'visitante' };

/**
 * Perfil del usuario actual. Lee primero el celular; si hay señal y un
 * cliente Supabase, trae la fila de `usuarios` y la deja guardada.
 *
 * @param {object|null} supabase cliente de createClient(); null en modo prueba
 * @returns {Promise<{id, nombre, cargo, email, rol}|null>}
 */
export async function obtenerPerfilTecnico(supabase) {
  if (getMockSession()) return PERFIL_VISITANTE;
  if (!supabase) return null;

  let user = null;
  try {
    const { data } = await supabase.auth.getUser();
    user = data?.user || null;
  } catch { /* sin sesión */ }
  if (!user) return null;

  let local = null;
  try { local = await db.perfil_tecnico.get(user.id); } catch { /* Dexie no disponible */ }

  const online = typeof navigator === 'undefined' || navigator.onLine;
  if (online) {
    try {
      const { data } = await supabase
        .from('usuarios')
        .select('id, nombre, cargo, email, rol')
        .eq('id', user.id)
        .maybeSingle();
      if (data) {
        const perfil = { ...data, actualizado_en: new Date().toISOString() };
        try { await db.perfil_tecnico.put(perfil); } catch { /* silent */ }
        return perfil;
      }
    } catch { /* red inestable: se usa lo local */ }
  }

  if (local) return local;
  // Sin fila local ni remota: lo mínimo que se sabe del usuario autenticado
  return {
    id: user.id,
    nombre: user.user_metadata?.nombre || user.user_metadata?.full_name || user.email?.split('@')[0] || 'Técnico',
    cargo: null,
    email: user.email || null,
    rol: null,
  };
}

/** "Nombre — Cargo" para pantalla y PDF; omite el cargo si no está. */
export function etiquetaPerfil(perfil) {
  if (!perfil) return '';
  return [perfil.nombre, perfil.cargo].filter(Boolean).join(' — ');
}
