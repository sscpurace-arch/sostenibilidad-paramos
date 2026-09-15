'use client';

/**
 * Banner de errores de validación al intentar finalizar.
 *
 * Dos avisos distintos: indicadores sin calificar (esto sí bloquea el envío) e
 * indicadores calificados sin foto (aviso; el envío lo decide el técnico en
 * el modal de FotosFaltantesModal).
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
              ? 'Un indicador sin foto'
              : `${fotosFaltantes.length} indicadores sin foto`}
          </p>
          <p className="text-xs text-amber-900/70 mb-2 leading-relaxed">
            Las fotos son la evidencia de la visita. Puedes enviar sin ellas, pero
            si alcanzas a tomarlas, mejor.
          </p>
          <ul className="flex flex-col gap-1">
            {fotosFaltantes.map(f => (
              <li key={f.indicador_id} className="text-xs text-amber-900 flex items-start gap-1.5">
                <span className="shrink-0 font-black">{f.orden ?? f.indicador_id}.</span>
                <span className="leading-snug">{f.nombre}</span>
              </li>
            ))}
          </ul>
        </div>
      )}
    </div>
  );
}
