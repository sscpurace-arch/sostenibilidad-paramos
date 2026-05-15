BEGIN;

-- Procesando JUAN DIEGO TACUE TACUE
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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

-- Procesando AIDA NUBIOLA OBANDO ASTAHIZA
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('34485089', 'AIDA NUBIOLA OBANDO ASTAHIZA', 'CAMPO BELLO', 'PIEDRA DE LEON', 'SOTARA', 2.226302, -76.537474, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 5),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 5),
    (v_calificacion_id, 4, 3),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 2),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 4),
    (v_calificacion_id, 19, 3),
    (v_calificacion_id, 20, 1),
    (v_calificacion_id, 21, 2),
    (v_calificacion_id, 22, 2),
    (v_calificacion_id, 23, 2),
    (v_calificacion_id, 24, 4),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 27, 3),
    (v_calificacion_id, 28, 3),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando JOSE OMAR GALLEGO ARBOLEDA
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('4787769', 'JOSE OMAR GALLEGO ARBOLEDA', 'SANGABRIEL', '', 'SOTARA', 2.271543, -76.555304, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 4),
    (v_calificacion_id, 2, 5),
    (v_calificacion_id, 3, 5),
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 5),
    (v_calificacion_id, 8, 3),
    (v_calificacion_id, 9, 5),
    (v_calificacion_id, 10, 3),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 13, 4),
    (v_calificacion_id, 14, 2),
    (v_calificacion_id, 15, 5),
    (v_calificacion_id, 16, 5),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 5),
    (v_calificacion_id, 20, 3),
    (v_calificacion_id, 21, 3),
    (v_calificacion_id, 22, 3),
    (v_calificacion_id, 23, 4),
    (v_calificacion_id, 24, 3),
    (v_calificacion_id, 25, 4),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 3),
    (v_calificacion_id, 28, 3),
    (v_calificacion_id, 29, 3);
END $$;

-- Procesando OMAR JOSE CEBALLOS ORDOÑEZ
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('10545079', 'OMAR JOSE CEBALLOS ORDOÑEZ', 'LA JOSEFINA', 'LA JOSEFINA', 'SOTARA', 2.236027, -76.561927, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 4),
    (v_calificacion_id, 2, 5),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 2),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 2),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 5),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 23, 4),
    (v_calificacion_id, 25, 4),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 4),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando LUIS ALBERTO CEBALLOS ALQUEDAN
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('98341686', 'LUIS ALBERTO CEBALLOS ALQUEDAN', 'LA JOSEFINA', 'LA JOSEFINA', 'SOTARA', 2.236489, -76.55917, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 5),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 5),
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 5),
    (v_calificacion_id, 6, 5),
    (v_calificacion_id, 8, 2),
    (v_calificacion_id, 9, 2),
    (v_calificacion_id, 10, 3),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 3),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 5),
    (v_calificacion_id, 16, 3),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 18, 5),
    (v_calificacion_id, 19, 5),
    (v_calificacion_id, 20, 5),
    (v_calificacion_id, 21, 4),
    (v_calificacion_id, 22, 2),
    (v_calificacion_id, 23, 3),
    (v_calificacion_id, 24, 4),
    (v_calificacion_id, 25, 5),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 4),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 5);
END $$;

-- Procesando LILIANA MUÑOZ ASTAIZA
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('55163823', 'LILIANA MUÑOZ ASTAIZA', 'LA JOSEFINA', 'LA JOSEFINA', 'SOTARA', 2.234801, -76.55913, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 5),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 4, 3),
    (v_calificacion_id, 6, 2),
    (v_calificacion_id, 7, 5),
    (v_calificacion_id, 8, 3),
    (v_calificacion_id, 9, 2),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 4),
    (v_calificacion_id, 15, 5),
    (v_calificacion_id, 16, 4),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 2),
    (v_calificacion_id, 21, 2),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 4),
    (v_calificacion_id, 27, 5);
END $$;

-- Procesando EUDOSIA DEL CARMEN PADILLA OTERO
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('30688542', 'EUDOSIA DEL CARMEN PADILLA OTERO', 'LA JOSEFINA', 'LA JOSEFINA', 'SOTARA', 2.235732, -76.55906, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 3),
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 5),
    (v_calificacion_id, 6, 4),
    (v_calificacion_id, 8, 2),
    (v_calificacion_id, 9, 2),
    (v_calificacion_id, 10, 4),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 3),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 5),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 18, 4),
    (v_calificacion_id, 19, 2),
    (v_calificacion_id, 20, 3),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 27, 5);
END $$;

-- Procesando EDIT BARBARA OLAVE MOLINA
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('34550554', 'EDIT BARBARA OLAVE MOLINA', 'LA JOSEFINA', 'LA JOSEFINA', 'SOTARA', 2.236706, -76.5557, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 5),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 5),
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 5),
    (v_calificacion_id, 6, 4),
    (v_calificacion_id, 7, 5),
    (v_calificacion_id, 8, 4),
    (v_calificacion_id, 9, 2),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 1),
    (v_calificacion_id, 21, 2),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 27, 5);
END $$;

