'use client';

const tieneNumero = (v) => v !== null && v !== undefined && v !== '' && !isNaN(Number(v));
const formatoHa = (v) => (tieneNumero(v) ? `${Number(v).toLocaleString('es-CO', { maximumFractionDigits: 2 })} ha` : '—');

/**
 * Card con información básica del productor.
 */
export default function ProductorInfoCard({ productor, onVerMapa }) {
  return (
    <section className="bg-white p-6 rounded-2xl shadow-sm border border-gray-100">
      <h2 className="text-2xl font-bold text-[#03A64A]">{productor.nombre_completo}</h2>
      <p className="text-sm text-gray-500 mt-1">CC: {productor.cedula}</p>
      <div className="mt-6">
        <p className="text-[10px] text-gray-700 uppercase font-bold">Nombre del predio</p>
        <p className="text-sm">
          {productor.nombre_predio
            ? productor.vereda
              ? `${productor.nombre_predio} • ${productor.vereda}`
              : productor.nombre_predio
            : '-'}
        </p>
      </div>

      {/* Hectáreas: vienen de la Base Maestra del diagnóstico SSP (cruce por
          cédula) o del registro del productor. Se ocultan si no hay dato. */}
      {(tieneNumero(productor.area_total_ha) || tieneNumero(productor.area_ganaderia_ha)) && (
        <div className="mt-4 grid grid-cols-2 gap-3">
          <div className="bg-gray-50 rounded-xl px-3 py-2">
            <p className="text-[10px] text-gray-500 uppercase font-bold">Área total</p>
            <p className="text-base font-black text-gray-800">{formatoHa(productor.area_total_ha)}</p>
          </div>
          <div className="bg-green-50 rounded-xl px-3 py-2">
            <p className="text-[10px] text-green-700 uppercase font-bold">En ganadería</p>
            <p className="text-base font-black text-[#03A64A]">{formatoHa(productor.area_ganaderia_ha)}</p>
          </div>
        </div>
      )}

      <button
        onClick={onVerMapa}
        className="mt-6 w-full flex items-center justify-center gap-2 py-3 border-2 border-[#03A64A]/20 rounded-xl text-[#03A64A] font-bold text-sm hover:bg-green-50 active:scale-95 transition-all"
      >
        📍 Ver ubicación del predio
      </button>

      {productor.ubicacion_lat && productor.ubicacion_lng && (
        <div className="mt-2 text-center">
          <p className="text-[10px] text-gray-400 font-mono">
            LAT: {productor.ubicacion_lat} | LNG: {productor.ubicacion_lng}
          </p>
        </div>
      )}
    </section>
  );
}
