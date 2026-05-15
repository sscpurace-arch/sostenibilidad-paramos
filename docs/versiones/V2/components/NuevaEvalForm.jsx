'use client';

/**
 * Formulario para iniciar una nueva evaluación: fecha + checkbox prueba + botón.
 */
export default function NuevaEvalForm({ fecha, onFechaChange, esPrueba, onEsPruebaChange, onIniciar }) {
  return (
    <section className="bg-white p-6 rounded-2xl shadow-sm border border-gray-100">
      <h3 className="font-bold text-gray-700 mb-4">Nueva Evaluación</h3>
      <div className="flex flex-col gap-4">
        <div>
          <label className="block text-[10px] text-gray-400 uppercase font-bold mb-1">Fecha de Visita</label>
          <input
            type="date"
            value={fecha}
            onChange={(e) => onFechaChange(e.target.value)}
            className="w-full bg-gray-50 border-2 border-gray-100 rounded-xl px-4 py-3 text-sm focus:border-[#03A64A] outline-none transition-colors"
          />
        </div>
        <div className="flex items-center gap-2 py-2">
          <input
            type="checkbox"
            id="esPrueba"
            checked={esPrueba}
            onChange={(e) => onEsPruebaChange(e.target.checked)}
            className="w-5 h-5 rounded border-gray-300 text-[#03A64A] focus:ring-[#03A64A]"
          />
          <label htmlFor="esPrueba" className="text-sm font-medium text-gray-700">Esta es una calificación de prueba</label>
        </div>
        <button
          onClick={onIniciar}
          className="bg-[#03A64A] text-white py-4 rounded-xl font-bold text-lg shadow-lg active:scale-95 transition-all"
        >
          Iniciar Calificación
        </button>
      </div>
    </section>
  );
}
