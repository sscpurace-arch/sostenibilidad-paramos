import { createServerClient } from '@supabase/ssr'
import { NextResponse } from 'next/server'
import { RUTAS_APP, CABECERA_COPIA } from './lib/rutas-app.js'

/**
 * ¿Supabase no respondió (caído, pausado, sin red entre servidores)?
 *
 * No es lo mismo que "no hay sesión". `getUser()` no lanza cuando el servicio
 * falla: devuelve `user: null` con un error. Antes ese caso se trataba como
 * "sin sesión" y TODOS los técnicos con señal quedaban devueltos al login
 * mientras Supabase estuviera pausado (pasó el 23-sep-2026), aunque tuvieran
 * todo guardado en el celular y pudieran seguir trabajando.
 */
function esFallaDelServicio(error) {
  if (!error) return false
  if (error.name === 'AuthRetryableFetchError') return true
  const estado = Number(error.status)
  return estado === 0 || estado >= 500
}

export async function middleware(request) {
  // Copias de las pantallas para trabajar sin señal. Las pide el service
  // worker al instalar cada versión (app/sw.js). Son cascarones estáticos, sin
  // datos de nadie (los datos salen de IndexedDB en el celular), así que se
  // entregan sin consultar la sesión: de esa forma la instalación siempre
  // queda completa, con o sin sesión iniciada en ese momento.
  if (
    request.method === 'GET' &&
    request.headers.get(CABECERA_COPIA) === '1' &&
    RUTAS_APP.includes(request.nextUrl.pathname)
  ) {
    return NextResponse.next()
  }

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
    // Falla del servicio con cookie de sesión presente: dejar pasar en vez de
    // expulsar al usuario. Los datos siguen protegidos por las políticas de
    // la base (RLS); aquí solo se decide qué pantalla mostrar.
    const tieneCookieDeSesion = request.cookies
      .getAll()
      .some((c) => c.name.includes('-auth-token'))
    try {
      const { data, error } = await supabase.auth.getUser()
      user = data?.user
      if (!user && tieneCookieDeSesion && esFallaDelServicio(error)) {
        return response
      }
    } catch {
      if (tieneCookieDeSesion) {
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
  // `usuarios` → falta completar registro; fila sin nombre o sin cargo →
  // también (registrados antes de que el cargo fuera obligatorio, o entrada
  // por Google); con activo=false → pendiente.
  // También aplica aquí (no solo en el cliente) la restricción real del rol
  // supervisor: de nada sirve ocultarle el menú si puede escribir la URL a mano.
  if (user && !esMock) {
    const rutasExentas = ['/completar-registro', '/pendiente-aprobacion']
    const exenta = rutasExentas.some((r) => request.nextUrl.pathname.startsWith(r))
    if (!exenta) {
      try {
        const { data: ud, error: errorPerfil } = await supabase.from('usuarios').select('rol, activo, nombre, cargo').eq('id', user.id).maybeSingle()
        // Si la consulta FALLÓ no se sabe nada del perfil: no es lo mismo que
        // "no tiene perfil". Antes una falla aquí mandaba a un técnico ya
        // registrado a /completar-registro.
        if (!errorPerfil) {
          if (!ud || !String(ud.nombre || '').trim() || !String(ud.cargo || '').trim()) {
            return NextResponse.redirect(new URL('/completar-registro', request.url))
          }
          if (ud.activo === false) {
            return NextResponse.redirect(new URL('/pendiente-aprobacion', request.url))
          }
          if (ud.rol === 'supervisor' && !request.nextUrl.pathname.startsWith('/supervisor')) {
            return NextResponse.redirect(new URL('/supervisor', request.url))
          }
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
     * - archivos estáticos: imágenes, JSON públicos (seed-demo.json, etc.) y
     *   PDF de public/ (la guía de calificación). OJO: un archivo estático que
     *   pase por aquí sin sesión recibe la redirección a /login, y el service
     *   worker, al instalarse, guardaba la página de login como si fuera la
     *   guía en PDF.
     * - auth/callback: debe procesar el código OAuth sin interferencia del middleware
     */
    '/((?!_next/static|_next/image|favicon.ico|manifest.json|sw\\.js|workbox-.*|api/.*|auth/callback|~offline|.*\\.(?:svg|png|jpg|jpeg|gif|webp|json|js|pdf|ico|txt|woff2?)$).*)',
  ],
}
