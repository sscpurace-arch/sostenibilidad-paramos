'use client';

export default function IndicadorCard({ indicador, score, onScoreChange, observation, onObservationChange }) {
  return (
    <div className="bg-white rounded-lg p-4 shadow-sm mb-4 border border-gray-100">
      <h3 className="font-bold text-gray-800 mb-2">{indicador.id}. {indicador.nombre}</h3>
      <div className="flex justify-between items-center mb-3">
        {[1, 2, 3, 4, 5].map((num) => (
          <button
            key={num}
            onClick={() => onScoreChange(num)}
            className={`w-10 h-10 rounded-full flex items-center justify-center border ${
              score === num
                ? 'bg-[#2E7D32] text-white border-[#2E7D32]'
                : 'bg-gray-50 text-gray-600 border-gray-200'
            }`}
          >
            {num}
          </button>
        ))}
      </div>
      {score && (
        <textarea
          className="w-full p-2 border border-gray-200 rounded text-sm bg-gray-50"
          placeholder="Observaciones..."
          value={observation || ''}
          onChange={(e) => onObservationChange(e.target.value)}
        />
      )}
    </div>
  );
}
