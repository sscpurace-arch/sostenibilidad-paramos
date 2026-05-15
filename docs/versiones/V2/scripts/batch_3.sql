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

-- Procesando JAIR COAJI SANTIAGO
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('4771438', 'JAIR COAJI SANTIAGO', 'LA MARGARITA', 'ULLUCOS', 'SOTARA', 2.2192291, -76.596392, 'Proyecto Sotará')
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
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 3),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 4),
    (v_calificacion_id, 13, 1),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 3),
    (v_calificacion_id, 23, 3),
    (v_calificacion_id, 24, 4),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 26, 3),
    (v_calificacion_id, 27, 4),
    (v_calificacion_id, 28, 1);
END $$;

-- Procesando VICTOR ARVEY MURILLO SANCHEZ
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('76296906', 'VICTOR ARVEY MURILLO SANCHEZ', 'EL CARMEN ', 'ULLUCOS', 'SOTARÁ', 2.2165, -76.59705, 'Proyecto Sotará')
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
    (v_calificacion_id, 2, 3),
    (v_calificacion_id, 3, 5),
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 1),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 2),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 10, 3),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 3),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 2),
    (v_calificacion_id, 20, 3),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 23, 5),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 1),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando ANGELA LUCERO TORRES CRIOLLO
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('1064676920', 'ANGELA LUCERO TORRES CRIOLLO', 'ARGELIA', 'ULLUCOS', 'SOTARÁ ', 2.213678, -76.596935, 'Proyecto Sotará')
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
    (v_calificacion_id, 2, 5),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 2),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 2),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 11, 1),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 13, 4),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 3),
    (v_calificacion_id, 19, 1),
    (v_calificacion_id, 20, 2),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 1),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando MANUEL BOLIVAR ZAMBRANO
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('1064676291', 'MANUEL BOLIVAR ZAMBRANO', 'CAJAMARQUITA', '', 'SOTARA', 2.240343, -76.54655, 'Proyecto Sotará')
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
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 5),
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 5),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 3),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 11, 1),
    (v_calificacion_id, 13, 2),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 2),
    (v_calificacion_id, 18, 4),
    (v_calificacion_id, 19, 1),
    (v_calificacion_id, 20, 3),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 4),
    (v_calificacion_id, 23, 4),
    (v_calificacion_id, 24, 4),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 3),
    (v_calificacion_id, 29, 3);
END $$;

-- Procesando DIEGO ARMANDO DIAZ CUCHUMBE
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('1060238959', 'DIEGO ARMANDO DIAZ CUCHUMBE', 'PARCELA #14', '', 'SOTARA', 2.242472, -76.546497, 'Proyecto Sotará')
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
    (v_calificacion_id, 3, 5),
    (v_calificacion_id, 5, 5),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 3),
    (v_calificacion_id, 10, 1),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 13, 4),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 5),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 4),
    (v_calificacion_id, 19, 3),
    (v_calificacion_id, 20, 3),
    (v_calificacion_id, 21, 2),
    (v_calificacion_id, 22, 4),
    (v_calificacion_id, 23, 5),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 2),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando JHON ALEXANDER HERRERA MENDEZ
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('1064677004', 'JHON ALEXANDER HERRERA MENDEZ', 'EL UVO', '', 'SOTARA', 2.25016, -76.558039, 'Proyecto Sotará')
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
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 4),
    (v_calificacion_id, 9, 3),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 13, 4),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 1),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 23, 1),
    (v_calificacion_id, 24, 1),
    (v_calificacion_id, 25, 1),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando ANA SULEIMA GARCIA LAME
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('1061746316', 'ANA SULEIMA GARCIA LAME', 'LAS BRISAS', '', 'SOTARA', 2.25021, -76.5561, 'Proyecto Sotará')
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
    (v_calificacion_id, 2, 2),
    (v_calificacion_id, 3, 3),
    (v_calificacion_id, 4, 3),
    (v_calificacion_id, 5, 3),
    (v_calificacion_id, 6, 4),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 10, 1),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 1),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 18, 5),
    (v_calificacion_id, 19, 4),
    (v_calificacion_id, 20, 4),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 2),
    (v_calificacion_id, 23, 1),
    (v_calificacion_id, 24, 3),
    (v_calificacion_id, 25, 1),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 2),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 3);
END $$;

