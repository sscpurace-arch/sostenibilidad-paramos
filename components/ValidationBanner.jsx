'use client';

/**
 * Banner de errores de validación al intentar finalizar.
 *
 * Dos barreras distintas: indicadores sin calificar, e indicadores calificados
 * en 2 o menos que no tienen foto de respaldo ni explicación de por qué falta.
 */
export default function ValidationBanner({ errorCount = 0, fotosFaltantes = [] }) {
  if (errorCount === 0 && fotosFaltantes.length === 0) return null;

  return (
    <div className="flex flex-col gap-3">
      {errorCount > 0 && (
        <div className="bg-red-50 border-2 border-[var(--color-danger)] rounded-xl p-4">
          <p className="font-bold text-sm mb-2" style={{ color: 'var(--color-danger)' }}>
            ⚠ Faltan {errorCount} indicadores por calificar
          </p>
          <p className="text-xs text-gray-600">
            Todos los indicadores deben tener calificación para enviar la evaluación.
            Puedes guardar tu progreso y continuar después.
          </p>
        </div>
      )}

      {fotosFaltantes.length > 0 && (
        <div className="bg-amber-50 border-2 border-amber-300 rounded-xl p-4">
          <p className="font-bold text-sm mb-2 text-amber-800">
            📷 {fotosFaltantes.length === 1
              ? 'Un indicador crítico sin foto'
              : `${fotosFaltantes.length} indicadores críticos sin foto`}
          </p>
          <p className="text-xs text-amber-900/70 mb-2 leading-relaxed">
            Las calificaciones de 1 o 2 necesitan una foto de respaldo. Si no fue
            posible tomarla, escribe en la tarjeta por qué.
          </p>
          <ul className="flex flex-col gap-1">
            {fotosFaltantes.map(f => (
              <li key={f.indicador_id} className="text-xs text-amber-900 flex items-start gap-1.5">
                <span className="shrink-0 font-black">{f.indicador_id}.</span>
                <span className="leading-snug">{f.nombre}</span>
              </li>
            ))}
          </ul>
        </div>
      )}
    </div>
  );
}
