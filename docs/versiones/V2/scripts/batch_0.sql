BEGIN;-- Procesando JUAN DIEGO TACUE TACUE
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('4771236', 'JUAN DIEGO TACUE TACUE', 'EL RECUERDO', 'ULLUCOS', 'SOTARA', 2.214333, -76.585882, 'Proyecto Sotará')
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
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 4, 3),
    (v_calificacion_id, 5, 2),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 10, 3),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 3),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 3),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 4),
    (v_calificacion_id, 19, 3),
    (v_calificacion_id, 20, 3),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 3),
    (v_calificacion_id, 23, 5),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando NANCY PATRICIA CIFUENTES DAZA
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('39623902', 'NANCY PATRICIA CIFUENTES DAZA', 'VILLA SOFIA', 'ULLUCOS', 'SOTARA', 2.199693, -76.600301, 'Proyecto Sotará')
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
    (v_calificacion_id, 9, 2),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 3),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 3),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 3),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 5),
    (v_calificacion_id, 23, 4),
    (v_calificacion_id, 25, 2),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 2);
END $$;

-- Procesando FLOR ESNEDA GRANDE
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('25693683', 'FLOR ESNEDA GRANDE', 'EL DIVISO', 'ULLUCOS', 'SOTARA', 2.201894, -76.595206, 'Proyecto Sotará')
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
    (v_calificacion_id, 21, 3),
    (v_calificacion_id, 22, 3),
    (v_calificacion_id, 23, 3),
    (v_calificacion_id, 24, 4),
    (v_calificacion_id, 25, 4),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando FABIOLA LEDEZMA MANZANO
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('29774725', 'FABIOLA LEDEZMA MANZANO', 'LA CRISTALINA', 'ULLUCOS', 'SOTARA', 2.204207, -76.585726, 'Proyecto Sotará')
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
    (v_calificacion_id, 4, 5),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 4),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 5),
    (v_calificacion_id, 9, 4),
    (v_calificacion_id, 10, 4),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 4),
    (v_calificacion_id, 13, 4),
    (v_calificacion_id, 14, 3),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 3),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 21, 3),
    (v_calificacion_id, 22, 4),
    (v_calificacion_id, 23, 4),
    (v_calificacion_id, 24, 4),
    (v_calificacion_id, 25, 4),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 2),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando LAURA VANESSA CIFUENTES LEDEZMA
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('1005979002', 'LAURA VANESSA CIFUENTES LEDEZMA', 'LA CRISTALINA', 'ULLUCOS', 'SOTARA', 2.205721, -76.58444, 'Proyecto Sotará')
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
    (v_calificacion_id, 4, 5),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 4),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 3),
    (v_calificacion_id, 9, 3),
    (v_calificacion_id, 10, 4),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 4),
    (v_calificacion_id, 13, 4),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 3),
    (v_calificacion_id, 17, 3),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 21, 3),
    (v_calificacion_id, 22, 3),
    (v_calificacion_id, 23, 4),
    (v_calificacion_id, 24, 4),
    (v_calificacion_id, 25, 4),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 2),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando MARTHA VIVIANA QUIÑONEZ GRANDE
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('106476394', 'MARTHA VIVIANA QUIÑONEZ GRANDE', 'CABUYERITA', 'ULLUCOS', 'SOTARA', 2.199295, -76.593669, 'Proyecto Sotará')
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
    (v_calificacion_id, 21, 3),
    (v_calificacion_id, 22, 3),
    (v_calificacion_id, 23, 4),
    (v_calificacion_id, 24, 4),
    (v_calificacion_id, 25, 4),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando TERESA DE JESUS TACUE DE ANACONA
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('25693546', 'TERESA DE JESUS TACUE DE ANACONA', 'LAS MARGARITAS', 'ULLUCOS', 'SOTARA', 2.215416, -76.579623, 'Proyecto Sotará')
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
    (v_calificacion_id, 7, 2),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 3),
    (v_calificacion_id, 10, 3),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 4),
    (v_calificacion_id, 13, 2),
    (v_calificacion_id, 14, 2),
    (v_calificacion_id, 15, 2),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 3),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 21, 3),
    (v_calificacion_id, 22, 3),
    (v_calificacion_id, 23, 4),
    (v_calificacion_id, 24, 4),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 4),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 3);
END $$;

-- Procesando DIOMAR QUIÑONEZ FERNANDEZ
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('31476021', 'DIOMAR QUIÑONEZ FERNANDEZ', 'PARCELA 22', 'ULLUCOS', 'SOTARA', 2.209142, -76.606331, 'Proyecto Sotará')
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
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 3),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 1),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 2),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 13, 4),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 4),
    (v_calificacion_id, 28, 3),
    (v_calificacion_id, 29, 2);
