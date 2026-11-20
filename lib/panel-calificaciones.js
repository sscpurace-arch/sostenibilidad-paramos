/**
 * panel-calificaciones — datos y agrupaciones de los paneles de calificaciones
 * (administrador: /admin; técnico: /mis-calificaciones).
 *
 * Una "fila" es una evaluación con su promedio ya calculado:
 *   { id, fecha, estado, tecnico_id, tecnico, productor_id, productor, cedula,
 *     vereda, municipio, promedio (número|null), dimensiones { [nombre]: número } }
 *
 * Con señal las filas las arma la base (función panel_calificaciones, ver
 * supabase/migrations/20261119_panel_calificaciones.sql): el navegador no
 * puede bajar las ~8.000 respuestas porque el servidor corta en 1.000 filas.
 * Sin señal, el técnico ve lo que tiene en el celular (IndexedDB), con el
 * mismo criterio de promedio (lib/validation.js).
 */
import { db, DIMENSION_COLORS } from '@/lib/db-offline';
import { promedioDimension, promedioGlobal } from '@/lib/validation';

export const DIMENSIONES = Object.keys(DIMENSION_COLORS);

/** Texto sin tildes ni mayúsculas, para juntar "Paletará" y "paletara". */
function normalizar(valor) {
  return String(valor ?? '')
    .normalize('NFD').replace(/[̀-ͯ]/g, '')
    .toLowerCase().replace(/\s+/g, ' ').trim();
}

function redondear(n) {
  return typeof n === 'number' && !isNaN(n) ? Math.round(n * 100) / 100 : null;
}

function promedioDe(lista) {
  const v = lista.filter(n => typeof n === 'number' && !isNaN(n));
  return v.length ? v.reduce((a, b) => a + b, 0) / v.length : null;
}

/** Año de una fecha ('2024-06-15 12:00:00+00', ISO o 'AAAA-MM-DD'). */
export function anioDe(fecha) {
  const a = String(fecha || '').slice(0, 4);
  return /^\d{4}$/.test(a) ? a : null;
}

// ─── Carga ──────────────────────────────────────────────────────────────────

/** Servidor: las filas ya calculadas. Lanza si no hay señal o no hay permiso. */
export async function cargarDelServidor(supabase) {
  const { data, error } = await supabase.rpc('panel_calificaciones');
  if (error || !data) throw error || new Error('Sin respuesta del servidor');
  return {
    origen: 'servidor',
    esAdmin: !!data.es_admin,
    evaluaciones: (data.evaluaciones || []).map(e => ({
      ...e,
      promedio: e.promedio != null ? Number(e.promedio) : null,
      dimensiones: Object.fromEntries(
        Object.entries(e.dimensiones || {}).map(([k, v]) => [k, Number(v)])
      ),
    })),
    productores: data.productores || [],
  };
}

/**
 * Celular: las evaluaciones del técnico que están en IndexedDB.
 * @param {string|null} tecnicoId  null en modo prueba: se muestran todas las locales
 * @param {boolean} incluirPruebas true en modo prueba (sus evaluaciones son es_prueba)
 */
export async function cargarDelCelular(tecnicoId, incluirPruebas = false) {
  let evs = tecnicoId
    ? await db.evaluaciones.where('tecnico_id').equals(tecnicoId).toArray()
    : await db.evaluaciones.toArray();
  if (!incluirPruebas) evs = evs.filter(e => !e.es_prueba);

  const ids = evs.map(e => e.id);
  const [indicadores, productores, respuestas] = await Promise.all([
    db.indicadores.toArray(),
    db.productores.toArray(),
    ids.length ? db.respuestas_indicadores.where('evaluacion_id').anyOf(ids).toArray() : [],
  ]);

  const dimensiones = [...new Set(indicadores.map(i => i.dimension).filter(Boolean))];
  const prodPorId = new Map(productores.map(p => [p.id, p]));
  const detallesPorEval = new Map();
  for (const r of respuestas) {
    if (!detallesPorEval.has(r.evaluacion_id)) detallesPorEval.set(r.evaluacion_id, {});
    detallesPorEval.get(r.evaluacion_id)[r.indicador_id] = { valor: r.valor, no_aplica: r.no_aplica };
  }

  const filas = evs.map(e => {
    const detalles = detallesPorEval.get(e.id) || {};
    const dims = {};
    for (const d of dimensiones) {
      const p = promedioDimension(indicadores, detalles, d);
      if (p != null) dims[d] = redondear(p);
    }
    const p = prodPorId.get(e.finca_id);
    return {
      id: e.id,
      fecha: e.fecha,
      estado: e.estado,
      tecnico_id: e.tecnico_id,
      tecnico: e.tecnico_nombre || null,
      productor_id: e.finca_id,
      productor: p?.nombre_completo || null,
      cedula: p?.cedula || null,
      vereda: p?.vereda || null,
      municipio: p?.municipio || null,
      promedio: redondear(promedioGlobal(dims)),
      dimensiones: dims,
    };
  }).sort((a, b) => String(b.fecha || '').localeCompare(String(a.fecha || '')));

  return {
    origen: 'celular',
    esAdmin: false,
    evaluaciones: filas,
    productores: productores.map(p => ({ id: p.id, vereda: p.vereda, municipio: p.municipio })),
  };
}

