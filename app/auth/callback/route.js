import { createServerClient } from '@supabase/ssr';
import { cookies } from 'next/headers';
import { NextResponse } from 'next/server';

// Intercambia el código de Google OAuth por una sesión, y decide a dónde
// mandar al usuario: si es la primera vez (sin fila en `usuarios`) va a
// completar su registro; si ya existe, al inicio normal.
// Usa cookies() de next/headers (no un NextResponse manual) porque es el
// único patrón que garantiza que las cookies de sesión queden en la
// respuesta sin importar qué redirect se construya después.
export async function GET(request) {
  const { searchParams, origin } = new URL(request.url);
  const code = searchParams.get('code');

  if (!code) {
    return NextResponse.redirect(`${origin}/login`);
  }

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

  const { data, error } = await supabase.auth.exchangeCodeForSession(code);
  if (error || !data?.user) {
    return NextResponse.redirect(`${origin}/login?error=oauth`);
  }

  const { data: fila } = await supabase.from('usuarios').select('id').eq('id', data.user.id).maybeSingle();
  const destino = fila ? '/' : '/completar-registro';
  return NextResponse.redirect(`${origin}${destino}`);
}
