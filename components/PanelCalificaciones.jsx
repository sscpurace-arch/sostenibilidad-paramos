'use client';
import { useMemo, useState } from 'react';
import { DIMENSION_COLORS } from '@/lib/db-offline';
import { fechaLegible } from '@/lib/pdf-utils';
import {
  DIMENSIONES, ORDENES, agrupar, anioDe, aCsv, filtrar, resumir,
} from '@/lib/panel-calificaciones';

/**
 * Panel de calificaciones, compartido por el administrador (todas las
 * evaluaciones, organizadas por técnico / vereda / municipio) y por cada
 * técnico (solo las suyas). Quién ve qué lo decide la base de datos
 * (panel_calificaciones); este componente solo presenta lo que recibe.
 *
 * @param {object}   datos      { evaluaciones, productores, origen }
 * @param {boolean}  esAdmin    agrega filtro y agrupación por técnico, y el CSV
 * @param {function} [onAbrir]  (evaluacion) => void; si falta, las filas no son botones
 * @param {function} [puedeAbrir] (evaluacion) => boolean
 */

const ESTADOS = [
  { id: 'todas', etiqueta: 'Todas' },
  { id: 'enviada', etiqueta: 'Enviadas' },
  { id: 'borrador', etiqueta: 'Borradores' },
];

function Kpi({ valor, etiqueta, color }) {
  return (
    <div className="card-glass flex-1 p-3 text-center">
      <p className="text-2xl font-black leading-none" style={{ color }}>{valor}</p>
      <p className="text-[9px] text-white/50 font-semibold uppercase tracking-wider leading-tight mt-1">{etiqueta}</p>
    </div>
  );
}

function Chip({ activo, onClick, children }) {
  return (
    <button
      type="button"
      onClick={onClick}
      aria-pressed={activo}
      className={`min-h-[36px] px-3 rounded-full text-[11px] font-bold border transition-colors whitespace-nowrap ${
        activo
          ? 'bg-pnn-verde/25 text-pnn-verde border-pnn-verde/50'
          : 'bg-white/5 text-white/60 border-white/10 hover:bg-white/10'
      }`}
    >
      {children}
    </button>
  );
}

function Selector({ valor, onChange, etiqueta, opciones }) {
  return (
    <label className="flex-1 min-w-[120px]">
      <span className="block text-[9px] font-black uppercase tracking-wider text-white/40 mb-1 px-1">{etiqueta}</span>
      <select
        value={valor}
        onChange={e => onChange(e.target.value)}
        // 16px: por debajo de eso iOS hace zoom al enfocar el campo
        className="w-full bg-white/5 border border-white/10 text-white text-base rounded-lg px-2 py-2"
      >
        {opciones.map(o => (
          <option key={o.valor} value={o.valor} className="bg-[#0d2a1c]">{o.etiqueta}</option>
        ))}
      </select>
    </label>
  );
}

/** Barra de 0 a 5 con el promedio al lado. */
function BarraPromedio({ valor, color = '#03A64A' }) {
  const pct = typeof valor === 'number' ? Math.min(100, Math.max(0, (valor / 5) * 100)) : 0;
  return (
    <div className="flex items-center gap-2">
      <div className="flex-1 h-2 rounded-full bg-white/10 overflow-hidden">
        <div className="h-full rounded-full" style={{ width: `${pct}%`, backgroundColor: color }} />
      </div>
      <span className="w-8 text-right text-sm font-black text-white tabular-nums">
        {typeof valor === 'number' ? valor.toFixed(1) : '—'}
      </span>
    </div>
  );
}

function Dimensiones({ valores }) {
  const hay = DIMENSIONES.filter(d => typeof valores?.[d] === 'number');
  if (hay.length === 0) return null;
  return (
    <div className="grid grid-cols-2 gap-x-4 gap-y-2">
      {hay.map(d => (
        <div key={d}>
          <p className="text-[9px] font-bold uppercase tracking-wide truncate" style={{ color: DIMENSION_COLORS[d] }}>{d}</p>
          <BarraPromedio valor={valores[d]} color={DIMENSION_COLORS[d]} />
        </div>
      ))}
    </div>
  );
}

