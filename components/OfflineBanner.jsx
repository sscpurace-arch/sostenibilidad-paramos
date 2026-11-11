'use client';
import { useState, useEffect } from 'react';
import { subscribe, getState, syncQueue, retryFailed, descartarFallidos, descartarFalloGuardado } from '@/lib/sync-engine';
import { subscribeFotos, syncFotos, retryFotosFallidas } from '@/lib/foto-sync';

// Botones del banner: altura mínima de 36 px y letra legible. Antes medían
// ~20 px con letra de 10 px, difíciles de tocar con guantes o al sol.
const BOTON = 'min-h-[36px] px-4 rounded-full text-xs font-bold uppercase transition-colors';

// Por qué los cambios esperan, cuando no es culpa de ningún registro
function motivoEspera(colaEnEspera) {
  if (colaEnEspera === 'sin-respuesta') return 'El servidor no responde (señal débil). Se reintenta solo; tus datos están guardados en el celular.';
  if (colaEnEspera === 'sesion') return 'Tu sesión venció. Cierra sesión y vuelve a entrar con tu correo para que suban. Tus datos siguen guardados en el celular.';
  return null;
}

export default function OfflineBanner() {
  const [state, setState] = useState(getState());
  const [isOnline, setIsOnline] = useState(true);
  const [isMock, setIsMock] = useState(false);
  const [fotos, setFotos] = useState({ subiendo: false, pendientes: 0, fallidas: 0 });
  const [descartando, setDescartando] = useState(false);

  // Borra de la cola lo que no se pudo subir. Los datos siguen en el
  // celular; solo deja de intentarse subirlos.
  const handleDescartar = async () => {
    const n = state.failedCount;
    const ok = window.confirm(
      `¿Dejar de intentar subir ${n} ${n === 1 ? 'cambio' : 'cambios'}?` + '\n\n' +
      'Lo que ves en este celular no cambia, pero esos cambios NO llegarán al servidor. Si no estás seguro, toca "Cancelar" y entra a "Ver detalle".'
    );
    if (!ok) return;
    setDescartando(true);
    try { await descartarFallidos(); } finally { setDescartando(false); }
  };

  useEffect(() => {
    // Detectar modo prueba
    setIsMock(!!localStorage.getItem('mock-user-session'));

    setState(getState());
    const unsub = subscribe(setState);
    const unsubFotos = subscribeFotos(setFotos);

    setIsOnline(navigator.onLine);
    const handleOnline = () => setIsOnline(true);
    const handleOffline = () => setIsOnline(false);

    window.addEventListener('online', handleOnline);
    window.addEventListener('offline', handleOffline);

    return () => {
      unsub();
      unsubFotos();
      window.removeEventListener('online', handleOnline);
      window.removeEventListener('offline', handleOffline);
    };
  }, []);

  // Lo último que marcó el técnico NO quedó en el celular (sin espacio, base
  // bloqueada). Es lo más grave que puede pasar en campo: va primero y se
  // muestra en cualquier modo, con o sin señal.
  const avisoGuardado = state.falloGuardado ? (
    <div role="alert" className="py-2 px-4 text-sm font-bold text-white bg-acento-rojo shadow-md flex flex-col gap-2">
      <span className="leading-snug">⚠ {state.falloGuardado}</span>
      <button
        onClick={() => descartarFalloGuardado()}
        className={`${BOTON} self-start bg-white text-acento-rojo hover:bg-red-50`}
      >
        Entendido
      </button>
    </div>
  ) : null;

  // Modo prueba: banner fijo informativo, sin cola de sync
  if (isMock) {
    return (
      <div className="flex flex-col">
        {avisoGuardado}
        <div className="text-center py-2 px-4 text-xs font-bold text-amber-900 bg-amber-300 shadow-md flex items-center justify-center gap-2">
          <span className="w-2 h-2 rounded-full bg-amber-600 animate-pulse" />
          Modo Prueba — Los datos no se guardan en el sistema real
        </div>
      </div>
    );
  }

  // Sin conexión
  if (!isOnline) {
    return (
      <div className="flex flex-col">
        {avisoGuardado}
        <div className="text-center py-2 px-4 text-xs font-bold text-white bg-red-500 shadow-md">
          {state.pendingCount > 0
            ? `⏳ ${state.pendingCount} ${state.pendingCount === 1 ? 'cambio guardado' : 'cambios guardados'} en el celular — subirán solos cuando haya señal`
            : '📡 Sin señal — puedes seguir trabajando, todo se guarda en el celular'}
        </div>
        {fotos.pendientes > 0 && (
          <div className="text-center py-1.5 px-4 text-xs font-bold text-white bg-red-600 shadow-md">
            📷 {fotos.pendientes} {fotos.pendientes === 1 ? 'foto guardada' : 'fotos guardadas'} en el celular, sin subir
          </div>
        )}
        {state.seedFailed && (
          <div className="text-center py-1.5 px-4 text-xs font-bold text-white bg-red-700 shadow-md">
            Sin datos locales — conéctate una vez para descargar la base
          </div>
        )}
      </div>
    );
  }

  // Banners de errores aunque haya conexión
  const hasIssues = state.failedCount > 0 || state.seedFailed || state.isSyncing || state.pendingCount > 0
    || fotos.pendientes > 0 || fotos.fallidas > 0 || fotos.subiendo || !!avisoGuardado;
  if (!hasIssues) return null;

  const espera = !state.isSyncing && state.pendingCount > 0 ? motivoEspera(state.colaEnEspera) : null;

  return (
    <div className="flex flex-col">
      {avisoGuardado}

      {/* Sincronizando o pendientes */}
      {(state.isSyncing || state.pendingCount > 0) && (
        <div className="py-2 px-4 text-xs font-bold text-white bg-amber-500 shadow-md flex flex-col gap-1.5">
          <div className="flex items-center justify-between gap-3">
            <div className="flex items-center flex-1">
              {state.isSyncing ? (
                <span className="flex items-center gap-2">
                  <svg className="animate-spin h-4 w-4 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                    <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" />
                    <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z" />
                  </svg>
                  Subiendo {state.pendingCount} {state.pendingCount === 1 ? 'cambio' : 'cambios'}…
                </span>
              ) : (
                <span>⏳ {state.pendingCount} {state.pendingCount === 1 ? 'cambio pendiente' : 'cambios pendientes'} de subir</span>
              )}
            </div>
            {!state.isSyncing && state.pendingCount > 0 && (
              <button
                onClick={() => syncQueue()}
                className={`${BOTON} bg-white text-amber-700 hover:bg-amber-50`}
              >
                Subir ahora
              </button>
            )}
          </div>
          {espera && (
            <span className="font-normal text-[12px] leading-snug">{espera}</span>
          )}
        </div>
      )}

      {/* Cambios que fallaron. Se muestra el motivo real: sin él, "no se
          pudieron subir" no le dice a nadie qué hacer, y el usuario reintenta
          en vano. */}
      {state.failedCount > 0 && (
        <div className="py-2 px-4 text-xs font-bold text-amber-900 bg-amber-200 flex flex-col gap-1.5">
          <span>⚠ {state.failedCount} {state.failedCount === 1 ? 'cambio no se pudo subir' : 'cambios no se pudieron subir'} (siguen guardados en el celular)</span>

          {/* Motivos agrupados: el usuario tiene que saber POR QUÉ para decidir */}
          {(state.failedReasons?.length > 0 ? state.failedReasons : (state.lastError ? [{ texto: state.lastError, n: state.failedCount }] : [])).map((m) => (
            <span key={m.texto} className="font-normal text-[12px] text-amber-900/90 leading-snug break-words">
              <span className="font-black">{m.n}×</span> {m.texto}
            </span>
          ))}

          <div className="flex flex-wrap items-center gap-2 mt-0.5">
            <button
              onClick={() => retryFailed()}
              className={`${BOTON} bg-amber-700 text-white hover:bg-amber-800`}
            >
              Reintentar
            </button>
            <button
              onClick={handleDescartar}
              disabled={descartando}
              className={`${BOTON} bg-white text-amber-800 border border-amber-400 hover:bg-amber-50 disabled:opacity-60`}
            >
              {descartando ? 'Descartando…' : 'Descartar'}
            </button>
            <a href="/diagnostico" className="ml-auto min-h-[36px] flex items-center font-normal text-xs underline text-amber-900/80">
              Ver detalle
            </a>
          </div>
        </div>
      )}

      {/* Fotos: van por su propia cola, así que se cuentan aparte */}
      {(fotos.subiendo || fotos.pendientes > 0) && (
        <div className="py-2 px-4 text-xs font-bold text-white bg-amber-500 shadow-md flex items-center justify-between gap-3">
          <span className="flex-1">
            {fotos.subiendo
              ? `📷 Subiendo fotos… (${fotos.pendientes} por subir)`
              : `📷 ${fotos.pendientes} ${fotos.pendientes === 1 ? 'foto pendiente' : 'fotos pendientes'}`}
          </span>
          {!fotos.subiendo && (
            <button
              onClick={() => syncFotos()}
              className={`${BOTON} bg-white text-amber-700 hover:bg-amber-50`}
            >
              Subir ahora
            </button>
          )}
        </div>
      )}

      {fotos.fallidas > 0 && (
        <div className="py-1.5 px-4 text-xs font-bold text-amber-900 bg-amber-200 flex items-center justify-between gap-3">
          <span>⚠ {fotos.fallidas} {fotos.fallidas === 1 ? 'foto no se pudo subir' : 'fotos no se pudieron subir'}</span>
          <button
            onClick={() => retryFotosFallidas()}
            className={`${BOTON} bg-amber-700 text-white hover:bg-amber-800`}
          >
            Reintentar
          </button>
        </div>
      )}

      {/* Sin datos semilla */}
      {state.seedFailed && (
        <div className="text-center py-1.5 px-4 text-xs font-bold text-white bg-red-600">
          Sin datos locales — conéctate una vez para descargar la base
        </div>
      )}
    </div>
  );
}
