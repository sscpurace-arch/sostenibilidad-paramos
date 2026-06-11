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

export const createClient = () => {
  const client = createBrowserClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
  )

  // Proxy auth.getUser para soportar el modo prueba (sesión con expiración)
  // y el modo offline: getUser() valida contra el servidor de Supabase, así
  // que sin red devolvería null aunque el usuario esté logueado. En ese caso
  // se usa la sesión guardada localmente (getSession no necesita red).
  const originalGetUser = client.auth.getUser.bind(client.auth)
  client.auth.getUser = async () => {
    const mock = getMockSession()
    if (mock) {
      return { data: { user: { ...MOCK_USER } }, error: null }
    }
    if (typeof navigator !== 'undefined' && !navigator.onLine) {
      const { data } = await client.auth.getSession()
      return { data: { user: data?.session?.user ?? null }, error: null }
    }
    try {
      const result = await originalGetUser()
      if (result?.data?.user) return result
      // Falla con red inestable: caer a la sesión local antes de rendirse
      const { data } = await client.auth.getSession()
      if (data?.session?.user) {
        return { data: { user: data.session.user }, error: null }
      }
      return result
    } catch {
      const { data } = await client.auth.getSession()
      return { data: { user: data?.session?.user ?? null }, error: null }
    }
  }

  // Proxy auth.signOut para limpiar la sesión de prueba
  const originalSignOut = client.auth.signOut.bind(client.auth)
  client.auth.signOut = async () => {
    clearMockSession()
    return originalSignOut()
  }

  return client
}
