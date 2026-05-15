const xlsx = require('xlsx');
const fs = require('fs');

const EVALUADOR_ID = 'e81ba52c-23df-4f4e-808d-937fd606426c';
const FECHA_FIJA = '2024-06-15 12:00:00+00';

function run() {
  console.log('--- Generando SQL de importación ---');

  const workbook = xlsx.readFile('data_import/Calificacion indicadores sotará.xlsx');
  const sheet = workbook.Sheets[workbook.SheetNames[0]];
  const data = xlsx.utils.sheet_to_json(sheet);

  // Transponer datos
  const productoresMap = {};
  data.forEach(row => {
    const label = row['CARACTERIZACION'];
    if (!label) return;

    Object.keys(row).forEach(key => {
      if (key === 'CARACTERIZACION') return;
      if (!productoresMap[key]) productoresMap[key] = { scores: {} };
      
      const value = row[key];
      
      if (label === 'Nombres y Apellidos del ganadero') productoresMap[key].nombre = value;
      else if (label === 'Número de cédula') productoresMap[key].cedula = value?.toString();
      else if (label === 'Vereda') productoresMap[key].vereda = value;
      else if (label === 'Municipio') productoresMap[key].municipio = value;
      else if (label === 'Nombre de la finca') productoresMap[key].nombre_predio = value;
      else if (label === 'LATITUD') productoresMap[key].lat = value;
      else if (label === 'LONGITUD') productoresMap[key].lng = value;
      else {
        const match = label.match(/^(\d+)\./);
        if (match) {
          const id = parseInt(match[1]);
          productoresMap[key].scores[id] = value;
        }
      }
    });
  });

  const productores = Object.values(productoresMap).filter(p => p.cedula && p.nombre);
  console.log(`Encontrados ${productores.length} productores.`);

  let sql = 'BEGIN;\n\n';

  for (const p of productores) {
    const nombre = p.nombre.replace(/'/g, "''");
    const predio = (p.nombre_predio || '').replace(/'/g, "''");
    const vereda = (p.vereda || '').replace(/'/g, "''");
    const municipio = (p.municipio || '').replace(/'/g, "''");
    const lat = p.lat || 'NULL';
    const lng = p.lng || 'NULL';

    sql += `-- Procesando ${nombre}\n`;
    sql += `DO $$\n`;
    sql += `DECLARE\n`;
    sql += `  v_productor_id UUID;\n`;
    sql += `  v_calificacion_id UUID;\n`;
    sql += `BEGIN\n`;
    
    // Upsert productor
    sql += `  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)\n`;
    sql += `  VALUES ('${p.cedula}', '${nombre}', '${predio}', '${vereda}', '${municipio}', ${lat}, ${lng}, 'Proyecto Sotará')\n`;
    sql += `  ON CONFLICT (cedula) DO UPDATE SET \n`;
    sql += `    nombre_completo = EXCLUDED.nombre_completo, \n`;
    sql += `    nombre_predio = EXCLUDED.nombre_predio, \n`;
    sql += `    vereda = EXCLUDED.vereda, \n`;
    sql += `    municipio = EXCLUDED.municipio, \n`;
    sql += `    ubicacion_lat = EXCLUDED.ubicacion_lat, \n`;
    sql += `    ubicacion_lng = EXCLUDED.ubicacion_lng, \n`;
    sql += `    proyecto = EXCLUDED.proyecto\n`;
    sql += `  RETURNING id INTO v_productor_id;\n\n`;

    // Find or create calificación
    sql += `  -- Buscar si ya existe una calificación para este productor y fecha\n`;
    sql += `  SELECT id INTO v_calificacion_id FROM calificaciones \n`;
    sql += `  WHERE productor_id = v_productor_id AND fecha_inicio = '${FECHA_FIJA}';\n\n`;
    
    sql += `  IF v_calificacion_id IS NULL THEN\n`;
    sql += `    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)\n`;
    sql += `    VALUES (v_productor_id, '${EVALUADOR_ID}', 'completada', '${FECHA_FIJA}', '${FECHA_FIJA}', false)\n`;
    sql += `    RETURNING id INTO v_calificacion_id;\n`;
    sql += `  ELSE\n`;
    sql += `    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización\n`;
    sql += `    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;\n`;
    sql += `  END IF;\n\n`;

    // Insert detalles
    const detalles = Object.entries(p.scores).map(([indId, score]) => {
      const val = score && !isNaN(score) ? parseInt(score) : null;
      if (val === null) return null;
      return `(${indId}, ${val})`;
    }).filter(d => d !== null);

    if (detalles.length > 0) {
      sql += `  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)\n`;
      sql += `  VALUES \n    ` + detalles.map(d => `(v_calificacion_id, ${d.substring(1, d.length - 1)})`).join(',\n    ') + ';\n';
    }

    sql += `END $$;\n\n`;
  }

  sql += 'COMMIT;';

  fs.writeFileSync('scripts/import_sotara.sql', sql);
  console.log('SQL generado en scripts/import_sotara.sql');
}

run();
