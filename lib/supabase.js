import { createBrowserClient } from '@supabase/ssr'

// Identidad del modo prueba: SIN privilegios de admin.
// El id se mantiene porque las evaluaciones de prueba sincronizadas lo usan como tecnico_id.
export const MOCK_USER = {
  id: 'e81ba52c-23df-4f4e-808d-937fd606426c',
  email: 'demo@purace.test',
  user_metadata: { nombre: 'Modo Prueba', rol: 'visitante' },
  app_metadata: {},
}

// Lee y valida la sesión de prueba desde la cookie.
// Devuelve null (y limpia residuos) si no existe, está corrupta o expiró.
export function getMockSession() {
  if (typeof window === 'undefined') return null
  const match = document.cookie.match(/(?:^|;\s*)mock-user-session=([^;]*)/)
  if (!match) {
    if (localStorage.getItem('mock-user-session')) localStorage.removeItem('mock-user-session')
    return null
  }
  try {
    const data = JSON.parse(decodeURIComponent(match[1]))
    if (!data.exp || Date.now() > data.exp) {
      clearMockSession()
      return null
    }
    return data
  } catch {
    clearMockSession()
    return null
  }
}

export function clearMockSession() {
  if (typeof window === 'undefined') return
  document.cookie = 'mock-user-session=; path=/; max-age=0;'
  localStorage.removeItem('mock-user-session')
}

// ─── Usuario recordado para trabajar sin señal ─────────────
//
// El token de Supabase dura una hora. Sin red no se puede renovar, y entonces
// getSession() devuelve null aunque la sesión siga guardada: el técnico que
// salió del pueblo con señal a las 7 a. m. ya no podía iniciar una
// evaluación a las 9 ("No se pudo confirmar tu sesión"). Se recuerda aquí el
// último usuario confirmado y se usa SOLO cuando la falla es de red. Si el
// servidor dice que la sesión ya no vale (cerró sesión, token revocado), no
// se usa. El servidor valida igual cada cambio al subir (RLS), así que esto
// no le da a nadie permisos que no tenga.
const USUARIO_KEY = 'usuario-sin-senal-v1'

function recordarUsuario(user) {
  if (typeof window === 'undefined' || !user?.id) return
  try {
    localStorage.setItem(USUARIO_KEY, JSON.stringify({
      id: user.id,
      email: user.email || null,
      user_metadata: user.user_metadata || {},
      app_metadata: user.app_metadata || {},
      aud: user.aud,
    }))
  } catch { /* almacenamiento lleno o bloqueado */ }
}

function usuarioRecordado() {
  if (typeof window === 'undefined') return null
  try {
    const raw = localStorage.getItem(USUARIO_KEY)
    return raw ? JSON.parse(raw) : null
  } catch {
    return null
  }
}

export function olvidarUsuario() {
  if (typeof window === 'undefined') return
  try { localStorage.removeItem(USUARIO_KEY) } catch { /* silent */ }
}

// ¿El error es de red (no hubo respuesta del servidor)? Solo en ese caso se
// usa el usuario recordado.
function esErrorDeRed(error) {
  if (!error) return false
  if (typeof navigator !== 'undefined' && !navigator.onLine) return true
  const nombre = String(error.name || '')
  const texto = String(error.message || error)
  return nombre === 'AuthRetryableFetchError' || nombre === 'AbortError' || nombre === 'TypeError' ||
    /fetch|network|timeout|tiempo|abort|load failed/i.test(texto)
}

// ─── Peticiones con tiempo límite ─────────────────────────
//
// Con "una rayita" de señal el celular dice que está en línea pero las
// peticiones no terminan nunca, y la pantalla que las espera queda congelada.
// Se cortan a los N segundos; el cambio ya está guardado en el celular y se
// reintenta después. Subir una foto o esperar a la IA tarda más, por eso
// tienen su propio límite.
function limiteSegundos(url) {
  const u = String(url || '')
  if (u.includes('/functions/v1/')) return 120   // diagnóstico / plan con IA
  if (u.includes('/storage/v1/')) return 90      // fotos y PDF
  return 25
}

function fetchConLimite(input, init = {}) {
  const url = typeof input === 'string' ? input : input?.url
  const controller = new AbortController()
  const timer = setTimeout(() => controller.abort(), limiteSegundos(url) * 1000)
  // Si quien llama ya trae su propia señal de cancelación, respetarla también
  if (init.signal) {
    if (init.signal.aborted) controller.abort()
    else init.signal.addEventListener('abort', () => controller.abort(), { once: true })
  }
  return fetch(input, { ...init, signal: controller.signal }).finally(() => clearTimeout(timer))
}

export const createClient = () => {
  const client = createBrowserClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY,
    { global: { fetch: fetchConLimite } }
  )

  // En el navegador createBrowserClient devuelve siempre el MISMO cliente.
  // Sin esta marca, cada createClient() envolvía otra vez el getUser ya
  // envuelto y la cadena crecía con cada pantalla abierta.
  if (client.__envueltoOffline) return client
  client.__envueltoOffline = true

  // Proxy auth.getUser para soportar el modo prueba (sesión con expiración)
  // y el modo offline: getUser() valida contra el servidor de Supabase, así
  // que sin red devolvería null aunque el usuario esté logueado. En ese caso
  // se usa la sesión guardada localmente (getSession no necesita red) y, si
  // el token ya venció y no se pudo renovar por falta de red, el último
  // usuario confirmado.
  const sesionLocal = async () => {
    try {
      const { data, error } = await client.auth.getSession()
      if (data?.session?.user) return { user: data.session.user, error: null }
      return { user: null, error }
    } catch (e) {
      return { user: null, error: e }
    }
  }
  const respaldoSinSenal = (error) => {
    const user = esErrorDeRed(error) ? usuarioRecordado() : null
    return { data: { user }, error: null }
  }

  const originalGetUser = client.auth.getUser.bind(client.auth)
  client.auth.getUser = async () => {
    const mock = getMockSession()
    if (mock) {
      return { data: { user: { ...MOCK_USER } }, error: null }
    }
    if (typeof navigator !== 'undefined' && !navigator.onLine) {
      const { user } = await sesionLocal()
      if (user) return { data: { user }, error: null }
      return respaldoSinSenal({ name: 'offline' })
    }
    try {
      const result = await originalGetUser()
      if (result?.data?.user) {
        recordarUsuario(result.data.user)
        return result
      }
      // Falla con red inestable: caer a la sesión local antes de rendirse
      const { user, error } = await sesionLocal()
      if (user) return { data: { user }, error: null }
      if (esErrorDeRed(result?.error) || esErrorDeRed(error)) return respaldoSinSenal(result?.error || error)
      return result
    } catch (e) {
      const { user } = await sesionLocal()
      if (user) return { data: { user }, error: null }
      return respaldoSinSenal(e)
    }
  }

  // Proxy auth.signOut para limpiar la sesión de prueba y el usuario recordado
  const originalSignOut = client.auth.signOut.bind(client.auth)
  client.auth.signOut = async () => {
    clearMockSession()
    olvidarUsuario()
    return originalSignOut()
  }

  return client
}