-- Procesando ROMEIRO MAPALLO MELENGE
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('76290202', 'ROMEIRO MAPALLO MELENGE', 'LAS BRISAS', 'PIEDRA DE LEON', 'SOTARA', 2.247606, -76.55699, 'Proyecto Sotará')
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
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 3),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 10, 4),
    (v_calificacion_id, 12, 3),
    (v_calificacion_id, 13, 4),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 2),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 3),
    (v_calificacion_id, 18, 4),
    (v_calificacion_id, 19, 4),
    (v_calificacion_id, 20, 3),
    (v_calificacion_id, 21, 2),
    (v_calificacion_id, 22, 1),
    (v_calificacion_id, 24, 4),
    (v_calificacion_id, 25, 2),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 1),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando NORMA YOLANDA MENDEZ SALAZAR
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('51786901', 'NORMA YOLANDA MENDEZ SALAZAR', 'CAJAMARCA', 'PIEDRA DE LEÓN ', 'SOTARA', 2.241508, -76.548122, 'Proyecto Sotará')
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
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 2),
    (v_calificacion_id, 10, 3),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 3),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 4),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 4),
    (v_calificacion_id, 19, 4),
    (v_calificacion_id, 20, 3),
    (v_calificacion_id, 21, 2),
    (v_calificacion_id, 22, 3),
    (v_calificacion_id, 23, 4),
    (v_calificacion_id, 24, 4),
    (v_calificacion_id, 25, 5),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 2),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando JOSE LEONARDO URBANO AGREDO
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('10542047', 'JOSE LEONARDO URBANO AGREDO', 'LA JOSEFINA PARCELA 2', 'PIEDRA DE LEÓN ', 'SOTARA', 2.23999, -76.55291, 'Proyecto Sotará')
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
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 3),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 3),
    (v_calificacion_id, 10, 2),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 4),
    (v_calificacion_id, 13, 1),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 3),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 4),
    (v_calificacion_id, 23, 4),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 4),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 4),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 3);
END $$;

-- Procesando MARIA LUISA TINTINAGO MENDEZ
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('48661808', 'MARIA LUISA TINTINAGO MENDEZ', 'BERDUV', 'PIEDRA DE LEÓN ', 'SOTARA', 2.241935, -76.548317, 'Proyecto Sotará')
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
    (v_calificacion_id, 6, 2),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 2),
    (v_calificacion_id, 10, 3),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 3),
    (v_calificacion_id, 13, 1),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 1),
    (v_calificacion_id, 16, 3),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 2),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 3),
    (v_calificacion_id, 23, 3),
    (v_calificacion_id, 25, 5),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 1),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando LEONEL ARTURO RIVERA CABRERA
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('98396591', 'LEONEL ARTURO RIVERA CABRERA', 'SANTA ELENA 17', 'PIEDRA DE LEÓN ', 'SOTARA', 2.24483, -76.54691, 'Proyecto Sotará')
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
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 3),
    (v_calificacion_id, 10, 3),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 4),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 2),
    (v_calificacion_id, 15, 5),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 18, 3),
    (v_calificacion_id, 19, 4),
    (v_calificacion_id, 20, 3),
    (v_calificacion_id, 21, 3),
    (v_calificacion_id, 22, 5),
    (v_calificacion_id, 23, 4),
    (v_calificacion_id, 25, 5),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 4),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 3);
END $$;