function FilaEvaluacion({ ev, mostrarTecnico, onAbrir, puedeAbrir }) {
  const abrible = !!(onAbrir && puedeAbrir && puedeAbrir(ev));
  const contenido = (
    <>
      <div className="min-w-0 flex-1 text-left">
        <p className="text-sm font-bold text-white truncate">{ev.productor || 'Productor sin nombre'}</p>
        <p className="text-[10px] text-white/45 truncate">
          {[ev.vereda, ev.municipio].filter(Boolean).join(' · ') || 'Sin vereda'} · {fechaLegible(ev.fecha, { mes: 'short' })}
        </p>
        {mostrarTecnico && (
          <p className="text-[10px] text-white/35 truncate">Técnico: {ev.tecnico || 'sin registrar'}</p>
        )}
      </div>
      <div className="shrink-0 text-right">
        <p className="text-lg font-black leading-none text-pnn-verde tabular-nums">
          {ev.estado === 'enviada' && typeof ev.promedio === 'number' ? ev.promedio.toFixed(1) : '—'}
        </p>
        <span className={`inline-block mt-1 text-[8px] font-black uppercase tracking-wider px-1.5 py-0.5 rounded-full ${
          ev.estado === 'enviada' ? 'bg-pnn-verde/20 text-pnn-verde' : 'bg-acento-amarillo/20 text-acento-amarillo'
        }`}>
          {ev.estado === 'enviada' ? 'Enviada' : 'Borrador'}
        </span>
      </div>
    </>
  );
  const clases = 'flex items-center gap-3 bg-white/5 rounded-xl px-3 py-2.5 w-full';
  return abrible ? (
    <button type="button" onClick={() => onAbrir(ev)} className={`${clases} hover:bg-white/10 active:bg-white/15 transition-colors`}>
      {contenido}
    </button>
  ) : (
    <div className={clases}>{contenido}</div>
  );
}

