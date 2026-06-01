import { createBrowserClient } from '@supabase/ssr'

export const createClient = () => {
  const client = createBrowserClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
  )

  // Proxy auth.getUser to support local dev mock login
  const originalGetUser = client.auth.getUser.bind(client.auth)
  client.auth.getUser = async () => {
    const isMock = typeof window !== 'undefined' && 
      (document.cookie.includes('mock-user-session') || localStorage.getItem('mock-user-session'));
    
    if (isMock) {
      return {
        data: {
          user: {
            id: 'e81ba52c-23df-4f4e-808d-937fd606426c',
            email: 'sscpurace@gmail.com',
            user_metadata: { nombre: 'Evaluador Principal', rol: 'evaluador' },
            app_metadata: {}
          }
        },
        error: null
      }
    }
    return originalGetUser()
  }

  // Proxy auth.signOut to clear mock session cookies
  const originalSignOut = client.auth.signOut.bind(client.auth)
  client.auth.signOut = async () => {
    if (typeof window !== 'undefined') {
      document.cookie = 'mock-user-session=; path=/; expires=Thu, 01 Jan 1970 00:00:01 GMT;'
      localStorage.removeItem('mock-user-session')
    }
    return originalSignOut()
  }

  return client
}
