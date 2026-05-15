'use client';
import { useState } from 'react';

/**
 * IndicadorCard — Tarjeta de calificación por indicador
 * 
 * Features:
 * - Rango dinámico desde indicador.rango_min / rango_max
 * - Descripción expandible
 * - Error inline con var(--color-danger)
 * - Validación visual al intentar finalizar (via prop `showError`)
 */
export default function IndicadorCard({ 
  indicador, 
  score, 
  onScoreChange, 
  observation, 
  onObservationChange,
  showError = false  // true cuando se intenta finalizar sin calificar
}) {
  const [expanded, setExpanded] = useState(false);

  const min = indicador.rango_min ?? 1;
  const max = indicador.rango_max ?? 5;
  const range = Array.from({ length: max - min + 1 }, (_, i) => min + i);

  const hasError = showError && !score;

  return (
    <div 
      className={`bg-white rounded-xl p-4 shadow-sm border-2 transition-colors duration-200 ${
        hasError 
          ? 'border-[var(--color-danger)] bg-red-50/30' 
          : score 
            ? 'border-green-200' 
            : 'border-gray-100'
      }`}
    >
      {/* Header con nombre e indicador de completado */}
      <div className="flex items-start justify-between gap-2 mb-1">
        <h3 className="font-bold text-gray-800 text-sm leading-tight">
          {indicador.orden ?? indicador.id}. {indicador.nombre}
        </h3>
        {score && (
          <span className="shrink-0 w-5 h-5 bg-green-100 text-[#03A64A] rounded-full flex items-center justify-center text-[10px]">
            ✓
          </span>
        )}
      </div>

      {/* Descripción expandible */}
      {indicador.descripcion && (
        <button
          type="button"
          onClick={() => setExpanded(!expanded)}
          className="text-[11px] text-blue-500 hover:text-blue-700 mb-2 flex items-center gap-1"
        >
          <span className={`transition-transform duration-200 inline-block ${expanded ? 'rotate-90' : ''}`}>▶</span>
          {expanded ? 'Ocultar descripción' : 'Ver descripción'}
        </button>
      )}
      {expanded && indicador.descripcion && (
        <p className="text-xs text-gray-500 mb-3 p-2 bg-blue-50/50 rounded-lg border border-blue-100 leading-relaxed">
          {indicador.descripcion}
        </p>
      )}

      {/* Botones de score — rango dinámico */}
      <div className="flex justify-between items-center mb-2 gap-1">
        {range.map((num) => (
          <button
            key={num}
            type="button"
            onClick={() => onScoreChange(num)}
            className={`flex-1 h-10 rounded-lg flex items-center justify-center font-bold text-sm transition-all duration-150 active:scale-90 ${
              score === num
                ? 'bg-[#03A64A] text-white shadow-md shadow-green-200'
                : 'bg-gray-50 text-gray-600 border border-gray-200 hover:border-gray-300'
            }`}
          >
            {num}
          </button>
        ))}
      </div>

      {/* Rango label */}
      <div className="flex justify-between text-[9px] text-gray-400 mb-2 px-1">
        <span>Bajo ({min})</span>
        <span>Alto ({max})</span>
      </div>

      {/* Error inline */}
      {hasError && (
        <p className="text-[11px] font-medium mt-1 mb-2 flex items-center gap-1" style={{ color: 'var(--color-danger)' }}>
          <span>⚠</span> Este indicador es obligatorio para finalizar la evaluación
        </p>
      )}

      {/* Observación — se muestra al seleccionar un score */}
      {score && (
        <textarea
          className="w-full p-3 border border-gray-200 rounded-lg text-sm bg-gray-50 focus:border-[#03A64A] focus:bg-white outline-none transition-colors resize-none"
          placeholder="Observaciones (opcional)..."
          rows={2}
          value={observation || ''}
          onChange={(e) => onObservationChange(e.target.value)}
        />
      )}
    </div>
  );
}
