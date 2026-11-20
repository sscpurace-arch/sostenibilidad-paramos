'use client';
import { useMemo, useState } from 'react';
import { abrirPantalla } from '@/lib/navegar';
import { fechaLegible } from '@/lib/pdf-utils';
import { seguimiento } from '@/lib/panel-calificaciones';

/**
 * Resumen de seguimiento, encima del panel de calificaciones:
 *   - Por técnico: cuántas visitas enviadas, cuántos productores por completar
 *     y cuántas visitas enviadas sin fotos (solo el administrador ve a todos).
 *   - Productores por completar: con borrador y sin visita enviada ese año.
 *   - Visitas enviadas sin fotos en el servidor.
 * Tocar un productor abre su perfil. Solo lee lo que recibe; no cambia datos.
 */

const TOTAL_INDICADORES = 29;

function irAlPerfil(productorId) {
  if (productorId) abrirPantalla(`/calificacion/nueva?productor=${encodeURIComponent(productorId)}`);
}

function Seccion({ titulo, cuenta, color, abierta, onAlternar, children }) {
  return (
    <div className="flex flex-col gap-2">
      <button
        type="button"
        onClick={onAlternar}
        aria-expanded={abierta}
        className="flex items-center justify-between gap-2 text-left min-h-[36px]"
      >
        <span className="text-[10px] font-black uppercase tracking-widest" style={{ color }}>
          {titulo} <span className="tabular-nums">({cuenta})</span>
        </span>
        <span className="text-[9px] text-white/35">{abierta ? 'Ocultar ▲' : 'Ver ▼'}</span>
      </button>
      {abierta && children}
    </div>
  );
}

function FilaProductor({ f, mostrarTecnico, detalle }) {
  return (
    <button
      type="button"
      onClick={() => irAlPerfil(f.productor_id)}
      className="flex items-center gap-3 bg-white/5 hover:bg-white/10 active:bg-white/15 rounded-xl px-3 py-2.5 w-full text-left transition-colors min-h-[44px]"
    >
      <div className="min-w-0 flex-1">
        <p className="text-sm font-bold text-white truncate">{f.productor || 'Productor sin nombre'}</p>
        <p className="text-[10px] text-white/45 truncate">
          {[f.vereda, f.municipio].filter(Boolean).join(' · ') || 'Sin vereda'}
          {mostrarTecnico && ` · ${f.tecnico || 'sin técnico'}`}
          {` · ${fechaLegible(f.fecha, { mes: 'short' })}`}
        </p>
      </div>
      <div className="shrink-0 text-right">{detalle}</div>
      <span className="text-white/30" aria-hidden="true">›</span>
    </button>
  );
}

export default function ResumenSeguimiento({ filas, esAdmin }) {
  const s = useMemo(() => seguimiento(filas), [filas]);
  const [abiertas, setAbiertas] = useState(() => new Set(['completar']));
  const alternar = k => setAbiertas(prev => {
    const n = new Set(prev);
    n.has(k) ? n.delete(k) : n.add(k);
    return n;
  });

  const hayTecnicos = esAdmin && s.porTecnico.length > 0;
  if (s.porTecnico.length === 0 && s.porCompletar.length === 0) return null;

  return (
    <div className="card-glass p-4 flex flex-col gap-4">
      <div>
        <p className="text-[10px] font-black uppercase tracking-widest text-white/50">Seguimiento</p>
        <p className="text-[10px] text-white/35">
          Quién completó, qué falta por completar y qué visitas no tienen fotos.
        </p>
      </div>

      {hayTecnicos && (
        <div className="overflow-x-auto -mx-1 px-1">
          <table className="w-full text-left border-separate border-spacing-y-1.5">
            <thead>
              <tr className="text-[9px] font-black uppercase tracking-wider text-white/40">
                <th className="font-black pb-1">Técnico</th>
                <th className="font-black pb-1 text-right px-2">Enviadas</th>
                <th className="font-black pb-1 text-right px-2">Por completar</th>
                {s.sinFotos && <th className="font-black pb-1 text-right px-2">Sin fotos</th>}
              </tr>
            </thead>
            <tbody>
              {s.porTecnico.map(t => (
                <tr key={t.tecnico_id || t.nombre} className="bg-white/5">
                  <td className="text-sm font-bold text-white py-2 pl-3 rounded-l-xl">{t.nombre}</td>
                  <td className="text-right tabular-nums text-sm font-black text-pnn-verde px-2">{t.enviadas}</td>
                  <td className={`text-right tabular-nums text-sm font-black px-2 ${t.porCompletar ? 'text-acento-amarillo' : 'text-white/30'} ${s.sinFotos ? '' : 'pr-3 rounded-r-xl'}`}>
                    {t.porCompletar}
                  </td>
                  {s.sinFotos && (
                    <td className={`text-right tabular-nums text-sm font-black px-2 pr-3 rounded-r-xl ${t.sinFotos ? 'text-orange-300' : 'text-white/30'}`}>
                      {t.sinFotos}
                    </td>
                  )}
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}

      <Seccion
        titulo="Productores por completar"
        cuenta={s.porCompletar.length}
        color="#FFC800"
        abierta={abiertas.has('completar')}
        onAlternar={() => alternar('completar')}
      >
        {s.porCompletar.length === 0 ? (
          <p className="text-xs text-white/50 px-1">No hay productores con la evaluación a medias.</p>
        ) : (
          <div className="flex flex-col gap-2">
            {s.porCompletar.map(f => (
              <FilaProductor
                key={f.id}
                f={f}
                mostrarTecnico={esAdmin}
                detalle={
                  <>
                    <p className="text-sm font-black leading-none tabular-nums text-acento-amarillo">
                      {f.avance != null ? `${f.avance}/${TOTAL_INDICADORES}` : (f.conAvance ? 'con avance' : '—')}
                    </p>
                    <p className="text-[8px] font-bold uppercase tracking-wider text-white/40 mt-1">
                      {f.conAvance ? 'Borrador' : 'Sin respuestas'}
                      {f.repetidos > 0 && ` · +${f.repetidos} repetido${f.repetidos > 1 ? 's' : ''}`}
                    </p>
                  </>
                }
              />
            ))}
          </div>
        )}
      </Seccion>

      {s.sinFotos && (
        <Seccion
          titulo="Visitas enviadas sin fotos"
          cuenta={s.sinFotos.length}
          color="#FDBA74"
          abierta={abiertas.has('fotos')}
          onAlternar={() => alternar('fotos')}
        >
          {s.sinFotos.length === 0 ? (
            <p className="text-xs text-white/50 px-1">Todas las visitas enviadas tienen al menos una foto.</p>
          ) : (
            <>
              <p className="text-[10px] text-white/40 px-1 leading-snug">
                En el servidor no hay ninguna foto de estas visitas. Pueden estar sin subir en el celular
                del técnico: que abra la app con señal. Si no se tomaron, no hay nada que subir.
              </p>
              <div className="flex flex-col gap-2">
                {s.sinFotos.map(f => (
                  <FilaProductor key={f.id} f={f} mostrarTecnico={esAdmin}
                    detalle={<p className="text-[9px] font-black uppercase tracking-wider text-orange-300">0 fotos</p>} />
                ))}
              </div>
            </>
          )}
        </Seccion>
      )}
    </div>
  );
}
