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
    <header className="sticky top-0 bg-[#F5F5F5]/95 backdrop-blur-md pt-2 pb-4 z-20 border-b border-gray-200 shadow-sm">
      <div className="px-6 w-full">
        <div className="flex justify-between items-center mb-2">
          <div className="flex flex-col gap-0.5 max-w-[70%]">
            <span className="text-[9px] text-gray-400 font-bold uppercase tracking-wider">Productor</span>
            <h1 className="font-bold text-gray-900 text-sm truncate">{nombreProductor}</h1>
          </div>
          <div className="text-right">
            <div className="flex items-center justify-end gap-1.5">
              <span className={`text-xs font-black ${todosCompletos ? 'text-[#03A64A]' : 'text-gray-700'}`}>
                {totalRespondidos} / {totalIndicadores}
              </span>
            </div>
            {autoSaveMsg && (
              <p className="text-[9px] text-green-600 font-bold animate-pulse">{autoSaveMsg}</p>
            )}
          </div>
        </div>
        
        <div className="w-full bg-gray-200 h-2 rounded-full overflow-hidden shadow-inner">
          <div
            className={`h-full transition-all duration-700 ${todosCompletos ? 'bg-[#03A64A]' : 'bg-blue-500 shadow-[0_0_10px_rgba(59,130,246,0.5)]'}`}
            style={{ width: `${progreso}%` }}
          ></div>
        </div>
        
        {pendingCount > 0 && (
          <p className="text-[9px] text-amber-700 mt-1.5 font-medium flex items-center gap-1">
            <span className="animate-spin-slow">⏳</span> {pendingCount} cambios por sincronizar
          </p>
        )}
      </div>
    </header>

  );
}
