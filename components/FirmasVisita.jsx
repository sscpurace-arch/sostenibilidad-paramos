'use client';
import { useMemo, useState } from 'react';
import FirmaModal from '@/components/FirmaModal';

/**
 * FirmasVisita — firmas del técnico y del productor al final de los
 * indicadores, sin tener que enviar primero (pedido 14-nov-2026: en campo el
 * productor firma al terminar la conversación, y el envío puede esperar a
 * revisar o a tener señal). Las mismas firmas siguen apareciendo, y se pueden
 * rehacer, en la pantalla de resultados.
 *
 * onGuardar(campo, dataUrl) lo maneja la página, que guarda la evaluación en
 * el celular SIN cambiar su estado (un borrador sigue siendo borrador).
 */
export default function FirmasVisita({ firmaTecnico = '', firmaProductor = '', labelProductor = 'Productor', onGuardar }) {
  const [abierto, setAbierto] = useState(false);

  // Identidad estable: FirmaModal lee `valores` por ref (ver su comentario)
  const valores = useMemo(
    () => ({ firma_tecnico: firmaTecnico, firma_productor: firmaProductor }),
    [firmaTecnico, firmaProductor]
  );

  return (
    <div className="bg-white rounded-xl p-4 shadow-sm border-2 border-gray-100 mt-2">
      <h3 className="font-bold text-gray-800 text-sm leading-tight mb-1">Firmas de la visita</h3>
      <p className="text-xs text-gray-500 mb-3 leading-relaxed">
        Pueden firmar ahora, antes de enviar. Si prefieres, también se puede firmar después del envío.
      </p>
      <div className="grid grid-cols-2 gap-3 mb-3">
        {[
          { valor: firmaTecnico, label: 'Técnico' },
          { valor: firmaProductor, label: labelProductor },
        ].map((f) => (
          <div key={f.label} className="flex flex-col items-center gap-1.5">
            <span className="text-[10px] font-black uppercase text-gray-400 tracking-widest text-center leading-tight">{f.label}</span>
            {f.valor ? (
              // eslint-disable-next-line @next/next/no-img-element
              <img src={f.valor} alt={`Firma ${f.label}`} className="h-16 w-full object-contain bg-white border border-gray-200 rounded-xl" />
            ) : (
              <div className="h-16 w-full bg-gray-50 border-2 border-dashed border-gray-200 rounded-xl flex items-center justify-center text-[10px] text-gray-300">Sin firmar</div>
            )}
          </div>
        ))}
      </div>
      <button
        type="button"
        onClick={() => setAbierto(true)}
        className="w-full h-12 rounded-xl font-bold text-sm flex items-center justify-center gap-2 bg-gray-50 border border-gray-200 text-gray-700 active:scale-95 transition-all"
      >
        <span>✍️</span> {(firmaTecnico || firmaProductor) ? 'Volver a firmar' : 'Firmar la calificación'}
      </button>

      {abierto && (
        <FirmaModal
          pasos={[
            { key: 'firma_tecnico', label: 'Firma del técnico' },
            { key: 'firma_productor', label: `Firma del ${labelProductor === 'Productor' ? 'productor' : labelProductor}` },
          ]}
          valores={valores}
          onGuardar={onGuardar}
          onCerrar={() => setAbierto(false)}
        />
      )}
    </div>
  );
}
