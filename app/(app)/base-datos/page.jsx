'use client';
import { useState, useEffect } from 'react';
import { db } from '@/lib/db-offline';
import { useRouter } from 'next/navigation';

export default function BaseDatosPage() {
  const [productores, setProductores] = useState([]);
  const [loading, setLoading] = useState(true);
  const [sortConfig, setSortConfig] = useState({ key: 'nombre_completo', direction: 'asc' });
  const router = useRouter();

  useEffect(() => {
    cargarProductores();
  }, []);

  async function cargarProductores() {
    setLoading(true);
    const all = await db.productores.toArray();
    setProductores(all);
    setLoading(false);
  }

  const sortData = (key) => {
    let direction = 'asc';
    if (sortConfig.key === key && sortConfig.direction === 'asc') {
      direction = 'desc';
    }
    setSortConfig({ key, direction });

    const sorted = [...productores].sort((a, b) => {
      if (!a[key]) return 1;
      if (!b[key]) return -1;
      if (a[key].toString().toLowerCase() < b[key].toString().toLowerCase()) {
        return direction === 'asc' ? -1 : 1;
      }
      if (a[key].toString().toLowerCase() > b[key].toString().toLowerCase()) {
        return direction === 'asc' ? 1 : -1;
      }
      return 0;
    });
    setProductores(sorted);
  };

  if (loading) return <div className="p-10 text-center text-gray-400">Cargando base de datos...</div>;

  return (
    <div className="flex flex-col gap-4 pb-20 max-w-full overflow-hidden">
      <header className="flex items-center justify-between mb-2">
        <div className="flex items-center gap-2">
          <button onClick={() => router.back()} className="text-gray-500 p-2">←</button>
          <h1 className="text-xl font-bold">Base de Datos de Productores</h1>
        </div>
        <div className="flex items-center gap-1 text-[10px] font-bold text-[#03A64A] bg-green-50 px-3 py-1 rounded-full animate-pulse">
          <span>DESLIZA</span>
          <span>→</span>
        </div>
      </header>

      <div className="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-x-auto">
        <table className="w-full text-left border-collapse min-w-[800px]">
          <thead>
            <tr className="bg-gray-50 border-b border-gray-100">
              {[
                { key: 'nombre_completo', label: 'Nombre Completo' },
                { key: 'cedula', label: 'Cédula' },
                { key: 'nombre_predio', label: 'Nombre Predio' },
                { key: 'vereda', label: 'Vereda' },
                { key: 'municipio', label: 'Municipio' },
                { key: 'proyecto', label: 'Proyecto' }
              ].map((col) => (
                <th 
                  key={col.key}
                  onClick={() => sortData(col.key)}
                  className="p-4 text-[10px] uppercase font-black text-gray-400 cursor-pointer hover:text-[#03A64A] transition-colors"
                >
                  <div className="flex items-center gap-1">
                    {col.label}
                    {sortConfig.key === col.key && (sortConfig.direction === 'asc' ? '↑' : '↓')}
                  </div>
                </th>
              ))}
            </tr>
          </thead>
          <tbody>
            {productores.map((p) => (
              <tr 
                key={p.id}
                onClick={() => router.push(`/calificacion/nueva?productor=${p.id}`)}
                className="border-b border-gray-50 hover:bg-gray-50/50 active:bg-gray-100 transition-colors cursor-pointer"
              >
                <td className="p-4 text-sm font-bold text-gray-800">{p.nombre_completo}</td>
                <td className="p-4 text-sm text-gray-500 font-mono">{p.cedula}</td>
                <td className="p-4 text-sm text-gray-600">{p.nombre_predio || '-'}</td>
                <td className="p-4 text-sm text-gray-600">{p.vereda || '-'}</td>
                <td className="p-4 text-sm text-gray-700 font-medium">{p.municipio || '-'}</td>
                <td className="p-4">
                  <span className={`text-[10px] px-2 py-0.5 rounded-full font-bold uppercase ${
                    p.proyecto === 'Proyecto Sotará' 
                      ? 'bg-blue-50 text-blue-600 border border-blue-100' 
                      : 'bg-green-50 text-green-600 border border-green-100'
                  }`}>
                    {p.proyecto || 'S/P'}
                  </span>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}
