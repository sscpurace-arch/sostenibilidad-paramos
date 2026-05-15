'use client';
import { useState } from 'react';
import { db } from '@/lib/db-offline';
import { saveRecord } from '@/lib/sync-engine';
import { createClient } from '@/lib/supabase';
import { useRouter } from 'next/navigation';

export default function NuevoProductorPage() {
  const [form, setForm] = useState({
    cedula: '',
    nombre_completo: '',
    nombre_predio: '',
    vereda: '',
    municipio: 'Puracé',
    nombre_tecnico: '',
    nombre_facilitador: '',
    ubicacion_lat: null,
    ubicacion_lng: null
  });
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [success, setSuccess] = useState(false);
  const router = useRouter();
  const supabase = createClient();

  const handleGPS = () => {
    if (!navigator.geolocation) return alert('GPS no soportado');
    navigator.geolocation.getCurrentPosition((pos) => {
      setForm({ ...form, ubicacion_lat: pos.coords.latitude, ubicacion_lng: pos.coords.longitude });
    });
  };

  const handleSave = async () => {
    if (!form.cedula || !form.nombre_completo) {
      return setError('Cédula y Nombre son obligatorios');
    }

    setLoading(true);
    setError(null);

    try {
      // 1. Verificar duplicado local
      const existe = await db.productores.where('cedula').equals(form.cedula).first();
      if (existe) {
        setLoading(false);
        return setError('Esta cédula ya está registrada localmente');
      }

      // 2. Obtener usuario actual
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) throw new Error('No hay sesión activa');

      const newId = crypto.randomUUID();
      const newProductor = {
        ...form,
        id: newId,
        created_by: user.id,
        created_at: new Date().toISOString()
      };

      // 3. Guardar local
      await db.productores.add(newProductor);

      // 4. Cola de sincronización
      await agregarACola('productores', 'INSERT', newProductor);

      // 5. Intentar sync si hay red
      if (navigator.onLine) {
        await procesarCola(supabase);
      }

      setSuccess(true);
    } catch (e) {
      setError(e.message);
    } finally {
      setLoading(false);
    }
  };

  if (success) {
    return (
      <div className="flex flex-col items-center justify-center py-20 text-center gap-6">
        <div className="w-20 h-20 bg-green-100 text-[#03A64A] rounded-full flex items-center justify-center text-4xl">✓</div>
        <h2 className="text-2xl font-bold">Productor Registrado</h2>
        <div className="flex flex-col gap-2 w-full">
          <button 
            onClick={() => router.push(`/calificacion/nueva/${form.id || ''}`)}
            className="bg-[#03A64A] text-white py-4 rounded-xl font-bold"
          >
            Evaluar ahora
          </button>
          <button 
            onClick={() => { setSuccess(false); setForm({ ...form, cedula: '', nombre_completo: '' }); }}
            className="text-gray-500 py-2"
          >
            Registrar otro
          </button>
        </div>
      </div>
    );
  }

  return (
    <div className="flex flex-col gap-4 pb-20">
      <header className="flex items-center gap-2">
        <button onClick={() => router.back()} className="text-gray-500 p-2">←</button>
        <h1 className="text-xl font-bold">Nuevo Productor</h1>
      </header>

      {error && <div className="bg-red-100 text-red-700 p-3 rounded-lg text-sm">{error}</div>}

      <div className="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 flex flex-col gap-5">
        <div>
          <label className="text-xs text-gray-400 uppercase font-bold">Información Básica</label>
          <input 
            type="number" 
            placeholder="Cédula *" 
            className="w-full py-3 border-b border-gray-100 focus:outline-none focus:border-[#03A64A]"
            value={form.cedula}
            onChange={e => setForm({...form, cedula: e.target.value})}
          />
          <input 
            placeholder="Nombre completo *" 
            className="w-full py-3 border-b border-gray-100 focus:outline-none focus:border-[#03A64A]"
            value={form.nombre_completo}
            onChange={e => setForm({...form, nombre_completo: e.target.value})}
          />
        </div>

        <div>
          <label className="text-xs text-gray-400 uppercase font-bold">Predio y Ubicación</label>
          <input 
            placeholder="Nombre del predio" 
            className="w-full py-3 border-b border-gray-100 focus:outline-none focus:border-[#03A64A]"
            value={form.nombre_predio}
            onChange={e => setForm({...form, nombre_predio: e.target.value})}
          />
          <input 
            placeholder="Vereda" 
            className="w-full py-3 border-b border-gray-100 focus:outline-none focus:border-[#03A64A]"
            value={form.vereda}
            onChange={e => setForm({...form, vereda: e.target.value})}
          />
          <div className="mt-4">
            <label className="text-[10px] text-gray-400 uppercase font-black">Municipio</label>
            <select 
              className="w-full py-3 border-b border-gray-100 focus:outline-none bg-white text-lg font-bold text-[#03A64A]"
              value={form.municipio}
              onChange={e => setForm({...form, municipio: e.target.value})}
            >
              {['Puracé', 'Sotará'].map(m => (
                <option key={m} value={m}>{m}</option>
              ))}
            </select>
          </div>
        </div>

        <button 
          onClick={handleGPS}
          className="flex items-center justify-center gap-2 text-sm text-blue-600 font-bold py-2 bg-blue-50 rounded-lg"
        >
          📍 {form.ubicacion_lat ? `${form.ubicacion_lat.toFixed(4)}, ${form.ubicacion_lng.toFixed(4)}` : 'Obtener ubicación GPS'}
        </button>

        <button 
          onClick={handleSave}
          disabled={loading}
          className="bg-[#03A64A] text-white py-4 rounded-xl font-bold shadow-lg disabled:opacity-50 mt-4"
        >
          {loading ? 'Guardando...' : 'Guardar Productor'}
        </button>
      </div>
    </div>
  );
}