-- Procesando RUBER ARIEL CERQUERA URRUTIA
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('10290755', 'RUBER ARIEL CERQUERA URRUTIA', 'LA JOSEFINA 6', 'LA JOSEFINA', 'SOTARA', 2.237181, -76.562022, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 5),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 5),
    (v_calificacion_id, 4, 3),
    (v_calificacion_id, 5, 5),
    (v_calificacion_id, 6, 2),
    (v_calificacion_id, 7, 5),
    (v_calificacion_id, 8, 4),
    (v_calificacion_id, 9, 3),
    (v_calificacion_id, 10, 3),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 2),
    (v_calificacion_id, 15, 5),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 4),
    (v_calificacion_id, 19, 4),
    (v_calificacion_id, 20, 3),
    (v_calificacion_id, 21, 2),
    (v_calificacion_id, 23, 2),
    (v_calificacion_id, 24, 4),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 3),
    (v_calificacion_id, 29, 4);
END $$;

-- Procesando ELIO CASTILLO MOSCA
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('76309539', 'ELIO CASTILLO MOSCA', 'EL ESTRECHO', 'CAMPOBELLO', 'SOTARA', 2.21838, -76.5347, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 5),
    (v_calificacion_id, 2, 5),
    (v_calificacion_id, 3, 5),
    (v_calificacion_id, 5, 5),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 5),
    (v_calificacion_id, 8, 4),
    (v_calificacion_id, 9, 5),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 13, 3),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 21, 4),
    (v_calificacion_id, 22, 3),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 4),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 4);
END $$;

-- Procesando ROVINSON SANCHEZ CONEJO
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('76316673', 'ROVINSON SANCHEZ CONEJO', 'CAMPO BELLO 10', 'CAMPO BELLO', 'SOTARA', 2.219988, -76.54377, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 4),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 3),
    (v_calificacion_id, 5, 5),
    (v_calificacion_id, 6, 1),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 4),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 13, 3),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 24, 4),
    (v_calificacion_id, 25, 4),
    (v_calificacion_id, 27, 4),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando MOISES ANTONIO COAJI MAMBUSCAY
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('4771314', 'MOISES ANTONIO COAJI MAMBUSCAY', 'MAYO', 'PIEDRA DE LEON', 'SOTARA', 2.228696, -76.55313, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 4),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 3),
    (v_calificacion_id, 4, 2),
    (v_calificacion_id, 5, 3),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 3),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 13, 4),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 1),
    (v_calificacion_id, 21, 2),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 27, 3);
END $$;

-- Procesando JHON FREDY GONZALEZ BOLAÑOS
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('76295922', 'JHON FREDY GONZALEZ BOLAÑOS', 'VIENTO LIBRE', 'PIEDRA DE LEÓN ', 'SOTARA', 2.23255, -76.55065, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 2),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 2),
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 2),
    (v_calificacion_id, 6, 4),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 3),
    (v_calificacion_id, 10, 4),
    (v_calificacion_id, 11, 3),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 5),
    (v_calificacion_id, 16, 3),
    (v_calificacion_id, 17, 3),
    (v_calificacion_id, 18, 2),
    (v_calificacion_id, 19, 1),
    (v_calificacion_id, 20, 2),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 1),
    (v_calificacion_id, 23, 3),
    (v_calificacion_id, 25, 4),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando EDGAR PIZO
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('76290042', 'EDGAR PIZO', 'LA JOSEFINA PARCELA 3', 'PIEDRA DE LEÓN ', 'SOTARA', 2.23537, -76.55606, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 4),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 4),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 2),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 3),
    (v_calificacion_id, 13, 1),
    (v_calificacion_id, 14, 3),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 21, 3),
    (v_calificacion_id, 22, 3),
    (v_calificacion_id, 23, 3),
    (v_calificacion_id, 24, 4),
    (v_calificacion_id, 25, 5),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando MARLENY SOSCUE GRANDE
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('25697112', 'MARLENY SOSCUE GRANDE', 'SANTA ELENA', 'CASAS NUEVAS', 'SOTARA', 2.26276, -76.55606, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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
    (v_calificacion_id, 9, 4),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 4),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 3),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 18, 3),
    (v_calificacion_id, 19, 3),
    (v_calificacion_id, 21, 3),
    (v_calificacion_id, 22, 4),
    (v_calificacion_id, 23, 4),
    (v_calificacion_id, 25, 5),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando IVAN RENE MOSCA MONTOYA
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('1064676830', 'IVAN RENE MOSCA MONTOYA', 'CANELAL', 'PIEDRA DE LEÓN ', 'SOTARA', 2.229287, -76.544142, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 3),
    (v_calificacion_id, 2, 3),
    (v_calificacion_id, 3, 3),
    (v_calificacion_id, 4, 3),
    (v_calificacion_id, 5, 2),
    (v_calificacion_id, 6, 2),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 2),
    (v_calificacion_id, 10, 2),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 3),
    (v_calificacion_id, 17, 1),
    (v_calificacion_id, 18, 2),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 4),
    (v_calificacion_id, 23, 5),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 4),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando GUSTAVO ADOLFO MOSCA MONTOYA
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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

-- Procesando NOIMAN FEBRES RIVERA OBANDO
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('10308477', 'NOIMAN FEBRES RIVERA OBANDO', 'BELLA VISTA ', 'CASAS NUEVAS', 'SOTARÁ', 2.26478824, -76.55716124, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 1),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 5, 5),
    (v_calificacion_id, 6, 1),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 3),
    (v_calificacion_id, 9, 4),
    (v_calificacion_id, 10, 3),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 13, 4),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 3),
    (v_calificacion_id, 19, 2),
    (v_calificacion_id, 20, 1),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 5),
    (v_calificacion_id, 23, 5),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 5),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 1),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 3);