// ─── Filtros y agrupaciones ─────────────────────────────────────────────────

/** Criterios: { estado: 'todas'|'enviada'|'borrador', anio: ''|'2026', tecnico: ''|id, municipio: ''|nombre } */
export function filtrar(filas, { estado = 'todas', anio = '', tecnico = '', municipio = '' } = {}) {
  return filas.filter(f => {
    if (estado !== 'todas' && f.estado !== estado) return false;
    if (anio && anioDe(f.fecha) !== anio) return false;
    if (tecnico && f.tecnico_id !== tecnico) return false;
    if (municipio && normalizar(f.municipio) !== normalizar(municipio)) return false;
    return true;
  });
}

/** Cifras de un conjunto de evaluaciones. Los promedios salen solo de las enviadas. */
export function resumir(filas) {
  const enviadas = filas.filter(f => f.estado === 'enviada');
  const conPromedio = enviadas.filter(f => typeof f.promedio === 'number');
  const dimensiones = {};
  for (const d of DIMENSIONES) {
    const p = promedioDe(conPromedio.map(f => f.dimensiones?.[d]));
    if (p != null) dimensiones[d] = redondear(p);
  }
  return {
    total: filas.length,
    enviadas: enviadas.length,
    borradores: filas.filter(f => f.estado === 'borrador').length,
    productores: new Set(enviadas.map(f => f.productor_id).filter(Boolean)).size,
    promedio: redondear(promedioDe(conPromedio.map(f => f.promedio))),
    dimensiones,
  };
}

/**
 * Agrupa las evaluaciones por 'tecnico' | 'vereda' | 'municipio'.
 * Para vereda y municipio agrega la cobertura: productores con evaluación
 * enviada sobre el total de productores de ese lugar.
 */
export function agrupar(filas, campo, productores = []) {
  const grupos = new Map();
  const nombres = new Map(); // clave normalizada → nombre más frecuente
  const conteoNombres = new Map();

  for (const f of filas) {
    const crudo = f[campo];
    const clave = normalizar(crudo) || '(sin dato)';
    if (!grupos.has(clave)) grupos.set(clave, []);
    grupos.get(clave).push(f);
    const etiqueta = String(crudo ?? '').trim();
    if (etiqueta) {
      const k = `${clave}|${etiqueta}`;
      conteoNombres.set(k, (conteoNombres.get(k) || 0) + 1);
      const actual = nombres.get(clave);
      if (!actual || conteoNombres.get(k) > (conteoNombres.get(`${clave}|${actual}`) || 0)) nombres.set(clave, etiqueta);
    }
  }

  const universo = new Map();
  if (campo === 'vereda' || campo === 'municipio') {
    for (const p of productores) {
      const clave = normalizar(p[campo]) || '(sin dato)';
      universo.set(clave, (universo.get(clave) || 0) + 1);
    }
  }

  return [...grupos.entries()].map(([clave, lista]) => {
    const r = resumir(lista);
    return {
      clave,
      nombre: nombres.get(clave) || (campo === 'tecnico' ? 'Sin técnico registrado' : 'Sin dato'),
      ...r,
      universo: universo.has(clave) ? universo.get(clave) : null,
      evaluaciones: lista,
    };
  });
}

export const ORDENES = {
  total: { etiqueta: 'Más evaluaciones', fn: (a, b) => b.total - a.total || a.nombre.localeCompare(b.nombre, 'es') },
  promedio: { etiqueta: 'Mejor promedio', fn: (a, b) => (b.promedio ?? -1) - (a.promedio ?? -1) || b.total - a.total },
  nombre: { etiqueta: 'A–Z', fn: (a, b) => a.nombre.localeCompare(b.nombre, 'es') },
};

// ─── CSV ────────────────────────────────────────────────────────────────────

/** CSV (con BOM para que Excel respete las tildes) de las evaluaciones que se ven. */
export function aCsv(filas) {
  const cols = ['Fecha', 'Técnico', 'Productor', 'Cédula', 'Vereda', 'Municipio', 'Estado', 'Promedio', ...DIMENSIONES];
  const celda = v => {
    const s = v == null ? '' : String(v);
    return /[",\n;]/.test(s) ? `"${s.replace(/"/g, '""')}"` : s;
  };
  const lineas = filas.map(f => [
    String(f.fecha || '').slice(0, 10), f.tecnico, f.productor, f.cedula, f.vereda, f.municipio,
    f.estado === 'enviada' ? 'Enviada' : 'Borrador', f.promedio,
    ...DIMENSIONES.map(d => f.dimensiones?.[d]),
  ].map(celda).join(','));
  return '﻿' + [cols.map(celda).join(','), ...lineas].join('\r\n');
}
