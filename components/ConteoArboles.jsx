'use client';
import { useState } from 'react';

/**
 * ConteoArboles — indicador 8, "Árboles en potreros".
 *
 * Del taller del 31-jul-2026: en el predio de la práctica había plántulas del
 * mismo lote, sembradas hace más de un año, con desarrollo radicalmente
 * distinto. El aliso ya está por encima del pasto; las especies de sucesión
 * tardía siguen suprimidas bajo la gramínea, al punto de que hubo que
 * señalarlas en la fotografía para poder verlas.
 *
 * Contar lo sembrado sobreestima el avance real y contradice la primera regla
 * del instrumento: se califica lo observado, no lo declarado. Un registro de
 * entrega de material no es una observación de campo.
 *
 * Los dos números se guardan por separado para que la diferencia (la
 * mortalidad del establecimiento) quede como dato aprovechable. El descriptor
 * oficial del indicador NO se modifica: esto es apoyo al evaluador.
 */
export default function ConteoArboles({ onAplicar, entradas }) {
  const [sembrados, setSembrados] = useState(entradas?.sembrados ?? '');
  const [establecidos, setEstablecidos] = useState(entradas?.establecidos ?? '');
  const [hectareas, setHectareas] = useState(entradas?.hectareas ?? '');

  const ns = parseFloat(sembrados) || 0;
  const ne = parseFloat(establecidos) || 0;
  const ha = parseFloat(hectareas) || 0;

  const completo = ne > 0 && ha > 0;
  const porHa = completo ? ne / ha : 0;
  const supervivencia = ns > 0 && ne > 0 ? Math.round((ne / ns) * 100) : null;

  // Bandas oficiales del indicador 8, aplicadas sobre árboles ESTABLECIDOS
  const puntaje = !completo ? null
    : porHa >= 70 ? 5
    : porHa >= 30 ? 4
    : porHa >= 10 ? 3
    : porHa >= 5 ? 2
    : 1;

  const aplicar = () => {
    if (!completo) return;
    const partes = [
      `${Math.round(porHa)} árboles establecidos/ha`,
      `${ne} establecidos y vivos en ${ha} ha`,
      ns > 0 ? `${ns} sembrados (${supervivencia}% establecido)` : null,
    ].filter(Boolean);
    onAplicar(puntaje, partes.join(' · '), {
      sembrados: ns, establecidos: ne, hectareas: ha,
      _resultado: porHa, _formula: 'árboles establecidos y vivos ÷ hectáreas de potrero',
    });
  };

  return (
    <div className="mb-3 p-3 bg-green-50/60 rounded-lg border border-green-100 flex flex-col gap-2.5">
      <div>
        <p className="text-[10px] font-black uppercase text-green-700 tracking-widest">
          🌱 Conteo — establecidos, no sembrados
        </p>
        <p className="text-[11px] text-green-800/70 mt-1 leading-snug">
          <span className="font-bold">Se califica</span> sobre los individuos establecidos y
          vivos, por encima del pasto. Un registro de siembra no es una observación de campo.
        </p>
      </div>

      <div className="grid grid-cols-3 gap-2">
        <Campo label="Establecidos y vivos" value={establecidos} onChange={setEstablecidos} placeholder="Ej: 45" />
        <Campo label="Hectáreas de potrero" value={hectareas} onChange={setHectareas} placeholder="Ej: 2" decimal />
        <Campo label="Sembrados (opcional)" value={sembrados} onChange={setSembrados} placeholder="Ej: 80" auxiliar />
      </div>

      {completo && (
        <div className="flex items-center justify-between gap-2 bg-white rounded-lg px-3 py-2 border border-green-100">
          <div className="text-xs text-gray-700 leading-snug min-w-0">
            <p className="font-bold">{Math.round(porHa)} árboles establecidos/ha</p>
            {supervivencia !== null && (
              <p className="text-[11px] text-gray-500">
                {ne} de {ns} sembrados se establecieron ({supervivencia}%)
              </p>
            )}
          </div>
          <button
            type="button"
            onClick={aplicar}
            className="shrink-0 bg-[#03A64A] text-white text-xs font-bold px-3 py-2 rounded-lg active:scale-95 transition-all"
          >
            Usar puntaje: {puntaje}
          </button>
        </div>
      )}
    </div>
  );
}

function Campo({ label, value, onChange, placeholder, decimal = false, auxiliar = false }) {
  return (
    <div>
      <label className="block text-[9px] text-gray-500 font-bold uppercase leading-tight mb-1">
        {label}
      </label>
      <input
        type="number"
        inputMode={decimal ? 'decimal' : 'numeric'}
        min="0"
        step={decimal ? '0.1' : '1'}
        value={value}
        onChange={(e) => onChange(e.target.value)}
        placeholder={placeholder}
        className={`w-full bg-white border rounded-lg px-2 py-2 text-sm text-gray-800 focus:border-[#03A64A] outline-none ${
          auxiliar ? 'border-gray-100 text-gray-500' : 'border-gray-200'
        }`}
      />
    </div>
  );
}