export default function PanelCalificaciones({ datos, esAdmin = false, onAbrir, puedeAbrir }) {
  // Referencias estables: un `|| []` crearía un arreglo nuevo en cada render
  // y recalcularía todos los useMemo de abajo.
  const todas = useMemo(() => datos?.evaluaciones ?? [], [datos]);
  const productores = useMemo(() => datos?.productores ?? [], [datos]);

  const [vista, setVista] = useState(esAdmin ? 'tecnico' : 'lista');
  const [estado, setEstado] = useState('todas');
  const [anio, setAnio] = useState('');
  const [tecnico, setTecnico] = useState('');
  const [municipio, setMunicipio] = useState('');
  const [orden, setOrden] = useState('total');
  const [abiertos, setAbiertos] = useState(() => new Set());

  // Opciones de los filtros, sacadas de lo que realmente hay
  const anios = useMemo(
    () => [...new Set(todas.map(f => anioDe(f.fecha)).filter(Boolean))].sort().reverse(),
    [todas]
  );
  const tecnicos = useMemo(() => {
    const m = new Map();
    todas.forEach(f => { if (f.tecnico_id) m.set(f.tecnico_id, f.tecnico || 'Sin nombre'); });
    return [...m.entries()].sort((a, b) => a[1].localeCompare(b[1], 'es'));
  }, [todas]);
  const municipios = useMemo(() => {
    const vistos = new Map();
    todas.forEach(f => {
      const n = String(f.municipio || '').trim();
      if (n && !vistos.has(n.toLowerCase())) vistos.set(n.toLowerCase(), n);
    });
    return [...vistos.values()].sort((a, b) => a.localeCompare(b, 'es'));
  }, [todas]);

  const filas = useMemo(
    () => filtrar(todas, { estado, anio, tecnico, municipio }),
    [todas, estado, anio, tecnico, municipio]
  );
  const total = useMemo(() => resumir(filas), [filas]);

  const campo = vista === 'lista' ? null : vista;
  const grupos = useMemo(() => {
    if (!campo) return [];
    return agrupar(filas, campo, productores).sort(ORDENES[orden].fn);
  }, [filas, campo, productores, orden]);

  const alternar = clave => setAbiertos(prev => {
    const s = new Set(prev);
    s.has(clave) ? s.delete(clave) : s.add(clave);
    return s;
  });

  const descargarCsv = () => {
    const blob = new Blob([aCsv(filas)], { type: 'text/csv;charset=utf-8' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `calificaciones-${new Date().toISOString().slice(0, 10)}.csv`;
    document.body.appendChild(a);
    a.click();
    a.remove();
    setTimeout(() => URL.revokeObjectURL(url), 1000);
  };

  const vistas = esAdmin
    ? [['tecnico', 'Técnico'], ['vereda', 'Vereda'], ['municipio', 'Municipio'], ['lista', 'Lista']]
    : [['lista', 'Lista'], ['vereda', 'Vereda'], ['municipio', 'Municipio']];

  return (
    <div className="flex flex-col gap-4">
      {/* Totales del conjunto que se está viendo */}
      <div className="flex gap-3">
        <Kpi valor={total.total} etiqueta="Evaluaciones" color="#049DD9" />
        <Kpi valor={total.enviadas} etiqueta="Enviadas" color="#03A64A" />
        <Kpi valor={total.productores} etiqueta="Productores" color="#FFC800" />
      </div>

      <div className="card-glass p-4 flex flex-col gap-3">
        <div className="flex items-end justify-between">
          <div>
            <p className="text-[10px] font-black uppercase tracking-widest text-white/50">Sostenibilidad promedio</p>
            <p className="text-[10px] text-white/35">de las evaluaciones enviadas (sobre 5)</p>
          </div>
          <p className="text-4xl font-black text-white leading-none tabular-nums">
            {typeof total.promedio === 'number' ? total.promedio.toFixed(1) : '—'}
          </p>
        </div>
        <Dimensiones valores={total.dimensiones} />
        {total.borradores > 0 && (
          <p className="text-[10px] text-acento-amarillo/80 font-semibold">
            {total.borradores} {total.borradores === 1 ? 'borrador' : 'borradores'} sin enviar: no entran en los promedios.
          </p>
        )}
      </div>

      {/* Filtros */}
      <div className="card-glass p-3 flex flex-col gap-3">
        <div className="flex flex-wrap gap-2">
          {ESTADOS.map(e => (
            <Chip key={e.id} activo={estado === e.id} onClick={() => setEstado(e.id)}>{e.etiqueta}</Chip>
          ))}
        </div>
        <div className="flex flex-wrap gap-2">
          {anios.length > 1 && (
            <Selector valor={anio} onChange={setAnio} etiqueta="Año"
              opciones={[{ valor: '', etiqueta: 'Todos' }, ...anios.map(a => ({ valor: a, etiqueta: a }))]} />
          )}
          {esAdmin && tecnicos.length > 1 && (
            <Selector valor={tecnico} onChange={setTecnico} etiqueta="Técnico"
              opciones={[{ valor: '', etiqueta: 'Todos' }, ...tecnicos.map(([id, n]) => ({ valor: id, etiqueta: n }))]} />
          )}
          {municipios.length > 1 && (
            <Selector valor={municipio} onChange={setMunicipio} etiqueta="Municipio"
              opciones={[{ valor: '', etiqueta: 'Todos' }, ...municipios.map(m => ({ valor: m, etiqueta: m }))]} />
          )}
        </div>
      </div>

      {/* Cómo organizar */}
      <div className="flex flex-col gap-2">
        <div className="flex items-center justify-between gap-2">
          <div className="flex gap-1.5 overflow-x-auto">
            {vistas.map(([id, etiqueta]) => (
              <Chip key={id} activo={vista === id} onClick={() => setVista(id)}>
                {id === 'lista' ? etiqueta : `Por ${etiqueta.toLowerCase()}`}
              </Chip>
            ))}
          </div>
        </div>
        {campo && grupos.length > 1 && (
          <div className="flex gap-1.5 items-center overflow-x-auto">
            <span className="text-[9px] font-black uppercase tracking-wider text-white/35 shrink-0">Orden</span>
            {Object.entries(ORDENES).map(([id, o]) => (
              <button
                key={id}
                type="button"
                onClick={() => setOrden(id)}
                aria-pressed={orden === id}
                className={`min-h-[32px] px-2.5 rounded-lg text-[10px] font-bold whitespace-nowrap ${
                  orden === id ? 'bg-white/15 text-white' : 'text-white/45 hover:text-white/70'
                }`}
              >
                {o.etiqueta}
              </button>
            ))}
          </div>
        )}
      </div>

      {/* Resultado */}
      {filas.length === 0 ? (
        <div className="card-glass p-8 text-center">
          <p className="text-white/50 text-sm font-semibold">No hay calificaciones con estos filtros.</p>
          {(estado !== 'todas' || anio || tecnico || municipio) && (
            <button
              type="button"
              onClick={() => { setEstado('todas'); setAnio(''); setTecnico(''); setMunicipio(''); }}
              className="mt-3 text-xs font-bold text-pnn-azul-claro underline"
            >
              Quitar filtros
            </button>
          )}
        </div>
      ) : campo ? (
        <div className="flex flex-col gap-3">
          {grupos.map(g => {
            const abierto = abiertos.has(g.clave);
            return (
              <div key={g.clave} className="card-glass p-4 flex flex-col gap-3">
                <button
                  type="button"
                  onClick={() => alternar(g.clave)}
                  aria-expanded={abierto}
                  className="flex items-start gap-3 text-left w-full"
                >
                  <div className="min-w-0 flex-1">
                    <p className="text-sm font-black text-white leading-tight truncate">{g.nombre}</p>
                    <p className="text-[10px] text-white/45 mt-0.5">
                      {g.total} {g.total === 1 ? 'evaluación' : 'evaluaciones'}
                      {g.borradores > 0 && ` · ${g.borradores} sin enviar`}
                      {g.productores > 0 && ` · ${g.productores} ${g.productores === 1 ? 'productor' : 'productores'}`}
                    </p>
                    {g.universo != null && (
                      <p className="text-[10px] text-pnn-azul-claro/80 mt-0.5">
                        Cobertura: {Math.min(g.productores, g.universo)} de {g.universo} productores
                      </p>
                    )}
                  </div>
                  <div className="shrink-0 text-right">
                    <p className="text-2xl font-black text-pnn-verde leading-none tabular-nums">
                      {typeof g.promedio === 'number' ? g.promedio.toFixed(1) : '—'}
                    </p>
                    <p className="text-[9px] text-white/35 mt-1">{abierto ? 'Ocultar ▲' : 'Ver ▼'}</p>
                  </div>
                </button>
                <BarraPromedio valor={g.promedio} />
                {abierto && (
                  <>
                    <Dimensiones valores={g.dimensiones} />
                    <div className="flex flex-col gap-2 border-t border-white/[0.06] pt-3">
                      {g.evaluaciones.map(ev => (
                        <FilaEvaluacion key={ev.id} ev={ev} mostrarTecnico={esAdmin && campo !== 'tecnico'}
                          onAbrir={onAbrir} puedeAbrir={puedeAbrir} />
                      ))}
                    </div>
                  </>
                )}
              </div>
            );
          })}
        </div>
      ) : (
        <div className="flex flex-col gap-2">
          {filas.map(ev => (
            <FilaEvaluacion key={ev.id} ev={ev} mostrarTecnico={esAdmin} onAbrir={onAbrir} puedeAbrir={puedeAbrir} />
          ))}
        </div>
      )}

      {esAdmin && filas.length > 0 && (
        <button
          type="button"
          onClick={descargarCsv}
          className="w-full min-h-[44px] bg-white/5 hover:bg-white/10 border border-white/10 text-white/80 text-xs font-bold rounded-2xl"
        >
          Descargar {filas.length} {filas.length === 1 ? 'fila' : 'filas'} en CSV (Excel)
        </button>
      )}

      {datos?.origen === 'celular' && (
        <p className="text-center text-[10px] text-white/40 leading-snug px-4">
          Se muestra lo que hay guardado en este celular. Con internet y la sesión abierta se completa con lo que enviaste desde otros equipos.
        </p>
      )}
    </div>
  );
}