END $$;

-- Procesando MARIA TERESA ESPINOZA ALEGRIA
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('25694102', 'MARIA TERESA ESPINOZA ALEGRIA', 'EDEN', 'ULLUCOS', 'SOTARA', 2.207956, -76.59891, 'Proyecto Sotará')
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
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 4, 3),
    (v_calificacion_id, 5, 5),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 2),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 10, 3),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 13, 4),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 21, 2),
    (v_calificacion_id, 25, 4),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 4),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando MILTON JAVIER SANCHEZ GRUESO
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('1063810090', 'MILTON JAVIER SANCHEZ GRUESO', 'LA VILLA DEL GANADO', 'ULLUCOS', 'SOTARA', 2.19654, -76.5906, 'Proyecto Sotará')
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
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 4),
    (v_calificacion_id, 9, 2),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 3),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 1),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 2),
    (v_calificacion_id, 27, 5);
END $$;

-- Procesando JOSE OMAR SANCHEZ SANTIAGO
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('4771164', 'JOSE OMAR SANCHEZ SANTIAGO', 'LA FLORESTA', 'ULLUCOS', 'SOTARA', 2.20073, -76.59138, 'Proyecto Sotará')
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
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 3),
    (v_calificacion_id, 5, 5),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 2),
    (v_calificacion_id, 9, 2),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 2),
    (v_calificacion_id, 15, 5),
    (v_calificacion_id, 16, 3),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 2),
    (v_calificacion_id, 23, 4),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 4),
    (v_calificacion_id, 28, 3),
    (v_calificacion_id, 29, 4);
END $$;

-- Procesando MARIA TEREZA ANACONA CERON
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('25702819', 'MARIA TEREZA ANACONA CERON', 'EL EDEN', 'ULLUCOS', 'SOTARA', 2.20399, -76.58425, 'Proyecto Sotará')
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
    (v_calificacion_id, 2, 5),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 5, 5),
    (v_calificacion_id, 6, 2),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 3),
    (v_calificacion_id, 9, 3),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 13, 4),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 3),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 1),
    (v_calificacion_id, 21, 2),
    (v_calificacion_id, 23, 3),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 4),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando NIDIA SOSCUE COLLO
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('25691306', 'NIDIA SOSCUE COLLO', 'EL PARAISO', 'ULLUCOS', 'SOTARA', 2.20361, -76.58985, 'Proyecto Sotará')
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
    (v_calificacion_id, 2, 5),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 5),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 3),
    (v_calificacion_id, 9, 2),
    (v_calificacion_id, 10, 3),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 3),
    (v_calificacion_id, 13, 4),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 18, 5),
    (v_calificacion_id, 19, 4),
    (v_calificacion_id, 20, 3),
    (v_calificacion_id, 21, 2),
    (v_calificacion_id, 22, 2),
    (v_calificacion_id, 23, 1),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 3),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando LUIS ALFREDO CALPA CHIGUE
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('13039313', 'LUIS ALFREDO CALPA CHIGUE', 'LA PLANADA', 'ULLUCOS', 'SOTARA', 2.197166, -76.593719, 'Proyecto Sotará')
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
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 3),
    (v_calificacion_id, 4, 3),
    (v_calificacion_id, 5, 5),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 2),
    (v_calificacion_id, 9, 2),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 3),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 18, 4),
    (v_calificacion_id, 19, 4),
    (v_calificacion_id, 20, 2),
    (v_calificacion_id, 21, 2),
    (v_calificacion_id, 22, 4),
    (v_calificacion_id, 23, 4),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 3),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando CLAUDIA MARIA ESPINOZA ALEGRIA
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('25694177', 'CLAUDIA MARIA ESPINOZA ALEGRIA', 'PARCELA 32', 'ULLUCOS', 'SOTARA', 2.19889, -76.59315, 'Proyecto Sotará')
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
    (v_calificacion_id, 2, 5),
    (v_calificacion_id, 5, 5),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 8, 2),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 10, 3),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 3),
    (v_calificacion_id, 13, 4),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 1),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 3),
    (v_calificacion_id, 23, 4),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 2),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 2);
END $$;

-- Procesando JESUS HERNEY ASTAIZA MEJIA
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('1061770754', 'JESUS HERNEY ASTAIZA MEJIA', 'PARCELA 5', 'ULLUCOS', 'SOTARA', 2.20664, -76.59604, 'Proyecto Sotará')
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
    (v_calificacion_id, 2, 5),
    (v_calificacion_id, 3, 3),
    (v_calificacion_id, 5, 3),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 21, 2),
    (v_calificacion_id, 24, 3),
    (v_calificacion_id, 25, 4),
    (v_calificacion_id, 27, 5);
