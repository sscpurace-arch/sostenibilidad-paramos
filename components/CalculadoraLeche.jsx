'use client';
import { useState } from 'react';

/**
 * Calculadora del indicador 22 (litros leche/hectárea/año).
 * El técnico en campo no calcula esto de memoria: pregunta lo fácil
 * (litros por día, vacas en ordeño, hectáreas de pastoreo) y la app
 * hace la cuenta y sugiere el puntaje según la banda oficial.
 *
 * Banda: Doble Propósito, trópico alto (la típica en fincas de páramo).
 */

// litros/ha/año → puntaje (banda Doble Propósito trópico alto de la guía oficial)
function puntajeLeche(litrosHaAno) {
  if (litrosHaAno > 2500) return 5;
  if (litrosHaAno >= 2001) return 4;
  if (litrosHaAno >= 1501) return 3;
  if (litrosHaAno >= 1001) return 2;
  return 1;
}

export default function CalculadoraLeche({ onAplicar }) {
  const [litrosDia, setLitrosDia] = useState('');
  const [vacas, setVacas] = useState('');
  const [hectareas, setHectareas] = useState('');

  const ld = parseFloat(litrosDia) || 0;
  const nv = parseFloat(vacas) || 0;
  const ha = parseFloat(hectareas) || 0;

  const completo = ld > 0 && ha > 0;
  const litrosHaAno = completo ? Math.round((ld * 365) / ha) : 0;
  const promedioVaca = ld > 0 && nv > 0 ? (ld / nv).toFixed(1) : null;
  const puntaje = completo ? puntajeLeche(litrosHaAno) : null;

  const aplicar = () => {
    if (!completo) return;
    const partes = [
      `Producción: ${ld} L/día`,
      nv > 0 ? `${nv} vacas en ordeño (${promedioVaca} L/vaca/día)` : null,
      `${ha} ha en pastoreo`,
      `→ ${litrosHaAno.toLocaleString('es-CO')} L/ha/año`,
    ].filter(Boolean);
    onAplicar(puntaje, partes.join(' · '));
  };

  return (
    <div className="mb-3 p-3 bg-green-50/60 rounded-lg border border-green-100 flex flex-col gap-2.5">
      <p className="text-[10px] font-black uppercase text-green-700 tracking-widest">
        🥛 Calculadora — la app hace la cuenta
      </p>
      <div className="grid grid-cols-3 gap-2">
        <div>
          <label className="block text-[9px] text-gray-500 font-bold uppercase leading-tight mb-1">
            Litros por día (toda la finca)
          </label>
          <input
            type="number" inputMode="decimal" min="0"
            value={litrosDia}
            onChange={(e) => setLitrosDia(e.target.value)}
            placeholder="Ej: 40"
            className="w-full bg-white border border-gray-200 rounded-lg px-2 py-2 text-sm text-gray-800 focus:border-[#03A64A] outline-none"
          />
        </div>
        <div>
          <label className="block text-[9px] text-gray-500 font-bold uppercase leading-tight mb-1">
            Vacas en ordeño
          </label>
          <input
            type="number" inputMode="numeric" min="0"
            value={vacas}
            onChange={(e) => setVacas(e.target.value)}
            placeholder="Ej: 8"
            className="w-full bg-white border border-gray-200 rounded-lg px-2 py-2 text-sm text-gray-800 focus:border-[#03A64A] outline-none"
          />
        </div>
        <div>
          <label className="block text-[9px] text-gray-500 font-bold uppercase leading-tight mb-1">
            Hectáreas en pastoreo
          </label>
          <input
            type="number" inputMode="decimal" min="0" step="0.1"
            value={hectareas}
            onChange={(e) => setHectareas(e.target.value)}
            placeholder="Ej: 3"
            className="w-full bg-white border border-gray-200 rounded-lg px-2 py-2 text-sm text-gray-800 focus:border-[#03A64A] outline-none"
          />
        </div>
      </div>

      {completo && (
        <div className="flex items-center justify-between gap-2 bg-white rounded-lg px-3 py-2 border border-green-100">
          <div className="text-xs text-gray-700 leading-snug">
            <p className="font-bold">{litrosHaAno.toLocaleString('es-CO')} litros/ha/año</p>
            {promedioVaca && <p className="text-[11px] text-gray-500">{promedioVaca} L por vaca al día</p>}
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
