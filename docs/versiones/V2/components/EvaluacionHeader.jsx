'use client';

/**
 * Header sticky con nombre del productor, progreso y mensaje de autosave.
 */
export default function EvaluacionHeader({ 
  nombreProductor, 
  totalRespondidos, 
  totalIndicadores, 
  todosCompletos, 
  autoSaveMsg, 
  pendingCount 
}) {
  const progreso = (totalRespondidos / totalIndicadores) * 100;

  return (
    <header className="sticky top-0 bg-[#F5F5F5] pt-2 pb-4 z-20 border-b border-gray-200">
      <div className="flex justify-between items-end mb-1">
        <h1 className="font-bold text-gray-800 text-sm truncate max-w-[200px]">{nombreProductor}</h1>
        <div className="text-right">
          <span className={`text-xs font-bold ${todosCompletos ? 'text-[#03A64A]' : 'text-gray-500'}`}>
            {totalRespondidos} / {totalIndicadores}
          </span>
          {autoSaveMsg && (
            <p className="text-[9px] text-green-600 font-medium animate-pulse">{autoSaveMsg}</p>
          )}
        </div>
      </div>
      <div className="w-full bg-gray-200 h-2 rounded-full overflow-hidden">
        <div
          className={`h-full transition-all duration-500 ${todosCompletos ? 'bg-[#03A64A]' : 'bg-blue-500'}`}
          style={{ width: `${progreso}%` }}
        ></div>
      </div>
      {pendingCount > 0 && (
        <p className="text-[9px] text-amber-600 mt-1">⏳ {pendingCount} cambios por sincronizar</p>
      )}
    </header>
  );
}
