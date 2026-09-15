'use client';
import { useState } from 'react';
import CalculadoraIndicador, { tieneCalculadora } from '@/components/CalculadoraIndicador';
import ConteoArboles from '@/components/ConteoArboles';
import FotoEvidencia from '@/components/FotoEvidencia';
import ConfirmarNoAplicaModal from '@/components/ConfirmarNoAplicaModal';

const NIVEL_COLOR = { 1: '#DC2626', 2: '#EA580C', 3: '#D97706', 4: '#65A30D', 5: '#03A64A' };

// Indicador 8 (árboles en potreros): se cuentan los establecidos y vivos,
// no los sembrados. Ver ConteoArboles.jsx.
const INDICADOR_ARBOLES = 8;

// Calculadoras que piden hectáreas en pastoreo: se precargan con el área en
// ganadería del predio si la app la conoce (editable, es solo un punto de
// partida).
const CALCULADORAS_CON_HECTAREAS = [22, 25];

/**
 * IndicadorCard — Tarjeta de calificación por indicador
 *
 * Features:
 * - Rango dinámico desde indicador.rango_min / rango_max
 * - Opción "No aplica" con aviso confirmable (valor null + no_aplica true,
 *   fuera del promedio)
 * - Criterios de calificación expandibles (pregunta guía + los 5 niveles oficiales)
 * - Error inline con var(--color-danger)
 * - Validación visual al intentar finalizar (via prop `showError`)
 * - Evidencia fotográfica opcional; al enviar se avisa cuáles faltan
 */