END $$;

-- Procesando INELDA COLLAZOS SALAZAR
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('25693801', 'INELDA COLLAZOS SALAZAR', 'EL REFUGIO - PARCELA #29', 'ULLUCOS', 'SOTARÁ', 2.19957, -76.59046, 'Proyecto Sotará')
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
    (v_calificacion_id, 2, 5),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 4, 5),
    (v_calificacion_id, 5, 5),
    (v_calificacion_id, 6, 1),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 2),
    (v_calificacion_id, 9, 4),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 1),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 5),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 1),
    (v_calificacion_id, 20, 1),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 23, 5),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 1),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 4),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando MARÍA VICTORIA MERA RUIZ
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('34547634', 'MARÍA VICTORIA MERA RUIZ', 'VICKY', 'ULLUCOS', 'SOTARÁ', 2.1945, -76.59121, 'Proyecto Sotará')
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
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 1),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 5),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 2),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 1),
    (v_calificacion_id, 20, 1),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 1),
    (v_calificacion_id, 23, 1),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 1),
    (v_calificacion_id, 26, 2),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 1),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando GERMAN CHAPID TULCÁN
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('4788173', 'GERMAN CHAPID TULCÁN', 'PARCELA # 08', 'ULLUCOS', 'SOTARÁ', 2.20508, -76.58875, 'Proyecto Sotará')
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
    (v_calificacion_id, 4, 3),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 1),
    (v_calificacion_id, 7, 2),
    (v_calificacion_id, 8, 2),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 10, 1),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 3),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 2),
    (v_calificacion_id, 19, 2),
    (v_calificacion_id, 20, 1),
    (v_calificacion_id, 21, 2),
    (v_calificacion_id, 24, 4),
    (v_calificacion_id, 25, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 29, 4);
END $$;

-- Procesando NOLBERTO COAJI BENAVIDES
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('4771252', 'NOLBERTO COAJI BENAVIDES', 'LOS MOTILONES', 'ULLUCOS', 'SOTARÁ', 2.20369, -76.60678, 'Proyecto Sotará')
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
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 1),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 5),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 1),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 1),
    (v_calificacion_id, 20, 2),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 23, 5),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 1),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando REYNEL SOSCUE QUIÑONES
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('10291060', 'REYNEL SOSCUE QUIÑONES', 'PARCELA 2', 'ULLUCOS', 'SOTARA', 2.210029, -76.60518, 'Proyecto Sotará')
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
    (v_calificacion_id, 2, 5),
    (v_calificacion_id, 5, 5),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 2),
    (v_calificacion_id, 8, 2),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 12, 4),
    (v_calificacion_id, 13, 1),
    (v_calificacion_id, 14, 4),
    (v_calificacion_id, 15, 1),
    (v_calificacion_id, 16, 5),
    (v_calificacion_id, 20, 1),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 27, 4);
END $$;