END $$;

-- Procesando MARY SOL MERA QUIÑONEZ
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('1063817889', 'MARY SOL MERA QUIÑONEZ', 'PARCELA 10', 'PIEDRA DE LEÓN', 'SOTARÁ', 2.23346, -76.55844, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 5),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 1),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 5),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 10, 1),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 5),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 3),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 1),
    (v_calificacion_id, 20, 1),
    (v_calificacion_id, 21, 2),
    (v_calificacion_id, 23, 3),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 4),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 4);
END $$;

-- Procesando NESTOR JULIAN MUÑOZ CALAMBAS
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('1060237416', 'NESTOR JULIAN MUÑOZ CALAMBAS', 'EL MAYO ', 'PIEDRA DE LEÓN ', 'SOTARÁ ', 2.23341, -76.55788, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 1),
    (v_calificacion_id, 2, 5),
    (v_calificacion_id, 3, 3),
    (v_calificacion_id, 5, 5),
    (v_calificacion_id, 6, 1),
    (v_calificacion_id, 7, 3),
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
    (v_calificacion_id, 19, 2),
    (v_calificacion_id, 20, 1),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 23, 4),
    (v_calificacion_id, 24, 3),
    (v_calificacion_id, 25, 1),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando AIDA LUCILA RIVERA OBANDO
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('34315870', 'AIDA LUCILA RIVERA OBANDO', 'CAMPO BELLO', 'CAMPO BELLO', 'SOTARÁ ', 2.22538942, -76.53873851, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 1),
    (v_calificacion_id, 2, 2),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 4, 3),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 10, 2),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 1),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 3),
    (v_calificacion_id, 18, 4),
    (v_calificacion_id, 19, 2),
    (v_calificacion_id, 20, 1),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 5),
    (v_calificacion_id, 23, 1),
    (v_calificacion_id, 25, 5),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 4);
END $$;

-- Procesando SAMUEL MAMBUSCAY TINTINAGO
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('76330564', 'SAMUEL MAMBUSCAY TINTINAGO', 'EL RAMAL # 2', 'PIEDRA DE LEÓN', 'SOTARÁ', 2.2302999, -76.5493785, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 1),
    (v_calificacion_id, 2, 3),
    (v_calificacion_id, 3, 2),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 4),
    (v_calificacion_id, 7, 1),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 3),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 2),
    (v_calificacion_id, 20, 2),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 23, 5),
    (v_calificacion_id, 24, 4),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando LUCILA QUIÑONEZ COLLAZOS
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('34562182', 'LUCILA QUIÑONEZ COLLAZOS', 'EL ALTO PARCELA #02', 'CASAS NUEVAS', 'SOTARÁ', 2.28429946, -76.54437759, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 3),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 1),
    (v_calificacion_id, 7, 5),
    (v_calificacion_id, 8, 3),
    (v_calificacion_id, 9, 4),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 13, 4),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 1),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 1),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 2),
    (v_calificacion_id, 20, 1),
    (v_calificacion_id, 21, 2),
    (v_calificacion_id, 23, 5),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 1),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando ROBERTO ZAMBRANO MUÑOZ
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('4749497', 'ROBERTO ZAMBRANO MUÑOZ', 'PORVENIR EL ALCAZAR', 'PIEDRA DE LEON', 'SOTARÁ ', 2.207255, -76.552988, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 2),
    (v_calificacion_id, 2, 5),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 2),
    (v_calificacion_id, 6, 2),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 2),
    (v_calificacion_id, 9, 2),
    (v_calificacion_id, 10, 4),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 13, 4),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 5),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 2),
    (v_calificacion_id, 19, 2),
    (v_calificacion_id, 20, 2),
    (v_calificacion_id, 21, 2),
    (v_calificacion_id, 22, 2),
    (v_calificacion_id, 23, 5),
    (v_calificacion_id, 24, 1),
    (v_calificacion_id, 25, 4),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 4),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando BERNABE CHANTRE ESCOBAR
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('76317110', 'BERNABE CHANTRE ESCOBAR', 'LA PALMA', 'PIEDRA DE LEON', 'SOTARÁ ', 2.221882, -76.55129, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 2),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 4, 3),
    (v_calificacion_id, 5, 2),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 2),
    (v_calificacion_id, 10, 4),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 13, 4),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 4),
    (v_calificacion_id, 19, 2),
    (v_calificacion_id, 20, 2),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 3),
    (v_calificacion_id, 23, 5),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 1),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 1),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando BERTHA IRENE MONTOYA MORALES
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('36381597', 'BERTHA IRENE MONTOYA MORALES', 'EL CRISTAL', 'PIEDRA DE LEON', 'SOTARÁ ', 2.236372, -76.547623, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 1),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 3),
    (v_calificacion_id, 10, 4),
    (v_calificacion_id, 11, 1),
    (v_calificacion_id, 12, 3),
    (v_calificacion_id, 13, 3),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 5),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 4),
    (v_calificacion_id, 19, 2),
    (v_calificacion_id, 20, 2),
    (v_calificacion_id, 21, 3),
    (v_calificacion_id, 23, 5),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 5),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando ANGELA FERNANDA RUIZ ASTAIZA
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('1061704137', 'ANGELA FERNANDA RUIZ ASTAIZA', 'LA MORENA', 'CASAS NUEVAS', 'SOTARÁ ', 2.277032, -76.54843, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 4),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 5),
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 2),
    (v_calificacion_id, 6, 2),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 2),
    (v_calificacion_id, 9, 4),
    (v_calificacion_id, 10, 3),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 3),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 3),
    (v_calificacion_id, 20, 2),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 2),
    (v_calificacion_id, 23, 5),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando DORA MILENA COQUE PERDOMO
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('34323133', 'DORA MILENA COQUE PERDOMO', 'LAS MARGARITAS', 'PIEDRA DE LEÓN', 'SOTARÁ ', 2.231824, -76.554485, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 1),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 4, 3),
    (v_calificacion_id, 5, 2),
    (v_calificacion_id, 6, 2),
    (v_calificacion_id, 7, 2),
    (v_calificacion_id, 8, 2),
    (v_calificacion_id, 9, 3),
    (v_calificacion_id, 10, 2),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 4),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 3),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 3),
    (v_calificacion_id, 20, 1),
    (v_calificacion_id, 21, 2),
    (v_calificacion_id, 22, 1),
    (v_calificacion_id, 23, 5),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 2),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 1),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando LEONILA CASTILLO ALBÁN
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('39793246', 'LEONILA CASTILLO ALBÁN', 'SANTA CECILIA ', 'SAN ROQUE', 'SOTARÁ ', 2.1715194, -76.6240194, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 2),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 5),
    (v_calificacion_id, 9, 5),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 1),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 2),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 2),
    (v_calificacion_id, 20, 1),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 3),
    (v_calificacion_id, 23, 4),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 5),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando ANA CECILIA JIMENEZ YAQUENO
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('48600036', 'ANA CECILIA JIMENEZ YAQUENO', 'BELLA VISTA', 'SAN ROQUE ', 'SOTARÁ ', 2.16073, -76.60101, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 2),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 5, 3),
    (v_calificacion_id, 6, 1),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 3),
    (v_calificacion_id, 9, 2),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 1),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 2),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 1),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 1),
    (v_calificacion_id, 20, 1),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 1),
    (v_calificacion_id, 23, 4),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 2),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 4);
