const fs = require('fs');
const path = require('path');
const crypto = require('crypto');

// Paths
const sqlFilePath = path.join(__dirname, '..', '02_import_datos_historicos.sql');
const sotaraSqlFilePath = path.join(__dirname, 'import_sotara.sql');
const fixSqlFilePath = path.join(__dirname, '..', 'scratch', 'fix_projects.sql');
const outputFilePath = path.join(__dirname, '..', 'public', 'seed-data.json');

// Helper to generate UUIDs
function getUUID() {
  return crypto.randomUUID();
}

// 1. Indicators Catalog
const indicators = [
  { id: 1, dimension_id: 1, dimension: 'Ambiental', orden: 1, nombre: 'Protección de fuentes de agua', rango_min: 1, rango_max: 5, descripcion: 'Estado y protección de nacimientos y cursos de agua.' },
  { id: 2, dimension_id: 1, dimension: 'Ambiental', orden: 2, nombre: 'Disponibilidad y calidad de agua', rango_min: 1, rango_max: 5, descripcion: 'Acceso a agua potable y de riego.' },
  { id: 3, dimension_id: 1, dimension: 'Ambiental', orden: 3, nombre: 'Manejo de agua', rango_min: 1, rango_max: 5, descripcion: 'Uso eficiente y almacenamiento de agua.' },
  { id: 4, dimension_id: 1, dimension: 'Ambiental', orden: 4, nombre: 'Disposición y tratamiento de aguas residuales', rango_min: 1, rango_max: 5, descripcion: 'Tratamiento de aguas grises y negras.' },
  { id: 5, dimension_id: 1, dimension: 'Ambiental', orden: 5, nombre: 'Manejo del suelo', rango_min: 1, rango_max: 5, descripcion: 'Prácticas de conservación y no erosión.' },
  { id: 6, dimension_id: 1, dimension: 'Ambiental', orden: 6, nombre: 'Fertilidad del suelo', rango_min: 1, rango_max: 5, descripcion: 'Uso de abonos orgánicos y análisis del suelo.' },
  { id: 7, dimension_id: 1, dimension: 'Ambiental', orden: 7, nombre: 'Manejo del bosque', rango_min: 1, rango_max: 5, descripcion: 'Conservación de áreas boscosas nativas.' },
  { id: 8, dimension_id: 1, dimension: 'Ambiental', orden: 8, nombre: 'Árboles en potrero', rango_min: 1, rango_max: 5, descripcion: 'Sistemas silvopastoriles, árboles dispersos.' },
  { id: 9, dimension_id: 1, dimension: 'Ambiental', orden: 9, nombre: 'Cercas vivas', rango_min: 1, rango_max: 5, descripcion: 'Delimitación con especies arbóreas o arbustivas.' },
  { id: 10, dimension_id: 1, dimension: 'Ambiental', orden: 10, nombre: 'Uso de fertilizantes, herbicidas y pesticidas', rango_min: 1, rango_max: 5, descripcion: 'Nivel de agroquímicos aplicados.' },
  { id: 11, dimension_id: 1, dimension: 'Ambiental', orden: 11, nombre: 'Fauna nativa y silvestre', rango_min: 1, rango_max: 5, descripcion: 'Protección de animales silvestres y corredores.' },
  { id: 12, dimension_id: 1, dimension: 'Ambiental', orden: 12, nombre: 'Reciclaje-reutilización de residuos líquidos y sólidos', rango_min: 1, rango_max: 5, descripcion: 'Manejo de basuras y plásticos de uso agrícola.' },
  { id: 13, dimension_id: 2, dimension: 'Socioeconómica', orden: 1, nombre: 'Acceso a crédito', rango_min: 1, rango_max: 5, descripcion: 'Financiación disponible para inversión.' },
  { id: 14, dimension_id: 2, dimension: 'Socioeconómica', orden: 2, nombre: 'Registro contables y de costos', rango_min: 1, rango_max: 5, descripcion: 'Llevar cuentas y balances de la producción.' },
  { id: 15, dimension_id: 2, dimension: 'Socioeconómica', orden: 3, nombre: 'Ingresos', rango_min: 1, rango_max: 5, descripcion: 'Nivel de ingresos netos mensuales.' },
  { id: 16, dimension_id: 2, dimension: 'Socioeconómica', orden: 4, nombre: 'Generación de nuevos empleos', rango_min: 1, rango_max: 5, descripcion: 'Contratación familiar o de jornaleros.' },
  { id: 17, dimension_id: 2, dimension: 'Socioeconómica', orden: 5, nombre: 'Difusión tecnológica', rango_min: 1, rango_max: 5, descripcion: 'Participación en días de campo o capacitación.' },
  { id: 18, dimension_id: 2, dimension: 'Socioeconómica', orden: 6, nombre: 'Seguridad alimentaria', rango_min: 1, rango_max: 5, descripcion: 'Producción de alimentos para el hogar (huerta).' },
  { id: 19, dimension_id: 3, dimension: 'Productiva', orden: 1, nombre: 'Sistemas productivos diversificados', rango_min: 1, rango_max: 5, descripcion: 'Variedad de cultivos y ganadería.' },
  { id: 20, dimension_id: 3, dimension: 'Productiva', orden: 2, nombre: 'Aprovechamiento de subproductos de cosecha', rango_min: 1, rango_max: 5, descripcion: 'Uso de residuos de cosecha o estiércol.' },
  { id: 21, dimension_id: 3, dimension: 'Productiva', orden: 3, nombre: 'Numero de potreros (franjas o divisiones)', rango_min: 1, rango_max: 5, descripcion: 'Rotación y número de potreros.' },
  { id: 22, dimension_id: 3, dimension: 'Productiva', orden: 4, nombre: 'Litros leche Hectárea/año', rango_min: 1, rango_max: 5, descripcion: 'Productividad de leche.' },
  { id: 23, dimension_id: 3, dimension: 'Productiva', orden: 5, nombre: 'Peso al destete', rango_min: 1, rango_max: 5, descripcion: 'Peso medio de los terneros.' },
  { id: 24, dimension_id: 3, dimension: 'Productiva', orden: 6, nombre: 'Edad de los machos al sacrificio', rango_min: 1, rango_max: 5, descripcion: 'Edad óptima de sacrificio.' },
  { id: 25, dimension_id: 3, dimension: 'Productiva', orden: 7, nombre: 'Carga animal/hectárea (Unidad de gran ganado - UGG)', rango_min: 1, rango_max: 5, descripcion: 'Número de animales por hectárea.' },
  { id: 26, dimension_id: 3, dimension: 'Productiva', orden: 8, nombre: 'Edad al primer parto', rango_min: 1, rango_max: 5, descripcion: 'Edad reproductiva inicial.' },
  { id: 27, dimension_id: 3, dimension: 'Productiva', orden: 9, nombre: 'Tasa de mortalidad', rango_min: 1, rango_max: 5, descripcion: 'Porcentaje de muertes anuales.' },
  { id: 28, dimension_id: 3, dimension: 'Productiva', orden: 10, nombre: 'Intervalo entre partos', rango_min: 1, rango_max: 5, descripcion: 'Días transcurridos entre partos.' },
  { id: 29, dimension_id: 3, dimension: 'Productiva', orden: 11, nombre: 'Registros técnicos y reproductivos', rango_min: 1, rango_max: 5, descripcion: 'Fichas de inseminación y sanidad.' }
];

