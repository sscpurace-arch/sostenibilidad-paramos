/**
 * Genera public/seed-demo.json: los datos del MODO PRUEBA (visitantes sin
 * cuenta), a partir de data/seed-data.json, SIN datos personales.
 *
 * public/ lo puede descargar cualquiera, así que aquí no puede ir nada que
 * identifique a un productor: ni nombre, ni cédula, ni predio, ni la
 * coordenada exacta de la casa. Solo van las calificaciones de prueba
 * (es_prueba), nunca las reales.
 *
 * Correr cada vez que cambie data/seed-data.json:
 *   node scripts/generar-seed-demo.mjs [entrada] [salida]
 * y subir SEED_VERSION en lib/sync-engine.js.
 */
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const RAIZ = path.join(path.dirname(fileURLToPath(import.meta.url)), '..');
const entrada = process.argv[2] || path.join(RAIZ, 'data', 'seed-data.json');
const salida = process.argv[3] || path.join(RAIZ, 'public', 'seed-demo.json');

// Mismo id que MOCK_USER en lib/supabase.js
const TECNICO_PRUEBA = 'e81ba52c-23df-4f4e-808d-937fd606426c';

const seed = JSON.parse(fs.readFileSync(entrada, 'utf8'));

// ~1 km de precisión: el mapa sigue ubicando la vereda, no la casa
const redondear = (v) => (v === null || v === undefined || v === '' ? null : Math.round(Number(v) * 100) / 100);

const productores = (seed.productores || []).map((p, i) => {
  const n = String(i + 1).padStart(3, '0');
  return {
    id: p.id,
    cedula: `DEMO-${n}`,
    nombre_completo: `Productor de prueba ${n}`,
    nombre_predio: `Predio de prueba ${n}`,
    vereda: p.vereda,
    municipio: p.municipio,
    proyecto: p.proyecto,
    ubicacion_lat: redondear(p.ubicacion_lat),
    ubicacion_lng: redondear(p.ubicacion_lng),
    area_total_ha: p.area_total_ha ?? null,
    area_ganaderia_ha: p.area_ganaderia_ha ?? null,
    created_by: null,
    created_at: p.created_at,
    updated_at: p.updated_at,
  };
});

const evaluaciones = (seed.evaluaciones || [])
  .filter((e) => e.es_prueba)
  .map((e) => ({
    id: e.id,
    finca_id: e.finca_id,
    tecnico_id: TECNICO_PRUEBA,
    estado: e.estado,
    fecha: e.fecha,
    es_prueba: true,
    observaciones_generales: '',
    created_at: e.created_at,
    updated_at: e.updated_at,
  }));

const idsPrueba = new Set(evaluaciones.map((e) => e.id));
const respuestas_indicadores = (seed.respuestas_indicadores || [])
  .filter((r) => idsPrueba.has(r.evaluacion_id))
  .map((r) => ({ ...r, es_prueba: true }));

const demo = {
  indicadores: seed.indicadores || [],
  productores,
  evaluaciones,
  respuestas_indicadores,
};

fs.writeFileSync(salida, JSON.stringify(demo));
console.log(`Escrito ${path.relative(RAIZ, salida)}: ${productores.length} productores anonimizados, ${evaluaciones.length} evaluaciones de prueba, ${respuestas_indicadores.length} respuestas.`);
