/**
 * Importa las hectáreas del predio (área total y área en ganadería) desde la
 * Base Maestra Consolidada del diagnóstico SSP y las cruza por cédula con los
 * productores de la app.
 *
 * Produce tres cosas:
 *   1. public/seed-data.json parcheado (area_total_ha / area_ganaderia_ha en
 *      cada productor que cruzó). Hay que subir SEED_VERSION en
 *      lib/sync-engine.js y hacer commit del seed.
 *   2. docs/sql-hectareas-datos.sql — UPDATE por cédula para Supabase.
 *   3. docs/reporte-hectareas.md — cuántas cruzaron y cuáles no, en ambos
 *      sentidos (cédulas del XLSX sin productor y productores sin hectáreas).
 *
 * Uso:
 *   node scripts/import-hectareas.mjs [ruta-al-xlsx] [--productores=export.json]
 *
 * --productores: JSON con [{ id, cedula, nombre_completo }] exportado de
 * Supabase, para que el reporte refleje la base real y no solo el seed.
 * Sin ese archivo, el cruce del reporte se hace contra el seed.
 *
 * No escribe en Supabase: el SQL generado se aplica aparte (Management API).
 */
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import XLSX from 'xlsx';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const RAIZ = path.join(__dirname, '..');

const XLSX_DEFECTO = path.join(
  RAIZ, '..', 'Operativo - Administrativo', 'P-2,3 Diagnóstico y Estrategia SSP Puracé',
  'Anexos_Formateados', 'Base_Maestra_Consolidada_2026-06-22.xlsx'
);
const HOJA = 'Maestra';
const COL_CEDULA = 'Cédula_Normalizada';
const COL_TOTAL = 'Área_Total_Finca_Ha';
const COL_GANADERIA = 'Área_Ganadería_Ha';

const args = process.argv.slice(2);
const rutaXlsx = args.find(a => !a.startsWith('--')) || XLSX_DEFECTO;
const rutaProductores = (args.find(a => a.startsWith('--productores=')) || '').split('=')[1] || null;

const soloDigitos = (v) => String(v ?? '').replace(/\D/g, '');
const numero = (v) => {
  if (v === null || v === undefined || v === '') return null;
  if (typeof v === 'number') return isFinite(v) ? v : null;
  const n = parseFloat(String(v).replace(',', '.').replace(/[^0-9.]/g, ''));
  return isNaN(n) ? null : n;
};

// ── 1. Leer XLSX ────────────────────────────────────────────────────────────
const wb = XLSX.readFile(rutaXlsx);
const ws = wb.Sheets[HOJA];
if (!ws) throw new Error(`No existe la hoja "${HOJA}" en ${rutaXlsx}`);
const filas = XLSX.utils.sheet_to_json(ws, { defval: null });

const porCedula = new Map();
const sinCedula = [];
const duplicadas = [];
for (const f of filas) {
  const ced = soloDigitos(f[COL_CEDULA]);
  if (!ced) { sinCedula.push(f); continue; }
  const dato = {
    cedula: ced,
    nombre: f['Nombre_Normalizado'] || f['Nombre_Original'] || '',
    area_total_ha: numero(f[COL_TOTAL]),
    area_ganaderia_ha: numero(f[COL_GANADERIA]),
  };
  if (porCedula.has(ced)) duplicadas.push(ced);
  porCedula.set(ced, dato);
}

// ── 2. Parchear el seed ─────────────────────────────────────────────────────
const rutaSeed = path.join(RAIZ, 'public', 'seed-data.json');
const seed = JSON.parse(fs.readFileSync(rutaSeed, 'utf8'));
let seedCruzados = 0;
const seedSinHectareas = [];
for (const p of seed.productores) {
  const d = porCedula.get(soloDigitos(p.cedula));
  if (d && (d.area_total_ha !== null || d.area_ganaderia_ha !== null)) {
    p.area_total_ha = d.area_total_ha;
    p.area_ganaderia_ha = d.area_ganaderia_ha;
    seedCruzados++;
  } else {
    seedSinHectareas.push({ cedula: p.cedula, nombre: p.nombre_completo });
  }
}
fs.writeFileSync(rutaSeed, JSON.stringify(seed));