async function run() {
  console.log('Cargando fix_projects.sql...');
  const fixSql = fs.readFileSync(fixSqlFilePath, 'utf8');
  const fixMap = {};
  
  // Parse fix_projects.sql
  const fixRegex = /UPDATE productores SET proyecto = '(.*?)'(?:, nombre_completo = '(.*?)', vereda = '(.*?)', municipio = '(.*?)')? WHERE REPLACE\(cedula, '\.', ''\) = '(\d+)';/g;
  let match;
  while ((match = fixRegex.exec(fixSql)) !== null) {
    const proyecto = match[1];
    const nombre = match[2];
    const vereda = match[3];
    const municipio = match[4];
    const cedula = match[5];
    fixMap[cedula] = { proyecto, nombre, vereda, municipio };
  }
  
  const simpleFixRegex = /UPDATE productores SET proyecto = '(.*?)' WHERE REPLACE\(cedula, '\.', ''\) = '(\d+)';/g;
  while ((match = simpleFixRegex.exec(fixSql)) !== null) {
    const proyecto = match[1];
    const cedula = match[2];
    if (!fixMap[cedula]) fixMap[cedula] = { proyecto };
    else fixMap[cedula].proyecto = proyecto;
  }
  
  console.log(`Cargados ${Object.keys(fixMap).length} mapeos de fix_projects.sql`);

  function parseSQLFile(filePath, defaultProyecto) {
    console.log(`Leyendo ${filePath}...`);
    const sql = fs.readFileSync(filePath, 'utf8');
    
    const productoresList = [];
    const evaluacionesList = [];
    const respuestasList = [];
    
    // Separar el archivo por productores
    const blocks = sql.split(/INSERT INTO productores/i);
    console.log(`Encontrados ${blocks.length - 1} registros de productores en ${path.basename(filePath)}.`);
    
    const tecnicoId = 'e81ba52c-23df-4f4e-808d-937fd606426c';
    
    for (let i = 1; i < blocks.length; i++) {
      const block = blocks[i];
      
      // 1. Extraer productor
      const prodValRegex = /VALUES\s*\(\s*'(\d+)'\s*,\s*'(.*?)'\s*,\s*'(.*?)'\s*,\s*'(.*?)'\s*,\s*'(.*?)'\s*,\s*(-?\d+(?:\.\d+)?|NULL)\s*,\s*(-?\d+(?:\.\d+)?|NULL)/i;
      const prodMatch = prodValRegex.exec(block);
      
      if (!prodMatch) {
        console.warn(`No se pudo parsear el productor en el bloque ${i} de ${path.basename(filePath)}`);
        continue;
      }
      
      const cedula = prodMatch[1];
      let nombre = prodMatch[2].replace(/''/g, "'");
      let predio = prodMatch[3].replace(/''/g, "'");
      let vereda = prodMatch[4].replace(/''/g, "'");
      let municipio = prodMatch[5].replace(/''/g, "'");
      let lat = prodMatch[6] === 'NULL' ? null : parseFloat(prodMatch[6]);
      let lng = prodMatch[7] === 'NULL' ? null : parseFloat(prodMatch[7]);
      
      // Corregir coordenadas enteras o anomalías
      if (lat && Math.abs(lat) > 90) {
        console.log(`[coord fix] Corrigiendo latitud entera para ${nombre}: ${lat} -> ${lat / 1000000}`);
        lat = lat / 1000000;
      }
      if (lng && Math.abs(lng) > 180) {
        console.log(`[coord fix] Corrigiendo longitud entera para ${nombre}: ${lng} -> ${lng / 1000000}`);
        lng = lng / 1000000;
      }
      if (lat && lng && lat === lng && lat > 0) {
        console.log(`[coord fix] Corrigiendo coordenadas idénticas para ${nombre}: lat=${lat}, lng=${lng} -> lng=-76.584111`);
        lng = -76.584111;
      }
      
      // Aplicar corrección de fix_projects
      let proyecto = defaultProyecto;
      if (defaultProyecto === 'Proyecto Paletará') {
        const fix = fixMap[cedula.replace(/\./g, '')];
        if (fix) {
          proyecto = fix.proyecto || proyecto;
          if (fix.nombre) nombre = fix.nombre;
          if (fix.vereda) vereda = fix.vereda;
          if (fix.municipio) municipio = fix.municipio;
        } else if (municipio.toLowerCase().includes('sotará') || vereda.toLowerCase().includes('piedra de león')) {
          proyecto = 'Proyecto Sotará';
        }
      }
      
      const productorId = getUUID();
      const productor = {
        id: productorId,
        cedula,
        nombre_completo: nombre,
        nombre_predio: predio,
        vereda,
        municipio,
        proyecto,
        ubicacion_lat: lat,
        ubicacion_lng: lng,
        created_by: tecnicoId,
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      };
      productoresList.push(productor);
      
      // 2. Extraer calificación
      const calRegex = /INSERT INTO calificaciones[\s\S]*?VALUES\s*\(\s*([^\s,]+)\s*,\s*([^\s,]+)\s*,\s*'(.*?)'\s*,\s*'(.*?)'\s*,\s*'(.*?)'/i;
      const calMatch = calRegex.exec(block);
      
      if (calMatch) {
        const estado = 'enviada';
        const fecha = calMatch[4]; // fecha_inicio (Group 4)
        const evaluacionId = getUUID();
        
        const evaluacion = {
          id: evaluacionId,
          finca_id: productorId,
          tecnico_id: tecnicoId,
          estado: estado,
          fecha: fecha,
          observaciones_generales: 'Migrado de histórico.',
          es_prueba: false,
          created_at: new Date().toISOString(),
          updated_at: new Date().toISOString()
        };
        evaluacionesList.push(evaluacion);
        
        // 3. Extraer detalles
        const detRegex = /\(\s*[^\s,]+\s*,\s*(\d+)\s*,\s*(\d+)\s*(?:,\s*'(.*?)'\s*)?\)/gi;
        const detStartIndex = block.indexOf('INSERT INTO calificacion_detalle');
        if (detStartIndex !== -1) {
          const detSubBlock = block.substring(detStartIndex);
          let detMatch;
          while ((detMatch = detRegex.exec(detSubBlock)) !== null) {
            const indicador_id = parseInt(detMatch[1]);
            const valor = parseInt(detMatch[2]);
            const observacion = detMatch[3] ? detMatch[3].replace(/''/g, "'") : null;
            
            const respuesta = {
              id: getUUID(),
              evaluacion_id: evaluacionId,
              indicador_id,
              valor,
              observacion: observacion || null,
              updated_at: new Date().toISOString()
            };
            respuestasList.push(respuesta);
          }
        }
      }
    }
    
    return { productoresList, evaluacionesList, respuestasList };
  }

  const puraceData = parseSQLFile(sqlFilePath, 'Proyecto Paletará');
  const sotaraData = parseSQLFile(sotaraSqlFilePath, 'Proyecto Sotará');

  // Unificar y deduplicar
  const uniqueProductores = {};
  const finalProductores = [];
  const finalEvaluaciones = [];
  const finalRespuestas = [];

  function addData(data) {
    data.productoresList.forEach((prod) => {
      if (uniqueProductores[prod.cedula]) {
        console.warn(`[duplicate] Productor duplicado con cédula ${prod.cedula}: ${prod.nombre_completo}`);
      } else {
        uniqueProductores[prod.cedula] = prod.id;
        finalProductores.push(prod);
      }
    });

    data.evaluacionesList.forEach((evalItem) => {
      const oldProd = data.productoresList.find(p => p.id === evalItem.finca_id);
      if (oldProd) {
        const uniqueProdId = uniqueProductores[oldProd.cedula];
        if (uniqueProdId) {
          const oldEvalId = evalItem.id;
          evalItem.finca_id = uniqueProdId;
          finalEvaluaciones.push(evalItem);

          const reps = data.respuestasList.filter(r => r.evaluacion_id === oldEvalId);
          reps.forEach((rep) => {
            finalRespuestas.push(rep);
          });
        }
      }
    });
  }

  addData(puraceData);
  addData(sotaraData);

  console.log(`Total productores unificados: ${finalProductores.length}`);
  console.log(`Total evaluaciones unificadas: ${finalEvaluaciones.length}`);
  console.log(`Total respuestas unificadas: ${finalRespuestas.length}`);

  const seedData = {
    indicadores: indicators,
    productores: finalProductores,
    evaluaciones: finalEvaluaciones,
    respuestas_indicadores: finalRespuestas
  };

  // Corregir mojibake (UTF-8 doblemente codificado, ej. "RÃ­o" → "Río")
  // que viene de los archivos SQL de origen.
  function fixMojibake(value) {
    if (typeof value === 'string' && /Ã[-¿ -ÿ]|Â[ -¿]/.test(value)) {
      const fixed = Buffer.from(value, 'latin1').toString('utf8');
      return fixed.includes('�') ? value : fixed;
    }
    if (Array.isArray(value)) return value.map(fixMojibake);
    if (value && typeof value === 'object') {
      for (const k of Object.keys(value)) value[k] = fixMojibake(value[k]);
    }
    return value;
  }

  fs.writeFileSync(outputFilePath, JSON.stringify(fixMojibake(seedData), null, 2));
  console.log(`Seed data escrita correctamente en ${outputFilePath}`);
}

run().catch(console.error);
