'use client';
import { useState } from 'react';
import { abrirPantalla } from "@/lib/navegar";
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
    ubicacion_lng: null,
    area_total_ha: '',
    area_ganaderia_ha: ''
  });
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const [success, setSuccess] = useState(false);
  const router = useRouter();
  const supabase = createClient();

  const [buscandoGps, setBuscandoGps] = useState(false);

  // Antes no tenía manejo de error ni tiempo límite: con el permiso negado o
  // sin satélites el botón no hacía nada y el técnico no sabía por qué.
  const handleGPS = () => {
    if (!navigator.geolocation) {
      setError('Este celular no permite usar el GPS desde la app. Escribe la latitud y la longitud a mano.');
      return;
    }
    setBuscandoGps(true);
    navigator.geolocation.getCurrentPosition(
      (pos) => {
        setBuscandoGps(false);
        setForm(f => ({
          ...f,
          ubicacion_lat: pos.coords.latitude.toFixed(6),
          ubicacion_lng: pos.coords.longitude.toFixed(6),
        }));
      },
      (err) => {
        setBuscandoGps(false);
        setError(err.code === 1
          ? 'La app no tiene permiso para usar la ubicación. Actívalo en los ajustes del celular, o escribe la latitud y la longitud a mano.'
          : 'El GPS no respondió (puede faltar cielo abierto). Inténtalo de nuevo afuera, o escribe la latitud y la longitud a mano.');
      },
      { enableHighAccuracy: true, timeout: 30000, maximumAge: 60000 }
    );
  };

  // Coordenadas escritas a mano (pedido de agosto-2026): grados decimales,
  // acepta coma o punto. Vacías = sin ubicación.
  const leerCoordenada = (v) => {
    if (v === null || v === undefined || String(v).trim() === '') return null;
    const n = parseFloat(String(v).trim().replace(',', '.'));
    return isNaN(n) ? NaN : n;
  };

  const handleSave = async () => {
    if (!form.cedula || !form.nombre_completo) {
      return setError('Cédula y Nombre son obligatorios');
    }

    const lat = leerCoordenada(form.ubicacion_lat);
    const lng = leerCoordenada(form.ubicacion_lng);
    if ((lat === null) !== (lng === null)) {
      return setError('Falta la latitud o la longitud: escribe las dos, o deja las dos vacías.');
    }
    // Rango de Colombia: atrapa errores de digitación (signo o punto corrido)
    if (lat !== null && (isNaN(lat) || isNaN(lng) || lat < -5 || lat > 14 || lng < -82 || lng > -66)) {
      return setError('Las coordenadas no parecen de Colombia. En la zona de Puracé la latitud es cerca de 2,3 y la longitud cerca de -76,4 (con el signo menos).');
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

      // 2. Obtener usuario actual (real o modo prueba)
      const isMock = typeof window !== 'undefined' && !!localStorage.getItem('mock-user-session');
      let userId = 'e81ba52c-23df-4f4e-808d-937fd606426c'; // fallback mock
      if (!isMock) {
        const { data: { user } } = await supabase.auth.getUser();
        if (!user) throw new Error('No hay sesión activa');
        userId = user.id;
      }

      // Hectáreas opcionales: texto vacío → null (la columna es numeric)
      const aNumero = (v) => {
        if (v === null || v === undefined || String(v).trim() === '') return null;
        const n = parseFloat(String(v).replace(',', '.'));
        return isNaN(n) ? null : n;
      };

      const newId = crypto.randomUUID();
      const newProductor = {
        ...form,
        area_total_ha: aNumero(form.area_total_ha),
        area_ganaderia_ha: aNumero(form.area_ganaderia_ha),
        ubicacion_lat: lat,
        ubicacion_lng: lng,
        id: newId,
        created_by: userId,
        created_at: new Date().toISOString(),
        es_prueba: isMock
      };

      // 3. Guardar local y cola de sincronización (e intentar sync inmediato si hay red)
      if (!(await saveRecord('productores', newProductor))) {
        throw new Error('El productor no quedó guardado en el celular. Lee el aviso rojo de arriba y vuelve a tocar "Guardar Productor".');
      }

      setForm({ ...form, id: newId });
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
            onClick={() => abrirPantalla(`/calificacion/nueva?productor=${form.id || ''}`)}
            className="bg-[#03A64A] text-white py-4 rounded-xl font-bold"
          >
            Evaluar ahora
          </button>
          <button 
            onClick={() => { setSuccess(false); setForm({ ...form, id: undefined, cedula: '', nombre_completo: '' }); }}
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
            className="w-full py-3 border-b border-gray-100 focus:outline-none focus:border-[#03A64A] text-gray-900 placeholder-gray-400"
            value={form.cedula}
            onChange={e => setForm({...form, cedula: e.target.value})}
          />
          <input
            placeholder="Nombre completo *"
            className="w-full py-3 border-b border-gray-100 focus:outline-none focus:border-[#03A64A] text-gray-900 placeholder-gray-400"
            value={form.nombre_completo}
            onChange={e => setForm({...form, nombre_completo: e.target.value})}
          />
        </div>

        <div>
          <label className="text-xs text-gray-400 uppercase font-bold">Predio y Ubicación</label>
          <input
            placeholder="Nombre del predio"
            className="w-full py-3 border-b border-gray-100 focus:outline-none focus:border-[#03A64A] text-gray-900 placeholder-gray-400"
            value={form.nombre_predio}
            onChange={e => setForm({...form, nombre_predio: e.target.value})}
          />
          <input
            placeholder="Vereda"
            className="w-full py-3 border-b border-gray-100 focus:outline-none focus:border-[#03A64A] text-gray-900 placeholder-gray-400"
            value={form.vereda}
            onChange={e => setForm({...form, vereda: e.target.value})}
          />
          <div className="mt-4 grid grid-cols-2 gap-3">
            <div>
              <label className="text-[10px] text-gray-400 uppercase font-black">Área total (ha)</label>
              <input
                type="number"
                inputMode="decimal"
                min="0"
                step="0.1"
                placeholder="Opcional"
                className="w-full py-3 border-b border-gray-100 focus:outline-none focus:border-[#03A64A] text-gray-900 placeholder-gray-400"
                value={form.area_total_ha}
                onChange={e => setForm({...form, area_total_ha: e.target.value})}
              />
            </div>
            <div>
              <label className="text-[10px] text-gray-400 uppercase font-black">En ganadería (ha)</label>
              <input
                type="number"
                inputMode="decimal"
                min="0"
                step="0.1"
                placeholder="Opcional"
                className="w-full py-3 border-b border-gray-100 focus:outline-none focus:border-[#03A64A] text-gray-900 placeholder-gray-400"
                value={form.area_ganaderia_ha}
                onChange={e => setForm({...form, area_ganaderia_ha: e.target.value})}
              />
            </div>
          </div>
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

        <div className="flex flex-col gap-2">
          <label className="text-xs text-gray-400 uppercase font-bold">Ubicación del predio</label>
          <button
            onClick={handleGPS}
            disabled={buscandoGps}
            className="min-h-[48px] flex items-center justify-center gap-2 text-sm text-blue-700 font-bold bg-blue-50 rounded-lg disabled:opacity-60"
          >
            📍 {buscandoGps ? 'Buscando señal GPS…' : 'Tomar ubicación con el GPS'}
          </button>
          <p className="text-[11px] text-gray-500">O escríbela a mano, en grados decimales (por ejemplo 2.3421 y -76.3854):</p>
          <div className="grid grid-cols-2 gap-3">
            <div>
              <label className="text-[10px] text-gray-400 uppercase font-black">Latitud</label>
              <input
                type="text"
                inputMode="decimal"
                placeholder="2.3421"
                className="w-full py-3 border-b border-gray-100 focus:outline-none focus:border-[#03A64A] text-base text-gray-900 placeholder-gray-400"
                value={form.ubicacion_lat ?? ''}
                onChange={e => setForm({ ...form, ubicacion_lat: e.target.value })}
              />
            </div>
            <div>
              <label className="text-[10px] text-gray-400 uppercase font-black">Longitud</label>
              <input
                type="text"
                inputMode="text"
                placeholder="-76.3854"
                className="w-full py-3 border-b border-gray-100 focus:outline-none focus:border-[#03A64A] text-base text-gray-900 placeholder-gray-400"
                value={form.ubicacion_lng ?? ''}
                onChange={e => setForm({ ...form, ubicacion_lng: e.target.value })}
              />
            </div>
          </div>
        </div>

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