-- Procesando ABEL CORNELIO ESPINOSA
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('1806967', 'ABEL CORNELIO ESPINOSA', 'LA CAMILA', 'ULLUCOS', 'SOTARÁ', 2.204111, 2.204111, 'Proyecto Sotará')
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
    (v_calificacion_id, 6, 1),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 4),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 10, 4),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 18, 5),
    (v_calificacion_id, 19, 2),
    (v_calificacion_id, 20, 3),
    (v_calificacion_id, 21, 2),
    (v_calificacion_id, 22, 2),
    (v_calificacion_id, 23, 1),
    (v_calificacion_id, 25, 4),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 1),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando ISMAEL RUIZ COLLAZOS
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('4774379', 'ISMAEL RUIZ COLLAZOS', 'EL EDÉN', 'ULLUCOS', 'SOTARÁ', 2.202957, -76.588507, 'Proyecto Sotará')
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
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 2),
    (v_calificacion_id, 4, 3),
    (v_calificacion_id, 5, 3),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 3),
    (v_calificacion_id, 9, 2),
    (v_calificacion_id, 10, 3),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 13, 3),
    (v_calificacion_id, 14, 2),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 3),
    (v_calificacion_id, 18, 3),
    (v_calificacion_id, 19, 1),
    (v_calificacion_id, 20, 2),
    (v_calificacion_id, 21, 3),
    (v_calificacion_id, 22, 3),
    (v_calificacion_id, 23, 4),
    (v_calificacion_id, 24, 3),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 1),
    (v_calificacion_id, 28, 3),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando OSCAR GUEVARA
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('10455131', 'OSCAR GUEVARA', 'PARCELA #7', 'ULLUCOS', 'SOTARÁ', 2.206229, -76.593712, 'Proyecto Sotará')
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
    (v_calificacion_id, 3, 1),
    (v_calificacion_id, 4, 5),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 2),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 3),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 10, 4),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 5),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 1),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 3),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 1),
    (v_calificacion_id, 20, 1),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 1),
    (v_calificacion_id, 23, 2),
    (v_calificacion_id, 24, 4),
    (v_calificacion_id, 25, 2),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando JOSÉ ARÍSTIDES BENAVIDES
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('4771199', 'JOSÉ ARÍSTIDES BENAVIDES', 'EL RAMAL', 'ULLUCOS', 'SOTARÁ', 2.191136, -76.586893, 'Proyecto Sotará')
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
    (v_calificacion_id, 3, 2),
    (v_calificacion_id, 4, 5),
    (v_calificacion_id, 5, 1),
    (v_calificacion_id, 6, 4),
    (v_calificacion_id, 7, 1),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 10, 1),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 5),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 2),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 1),
    (v_calificacion_id, 20, 1),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 1),
    (v_calificacion_id, 23, 1),
    (v_calificacion_id, 24, 3),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando ALBEIRO ALEGRÍA MOLINA
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('4771279', 'ALBEIRO ALEGRÍA MOLINA', 'EL CLAVELLINO', 'ULLUCOS', 'SOTARÁ', 2.191859, -76.587396, 'Proyecto Sotará')
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
    (v_calificacion_id, 2, 5),
    (v_calificacion_id, 3, 2),
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 1),
    (v_calificacion_id, 7, 5),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 10, 1),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 5),
    (v_calificacion_id, 13, 3),
    (v_calificacion_id, 14, 4),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 3),
    (v_calificacion_id, 17, 2),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 3),
    (v_calificacion_id, 20, 3),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 1),
    (v_calificacion_id, 23, 5),
    (v_calificacion_id, 24, 4),
    (v_calificacion_id, 25, 4),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 5);
END $$;

-- Procesando FREDY ANACONA ANACONA
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('16783793', 'FREDY ANACONA ANACONA', 'PARCELA #17', 'ULLUCOS', 'SOTARÁ', 2.205621, -76.596143, 'Proyecto Sotará')
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
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 4, 3),
    (v_calificacion_id, 5, 3),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 4),
    (v_calificacion_id, 9, 4),
    (v_calificacion_id, 10, 3),
    (v_calificacion_id, 11, 3),
    (v_calificacion_id, 12, 4),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 2),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 3),
    (v_calificacion_id, 17, 3),
    (v_calificacion_id, 18, 5),
    (v_calificacion_id, 19, 4),
    (v_calificacion_id, 20, 3),
    (v_calificacion_id, 21, 2),
    (v_calificacion_id, 22, 1),
    (v_calificacion_id, 23, 5),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 4),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 5);
END $$;

-- Procesando ALMA ROSIO ANACONA
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('52158097', 'ALMA ROSIO ANACONA', 'PARCELA #16', 'ULLUCOS', 'SOTARÁ', 2.204189, -76.594265, 'Proyecto Sotará')
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
    (v_calificacion_id, 3, 3),
    (v_calificacion_id, 4, 5),
    (v_calificacion_id, 5, 3),
    (v_calificacion_id, 6, 1),
    (v_calificacion_id, 7, 2),
    (v_calificacion_id, 8, 2),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 10, 1),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 5),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 3),
    (v_calificacion_id, 17, 2),
    (v_calificacion_id, 18, 4),
    (v_calificacion_id, 19, 4),
    (v_calificacion_id, 20, 4),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 2),
    (v_calificacion_id, 23, 3),
    (v_calificacion_id, 24, 1),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 5);
END $$;

