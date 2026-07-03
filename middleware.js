import { createServerClient } from '@supabase/ssr'
import { NextResponse } from 'next/server'

export async function middleware(request) {
  let response = NextResponse.next({
    request: {
      headers: request.headers,
    },
  })

  const supabase = createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY,
    {
      cookies: {
        get(name) {
          return request.cookies.get(name)?.value
        },
        set(name, value, options) {
          request.cookies.set({
            name,
            value,
            ...options,
          })
          response = NextResponse.next({
            request: {
              headers: request.headers,
            },
          })
          response.cookies.set({
            name,
            value,
            ...options,
          })
        },
        remove(name, options) {
          request.cookies.set({
            name,
            value: '',
            ...options,
          })
          response = NextResponse.next({
            request: {
              headers: request.headers,
            },
          })
          response.cookies.set({
            name,
            value: '',
            ...options,
          })
        },
      },
    }
  )

  let user = null
  let esMock = false
  const mockCookie = request.cookies.get('mock-user-session')?.value
  if (mockCookie) {
    // Sesión de prueba: solo válida si tiene expiración vigente. Si está
    // corrupta o vencida, se elimina y se cae al flujo de auth real.
    try {
      let parsed
      try {
        parsed = JSON.parse(mockCookie)
      } catch {
        parsed = JSON.parse(decodeURIComponent(mockCookie))
      }
      if (parsed?.exp && Date.now() < parsed.exp) {
        user = parsed
        esMock = true
      } else {
        response.cookies.set({ name: 'mock-user-session', value: '', path: '/', maxAge: 0 })
      }
    } catch {
      response.cookies.set({ name: 'mock-user-session', value: '', path: '/', maxAge: 0 })
    }
  }
  if (!user) {
    try {
      const { data } = await supabase.auth.getUser()
      user = data?.user
    } catch {
      // Error de red/Supabase: si el navegador trae cookie de sesión,
      // dejar pasar en vez de expulsar al usuario por una falla transitoria.
      const hasSessionCookie = request.cookies
        .getAll()
        .some((c) => c.name.includes('-auth-token'))
      if (hasSessionCookie) {
        return response
      }
    }
  }

  // Si no hay usuario y no está en /login, redirigir a /login
  if (!user && !request.nextUrl.pathname.startsWith('/login')) {
    return NextResponse.redirect(new URL('/login', request.url))
  }

  // Si hay usuario y está en /login, redirigir a /
  if (user && request.nextUrl.pathname.startsWith('/login')) {
    return NextResponse.redirect(new URL('/', request.url))
  }

  // Aprobación de usuarios reales (no aplica al modo prueba): sin fila en
  // `usuarios` → falta completar registro; con activo=false → pendiente.
  // También aplica aquí (no solo en el cliente) la restricción real del rol
  // supervisor: de nada sirve ocultarle el menú si puede escribir la URL a mano.
  if (user && !esMock) {
    const rutasExentas = ['/completar-registro', '/pendiente-aprobacion']
    const exenta = rutasExentas.some((r) => request.nextUrl.pathname.startsWith(r))
    if (!exenta) {
      try {
        const { data: ud } = await supabase.from('usuarios').select('rol, activo').eq('id', user.id).maybeSingle()
        if (!ud) {
          return NextResponse.redirect(new URL('/completar-registro', request.url))
        }
        if (ud.activo === false) {
          return NextResponse.redirect(new URL('/pendiente-aprobacion', request.url))
        }
        if (ud.rol === 'supervisor' && !request.nextUrl.pathname.startsWith('/supervisor')) {
          return NextResponse.redirect(new URL('/supervisor', request.url))
        }
      } catch {
        // Sin red o error transitorio: no bloquear al usuario por esto
      }
    }
  }

  return response
}

export const config = {
  matcher: [
    /*
     * Excluir:
     * - _next/static, _next/image (archivos de build)
     * - favicon.ico, manifest.json (PWA)
     * - archivos estáticos: imágenes, JSON públicos (seed-data.json, etc.)
     * - auth/callback: debe procesar el código OAuth sin interferencia del middleware
     */
    '/((?!_next/static|_next/image|favicon.ico|manifest.json|sw\\.js|workbox-.*|api/.*|auth/callback|~offline|.*\\.(?:svg|png|jpg|jpeg|gif|webp|json|js)$).*)',
  ],
}
