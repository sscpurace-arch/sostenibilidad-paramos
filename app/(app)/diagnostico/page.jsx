'use client';
import { useState, useEffect } from 'react';
import { db } from '@/lib/db-offline';
import { getClient, retryFailed, syncQueue } from '@/lib/sync-engine';

/**
 * Pantalla de diagnóstico.
 *
 * Existe porque depurar a ciegas no funciona: el problema pasa en el celular
 * de campo, no aquí. Esta pantalla dice qué versión está corriendo el
 * dispositivo, qué hay atascado en la cola y —lo importante— PRUEBA cada
 * cambio atascado contra el servidor para traer el error real, en vez de
 * dejarlo escondido en la consola.
 *
 * Todo lo que hace es de solo lectura salvo dos botones explícitos.
 */
export default function DiagnosticoPage() {
  const [info, setInfo] = useState(null);
  const [pendientes, setPendientes] = useState([]);
  const [analizando, setAnalizando] = useState(false);
  const [resultados, setResultados] = useState({});
  const [mensaje, setMensaje] = useState(null);

  const cargar = async () => {
    const cola = await db.sync_queue.where('sync_pending').equals(1).toArray();

    let swEsperando = false;
    let swActivo = false;
    try {
      const reg = await navigator.serviceWorker?.getRegistration();
      swEsperando = !!reg?.waiting;
      swActivo = !!navigator.serviceWorker?.controller;
    } catch (e) { /* navegador sin service worker */ }

    let almacenamiento = null;
    try {
      const est = await navigator.storage?.estimate?.();
      if (est?.quota) {
        almacenamiento = `${Math.round(est.usage / 1048576)} MB de ${Math.round(est.quota / 1048576)} MB`;
      }
    } catch (e) { /* no disponible */ }

    setInfo({
      version: process.env.NEXT_PUBLIC_BUILD_ID || 'desconocida',
      swEsperando,
      swActivo,
      conexion: typeof navigator !== 'undefined' && navigator.onLine ? 'con internet' : 'sin internet',
      sesionReal: !!getClient(),
      almacenamiento,
      navegador: typeof navigator !== 'undefined' ? navigator.userAgent : '',
      productores: await db.productores.count(),
      evaluaciones: await db.evaluaciones.count(),
      respuestas: await db.respuestas_indicadores.count(),
    });
    setPendientes(cola);
  };

  useEffect(() => { cargar(); }, []);

  /**
   * Prueba cada cambio atascado contra el servidor, de a uno, y guarda el
   * error textual que devuelve. Es la única forma de saber por qué no suben.
   */
  const analizar = async () => {
    const supabase = getClient();
    if (!supabase) {
      setMensaje('Estás en modo prueba o sin sesión. Entra con tu correo para poder analizar.');
      return;
    }
    setAnalizando(true);
    setMensaje(null);
    const out = {};
    for (const item of pendientes) {
      if (item.payload?.es_prueba) { out[item.localId] = 'Marcado como prueba: no se sube (por diseño)'; continue; }
      try {
        if (item.operacion === 'DELETE') {
          const { error } = await supabase.from(item.tabla).delete().eq('id', item.payload.id);
          out[item.localId] = error ? error.message : 'OK — se puede borrar';
        } else {
          const { error } = await supabase
            .from(item.tabla)
            .upsert([item.payload], { onConflict: 'id', ignoreDuplicates: false });
          out[item.localId] = error ? error.message : 'OK — subió bien';
          if (!error) await db.sync_queue.update(item.localId, { sync_pending: 0, ultimo_error: null });
        }
      } catch (e) {
        out[item.localId] = String(e?.message || e);
      }
      setResultados({ ...out });
    }
    setAnalizando(false);
    await cargar();
  };

  /**
   * Borra el service worker y los cachés de archivos para obligar al celular a
   * bajar la versión nueva. NO toca IndexedDB: las evaluaciones, productores y
   * fotos guardados en el dispositivo se conservan intactos.
   */
  const forzarActualizacion = async () => {
    setMensaje('Actualizando…');
    try {
      const regs = await navigator.serviceWorker.getRegistrations();
      await Promise.all(regs.map(r => r.unregister()));
      const claves = await caches.keys();
      await Promise.all(claves.map(k => caches.delete(k)));
    } catch (e) { /* seguir de todos modos */ }
    window.location.href = '/?v=' + Date.now();
  };

  const copiar = async () => {
    const texto = [
      '--- Diagnóstico App Páramos ---',
      `Versión: ${info?.version}`,
      `Service worker activo: ${info?.swActivo} · esperando: ${info?.swEsperando}`,
      `Conexión: ${info?.conexion} · sesión real: ${info?.sesionReal}`,
      `Almacenamiento: ${info?.almacenamiento || 'n/d'}`,
      `Local: ${info?.productores} productores, ${info?.evaluaciones} evaluaciones, ${info?.respuestas} respuestas`,
      `Navegador: ${info?.navegador}`,
      `Cambios pendientes: ${pendientes.length}`,
      ...pendientes.map(p =>
        `  · ${p.tabla} (${p.operacion || 'UPSERT'}) intentos=${p.error_count || 0} :: ${resultados[p.localId] || p.ultimo_error || 'sin analizar'}`
      ),
    ].join('\n');
    try {
      await navigator.clipboard.writeText(texto);
      setMensaje('Diagnóstico copiado. Pégalo en el chat.');
    } catch (e) {
      setMensaje('No se pudo copiar. Toma una captura de pantalla.');
    }
  };

  const porTabla = pendientes.reduce((acc, p) => {
    acc[p.tabla] = (acc[p.tabla] || 0) + 1;
    return acc;
  }, {});

  return (
    <div className="flex flex-col gap-4 pb-24">
      <h1 className="text-2xl font-bold text-white">Diagnóstico</h1>

      {mensaje && (
        <div className="bg-blue-50 border border-blue-200 rounded-xl p-3 text-sm text-blue-900">{mensaje}</div>
      )}

      <div className="bg-white rounded-xl p-4 shadow-sm flex flex-col gap-2">
        <h2 className="font-bold text-gray-800 text-sm">Estado de la app</h2>
        <Fila k="Versión instalada" v={info?.version} />
        <Fila k="Versión nueva esperando" v={info?.swEsperando ? 'SÍ — toca Forzar actualización' : 'no'} />
        <Fila k="Conexión" v={info?.conexion} />
        <Fila k="Sesión" v={info?.sesionReal ? 'real (sincroniza)' : 'prueba o sin sesión (NO sincroniza)'} />
        <Fila k="Almacenamiento" v={info?.almacenamiento || 'n/d'} />
        <Fila k="Datos en el celular" v={`${info?.productores ?? '…'} productores · ${info?.evaluaciones ?? '…'} evaluaciones`} />
      </div>

      <button
        onClick={forzarActualizacion}
        className="w-full h-14 rounded-xl bg-[#049DD9] text-white font-bold text-sm active:scale-95 transition-all"
      >
        Forzar actualización a la última versión
      </button>
      <p className="text-[11px] text-white/50 -mt-2 leading-snug px-1">
        Borra la versión guardada y baja la más reciente. No borra tus productores,
        evaluaciones ni fotos: eso queda intacto en el celular.
      </p>

      <div className="bg-white rounded-xl p-4 shadow-sm flex flex-col gap-3">
        <h2 className="font-bold text-gray-800 text-sm">
          Cambios sin subir: {pendientes.length}
        </h2>
        {Object.keys(porTabla).length > 0 && (
          <p className="text-xs text-gray-500">
            {Object.entries(porTabla).map(([t, n]) => `${n} en ${t}`).join(' · ')}
          </p>
        )}

        {pendientes.length > 0 && (
          <>
            <div className="flex gap-2">
              <button
                onClick={analizar}
                disabled={analizando}
                className="flex-1 h-12 rounded-lg bg-[#03A64A] text-white font-bold text-xs disabled:opacity-60"
              >
                {analizando ? 'Analizando…' : '¿Por qué no suben?'}
              </button>
              <button
                onClick={async () => { await retryFailed(); await syncQueue(); await cargar(); }}
                className="flex-1 h-12 rounded-lg bg-gray-100 text-gray-700 font-bold text-xs border border-gray-200"
              >
                Reintentar
              </button>
            </div>

            <div className="flex flex-col gap-2 max-h-80 overflow-y-auto">
              {pendientes.map(p => {
                const r = resultados[p.localId] || p.ultimo_error;
                const ok = r && r.startsWith('OK');
                return (
                  <div key={p.localId} className="border border-gray-100 rounded-lg p-2 text-[11px]">
                    <p className="font-bold text-gray-700">
                      {p.tabla} · {p.operacion || 'UPSERT'} · intentos {p.error_count || 0}
                    </p>
                    <p className="text-gray-400 font-mono text-[10px] break-all">{p.payload?.id}</p>
                    {r && (
                      <p className={`mt-1 leading-snug ${ok ? 'text-green-700' : 'text-red-700'}`}>{r}</p>
                    )}
                  </div>
                );
              })}
            </div>
          </>
        )}

        <button
          onClick={copiar}
          className="w-full h-11 rounded-lg bg-gray-100 text-gray-700 font-bold text-xs border border-gray-200"
        >
          Copiar diagnóstico para enviar
        </button>
      </div>
    </div>
  );
}

function Fila({ k, v }) {
  return (
    <div className="flex justify-between gap-3 text-xs">
      <span className="text-gray-500 shrink-0">{k}</span>
      <span className="text-gray-800 font-medium text-right break-words">{v ?? '…'}</span>
    </div>
  );
}