END $$;

-- Procesando MARÍA INÉS COLLAZOS SILVA
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('25700280', 'MARÍA INÉS COLLAZOS SILVA', 'LAS PIEDRAS', 'SAN ROQUE ', 'SOTARÁ ', 2.161805, -76.607034, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 2),
    (v_calificacion_id, 2, 1),
    (v_calificacion_id, 3, 2),
    (v_calificacion_id, 4, 3),
    (v_calificacion_id, 5, 3),
    (v_calificacion_id, 6, 1),
    (v_calificacion_id, 7, 1),
    (v_calificacion_id, 8, 3),
    (v_calificacion_id, 9, 3),
    (v_calificacion_id, 10, 1),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 13, 3),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 2),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 1),
    (v_calificacion_id, 20, 1),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 23, 5),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 2),
    (v_calificacion_id, 26, 1),
    (v_calificacion_id, 27, 4),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando MARTHA CECILIA SILVA PALECHOR
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('34321845', 'MARTHA CECILIA SILVA PALECHOR', 'LOS CEDROS, LAS ESTRELLAS', 'SAN ROQUE ', 'SOTARÁ ', 2.17389, -76.6118, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 3),
    (v_calificacion_id, 2, 2),
    (v_calificacion_id, 3, 3),
    (v_calificacion_id, 4, 5),
    (v_calificacion_id, 5, 3),
    (v_calificacion_id, 6, 2),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 2),
    (v_calificacion_id, 9, 2),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 4),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 3),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 2),
    (v_calificacion_id, 19, 2),
    (v_calificacion_id, 20, 3),
    (v_calificacion_id, 21, 2),
    (v_calificacion_id, 22, 2),
    (v_calificacion_id, 23, 4),
    (v_calificacion_id, 24, 4),
    (v_calificacion_id, 25, 2),
    (v_calificacion_id, 26, 3),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando CONSTANCIA ARGELIA QUILINDO CAMAYO
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('34543947', 'CONSTANCIA ARGELIA QUILINDO CAMAYO', 'ALIZALES ', 'EL DIVISO ', 'SOTARÁ ', 2.15514, -76.62682, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 1),
    (v_calificacion_id, 2, 5),
    (v_calificacion_id, 3, 3),
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 2),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 4),
    (v_calificacion_id, 9, 4),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 1),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 2),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 1),
    (v_calificacion_id, 20, 1),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 23, 5),
    (v_calificacion_id, 24, 3),
    (v_calificacion_id, 25, 1),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 1),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando OLMES CRUZ SANDOVAL
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('16667705', 'OLMES CRUZ SANDOVAL', 'CRISANTEMO ', 'SAN ROQUE ', 'SOTARÁ', 2.15351, -76.61745, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 1),
    (v_calificacion_id, 2, 3),
    (v_calificacion_id, 3, 2),
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 2),
    (v_calificacion_id, 7, 1),
    (v_calificacion_id, 8, 5),
    (v_calificacion_id, 9, 3),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 4),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 1),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 1),
    (v_calificacion_id, 20, 4),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 23, 3),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 1),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando HEYERMIRO MONTILLA HOYOS
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('4773045', 'HEYERMIRO MONTILLA HOYOS', 'LOS GUARANGOS ', 'CHAPA', 'SOTARÁ ', 2.19522, -76.62933, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 1),
    (v_calificacion_id, 2, 3),
    (v_calificacion_id, 3, 2),
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 2),
    (v_calificacion_id, 7, 1),
    (v_calificacion_id, 8, 5),
    (v_calificacion_id, 9, 3),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 4),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 1),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 1),
    (v_calificacion_id, 20, 4),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 23, 3),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 1),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando DEISY YOHANA GUERRERO 
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('1064676497', 'DEISY YOHANA GUERRERO ', 'LOS NARANJOS ', 'CHAPA', 'SOTARÁ ', 2.19426, -76.62643, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 1),
    (v_calificacion_id, 2, 2),
    (v_calificacion_id, 3, 2),
    (v_calificacion_id, 5, 3),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 5),
    (v_calificacion_id, 9, 5),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 13, 4),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 1),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 2),
    (v_calificacion_id, 20, 1),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 3),
    (v_calificacion_id, 23, 3),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 3);
