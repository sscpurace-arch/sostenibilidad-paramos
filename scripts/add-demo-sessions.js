/**
 * Agrega 10 evaluaciones de demo al seed-data.json.
 *
 * Cada evaluación:
 * - está en estado 'borrador' (es_prueba: true)
 * - tiene los indicadores 1-28 pre-calificados al azar
 * - deja el indicador 29 ("Registros técnicos y reproductivos") libre
 *
 * Uso: node scripts/add-demo-sessions.js
 * Para limpiar y regenerar: node scripts/add-demo-sessions.js --reset
 */

const fs = require('fs');
const path = require('path');
const crypto = require('crypto');

const SEED_PATH = path.join(__dirname, '..', 'public', 'seed-data.json');
const MOCK_USER_ID = 'e81ba52c-23df-4f4e-808d-937fd606426c';
const DEMO_TAG = '__DEMO_BORRADOR__'; // marca en observaciones para identificarlos
const NUM_PRODUCTORES = 10;
const INDICADOR_LIBRE = 29;

const seed = JSON.parse(fs.readFileSync(SEED_PATH, 'utf8'));

// Limpiar sesiones de demo anteriores si existen
const demoEvalIds = seed.evaluaciones
  .filter(e => e.observaciones_generales === DEMO_TAG)
  .map(e => e.id);

seed.evaluaciones = seed.evaluaciones.filter(e => e.observaciones_generales !== DEMO_TAG);
seed.respuestas_indicadores = seed.respuestas_indicadores.filter(
  r => !demoEvalIds.includes(r.evaluacion_id)
);

if (process.argv.includes('--reset')) {
  fs.writeFileSync(SEED_PATH, JSON.stringify(seed, null, 2));
  console.log('Demo sessions eliminadas del seed-data.json');
  process.exit(0);
}

// Tomar los primeros N productores
const targetProductores = seed.productores.slice(0, NUM_PRODUCTORES);

// Indicadores 1-28 (todos excepto el 29)
const indicadorIds = Array.from({ length: 28 }, (_, i) => i + 1);

const newEvals = [];
const newRespuestas = [];

for (const productor of targetProductores) {
  const evalId = crypto.randomUUID();
  newEvals.push({
    id: evalId,
    finca_id: productor.id,
    tecnico_id: MOCK_USER_ID,
    estado: 'borrador',
    fecha: new Date().toISOString(),
    observaciones_generales: DEMO_TAG,
    es_prueba: true,
    created_at: new Date().toISOString(),
    updated_at: new Date().toISOString(),
  });

  for (const indId of indicadorIds) {
    // Valor entre 2 y 5 con distribución realista (mayoría medio-alto)
    const valor = [2, 3, 3, 4, 4, 4, 5, 5][Math.floor(Math.random() * 8)];
    newRespuestas.push({
      id: crypto.randomUUID(),
      evaluacion_id: evalId,
      indicador_id: indId,
      valor,
      observacion: null,
      updated_at: new Date().toISOString(),
    });
  }
}

seed.evaluaciones.push(...newEvals);
seed.respuestas_indicadores.push(...newRespuestas);

fs.writeFileSync(SEED_PATH, JSON.stringify(seed, null, 2));
console.log(`✅ ${NUM_PRODUCTORES} evaluaciones de demo agregadas al seed-data.json`);
console.log(`   Productores: ${targetProductores.map(p => p.nombre_completo).join(', ')}`);
console.log(`   Indicadores pre-calificados: 1-28 (falta solo el #${INDICADOR_LIBRE})`);
console.log(`   Para eliminarlas: node scripts/add-demo-sessions.js --reset`);
