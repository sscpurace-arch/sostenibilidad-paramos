'use client';

/**
 * Banner de errores de validación al intentar finalizar.
 */
export default function ValidationBanner({ errorCount }) {
  if (errorCount === 0) return null;

  return (
    <div className="bg-red-50 border-2 border-[var(--color-danger)] rounded-xl p-4">
      <p className="font-bold text-sm mb-2" style={{ color: 'var(--color-danger)' }}>
        ⚠ Faltan {errorCount} indicadores por calificar
      </p>
      <p className="text-xs text-gray-600">
        Todos los indicadores deben tener calificación para enviar la evaluación.
        Puedes guardar tu progreso y continuar después.
      </p>
    </div>
  );
}