END $$;

-- Procesando HERNAN DARIO COLLAZOS GUERRERO
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('1061791193', 'HERNAN DARIO COLLAZOS GUERRERO', 'EL PUERTO', 'SAN ROQUE', 'SOTARA', 2.164384, -76.605527, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 4),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 5),
    (v_calificacion_id, 4, 2),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 2),
    (v_calificacion_id, 9, 2),
    (v_calificacion_id, 10, 1),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 4),
    (v_calificacion_id, 13, 4),
    (v_calificacion_id, 14, 2),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 3),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 1),
    (v_calificacion_id, 21, 4),
    (v_calificacion_id, 22, 3),
    (v_calificacion_id, 23, 4),
    (v_calificacion_id, 24, 3),
    (v_calificacion_id, 25, 1),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 4),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 5);
END $$;

-- Procesando GUIDO OMAR QUINAYAS
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('1064677022', 'GUIDO OMAR QUINAYAS', 'LA PAILA', 'SAN ROQUE', 'SOTARA', 2.1572, -76.59342, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 2),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 3),
    (v_calificacion_id, 4, 2),
    (v_calificacion_id, 5, 5),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 4),
    (v_calificacion_id, 9, 5),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 13, 2),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 1),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 4),
    (v_calificacion_id, 19, 4),
    (v_calificacion_id, 20, 4),
    (v_calificacion_id, 21, 2),
    (v_calificacion_id, 23, 3),
    (v_calificacion_id, 24, 3),
    (v_calificacion_id, 25, 2),
    (v_calificacion_id, 27, 1),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando YANETH ALEXANDRA GUERRERO MONTILLA
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('1081702462', 'YANETH ALEXANDRA GUERRERO MONTILLA', 'LA MARIA A', 'CHAPA', 'SOTARA', 2.194362, -76.639987, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

-- Procesando MARCO ANTONIO SILVA
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('1517795', 'MARCO ANTONIO SILVA', 'PLAN GRANDE', 'SAN ROQUE', 'SOTARA', 2.172323, -76.606168, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 3),
    (v_calificacion_id, 2, 5),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 2),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 3),
    (v_calificacion_id, 9, 5),
    (v_calificacion_id, 10, 3),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 13, 3),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 2),
    (v_calificacion_id, 16, 5),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 2),
    (v_calificacion_id, 20, 4),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 23, 3),
    (v_calificacion_id, 24, 4),
    (v_calificacion_id, 25, 2),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 4),
    (v_calificacion_id, 28, 3),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando JUAN ELIAS REALPE
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('4773064', 'JUAN ELIAS REALPE', 'EL  NOGAL', 'SAN ROQUE', 'SOTARA', 2.176757, -76.622074, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 1),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 3),
    (v_calificacion_id, 5, 3),
    (v_calificacion_id, 6, 1),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 5),
    (v_calificacion_id, 9, 5),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 1),
    (v_calificacion_id, 13, 4),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 2),
    (v_calificacion_id, 20, 1),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 3),
    (v_calificacion_id, 23, 2),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 3),
    (v_calificacion_id, 29, 3);
END $$;

-- Procesando ENIO MARCEL BOLAÑOS GUERRERO
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('4771288', 'ENIO MARCEL BOLAÑOS GUERRERO', 'ALTA VISTA', 'DIVISO', 'SOTARA', 2.183982, -76.630285, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 3),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 4, 3),
    (v_calificacion_id, 5, 3),
    (v_calificacion_id, 6, 1),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 4),
    (v_calificacion_id, 9, 3),
    (v_calificacion_id, 10, 4),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 3),
    (v_calificacion_id, 13, 4),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 18, 4),
    (v_calificacion_id, 19, 3),
    (v_calificacion_id, 20, 3),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 2),
    (v_calificacion_id, 23, 3),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 2),
    (v_calificacion_id, 26, 3),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 1),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando JONATHAN  ANDRES TALAGA AUSECHA
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('1061794141', 'JONATHAN  ANDRES TALAGA AUSECHA', 'EL AGUACATE', 'DIVISO', 'SOTARA', 2.186117, -76.632133, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 3),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 3),
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 3),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 4),
    (v_calificacion_id, 9, 3),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 13, 4),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 1),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 2),
    (v_calificacion_id, 19, 2),
    (v_calificacion_id, 20, 3),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 2),
    (v_calificacion_id, 23, 3),
    (v_calificacion_id, 24, 4),
    (v_calificacion_id, 25, 4),
    (v_calificacion_id, 26, 3),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 3),
    (v_calificacion_id, 29, 3);