// ── 3. Productores reales (si se pasó el export) ────────────────────────────
let productores = seed.productores.map(p => ({ id: p.id, cedula: p.cedula, nombre_completo: p.nombre_completo }));
let fuenteProductores = 'seed-data.json';
if (rutaProductores) {
  productores = JSON.parse(fs.readFileSync(rutaProductores, 'utf8'));
  fuenteProductores = path.basename(rutaProductores);
}
const cedulasApp = new Set(productores.map(p => soloDigitos(p.cedula)));

const cruzan = [];
const productoresSinHectareas = [];
for (const p of productores) {
  const d = porCedula.get(soloDigitos(p.cedula));
  if (d && (d.area_total_ha !== null || d.area_ganaderia_ha !== null)) cruzan.push({ ...p, ...d });
  else productoresSinHectareas.push(p);
}
const xlsxSinProductor = [...porCedula.values()].filter(d => !cedulasApp.has(d.cedula));

// ── 4. SQL para Supabase (por cédula normalizada) ───────────────────────────
const sqlVal = (n) => (n === null ? 'null' : String(n));
const lineas = [...porCedula.values()]
  .filter(d => d.area_total_ha !== null || d.area_ganaderia_ha !== null)
  .map(d => `  ('${d.cedula}', ${sqlVal(d.area_total_ha)}, ${sqlVal(d.area_ganaderia_ha)})`);
const sql = `-- Generado por scripts/import-hectareas.mjs el ${new Date().toISOString().slice(0, 10)}
-- Fuente: ${path.basename(rutaXlsx)}, hoja "${HOJA}" (${filas.length} filas, ${lineas.length} con hectáreas)
-- Cruce por cédula sin puntos ni espacios. Solo toca filas que cruzan; no crea productores.
update public.productores p
   set area_total_ha     = v.total,
       area_ganaderia_ha = v.ganaderia,
       updated_at        = now()
  from (values
${lineas.join(',\n')}
  ) as v(cedula, total, ganaderia)
 where regexp_replace(p.cedula, '\\D', '', 'g') = v.cedula;
`;
fs.mkdirSync(path.join(RAIZ, 'docs'), { recursive: true });
fs.writeFileSync(path.join(RAIZ, 'docs', 'sql-hectareas-datos.sql'), sql);

// ── 5. Reporte ──────────────────────────────────────────────────────────────
const lista = (arr, f) => (arr.length ? arr.map(f).join('\n') : '_ninguno_');
const reporte = `# Importación de hectáreas — ${new Date().toISOString().slice(0, 10)}

Fuente: \`${path.basename(rutaXlsx)}\`, hoja **${HOJA}**.
Cruce por cédula (solo dígitos) contra **${fuenteProductores}** (${productores.length} productores).

| | |
|---|---|
| Filas en el XLSX | ${filas.length} |
| Cédulas únicas con hectáreas | ${lineas.length} |
| Filas sin cédula | ${sinCedula.length} |
| Cédulas repetidas en el XLSX | ${duplicadas.length} |
| **Productores que cruzaron** | **${cruzan.length} / ${productores.length}** |
| Productores sin hectáreas | ${productoresSinHectareas.length} |
| Cédulas del XLSX sin productor en la app | ${xlsxSinProductor.length} |
| Productores del seed parcheados | ${seedCruzados} / ${seed.productores.length} |

## Productores de la app SIN hectáreas (no están en la hoja Maestra)
${lista(productoresSinHectareas, p => `- ${p.cedula} — ${p.nombre_completo}`)}

## Cédulas del XLSX que NO tienen productor en la app
${lista(xlsxSinProductor, d => `- ${d.cedula} — ${d.nombre} (${d.area_total_ha ?? '—'} ha total, ${d.area_ganaderia_ha ?? '—'} ha ganadería)`)}

${duplicadas.length ? `## Cédulas repetidas en el XLSX (se tomó la última fila)\n${lista([...new Set(duplicadas)], c => `- ${c}`)}\n` : ''}
`;
fs.writeFileSync(path.join(RAIZ, 'docs', 'reporte-hectareas.md'), reporte);

console.log(`XLSX: ${filas.length} filas, ${lineas.length} con hectáreas`);
console.log(`Seed: ${seedCruzados}/${seed.productores.length} productores parcheados`);
console.log(`Cruce contra ${fuenteProductores}: ${cruzan.length}/${productores.length} cruzaron, ${productoresSinHectareas.length} sin hectáreas, ${xlsxSinProductor.length} cédulas del XLSX sin productor`);
console.log('Escrito: public/seed-data.json, docs/sql-hectareas-datos.sql, docs/reporte-hectareas.md');
