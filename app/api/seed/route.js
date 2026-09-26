import { createServerClient } from '@supabase/ssr';
import { cookies } from 'next/headers';
import seed from '@/data/seed-data.json';

// Datos iniciales para trabajar sin señal (productores, histórico de
// calificaciones). Antes eran un archivo público (/seed-data.json) que
// cualquiera podía descargar sin cuenta, con 270 cédulas y coordenadas.
// Ahora solo se entregan a un usuario con sesión iniciada y aprobado.
export const dynamic = 'force-dynamic';

export async function GET() {
  const cookieStore = cookies();
  const supabase = createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY,
    {
      cookies: {
        get(name) { return cookieStore.get(name)?.value; },
        set(name, value, options) { cookieStore.set({ name, value, ...options }); },
        remove(name, options) { cookieStore.set({ name, value: '', ...options }); },
      },
    }
  );

  const { data: { user } = {} } = await supabase.auth.getUser();
  if (!user) {
    return Response.json({ error: 'Inicia sesión para descargar los datos' }, { status: 401 });
  }

  // Un usuario recién registrado que todavía no ha sido aprobado no recibe datos
  const { data: fila } = await supabase.from('usuarios').select('activo').eq('id', user.id).maybeSingle();
  if (!fila || fila.activo === false) {
    return Response.json({ error: 'Tu cuenta todavía no está aprobada' }, { status: 403 });
  }

  return Response.json(seed, {
    headers: { 'Cache-Control': 'private, no-store' },
  });
}