END $$;

-- Procesando AURIS MONTILLA CARVAJAL
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('1063809524', 'AURIS MONTILLA CARVAJAL', 'EL NARANJO', 'SAN ROQUE', 'SOTARA', 2.17664, -76.61946, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 3),
    (v_calificacion_id, 2, 5),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 4),
    (v_calificacion_id, 9, 3),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 3),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 2),
    (v_calificacion_id, 18, 3),
    (v_calificacion_id, 19, 3),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 4),
    (v_calificacion_id, 23, 4),
    (v_calificacion_id, 24, 4),
    (v_calificacion_id, 25, 4),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 1),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando RUBIO ALEXANDER GUERRERO ORDOÑEZ
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('1063806941', 'RUBIO ALEXANDER GUERRERO ORDOÑEZ', 'EL NARANJO', 'SAN ROQUE', 'SOTARA', 2.17645, -76.62004, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 4),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 3),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 3),
    (v_calificacion_id, 9, 4),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 3),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 2),
    (v_calificacion_id, 18, 3),
    (v_calificacion_id, 19, 3),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 3),
    (v_calificacion_id, 23, 4),
    (v_calificacion_id, 24, 4),
    (v_calificacion_id, 25, 4),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 1),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando JAIRO ORLANDO VELASCO CASTILLO
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('4773002', 'JAIRO ORLANDO VELASCO CASTILLO', 'EL PORVENIR', 'CHAPA', 'SOTARA', 2.18903, -76.63731, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 4),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 3),
    (v_calificacion_id, 4, 3),
    (v_calificacion_id, 5, 3),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 4),
    (v_calificacion_id, 9, 3),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 3),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 3),
    (v_calificacion_id, 17, 4),
    (v_calificacion_id, 18, 3),
    (v_calificacion_id, 19, 2),
    (v_calificacion_id, 20, 3),
    (v_calificacion_id, 22, 3),
    (v_calificacion_id, 23, 3),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 5),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 4),
    (v_calificacion_id, 28, 3),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando ROBERT CEDIEL BECERRA GUERRERO
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('76308041', 'ROBERT CEDIEL BECERRA GUERRERO', 'EL COLUMPIO', 'CHAPA', 'SOTARA', 2.196248, -76.632176, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 4),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 4, 3),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 1),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 4),
    (v_calificacion_id, 9, 3),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 3),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 1),
    (v_calificacion_id, 18, 3),
    (v_calificacion_id, 19, 2),
    (v_calificacion_id, 20, 3),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 2),
    (v_calificacion_id, 23, 4),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 2),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando PEDRO ANTONIO GUERRERO MAGON
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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

-- Procesando ARGEMIRO ZUÑIGA
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('1517686', 'ARGEMIRO ZUÑIGA', 'BELLAVISTA', 'ULLUCOS', 'SOTARA', 2.22177, -76.58553, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 3),
    (v_calificacion_id, 2, 3),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 4, -3),
    (v_calificacion_id, 5, 3),
    (v_calificacion_id, 6, 4),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 2),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 10, -3),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, -3),
    (v_calificacion_id, 13, 3),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 1),
    (v_calificacion_id, 20, -3),
    (v_calificacion_id, 21, 5),
    (v_calificacion_id, 22, 2),
    (v_calificacion_id, 23, 3),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 4),
    (v_calificacion_id, 26, 3),
    (v_calificacion_id, 27, 3),
    (v_calificacion_id, 28, 3),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando JESUS ADOLFO ZUÑIGA COAJI
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('4771187', 'JESUS ADOLFO ZUÑIGA COAJI', 'EL ARRAYAN', 'ULLUCOS', 'SOTARA', 2.21696, -76.58756, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 3),
    (v_calificacion_id, 2, 3),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 4, -3),
    (v_calificacion_id, 5, 5),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 2),
    (v_calificacion_id, 9, 2),
    (v_calificacion_id, 10, -3),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, -3),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 18, -2),
    (v_calificacion_id, 19, 1),
    (v_calificacion_id, 20, -3),
    (v_calificacion_id, 21, 3),
    (v_calificacion_id, 22, 2),
    (v_calificacion_id, 23, 1),
    (v_calificacion_id, 24, 4),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 26, 3),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando FELIPE YACUMAL
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('10516112', 'FELIPE YACUMAL', 'SIN NOMBRE', 'ULLUCOS', 'SOTARA', 2.219548, -76.59007, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 4),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 5, 5),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 10, 2),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 3),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 5),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 19, 4),
    (v_calificacion_id, 20, 3),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 27, 5);
END $$;