-- Procesando UBER SALAZAR MUÑOZ
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('10548542', 'UBER SALAZAR MUÑOZ', 'BELLA VISTA', 'PIEDRA DE LEÓN ', 'SOTARA', 2245278, -76.553911, 'Proyecto Sotará')
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
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 5),
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 4),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 4),
    (v_calificacion_id, 9, 3),
    (v_calificacion_id, 10, 4),
    (v_calificacion_id, 11, 3),
    (v_calificacion_id, 12, 4),
    (v_calificacion_id, 13, 1),
    (v_calificacion_id, 14, 3),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 5),
    (v_calificacion_id, 17, 1),
    (v_calificacion_id, 18, 4),
    (v_calificacion_id, 19, 2),
    (v_calificacion_id, 20, 3),
    (v_calificacion_id, 21, 5),
    (v_calificacion_id, 22, 5),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 5),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 3),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando FELIPE LEON MUÑOZ 
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('1517789', 'FELIPE LEON MUÑOZ ', 'LOMITAS ', 'PIEDRA DE LEÓN ', 'SOTARÁ ', 2.244796, -76.550691, 'Proyecto Sotará')
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
    (v_calificacion_id, 2, 5),
    (v_calificacion_id, 3, 3),
    (v_calificacion_id, 4, 3),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 1),
    (v_calificacion_id, 7, 5),
    (v_calificacion_id, 8, 5),
    (v_calificacion_id, 9, 4),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 5),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 1),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 2),
    (v_calificacion_id, 20, 1),
    (v_calificacion_id, 21, 2),
    (v_calificacion_id, 22, 4),
    (v_calificacion_id, 23, 5),
    (v_calificacion_id, 25, 5),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando JORGE ARMANDO DÍAZ MANGUAY
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('76312936', 'JORGE ARMANDO DÍAZ MANGUAY', 'LAS CRUCES', 'PIEDRA DE LEÓN', 'SOTARÁ', 2.23888, -76.5412, 'Proyecto Sotará')
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
    (v_calificacion_id, 2, 1),
    (v_calificacion_id, 3, 2),
    (v_calificacion_id, 5, 5),
    (v_calificacion_id, 6, 1),
    (v_calificacion_id, 7, 5),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 2),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 3),
    (v_calificacion_id, 18, 2),
    (v_calificacion_id, 19, 1),
    (v_calificacion_id, 20, 1),
    (v_calificacion_id, 21, 2),
    (v_calificacion_id, 22, 5),
    (v_calificacion_id, 23, 3),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 5),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando ERIBERTO RAMOS 
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('351677', 'ERIBERTO RAMOS ', 'EL LAUREL', 'PIEDRA DE LEÓN ', 'SOTARÁ', 2.23993, -76.54411, 'Proyecto Sotará')
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
    (v_calificacion_id, 2, 1),
    (v_calificacion_id, 3, 5),
    (v_calificacion_id, 4, 3),
    (v_calificacion_id, 5, 5),
    (v_calificacion_id, 6, 2),
    (v_calificacion_id, 7, 5),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 2),
    (v_calificacion_id, 10, 4),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 3),
    (v_calificacion_id, 18, 2),
    (v_calificacion_id, 19, 2),
    (v_calificacion_id, 20, 1),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 5),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 5),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 3);
END $$;

-- Procesando LIBARDO SÁNCHEZ ORTÍZ
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('76284900', 'LIBARDO SÁNCHEZ ORTÍZ', 'LA ESPERANZA ', 'PIEDRA DE LEÓN', 'SOTARÁ', 2.2455, -76.55271, 'Proyecto Sotará')
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
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 1),
    (v_calificacion_id, 6, 1),
    (v_calificacion_id, 7, 2),
    (v_calificacion_id, 8, 3),
    (v_calificacion_id, 9, 3),
    (v_calificacion_id, 10, 4),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 2),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 3),
    (v_calificacion_id, 17, 3),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 2),
    (v_calificacion_id, 20, 1),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando GEOVANNY CALAMBAZ YALANDA
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('76306996', 'GEOVANNY CALAMBAZ YALANDA', 'BELLA VISTA', 'PIEDRA DE LEÓN', 'SOTARÁ', 2.24778, -76.55516, 'Proyecto Sotará')
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
    (v_calificacion_id, 5, 3),
    (v_calificacion_id, 6, 1),
    (v_calificacion_id, 7, 2),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 13, 4),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 2),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 2),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 1),
    (v_calificacion_id, 20, 1),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 23, 4),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 2),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 4),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando HERMES ALEXANDER MAMBUSCAY ZAMBRANO
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('1064676922', 'HERMES ALEXANDER MAMBUSCAY ZAMBRANO', 'EL DIVISO', 'PIEDRA DE LEON', 'SOTARÁ ', 2.248999, -76.554285, 'Proyecto Sotará')
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
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 2),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 3),
    (v_calificacion_id, 9, 2),
    (v_calificacion_id, 10, 2),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 5),
    (v_calificacion_id, 16, 3),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 1),
    (v_calificacion_id, 20, 1),
    (v_calificacion_id, 21, 2),
    (v_calificacion_id, 22, 2),
    (v_calificacion_id, 23, 5),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 5),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 4);
END $$;

-- Procesando JESUS ARTURO ACOSTA MUÑOZ
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('76310162', 'JESUS ARTURO ACOSTA MUÑOZ', 'LAS PAMPAS', 'PIEDRA DE LEÓN', 'SOTARÁ', 2.244247, -76.549743, 'Proyecto Sotará')
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
    (v_calificacion_id, 3, 5),
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 5),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 5),
    (v_calificacion_id, 8, 3),
    (v_calificacion_id, 9, 5),
    (v_calificacion_id, 10, 4),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 3),
    (v_calificacion_id, 18, 4),
    (v_calificacion_id, 19, 3),
    (v_calificacion_id, 20, 2),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 2),
    (v_calificacion_id, 23, 5),
    (v_calificacion_id, 24, 3),
    (v_calificacion_id, 25, 5),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 2),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 1);
END $$;

COMMIT;
COMMIT;