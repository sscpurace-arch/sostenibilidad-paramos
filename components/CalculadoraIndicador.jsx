'use client';
import { useState, useMemo } from 'react';

/**
 * CalculadoraIndicador — hace en la app las cuentas que el técnico hacía a mano.
 *
 * Del taller del 31-jul-2026: calcular de pie, con lluvia y viento, es donde
 * entra el error aritmético, y además consume tiempo de la visita. Aquí se
 * pregunta lo fácil (litros al día, cuántos animales, cuántas hectáreas) y la
 * app aplica la fórmula y sugiere el puntaje según la banda oficial.
 *
 * Dos decisiones de diseño que vienen del documento de requerimientos:
 *  - La fórmula se muestra siempre, no se esconde en un manual. El objetivo
 *    declarado es que el evaluador la interiorice y con el tiempo pueda
 *    prescindir de la guía impresa.
 *  - Se guardan las ENTRADAS, no solo el resultado, para que el dato sea
 *    auditable y recalculable si una fórmula cambia.
 */

// ---------------------------------------------------------------------------
// Bandas oficiales (Anexo A de la matriz)
//
// Los rangos publicados tienen huecos: el ind. 25 no cubre 0,8-0,9 ni 1,0-1,1,
// y el 27 no cubre 2,0-2,5 %. Se cierran hacia la banda superior (favorable al
// productor) y queda anotado — el rediseño del ind. 25 ya estaba previsto para
// la v2.0 de la matriz.
// ---------------------------------------------------------------------------

function porBandas(bandas, valor) {
  for (const [umbral, puntaje] of bandas) {
    if (valor >= umbral) return puntaje;
  }
  return 1;
}

const UGG_KG = 450;   // 1 Unidad de Gran Ganado = 450 kg