-- Procesando JUAN CARLOS YACUMAL CIFUENTES
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('76314835', 'JUAN CARLOS YACUMAL CIFUENTES', 'LA BENDITA', 'ULLUCOS', 'SOTARA', 2.214282, -76.586068, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 4),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 5),
    (v_calificacion_id, 6, 5),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 10, 3),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 3),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 4),
    (v_calificacion_id, 15, 5),
    (v_calificacion_id, 16, 5),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 18, 4),
    (v_calificacion_id, 19, 3),
    (v_calificacion_id, 20, 3),
    (v_calificacion_id, 21, 2),
    (v_calificacion_id, 22, 4),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 4),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 3),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 5);
END $$;

-- Procesando YENNY MAGALY PAZ CRUZ
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('1061713441', 'YENNY MAGALY PAZ CRUZ', 'LA MARGARITA', 'ULLUCOS', 'SOTARA', 2.22001, -76.590665, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 2),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 5, 5),
    (v_calificacion_id, 6, 2),
    (v_calificacion_id, 8, 3),
    (v_calificacion_id, 9, 1),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 29, 3);
END $$;

-- Procesando YENI VIVIANA COAJI TACUE
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('1061706732', 'YENI VIVIANA COAJI TACUE', 'SAN ANTONIO', 'ULLUCOS', 'SOTARA', 2.224957, -76.596325, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 3),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando EDWIN ALEXANDER SANCHEZ ZUÑIGA
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('1061686462', 'EDWIN ALEXANDER SANCHEZ ZUÑIGA', 'EL ARRAYAN', 'ULLUCOS', 'SOTARÁ ', 2.220874, -76.585535, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 4),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 5),
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 5),
    (v_calificacion_id, 8, 3),
    (v_calificacion_id, 9, 3),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 2),
    (v_calificacion_id, 13, 4),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 3),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 18, 2),
    (v_calificacion_id, 19, 3),
    (v_calificacion_id, 20, 3),
    (v_calificacion_id, 21, 2),
    (v_calificacion_id, 22, 3),
    (v_calificacion_id, 23, 4),
    (v_calificacion_id, 25, 5),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando CARMEN EUGENIA ZUÑIGA COAJI
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('48661807', 'CARMEN EUGENIA ZUÑIGA COAJI', 'LOTE N°2', 'ULLUCOS', 'SOTARÁ ', 2.217968, -76.58831, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 4),
    (v_calificacion_id, 2, 5),
    (v_calificacion_id, 3, 5),
    (v_calificacion_id, 4, 4),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 3),
    (v_calificacion_id, 8, 4),
    (v_calificacion_id, 9, 4),
    (v_calificacion_id, 10, 4),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 4),
    (v_calificacion_id, 13, 4),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 3),
    (v_calificacion_id, 17, 5),
    (v_calificacion_id, 18, 2),
    (v_calificacion_id, 19, 3),
    (v_calificacion_id, 20, 5),
    (v_calificacion_id, 21, 3),
    (v_calificacion_id, 22, 5),
    (v_calificacion_id, 23, 4),
    (v_calificacion_id, 25, 5),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 5),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando RICARDINA ALEGRÍA MUÑOZ
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('25693748', 'RICARDINA ALEGRÍA MUÑOZ', 'EL PRODIGIO, PARCELA #17', 'ULLUCOS', 'SOTARÁ', 2.218348, -76.585953, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 4),
    (v_calificacion_id, 2, 5),
    (v_calificacion_id, 3, 5),
    (v_calificacion_id, 4, 3),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 3),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 3),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 4),
    (v_calificacion_id, 17, 3),
    (v_calificacion_id, 18, 2),
    (v_calificacion_id, 19, 1),
    (v_calificacion_id, 20, 5),
    (v_calificacion_id, 21, 5),
    (v_calificacion_id, 22, 4),
    (v_calificacion_id, 23, 4),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 5),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 4);
END $$;

-- Procesando WILMER JULIAN COLLAZOS ALEGRÍA
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('1061733459', 'WILMER JULIAN COLLAZOS ALEGRÍA', 'EL PRODIGIO', 'ULLUCOS', 'SOTARÁ', 2.218348, -76.585953, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 4),
    (v_calificacion_id, 2, 5),
    (v_calificacion_id, 3, 5),
    (v_calificacion_id, 4, 3),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 1),
    (v_calificacion_id, 9, 3),
    (v_calificacion_id, 10, 5),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 3),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 3),
    (v_calificacion_id, 16, 4),
    (v_calificacion_id, 17, 3),
    (v_calificacion_id, 18, 2),
    (v_calificacion_id, 19, 1),
    (v_calificacion_id, 20, 5),
    (v_calificacion_id, 21, 5),
    (v_calificacion_id, 22, 4),
    (v_calificacion_id, 23, 4),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 5),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 4);
END $$;

-- Procesando EDUARDO BOLAÑOS BRAVO
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('4771096', 'EDUARDO BOLAÑOS BRAVO', 'SAN JOSÉ', 'ULLUCOS', 'SOTARÁ', 2.225691, -76.585001, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 5),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 3),
    (v_calificacion_id, 4, 5),
    (v_calificacion_id, 5, 3),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 5),
    (v_calificacion_id, 8, 5),
    (v_calificacion_id, 9, 5),
    (v_calificacion_id, 10, 4),
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 5),
    (v_calificacion_id, 13, 4),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 1),
    (v_calificacion_id, 17, 3),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 1),
    (v_calificacion_id, 20, 5),
    (v_calificacion_id, 21, 2),
    (v_calificacion_id, 22, 2),
    (v_calificacion_id, 23, 5),
    (v_calificacion_id, 24, 5),
    (v_calificacion_id, 25, 4),
    (v_calificacion_id, 26, 5),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 3),
    (v_calificacion_id, 29, 2);