-- Procesando DEYSY JHACIBE COLLAZOS SALAZAR
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('34329981', 'DEYSY JHACIBE COLLAZOS SALAZAR', 'LOTE #4', 'ULLUCOS', 'SOTARÁ', 2.216636, -76.585097, 'Proyecto Sotará')
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
    (v_calificacion_id, 2, 5),
    (v_calificacion_id, 3, 5),
    (v_calificacion_id, 4, 5),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 10, 3),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 5),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 3),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 1),
    (v_calificacion_id, 20, 1),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 1),
    (v_calificacion_id, 23, 5),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 1),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 1),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando FABIOLA EMILCE ASTAIZA QUINONEZ
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('25693804', 'FABIOLA EMILCE ASTAIZA QUINONEZ', 'LOS ANGELES 1', 'ULLUCOS', 'SOTARÁ ', 2.193463, -76.587776, 'Proyecto Sotará')
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
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 4, 3),
    (v_calificacion_id, 5, 3),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 4),
    (v_calificacion_id, 9, 4),
    (v_calificacion_id, 10, 4),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 13, 3),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 1),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 2),
    (v_calificacion_id, 20, 5),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 23, 5),
    (v_calificacion_id, 24, 1),
    (v_calificacion_id, 25, 1),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando FRANCY DAMARIS ALEGRIA ORDOÑEZ
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('25694101', 'FRANCY DAMARIS ALEGRIA ORDOÑEZ', 'LA LUNA', 'ULLUCOS', 'SOTARÁ ', 2.206078, -76.60088, 'Proyecto Sotará')
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
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 5),
    (v_calificacion_id, 4, 3),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 4),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 2),
    (v_calificacion_id, 10, 3),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 13, 1),
    (v_calificacion_id, 14, 2),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 3),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 4),
    (v_calificacion_id, 19, 2),
    (v_calificacion_id, 20, 1),
    (v_calificacion_id, 21, 2),
    (v_calificacion_id, 22, 3),
    (v_calificacion_id, 23, 3),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 4),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 4);
END $$;

-- Procesando JUAN CARLOS GUANCHA ESCOBAR
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('87217881', 'JUAN CARLOS GUANCHA ESCOBAR', 'LOS ARRAYANES', 'ULLUCOS', 'SOTARÁ ', 2.206567, -76.597553, 'Proyecto Sotará')
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
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 5),
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 4),
    (v_calificacion_id, 7, 2),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 10, 2),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 1),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 3),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 2),
    (v_calificacion_id, 20, 1),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 5),
    (v_calificacion_id, 23, 5),
    (v_calificacion_id, 24, 3),
    (v_calificacion_id, 25, 4),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando ORLANDO CIFUENTES DAZA
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('11389333', 'ORLANDO CIFUENTES DAZA', 'MAUJATÁN', 'ULLUCOS', 'SOTARÁ', 2.196829, -76.591497, 'Proyecto Sotará')
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
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 2),
    (v_calificacion_id, 5, 5),
    (v_calificacion_id, 6, 2),
    (v_calificacion_id, 7, 2),
    (v_calificacion_id, 8, 2),
    (v_calificacion_id, 9, 2),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 13, 3),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 2),
    (v_calificacion_id, 16, 5),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 1),
    (v_calificacion_id, 20, 1),
    (v_calificacion_id, 21, 2),
    (v_calificacion_id, 24, 4),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 27, 4);
END $$;

-- Procesando FRANCISCO PARMENIDES MAMBUSCAY TINTINAGO
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('76290011', 'FRANCISCO PARMENIDES MAMBUSCAY TINTINAGO', 'EL MAYO', 'PIEDRA DE LEON', 'SOTARA', 2.229026, -76.55156, 'Proyecto Sotará')
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
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 3),
    (v_calificacion_id, 4, 2),
    (v_calificacion_id, 5, 5),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 10, 1),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 4),
    (v_calificacion_id, 19, 4),
    (v_calificacion_id, 20, 4),
    (v_calificacion_id, 21, 2),
    (v_calificacion_id, 22, 1),
    (v_calificacion_id, 23, 3),
    (v_calificacion_id, 24, 3),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 4),
    (v_calificacion_id, 28, 3),
    (v_calificacion_id, 29, 4);
END $$;

-- Procesando MARIA IRENE MEJIA MONTILLA
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('25693701', 'MARIA IRENE MEJIA MONTILLA', 'SAN GABRIEL #3', 'CASAS NUEVAS', 'SOTARA', 2.269612, -76.552383, 'Proyecto Sotará')
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
    (v_calificacion_id, 6, 5),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 3),
    (v_calificacion_id, 9, 3),
    (v_calificacion_id, 10, 3),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 4),
    (v_calificacion_id, 15, 5),
    (v_calificacion_id, 16, 3),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 18, 4),
    (v_calificacion_id, 19, 5),
    (v_calificacion_id, 20, 4),
    (v_calificacion_id, 21, 2),
    (v_calificacion_id, 22, 2),
    (v_calificacion_id, 23, 4),
    (v_calificacion_id, 25, 4),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 4),
    (v_calificacion_id, 28, 2),
    (v_calificacion_id, 29, 4);
END $$;


COMMIT;