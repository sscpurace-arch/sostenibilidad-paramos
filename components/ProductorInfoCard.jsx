'use client';

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