export const CALCULADORAS = {
  // ---- 22 · Litros de leche / hectárea / año -------------------------------
  22: {
    icono: '🥛',
    titulo: 'Litros de leche por hectárea al año',
    formula: '(litros por día × 365) ÷ hectáreas en pastoreo',
    nota: 'Banda: Doble Propósito, trópico alto — la típica en fincas de páramo.',
    campos: [
      { key: 'litrosDia',  label: 'Litros por día (toda la finca)', placeholder: 'Ej: 40', decimal: true,  requerido: true },
      { key: 'vacas',      label: 'Vacas en ordeño',                placeholder: 'Ej: 8',  decimal: false },
      { key: 'hectareas',  label: 'Hectáreas en pastoreo',          placeholder: 'Ej: 3',  decimal: true,  requerido: true },
    ],
    calcular: ({ litrosDia, vacas, hectareas }) => {
      const valor = Math.round((litrosDia * 365) / hectareas);
      const detalle = [
        `${litrosDia} L/día`,
        vacas > 0 ? `${vacas} vacas en ordeño (${(litrosDia / vacas).toFixed(1)} L/vaca/día)` : null,
        `${hectareas} ha en pastoreo`,
      ].filter(Boolean);
      return { valor, texto: `${valor.toLocaleString('es-CO')} litros/ha/año`, detalle };
    },
    puntaje: (v) => porBandas([[2501, 5], [2001, 4], [1501, 3], [1001, 2]], v),
  },

  // ---- 25 · Carga animal (UGG/ha) -----------------------------------------
  25: {
    icono: '🐄',
    titulo: 'Carga animal por hectárea',
    formula: '(nº animales × peso promedio) ÷ 450 kg = UGG · luego UGG ÷ hectáreas',
    nota: 'Los pesos de referencia son editables: ajústalos a lo que se observa en el predio.',
    campos: [
      { key: 'adultos',    label: 'Adultos',          placeholder: '0', decimal: false, grupo: 'animales' },
      { key: 'pesoAdulto', label: 'kg c/u',           placeholder: '450', decimal: true, defecto: '450', grupo: 'animales', auxiliar: true },
      { key: 'jovenes',    label: 'Jóvenes',          placeholder: '0', decimal: false, grupo: 'animales' },
      { key: 'pesoJoven',  label: 'kg c/u',           placeholder: '250', decimal: true, defecto: '250', grupo: 'animales', auxiliar: true },
      { key: 'terneros',   label: 'Terneros',         placeholder: '0', decimal: false, grupo: 'animales' },
      { key: 'pesoTernero',label: 'kg c/u',           placeholder: '120', decimal: true, defecto: '120', grupo: 'animales', auxiliar: true },
      { key: 'hectareas',  label: 'Hectáreas en pastoreo', placeholder: 'Ej: 8', decimal: true, requerido: true },
    ],
    // Requiere al menos un animal y las hectáreas
    completo: (v) => v.hectareas > 0 && (v.adultos + v.jovenes + v.terneros) > 0,
    calcular: (v) => {
      const kg = v.adultos * v.pesoAdulto + v.jovenes * v.pesoJoven + v.terneros * v.pesoTernero;
      const ugg = kg / UGG_KG;
      const valor = ugg / v.hectareas;
      const cabezas = v.adultos + v.jovenes + v.terneros;
      return {
        valor,
        texto: `${valor.toFixed(2)} UGG/ha`,
        detalle: [
          `${cabezas} animales · ${kg.toLocaleString('es-CO')} kg`,
          `${ugg.toFixed(2)} UGG en ${v.hectareas} ha`,
        ],
      };
    },
    puntaje: (v) => porBandas([[1.51, 5], [1.1, 4], [0.9, 3], [0.7, 2]], v),
  },

  // ---- 27 · Tasa de mortalidad --------------------------------------------
  27: {
    icono: '📉',
    titulo: 'Tasa de mortalidad anual',
    formula: '(nº de muertes en el año ÷ total de animales) × 100',
    campos: [
      { key: 'muertes', label: 'Muertes en el último año', placeholder: 'Ej: 2',  decimal: false },
      { key: 'total',   label: 'Total de animales',        placeholder: 'Ej: 40', decimal: false, requerido: true },
    ],
    calcular: ({ muertes, total }) => {
      const valor = (muertes / total) * 100;
      return {
        valor,
        texto: `${valor.toFixed(1)} % de mortalidad anual`,
        detalle: [`${muertes} de ${total} animales`],
      };
    },
    // Acá menos es mejor: se evalúa al revés que las demás
    puntaje: (v) => (v < 2.5 ? 5 : v < 5 ? 4 : v < 7.5 ? 3 : v < 10 ? 2 : 1),
  },

  // ---- 28 · Intervalo entre partos ----------------------------------------
  28: {
    icono: '🗓',
    titulo: 'Intervalo entre partos',
    formula: 'promedio de meses transcurridos entre dos partos consecutivos',
    nota: 'Si se conocen las fechas, calcular el promedio de la finca antes de anotarlo.',
    campos: [
      { key: 'meses', label: 'Meses entre partos (promedio)', placeholder: 'Ej: 14', decimal: true, requerido: true },
    ],
    calcular: ({ meses }) => ({
      valor: meses,
      texto: `${meses} meses entre partos`,
      detalle: [],
    }),
    puntaje: (v) => (v <= 13 ? 5 : v <= 15 ? 4 : v <= 18 ? 3 : v < 21 ? 2 : 1),
  },
};

export function tieneCalculadora(indicadorId) {
  return Object.prototype.hasOwnProperty.call(CALCULADORAS, indicadorId);
}

// ---------------------------------------------------------------------------

