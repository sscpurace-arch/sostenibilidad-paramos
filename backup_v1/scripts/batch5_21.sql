BEGIN;-- Procesando LIDA NEIRA DORADO PAJOY
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('34475112', 'LIDA NEIRA DORADO PAJOY', 'EL CARMEN', 'ULLUCOS', 'SOTARA', 2.213395, -76.59829, 'Proyecto Sotará')
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
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 3),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 3),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 3),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 21, 2),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 4),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 1),
    (v_calificacion_id, 28, 3),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando MARLENY SANCHEZ SANTIAGO
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('25693772', 'MARLENY SANCHEZ SANTIAGO', 'LA SABANA', 'ULLUCOS', 'SOTARA', 2.222333, -76.582863, 'Proyecto Sotará')
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
    (v_calificacion_id, 1, 4),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 5, 3),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 2),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 5),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 1),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 21, 2),
    (v_calificacion_id, 22, 4),
    (v_calificacion_id, 23, 3),
    (v_calificacion_id, 24, 3),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 4),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando JAIRO EVELIO PERAFAN TINTINAGO
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('1064676399', 'JAIRO EVELIO PERAFAN TINTINAGO', 'LA TINAJA', 'ULLUCOS', 'SOTARA', 2.216356, -76.582551, 'Proyecto Sotará')
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
    (v_calificacion_id, 1, 4),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 4),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 4),
    (v_calificacion_id, 9, 4),
    (v_calificacion_id, 10, 3),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 3),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 5),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 3),
    (v_calificacion_id, 17, 2),
    (v_calificacion_id, 18, 4),
    (v_calificacion_id, 19, 3),
    (v_calificacion_id, 20, 3),
    (v_calificacion_id, 21, 3),
    (v_calificacion_id, 22, 4),
    (v_calificacion_id, 23, 4),
    (v_calificacion_id, 24, 4),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 3),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando JORGE ARBEY VARGAS
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('76030030', 'JORGE ARBEY VARGAS', 'LA JULIANA', 'ULLUCOS', 'SOTARA', 2.215935, -76.578464, 'Proyecto Sotará')
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
    (v_calificacion_id, 1, 4),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 3),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 2),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 10, 4),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 4),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 2),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 21, 4),
    (v_calificacion_id, 24, 4),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 4),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando BEATRIZ SANTIAGO SANCHEZ
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('25693713', 'BEATRIZ SANTIAGO SANCHEZ', 'LA MARGARITA', 'ULLUCOS', 'SOTARA', 2.217866, -76.596636, 'Proyecto Sotará')
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
    (v_calificacion_id, 1, 4),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 4, 3),
    (v_calificacion_id, 5, 3),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 3),
    (v_calificacion_id, 13, 4),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 2),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 21, 4),
    (v_calificacion_id, 22, 4),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 4),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 1);
END $$;


COMMIT;