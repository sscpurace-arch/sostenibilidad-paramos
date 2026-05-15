'use client';
import { useState } from 'react';
import { createClient } from '@/lib/supabase';
import { useRouter } from 'next/navigation';

export default function LoginPage() {
  const [email, setEmail] = useState('sscpurace@gmail.com');
  const [password, setPassword] = useState('');
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(false);
  const router = useRouter();
  const supabase = createClient();

  const handleLogin = async () => {
    setLoading(true);
    setError(null);
    
    try {
      const { error } = await supabase.auth.signInWithPassword({
        email,
        password,
      });

      if (error) {
        setError(error.message === 'Invalid login credentials' ? 'Credenciales inválidas' : error.message);
      } else {
        router.push('/');
        router.refresh();
      }
    } catch (e) {
      setError('Error de conexión');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-[#E8F5E9] flex flex-col items-center justify-center p-6">
      <div className="bg-[#03A64A] w-20 h-20 rounded-full flex items-center justify-center text-white text-4xl font-bold mb-4 shadow-lg">
        P
      </div>
      <h1 className="text-3xl font-bold text-gray-800">PNN Puracé</h1>
      <p className="text-gray-600 mb-8">Sostenibilidad Páramos</p>

      <div className="w-full max-w-sm flex flex-col gap-4">
        {error && (
          <div className="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-xl text-sm">
            {error}
          </div>
        )}
        <input
          type="email"
          placeholder="Email"
          className="w-full p-4 rounded-xl border border-gray-200 focus:outline-none focus:ring-2 focus:ring-[#03A64A]"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
        />
        <input
          type="password"
          placeholder="Contraseña"
          className="w-full p-4 rounded-xl border border-gray-200 focus:outline-none focus:ring-2 focus:ring-[#03A64A]"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          onKeyDown={(e) => e.key === 'Enter' && handleLogin()}
        />
        <button 
          onClick={handleLogin}
          disabled={loading}
          className="bg-[#03A64A] text-white py-4 rounded-xl font-bold text-lg shadow-md mt-2 disabled:opacity-50"
        >
          {loading ? 'Ingresando...' : 'Ingresar'}
        </button>
      </div>
    </div>
  );
}