export default function CalculadoraIndicador({ indicadorId, onAplicar }) {
  const def = CALCULADORAS[indicadorId];

  const [valores, setValores] = useState(() => {
    const inicial = {};
    (def?.campos || []).forEach(c => { inicial[c.key] = c.defecto || ''; });
    return inicial;
  });

  const numeros = useMemo(() => {
    const n = {};
    (def?.campos || []).forEach(c => { n[c.key] = parseFloat(valores[c.key]) || 0; });
    return n;
  }, [valores, def]);

  if (!def) return null;

  const completo = def.completo
    ? def.completo(numeros)
    : def.campos.filter(c => c.requerido).every(c => numeros[c.key] > 0);

  const resultado = completo ? def.calcular(numeros) : null;
  const puntaje = resultado ? def.puntaje(resultado.valor) : null;

  const aplicar = () => {
    if (!resultado) return;
    const resumen = [resultado.texto, ...resultado.detalle].join(' · ');
    // Se entregan también las entradas crudas: el resumen es para leer, las
    // entradas son para poder recalcular después si cambia la fórmula.
    onAplicar(puntaje, resumen, { ...numeros, _resultado: resultado.valor, _formula: def.formula });
  };

  // Los campos con `grupo` van en fila (cantidad + peso); el resto en rejilla
  const campos = def.campos;
  const enRejilla = campos.filter(c => !c.grupo);
  const enGrupo = campos.filter(c => c.grupo);

  return (
    <div className="mb-3 p-3 bg-green-50/60 rounded-lg border border-green-100 flex flex-col gap-2.5">
      <div>
        <p className="text-[10px] font-black uppercase text-green-700 tracking-widest">
          {def.icono} Calculadora — la app hace la cuenta
        </p>
        <p className="text-[11px] text-green-800/70 mt-1 leading-snug">
          <span className="font-bold">Fórmula:</span> {def.formula}
        </p>
      </div>

      {enGrupo.length > 0 && (
        <div className="flex flex-col gap-1.5">
          {chunkPares(enGrupo).map(([cantidad, peso]) => (
            <div key={cantidad.key} className="flex gap-2 items-end">
              <div className="flex-1">
                <Etiqueta>{cantidad.label}</Etiqueta>
                <Entrada campo={cantidad} valores={valores} setValores={setValores} />
              </div>
              {peso && (
                <div className="w-20 shrink-0">
                  <Etiqueta>{peso.label}</Etiqueta>
                  <Entrada campo={peso} valores={valores} setValores={setValores} />
                </div>
              )}
            </div>
          ))}
        </div>
      )}

      {enRejilla.length > 0 && (
        <div className={`grid gap-2 ${enRejilla.length >= 3 ? 'grid-cols-3' : enRejilla.length === 2 ? 'grid-cols-2' : 'grid-cols-1'}`}>
          {enRejilla.map(campo => (
            <div key={campo.key}>
              <Etiqueta>{campo.label}</Etiqueta>
              <Entrada campo={campo} valores={valores} setValores={setValores} />
            </div>
          ))}
        </div>
      )}

      {def.nota && (
        <p className="text-[10px] text-green-800/50 italic leading-relaxed">{def.nota}</p>
      )}

      {resultado && (
        <div className="flex items-center justify-between gap-2 bg-white rounded-lg px-3 py-2 border border-green-100">
          <div className="text-xs text-gray-700 leading-snug min-w-0">
            <p className="font-bold">{resultado.texto}</p>
            {resultado.detalle.map((d, i) => (
              <p key={i} className="text-[11px] text-gray-500">{d}</p>
            ))}
          </div>
          <button
            type="button"
            onClick={aplicar}
            className="shrink-0 bg-[#03A64A] text-white text-xs font-bold px-3 py-2 rounded-lg active:scale-95 transition-all"
          >
            Usar puntaje: {puntaje}
          </button>
        </div>
      )}
    </div>
  );
}

function Etiqueta({ children }) {
  return (
    <label className="block text-[9px] text-gray-500 font-bold uppercase leading-tight mb-1">
      {children}
    </label>
  );
}

function Entrada({ campo, valores, setValores }) {
  return (
    <input
      type="number"
      inputMode={campo.decimal ? 'decimal' : 'numeric'}
      min="0"
      step={campo.decimal ? '0.1' : '1'}
      value={valores[campo.key]}
      onChange={(e) => setValores(prev => ({ ...prev, [campo.key]: e.target.value }))}
      placeholder={campo.placeholder}
      className={`w-full bg-white border rounded-lg px-2 py-2 text-sm text-gray-800 focus:border-[#03A64A] outline-none ${
        campo.auxiliar ? 'border-gray-100 text-gray-500' : 'border-gray-200'
      }`}
    />
  );
}

/** Agrupa los campos de a dos: cantidad + su peso de referencia. */
function chunkPares(campos) {
  const pares = [];
  for (let i = 0; i < campos.length; i += 2) pares.push([campos[i], campos[i + 1]]);
  return pares;
}
