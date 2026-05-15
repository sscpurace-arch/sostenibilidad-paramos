BEGIN;-- Procesando GUSTAVO ADOLFO MOSCA MONTOYA
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('1061698446', 'GUSTAVO ADOLFO MOSCA MONTOYA', 'CANELAL PARCELA 1', 'PIEDRA DE LEÓN ', 'SOTARA', 2.230262, -76.540983, 'Proyecto Sotará')
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
    (v_calificacion_id, 3, 3),
    (v_calificacion_id, 4, 3),
    (v_calificacion_id, 5, 3),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 2),
    (v_calificacion_id, 10, 4),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 4),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 3),
    (v_calificacion_id, 17, 2),
    (v_calificacion_id, 18, 2),
    (v_calificacion_id, 20, 4),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 3),
    (v_calificacion_id, 23, 5),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 4),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 3);
END $$;

-- Procesando HECTOR FABIO MAMBUSCAY TINTINAGO
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('4771241', 'HECTOR FABIO MAMBUSCAY TINTINAGO', 'EL RAMAL', 'PIEDRA DE LEÓN ', 'SOTARA', 2.233318, -76.549421, 'Proyecto Sotará')
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
    (v_calificacion_id, 1, 2),
    (v_calificacion_id, 2, 3),
    (v_calificacion_id, 3, 2),
    (v_calificacion_id, 4, 3),
    (v_calificacion_id, 5, 3),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 2),
    (v_calificacion_id, 10, 2),
    (v_calificacion_id, 11, 3),
    (v_calificacion_id, 12, 3),
    (v_calificacion_id, 13, 3),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 3),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 3),
    (v_calificacion_id, 23, 3),
    (v_calificacion_id, 24, 4),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 4),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando CARLOS ALBERTO TARAPUES QUENAN
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('98341876', 'CARLOS ALBERTO TARAPUES QUENAN', 'FINCA LA JOSEFINA 15', 'PIEDRA DE LEÓN ', 'SOTARA', 2.234564, -76.557092, 'Proyecto Sotará')
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
    (v_calificacion_id, 3, 3),
    (v_calificacion_id, 4, 3),
    (v_calificacion_id, 5, 3),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 2),
    (v_calificacion_id, 10, 3),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 3),
    (v_calificacion_id, 13, 1),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 3),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 2),
    (v_calificacion_id, 19, 2),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 2),
    (v_calificacion_id, 23, 5),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 5),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando DEYVID SANTIAGO MAMBUSCAY GARZON
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('1002821603', 'DEYVID SANTIAGO MAMBUSCAY GARZON', 'PARCELA 02', 'PIEDRA DE LEÓN', 'SOTARÁ ', 2.22886, -76.55038, 'Proyecto Sotará')
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
    (v_calificacion_id, 2, 3),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 5, 5),
    (v_calificacion_id, 6, 1),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 2),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 1),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 2),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 3),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 1),
    (v_calificacion_id, 20, 1),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 5),
    (v_calificacion_id, 23, 5),
    (v_calificacion_id, 25, 5),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 1),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando EIBER MAMBUSCAY TINTINAGO
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('4771399', 'EIBER MAMBUSCAY TINTINAGO', 'PARCELA N° 06', 'PIEDRA DE LEÓN', 'SOTARÁ ', 2.22802, -76.54892, 'Proyecto Sotará')
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
    (v_calificacion_id, 2, 3),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 5),
    (v_calificacion_id, 6, 1),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 11, 3),
    (v_calificacion_id, 12, 1),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 2),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 3),
    (v_calificacion_id, 18, 2),
    (v_calificacion_id, 19, 2),
    (v_calificacion_id, 20, 1),
    (v_calificacion_id, 21, 2),
    (v_calificacion_id, 22, 4),
    (v_calificacion_id, 23, 5),
    (v_calificacion_id, 25, 5),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 1);
END $$;


COMMIT;