'use client';

/**
 * Formulario para iniciar una nueva evaluación: fecha + persona receptora + checkbox prueba + botón.
 */
export default function NuevaEvalForm({
  fecha, onFechaChange,
  esPrueba, onEsPruebaChange,
  receptorEsOtro, onReceptorEsOtroChange,
  receptorNombre, onReceptorNombreChange,
  receptorCedula, onReceptorCedulaChange,
  receptorParentesco, onReceptorParentescoChange,
  onIniciar,
}) {
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

        <div>
          <label className="block text-[10px] text-gray-400 uppercase font-bold mb-2">
            ¿La visita la recibe otra persona (no el propietario)?
          </label>
          <div className="flex gap-2">
            <button
              type="button"
              onClick={() => onReceptorEsOtroChange(false)}
              className={`flex-1 py-2.5 rounded-xl font-bold text-sm transition-all ${
                !receptorEsOtro ? 'bg-[#03A64A] text-white' : 'bg-gray-50 text-gray-500 border border-gray-200'
              }`}
            >
              No
            </button>
            <button
              type="button"
              onClick={() => onReceptorEsOtroChange(true)}
              className={`flex-1 py-2.5 rounded-xl font-bold text-sm transition-all ${
                receptorEsOtro ? 'bg-[#03A64A] text-white' : 'bg-gray-50 text-gray-500 border border-gray-200'
              }`}
            >
              Sí
            </button>
          </div>
        </div>

        {receptorEsOtro && (
          <div className="flex flex-col gap-3 bg-amber-50/50 border border-amber-100 rounded-xl p-3">
            <div>
              <label className="block text-[10px] text-gray-400 uppercase font-bold mb-1">Nombre completo</label>
              <input
                type="text"
                value={receptorNombre}
                onChange={(e) => onReceptorNombreChange(e.target.value)}
                placeholder="Nombre de quien recibe la visita"
                className="w-full bg-white border-2 border-gray-100 rounded-xl px-4 py-3 text-sm focus:border-[#03A64A] outline-none transition-colors"
              />
            </div>
            <div>
              <label className="block text-[10px] text-gray-400 uppercase font-bold mb-1">Cédula</label>
              <input
                type="text"
                value={receptorCedula}
                onChange={(e) => onReceptorCedulaChange(e.target.value)}
                placeholder="Número de cédula"
                className="w-full bg-white border-2 border-gray-100 rounded-xl px-4 py-3 text-sm focus:border-[#03A64A] outline-none transition-colors"
              />
            </div>
            <div>
              <label className="block text-[10px] text-gray-400 uppercase font-bold mb-1">Parentesco con el propietario</label>
              <input
                type="text"
                value={receptorParentesco}
                onChange={(e) => onReceptorParentescoChange(e.target.value)}
                placeholder="Ej: hijo, esposa, administrador, vecino..."
                className="w-full bg-white border-2 border-gray-100 rounded-xl px-4 py-3 text-sm focus:border-[#03A64A] outline-none transition-colors"
              />
            </div>
          </div>
        )}

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