export default function IndicadorCard({
  indicador,
  score,
  onScoreChange,
  noAplica = false,
  onNoAplicaChange,
  observation,
  onObservationChange,
  showError = false,  // true cuando se intenta finalizar sin calificar
  fotos = [],
  fotoUrls = {},
  onAgregarFoto,
  onBorrarFoto,
  guardandoFoto = false,
  motivoSinFoto = '',
  onMotivoSinFotoChange,
  entradas,
  onCalculoAplicado,
  hectareasPredio = null,
}) {
  const [expanded, setExpanded] = useState(false);
  const [confirmandoNoAplica, setConfirmandoNoAplica] = useState(false);
  const tieneNiveles = Array.isArray(indicador.niveles) && indicador.niveles.length > 0;

  const min = indicador.rango_min ?? 1;
  const max = indicador.rango_max ?? 5;
  const range = Array.from({ length: max - min + 1 }, (_, i) => min + i);

  const resuelto = !!score || noAplica;
  const hasError = showError && !resuelto;

  // Con puntaje 1 o 2 la foto sigue siendo la evidencia más importante: se
  // pide con más énfasis y se ofrece anotar por qué no se pudo tomar. Ya no
  // bloquea el envío (taller 2026-09-07); el aviso final lista lo que falte.
  const soporteFotografico = !!onAgregarFoto;
  const requiereFoto = soporteFotografico && !!score && score <= 2;
  const faltaEvidencia = requiereFoto && fotos.length === 0;
  const faltaEvidenciaSinExcusa = faltaEvidencia && !String(motivoSinFoto || '').trim();

  const valoresIniciales = CALCULADORAS_CON_HECTAREAS.includes(indicador.id) && hectareasPredio > 0
    ? { hectareas: String(hectareasPredio) }
    : null;

  // Las calculadoras aplican puntaje, desglose y entradas de una sola vez.
  //
  // Va por un handler propio y NO por onScoreChange + onObservationChange en
  // cadena: esos tres callbacks leen el mismo estado del render actual, así que
  // encadenarlos hace que cada uno guarde con datos obsoletos y el último
  // sobreescriba a los anteriores. Se perdían la observación y las entradas.
  const aplicarCalculo = (puntaje, resumen, entradasCalculo) => {
    if (onCalculoAplicado) {
      onCalculoAplicado({ valor: puntaje, observacion: resumen, entradas: entradasCalculo });
    } else {
      onScoreChange(puntaje);
      onObservationChange(resumen);
    }
  };

  const confirmarNoAplica = () => {
    setConfirmandoNoAplica(false);
    if (onNoAplicaChange) onNoAplicaChange(true);
  };

  return (
    <div
      className={`bg-white rounded-xl p-4 shadow-sm border-2 transition-colors duration-200 ${
        hasError
          ? 'border-[var(--color-danger)] bg-red-50/30'
          : faltaEvidenciaSinExcusa
            ? 'border-amber-300 bg-amber-50/30'
            : noAplica
              ? 'border-gray-300 bg-gray-50/60'
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
        {noAplica ? (
          <span className="shrink-0 px-2 h-5 bg-gray-200 text-gray-600 rounded-full flex items-center justify-center text-[10px] font-black uppercase tracking-wider">
            N/A
          </span>
        ) : score && (
          <span className="shrink-0 w-5 h-5 bg-green-100 text-[#03A64A] rounded-full flex items-center justify-center text-[10px]">
            ✓
          </span>
        )}
      </div>

      {/* Ayuda para calificar: pregunta guía + los 5 niveles oficiales (si ya están cargados) */}
      {(indicador.descripcion || tieneNiveles) && (
        <button
          type="button"
          onClick={() => setExpanded(!expanded)}
          className="text-[11px] text-blue-500 hover:text-blue-700 mb-2 flex items-center gap-1 py-2 -my-1 pr-3"
        >
          <span className={`transition-transform duration-200 inline-block ${expanded ? 'rotate-90' : ''}`}>▶</span>
          {expanded ? 'Ocultar ayuda' : (tieneNiveles ? '¿Cómo califico esto?' : 'Ver descripción')}
        </button>
      )}
      {expanded && (
        tieneNiveles ? (
          <div className="mb-3 p-3 bg-blue-50/50 rounded-lg border border-blue-100 flex flex-col gap-2">
            {indicador.pregunta_guia && (
              <p className="text-xs text-blue-900 font-medium leading-relaxed">{indicador.pregunta_guia}</p>
            )}
            <div className="flex flex-col gap-1.5">
              {[...indicador.niveles].sort((a, b) => b.valor - a.valor).map(n => (
                <div
                  key={n.valor}
                  className={`flex items-start gap-2 text-xs rounded-md px-1.5 py-1 ${score === n.valor ? 'bg-white ring-1 ring-blue-200' : ''}`}
                >
                  <span
                    className="shrink-0 w-5 h-5 rounded-full flex items-center justify-center text-white text-[10px] font-black mt-0.5"
                    style={{ backgroundColor: NIVEL_COLOR[n.valor] || '#666' }}
                  >
                    {n.valor}
                  </span>
                  <span className={`leading-snug ${score === n.valor ? 'text-gray-800 font-medium' : 'text-gray-500'}`}>{n.texto}</span>
                </div>
              ))}
            </div>
            {indicador.nota_criterio && (
              <p className="text-[10px] text-blue-400 italic leading-relaxed border-t border-blue-100 pt-1.5 mt-0.5">
                {indicador.nota_criterio}
              </p>
            )}
          </div>
        ) : indicador.descripcion && (
          <p className="text-xs text-gray-500 mb-3 p-2 bg-blue-50/50 rounded-lg border border-blue-100 leading-relaxed">
            {indicador.descripcion}
          </p>
        )
      )}

      {/* Indicadores con cálculo: la app hace la cuenta y guarda las entradas.
          Con N/A se ocultan: no hay nada que calcular. */}
      {!noAplica && indicador.id === INDICADOR_ARBOLES && (
        <ConteoArboles entradas={entradas} onAplicar={aplicarCalculo} />
      )}
      {!noAplica && tieneCalculadora(indicador.id) && (
        <CalculadoraIndicador indicadorId={indicador.id} onAplicar={aplicarCalculo} valoresIniciales={valoresIniciales} />
      )}

      {/* Botones de score — rango dinámico. Elegir un número quita el N/A. */}
      <div className="flex justify-between items-center mb-2 gap-1">
        {range.map((num) => (
          <button
            key={num}
            type="button"
            onClick={() => onScoreChange(num)}
            className={`flex-1 h-10 rounded-lg flex items-center justify-center font-bold text-sm transition-all duration-150 active:scale-90 ${
              !noAplica && score === num
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

      {/* No aplica: discreto a propósito, para que no compita con el 1-5 */}
      {onNoAplicaChange && (
        <button
          type="button"
          onClick={() => (noAplica ? onNoAplicaChange(false) : setConfirmandoNoAplica(true))}
          className={`w-full py-2 mb-2 rounded-lg text-xs font-bold transition-all active:scale-[0.98] ${
            noAplica
              ? 'bg-gray-700 text-white'
              : 'bg-white text-gray-500 border border-dashed border-gray-300 hover:border-gray-400'
          }`}
        >
          {noAplica ? 'No aplica en este predio · tocar para calificar' : 'No aplica en este predio'}
        </button>
      )}

      {confirmandoNoAplica && (
        <ConfirmarNoAplicaModal
          indicador={indicador}
          onConfirmar={confirmarNoAplica}
          onVolver={() => setConfirmandoNoAplica(false)}
        />
      )}

      {/* Error inline */}
      {hasError && (
        <p className="text-[11px] font-medium mt-1 mb-2 flex items-center gap-1" style={{ color: 'var(--color-danger)' }}>
          <span>⚠</span> Este indicador es obligatorio para finalizar la evaluación
        </p>
      )}

      {/* Observación — se muestra al seleccionar un score o marcar N/A */}
      {resuelto && (
        <textarea
          className={`w-full p-3 border rounded-lg text-sm text-gray-800 outline-none transition-colors resize-none ${
            noAplica && !String(observation || '').trim()
              ? 'border-amber-300 bg-amber-50/50 placeholder-amber-700/60 focus:border-amber-400 focus:bg-white'
              : 'border-gray-200 bg-gray-50 placeholder-gray-400 focus:border-[#03A64A] focus:bg-white'
          }`}
          placeholder={noAplica ? '¿Por qué no aplica en este predio? (motivo)' : 'Observaciones (opcional)...'}
          rows={2}
          value={observation || ''}
          onChange={(e) => onObservationChange(e.target.value)}
        />
      )}

      {/* Evidencia fotográfica — también tras elegir score, como la observación.
          Un N/A no pide foto. */}
      {score && !noAplica && soporteFotografico && (
        <FotoEvidencia
          fotos={fotos}
          urls={fotoUrls}
          onAgregar={(files) => onAgregarFoto(indicador.id, files)}
          onBorrar={onBorrarFoto}
          guardando={guardandoFoto}
          obligatoria={faltaEvidencia}
        />
      )}

      {/* Escape justificado: sin esto, la salida fácil sería subir la nota a 3 */}
      {faltaEvidencia && !noAplica && onMotivoSinFotoChange && (
        <textarea
          className="w-full mt-2 p-3 border border-amber-200 rounded-lg text-sm bg-amber-50/50 text-gray-800 placeholder-amber-700/50 focus:border-amber-400 focus:bg-white outline-none transition-colors resize-none"
          placeholder="¿Por qué no se pudo tomar la foto?"
          rows={2}
          value={motivoSinFoto || ''}
          onChange={(e) => onMotivoSinFotoChange(e.target.value)}
        />
      )}
    </div>
  );
}