END $$;

-- Procesando ALEXANDER BENAVIDES BOLAÑOS
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('76028835', 'ALEXANDER BENAVIDES BOLAÑOS', 'PARCELA # 22 - ALTOS DE LA PERLA', 'ULLUCOS', 'SOTARÁ', 2.227788, -76.58491, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 1),
    (v_calificacion_id, 2, 3),
    (v_calificacion_id, 3, 3),
    (v_calificacion_id, 4, 5),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 4),
    (v_calificacion_id, 7, 1),
    (v_calificacion_id, 8, 3),
    (v_calificacion_id, 9, 3),
    (v_calificacion_id, 10, 4),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 5),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 3),
    (v_calificacion_id, 17, 2),
    (v_calificacion_id, 18, 1),
    (v_calificacion_id, 19, 1),
    (v_calificacion_id, 20, 5),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 4),
    (v_calificacion_id, 23, 5),
    (v_calificacion_id, 24, 4),
    (v_calificacion_id, 25, 4),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 3),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando ANA LUISA GUERRERO RUIZ
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('25706328', 'ANA LUISA GUERRERO RUIZ', 'LOTE #2', 'ULLUCOS', 'SOTARÁ', 2.214313, -76.59489, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 4),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 4, 3),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 2),
    (v_calificacion_id, 9, 4),
    (v_calificacion_id, 10, 3),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 4),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 3),
    (v_calificacion_id, 18, 4),
    (v_calificacion_id, 19, 2),
    (v_calificacion_id, 20, 4),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 5),
    (v_calificacion_id, 23, 5),
    (v_calificacion_id, 24, 4),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando CESAR DANILO FERNANDEZ GUERRERO
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('4771606', 'CESAR DANILO FERNANDEZ GUERRERO', 'LOTE #1', 'ULLUCOS', 'SOTARÁ', 2.214774, -76.593581, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje)
  VALUES 
    (v_calificacion_id, 1, 4),
    (v_calificacion_id, 2, 4),
    (v_calificacion_id, 3, 4),
    (v_calificacion_id, 4, 3),
    (v_calificacion_id, 5, 4),
    (v_calificacion_id, 6, 3),
    (v_calificacion_id, 7, 4),
    (v_calificacion_id, 8, 2),
    (v_calificacion_id, 9, 4),
    (v_calificacion_id, 10, 3),
    (v_calificacion_id, 11, 5),
    (v_calificacion_id, 12, 4),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 1),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 3),
    (v_calificacion_id, 18, 4),
    (v_calificacion_id, 19, 2),
    (v_calificacion_id, 20, 4),
    (v_calificacion_id, 21, 1),
    (v_calificacion_id, 22, 5),
    (v_calificacion_id, 23, 5),
    (v_calificacion_id, 24, 4),
    (v_calificacion_id, 25, 3),
    (v_calificacion_id, 26, 4),
    (v_calificacion_id, 27, 5),
    (v_calificacion_id, 28, 4),
    (v_calificacion_id, 29, 1);
END $$;

-- Procesando WILLIAN ALEXIS ZUÑIGA SANCHEZ
DO $$
DECLARE
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, proyecto)
  VALUES ('1064676728', 'WILLIAN ALEXIS ZUÑIGA SANCHEZ', 'LA SABANA', 'ULLUCOS', 'SOTARA', 2.226798, -76.581661, 'Proyecto Sotará')
  ON CONFLICT (cedula) DO UPDATE SET 
    nombre_completo = EXCLUDED.nombre_completo, 
    nombre_predio = EXCLUDED.nombre_predio, 
    vereda = EXCLUDED.vereda, 
    municipio = EXCLUDED.municipio, 
    ubicacion_lat = EXCLUDED.ubicacion_lat, 
    ubicacion_lng = EXCLUDED.ubicacion_lng, 
    proyecto = EXCLUDED.proyecto
  RETURNING id INTO v_productor_id;

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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
    (v_calificacion_id, 11, 4),
    (v_calificacion_id, 12, 3),
    (v_calificacion_id, 13, 5),
    (v_calificacion_id, 14, 3),
    (v_calificacion_id, 15, 4),
    (v_calificacion_id, 16, 2),
    (v_calificacion_id, 17, 4),
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

-- Procesando LIDA NEIRA DORADO PAJOY
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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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

  -- Buscar si ya existe una calificación para este productor y fecha
  SELECT id INTO v_calificacion_id FROM calificaciones 
  WHERE productor_id = v_productor_id AND fecha_inicio = '2024-06-15 12:00:00+00';

  IF v_calificacion_id IS NULL THEN
    INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin, es_prueba)
    VALUES (v_productor_id, 'e81ba52c-23df-4f4e-808d-937fd606426c', 'completada', '2024-06-15 12:00:00+00', '2024-06-15 12:00:00+00', false)
    RETURNING id INTO v_calificacion_id;
  ELSE
    -- Si ya existe, limpiamos los detalles anteriores para evitar duplicados en la actualización
    DELETE FROM calificacion_detalle WHERE calificacion_id = v_calificacion_id;
  END IF;

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