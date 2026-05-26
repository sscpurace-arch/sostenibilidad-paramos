'use client';
import { useState, useEffect } from 'react';
import { createClient } from '@/lib/supabase';
import { useRouter } from 'next/navigation';

export default function LoginPage() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(false);
  const [attempts, setAttempts] = useState(0);
  const [cooldown, setCooldown] = useState(0);
  
  const router = useRouter();
  const supabase = createClient();

  useEffect(() => {
    if (cooldown <= 0) return;
    const timer = setInterval(() => {
      setCooldown((prev) => {
        if (prev <= 1) {
          setAttempts(0);
          return 0;
        }
        return prev - 1;
      });
    }, 1000);
    return () => clearInterval(timer);
  }, [cooldown]);

  const handleLogin = async () => {
    if (cooldown > 0) return;
    
    setLoading(true);
    setError(null);
    
    try {
      const { error } = await supabase.auth.signInWithPassword({
        email,
        password,
      });

      if (error) {
        const nextAttempts = attempts + 1;
        setAttempts(nextAttempts);
        if (nextAttempts >= 5) {
          setCooldown(30);
          setError('Demasiados intentos. Por favor espere 30 segundos.');
        } else {
          setError(error.message === 'Invalid login credentials' ? 'Credenciales inválidas' : error.message);
        }
      } else {
        setAttempts(0);
        router.push('/');
        router.refresh();
      }
    } catch (e) {
      const nextAttempts = attempts + 1;
      setAttempts(nextAttempts);
      if (nextAttempts >= 5) {
        setCooldown(30);
        setError('Demasiados intentos. Por favor espere 30 segundos.');
      } else {
        setError('Error de conexión');
      }
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
          disabled={cooldown > 0}
        />
        <input
          type="password"
          placeholder="Contraseña"
          className="w-full p-4 rounded-xl border border-gray-200 focus:outline-none focus:ring-2 focus:ring-[#03A64A]"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          onKeyDown={(e) => e.key === 'Enter' && cooldown === 0 && handleLogin()}
          disabled={cooldown > 0}
        />
        <div className="text-right">
          <a
            href="#"
            onClick={(e) => {
              e.preventDefault();
              alert('Por favor contacte al administrador del sistema para restablecer su contraseña.');
            }}
            className="text-sm text-[#03A64A] hover:underline"
          >
            ¿Olvidaste tu contraseña?
          </a>
        </div>
        <button 
          onClick={handleLogin}
          disabled={loading || cooldown > 0}
          className="bg-[#03A64A] text-white py-4 rounded-xl font-bold text-lg shadow-md mt-2 disabled:opacity-50"
        >
          {cooldown > 0 
            ? `Bloqueado (${cooldown}s)` 
            : loading 
              ? 'Ingresando...' 
              : 'Ingresar'}
        </button>
      </div>
    </div>
  );
}
