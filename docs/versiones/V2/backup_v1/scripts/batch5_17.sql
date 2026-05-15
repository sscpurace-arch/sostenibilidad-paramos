BEGIN;-- Procesando PEDRO ANTONIO GUERRERO MAGON
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('4771230', 'PEDRO ANTONIO GUERRERO MAGON', 'LA MARIA', 'CHAPA', 'SOTARA', 2.19459971, -76.63889, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
  VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 3),
    (v_calificacion_id, 2, 3),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 5, 2),
    (v_calificacion_id, 6, 2),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 4),
    (v_calificacion_id, 9, 2),
    (v_calificacion_id, 10, 4),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 3),
    (v_calificacion_id, 17, 1),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 4),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando GLADIS MUÑOZ MONCAYO
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('25290509', 'GLADIS MUÑOZ MONCAYO', 'EL ARENAL', 'DIVISO', 'SOTARA', 2.18415, -76.63407, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
  VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 1),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 2),
    (v_calificacion_id, 4, 3),
    (v_calificacion_id, 5, 3),
    (v_calificacion_id, 6, 2),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 4),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 4),
    (v_calificacion_id, 13, 4),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 5),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 18, 4),
    (v_calificacion_id, 19, 3),
    (v_calificacion_id, 20, 3),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 2),
    (v_calificacion_id, 23, 3),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 4),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando PORFIRIO SANTIAGO
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('10532886', 'PORFIRIO SANTIAGO', 'LOS ARRAYANES', 'SAN ROQUE', 'SOTARA', 2.184067, -76.624295, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
  VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 1),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 3),
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 3),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 2),
    (v_calificacion_id, 9, 4),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 4),
    (v_calificacion_id, 13, 4),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 2),
    (v_calificacion_id, 18, 2),
    (v_calificacion_id, 19, 3),
    (v_calificacion_id, 20, 4),
    (v_calificacion_id, 21, 4),
    (v_calificacion_id, 22, 3),
    (v_calificacion_id, 23, 4),
    (v_calificacion_id, 25, 4),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 1),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando YENY PAOLA SILVA JIMENEZ
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('1061693094', 'YENY PAOLA SILVA JIMENEZ', 'EL EDEN', 'SAN ROQUE', 'SOTARA', 2.179, -76.61843, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
  VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 5),
    (v_calificacion_id, 2, 5),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 4),
    (v_calificacion_id, 9, 4),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 3),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 2),
    (v_calificacion_id, 16, 3),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 2),
    (v_calificacion_id, 19, 3),
    (v_calificacion_id, 21, 2),
    (v_calificacion_id, 22, 3),
    (v_calificacion_id, 23, 2),
    (v_calificacion_id, 24, 4),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 1),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando JESÚS HERNÁN ALBÁN 
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('26308173', 'JESÚS HERNÁN ALBÁN ', 'EL COLUMPIO', 'CHAPA ', 'SOTARÁ ', 2.19647, -76.63319, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
  VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 1),
    (v_calificacion_id, 2, 2),
    (v_calificacion_id, 3, 2),
    (v_calificacion_id, 4, 5),
    (v_calificacion_id, 5, 2),
    (v_calificacion_id, 6, 1),
    (v_calificacion_id, 7, 2),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 10, 1),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 2),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 2),
    (v_calificacion_id, 18, 3),
    (v_calificacion_id, 19, 2),
    (v_calificacion_id, 20, 1),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 2),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 1),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 1),
    (v_calificacion_id, 29, 1);
END $$;


COMMIT;