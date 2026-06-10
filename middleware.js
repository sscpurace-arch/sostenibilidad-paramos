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
      } else {
        response.cookies.set({ name: 'mock-user-session', value: '', path: '/', maxAge: 0 })
      }
    } catch {
      response.cookies.set({ name: 'mock-user-session', value: '', path: '/', maxAge: 0 })
    }
  }
  if (!user) {
    const { data } = await supabase.auth.getUser()
    user = data?.user
  }

  // Si no hay usuario y no está en /login, redirigir a /login
  if (!user && !request.nextUrl.pathname.startsWith('/login')) {
    return NextResponse.redirect(new URL('/login', request.url))
  }

  // Si hay usuario y está en /login, redirigir a /
  if (user && request.nextUrl.pathname.startsWith('/login')) {
    return NextResponse.redirect(new URL('/', request.url))
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
     */
    '/((?!_next/static|_next/image|favicon.ico|manifest.json|api/.*|.*\\.(?:svg|png|jpg|jpeg|gif|webp|json)$).*)',
  ],
}
