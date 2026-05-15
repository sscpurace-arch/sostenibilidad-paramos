-- Generado automaticamente
DO $$
DECLARE
  v_usuario_id UUID;
  v_productor_id UUID;
  v_calificacion_id UUID;
BEGIN
  INSERT INTO usuarios (id, nombre, email, rol) VALUES (gen_random_uuid(), 'Evaluador Principal', 'sscpurace@gmail.com', 'evaluador') ON CONFLICT (email) DO UPDATE SET email=EXCLUDED.email RETURNING id INTO v_usuario_id;

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('1061803252', 'Angye Viviana Alonso Chaparral', 'El Tunel', 'Rio Negro', 'Puracé', 2.233546, -76.452841, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-11 00:00:00', '2025-02-11 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 4, 'Atendió la visita Alexis Quelal esposo de Angie Viviana');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 1, 'Atendió la visita Alexis Quelal esposo de Angie Viviana');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 2, 'Atendió la visita Alexis Quelal esposo de Angie Viviana');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, 'Atendió la visita Alexis Quelal esposo de Angie Viviana');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 5, 'Atendió la visita Alexis Quelal esposo de Angie Viviana');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, 'Atendió la visita Alexis Quelal esposo de Angie Viviana');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 5, 'Atendió la visita Alexis Quelal esposo de Angie Viviana');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 4, 'Atendió la visita Alexis Quelal esposo de Angie Viviana');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 2, 'Atendió la visita Alexis Quelal esposo de Angie Viviana');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 5, 'Atendió la visita Alexis Quelal esposo de Angie Viviana');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, 'Atendió la visita Alexis Quelal esposo de Angie Viviana');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 5, 'Atendió la visita Alexis Quelal esposo de Angie Viviana');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 4, 'Atendió la visita Alexis Quelal esposo de Angie Viviana');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'Atendió la visita Alexis Quelal esposo de Angie Viviana');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 3, 'Atendió la visita Alexis Quelal esposo de Angie Viviana');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, 'Atendió la visita Alexis Quelal esposo de Angie Viviana');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, 'Atendió la visita Alexis Quelal esposo de Angie Viviana');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 4, 'Atendió la visita Alexis Quelal esposo de Angie Viviana');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, 'Atendió la visita Alexis Quelal esposo de Angie Viviana');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 5, 'Atendió la visita Alexis Quelal esposo de Angie Viviana');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, 'Atendió la visita Alexis Quelal esposo de Angie Viviana');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 3, 'Atendió la visita Alexis Quelal esposo de Angie Viviana');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, 'Atendió la visita Alexis Quelal esposo de Angie Viviana');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, 'Atendió la visita Alexis Quelal esposo de Angie Viviana');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 1, 'Atendió la visita Alexis Quelal esposo de Angie Viviana');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 4, 'Atendió la visita Alexis Quelal esposo de Angie Viviana');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, 'Atendió la visita Alexis Quelal esposo de Angie Viviana');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 5, 'Atendió la visita Alexis Quelal esposo de Angie Viviana');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 4, 'Atendió la visita Alexis Quelal esposo de Angie Viviana');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('34550377', 'Mariela Guauña Cuchumbe', 'Agua Bonita', 'Rio Negro', 'Puracé', 2.211393, -76.48866, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-11 00:00:00', '2025-02-11 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('1061711097', 'Mariana Velasco Guauña', 'Majuas', 'Rio Negro', 'Puracé', 2.233464, -76.453294, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-11 00:00:00', '2025-02-11 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, 'El predio solo cuenta con vía de acceso peatonal.
Usar los linderos para establecer el SSP.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, 'El predio solo cuenta con vía de acceso peatonal.
Usar los linderos para establecer el SSP.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, 'El predio solo cuenta con vía de acceso peatonal.
Usar los linderos para establecer el SSP.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 1, 'El predio solo cuenta con vía de acceso peatonal.
Usar los linderos para establecer el SSP.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, 'El predio solo cuenta con vía de acceso peatonal.
Usar los linderos para establecer el SSP.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, 'El predio solo cuenta con vía de acceso peatonal.
Usar los linderos para establecer el SSP.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, 'El predio solo cuenta con vía de acceso peatonal.
Usar los linderos para establecer el SSP.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 2, 'El predio solo cuenta con vía de acceso peatonal.
Usar los linderos para establecer el SSP.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 2, 'El predio solo cuenta con vía de acceso peatonal.
Usar los linderos para establecer el SSP.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 4, 'El predio solo cuenta con vía de acceso peatonal.
Usar los linderos para establecer el SSP.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, 'El predio solo cuenta con vía de acceso peatonal.
Usar los linderos para establecer el SSP.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 5, 'El predio solo cuenta con vía de acceso peatonal.
Usar los linderos para establecer el SSP.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, 'El predio solo cuenta con vía de acceso peatonal.
Usar los linderos para establecer el SSP.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'El predio solo cuenta con vía de acceso peatonal.
Usar los linderos para establecer el SSP.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 3, 'El predio solo cuenta con vía de acceso peatonal.
Usar los linderos para establecer el SSP.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, 'El predio solo cuenta con vía de acceso peatonal.
Usar los linderos para establecer el SSP.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, 'El predio solo cuenta con vía de acceso peatonal.
Usar los linderos para establecer el SSP.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 3, 'El predio solo cuenta con vía de acceso peatonal.
Usar los linderos para establecer el SSP.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 1, 'El predio solo cuenta con vía de acceso peatonal.
Usar los linderos para establecer el SSP.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, 'El predio solo cuenta con vía de acceso peatonal.
Usar los linderos para establecer el SSP.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, 'El predio solo cuenta con vía de acceso peatonal.
Usar los linderos para establecer el SSP.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 2, 'El predio solo cuenta con vía de acceso peatonal.
Usar los linderos para establecer el SSP.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, 'El predio solo cuenta con vía de acceso peatonal.
Usar los linderos para establecer el SSP.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, 'El predio solo cuenta con vía de acceso peatonal.
Usar los linderos para establecer el SSP.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 2, 'El predio solo cuenta con vía de acceso peatonal.
Usar los linderos para establecer el SSP.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, 'El predio solo cuenta con vía de acceso peatonal.
Usar los linderos para establecer el SSP.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, 'El predio solo cuenta con vía de acceso peatonal.
Usar los linderos para establecer el SSP.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 5, 'El predio solo cuenta con vía de acceso peatonal.
Usar los linderos para establecer el SSP.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, 'El predio solo cuenta con vía de acceso peatonal.
Usar los linderos para establecer el SSP.');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('25628152', 'Miriam Patricia Hidrobo Perdomo', 'El Lago', 'Rio Negro', 'Puracé', 2.229408, -76.462273, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-12 00:00:00', '2025-02-12 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 2, 'Requiere de panel solar
Cuenta con nacimiento de agua a 410 metros fuera del predio.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, 'Requiere de panel solar
Cuenta con nacimiento de agua a 410 metros fuera del predio.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, 'Requiere de panel solar
Cuenta con nacimiento de agua a 410 metros fuera del predio.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, 'Requiere de panel solar
Cuenta con nacimiento de agua a 410 metros fuera del predio.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, 'Requiere de panel solar
Cuenta con nacimiento de agua a 410 metros fuera del predio.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, 'Requiere de panel solar
Cuenta con nacimiento de agua a 410 metros fuera del predio.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, 'Requiere de panel solar
Cuenta con nacimiento de agua a 410 metros fuera del predio.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 2, 'Requiere de panel solar
Cuenta con nacimiento de agua a 410 metros fuera del predio.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 3, 'Requiere de panel solar
Cuenta con nacimiento de agua a 410 metros fuera del predio.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 5, 'Requiere de panel solar
Cuenta con nacimiento de agua a 410 metros fuera del predio.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, 'Requiere de panel solar
Cuenta con nacimiento de agua a 410 metros fuera del predio.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, 'Requiere de panel solar
Cuenta con nacimiento de agua a 410 metros fuera del predio.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, 'Requiere de panel solar
Cuenta con nacimiento de agua a 410 metros fuera del predio.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'Requiere de panel solar
Cuenta con nacimiento de agua a 410 metros fuera del predio.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, 'Requiere de panel solar
Cuenta con nacimiento de agua a 410 metros fuera del predio.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, 'Requiere de panel solar
Cuenta con nacimiento de agua a 410 metros fuera del predio.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, 'Requiere de panel solar
Cuenta con nacimiento de agua a 410 metros fuera del predio.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, 'Requiere de panel solar
Cuenta con nacimiento de agua a 410 metros fuera del predio.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, 'Requiere de panel solar
Cuenta con nacimiento de agua a 410 metros fuera del predio.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, 'Requiere de panel solar
Cuenta con nacimiento de agua a 410 metros fuera del predio.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, 'Requiere de panel solar
Cuenta con nacimiento de agua a 410 metros fuera del predio.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 2, 'Requiere de panel solar
Cuenta con nacimiento de agua a 410 metros fuera del predio.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, 'Requiere de panel solar
Cuenta con nacimiento de agua a 410 metros fuera del predio.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, 'Requiere de panel solar
Cuenta con nacimiento de agua a 410 metros fuera del predio.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, 'Requiere de panel solar
Cuenta con nacimiento de agua a 410 metros fuera del predio.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 3, 'Requiere de panel solar
Cuenta con nacimiento de agua a 410 metros fuera del predio.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, 'Requiere de panel solar
Cuenta con nacimiento de agua a 410 metros fuera del predio.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, 'Requiere de panel solar
Cuenta con nacimiento de agua a 410 metros fuera del predio.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, 'Requiere de panel solar
Cuenta con nacimiento de agua a 410 metros fuera del predio.');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('25628220', 'Ana Cleotilde Camayo Yalanda', 'El Cerote', 'Rio Negro', 'Puracé', 2.229033, -76.468304, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-12 00:00:00', '2025-02-12 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 2, 'Requiere de panel solar');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, 'Requiere de panel solar');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, 'Requiere de panel solar');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 2, 'Requiere de panel solar');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 5, 'Requiere de panel solar');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, 'Requiere de panel solar');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, 'Requiere de panel solar');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 2, 'Requiere de panel solar');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 3, 'Requiere de panel solar');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 2, 'Requiere de panel solar');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 1, 'Requiere de panel solar');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 4, 'Requiere de panel solar');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 4, 'Requiere de panel solar');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'Requiere de panel solar');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 3, 'Requiere de panel solar');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, 'Requiere de panel solar');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, 'Requiere de panel solar');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, 'Requiere de panel solar');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, 'Requiere de panel solar');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, 'Requiere de panel solar');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, 'Requiere de panel solar');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 5, 'Requiere de panel solar');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, 'Requiere de panel solar');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 4, 'Requiere de panel solar');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 1, 'Requiere de panel solar');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, 'Requiere de panel solar');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, 'Requiere de panel solar');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 5, 'Requiere de panel solar');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, 'Requiere de panel solar');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('1061723670', 'Edwin Ivan Idrobo Santiago', 'Tambor 3', 'Rio Negro', 'Puracé', 2.229907, -76.451275, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-17 00:00:00', '2025-02-17 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 3, 'Indicadores_Images/63f5a3f7.Firma Técnico.141654.png');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 2, 'Indicadores_Images/63f5a3f7.Firma Técnico.141654.png');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, 'Indicadores_Images/63f5a3f7.Firma Técnico.141654.png');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, 'Indicadores_Images/63f5a3f7.Firma Técnico.141654.png');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, 'Indicadores_Images/63f5a3f7.Firma Técnico.141654.png');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, 'Indicadores_Images/63f5a3f7.Firma Técnico.141654.png');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, 'Indicadores_Images/63f5a3f7.Firma Técnico.141654.png');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 3, 'Indicadores_Images/63f5a3f7.Firma Técnico.141654.png');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 2, 'Indicadores_Images/63f5a3f7.Firma Técnico.141654.png');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, 'Indicadores_Images/63f5a3f7.Firma Técnico.141654.png');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, 'Indicadores_Images/63f5a3f7.Firma Técnico.141654.png');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 4, 'Indicadores_Images/63f5a3f7.Firma Técnico.141654.png');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, 'Indicadores_Images/63f5a3f7.Firma Técnico.141654.png');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'Indicadores_Images/63f5a3f7.Firma Técnico.141654.png');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, 'Indicadores_Images/63f5a3f7.Firma Técnico.141654.png');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 4, 'Indicadores_Images/63f5a3f7.Firma Técnico.141654.png');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, 'Indicadores_Images/63f5a3f7.Firma Técnico.141654.png');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 4, 'Indicadores_Images/63f5a3f7.Firma Técnico.141654.png');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, 'Indicadores_Images/63f5a3f7.Firma Técnico.141654.png');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 4, 'Indicadores_Images/63f5a3f7.Firma Técnico.141654.png');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 3, 'Indicadores_Images/63f5a3f7.Firma Técnico.141654.png');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 2, 'Indicadores_Images/63f5a3f7.Firma Técnico.141654.png');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, 'Indicadores_Images/63f5a3f7.Firma Técnico.141654.png');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, 'Indicadores_Images/63f5a3f7.Firma Técnico.141654.png');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, 'Indicadores_Images/63f5a3f7.Firma Técnico.141654.png');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, 'Indicadores_Images/63f5a3f7.Firma Técnico.141654.png');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, 'Indicadores_Images/63f5a3f7.Firma Técnico.141654.png');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, 'Indicadores_Images/63f5a3f7.Firma Técnico.141654.png');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, 'Indicadores_Images/63f5a3f7.Firma Técnico.141654.png');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('25628727', 'Maria Delia Magon Gurrute', 'El Local', 'Rio Negro', 'Puracé', 2.227956, -76.45023, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-17 00:00:00', '2025-02-17 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('10290328', 'Lorenzo Tombe Yace', 'Tambor 5', 'Rio Negro', 'Puracé', 2.214167, -76.449278, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-17 00:00:00', '2025-02-17 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('10575092', 'Marino Tombe Yace', 'La Tormenta', 'Rio Negro', 'Puracé', 2.199748, -76.491551, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-17 00:00:00', '2025-02-17 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('25284669', 'Yaned Patricia Camayo', 'San Luis', 'Rio Negro', 'Puracé', 2.22013, -76.480957, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-17 00:00:00', '2025-02-17 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 3, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('25628686', 'Ana Teresa Camayo Chaparral', 'San Luiz', 'Rio Negro', 'Puracé', 2.217947, -76.483127, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-17 00:00:00', '2025-02-17 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('1060237237', 'Melba Magnolia Avirama Olave', 'San Luis 6', 'Rio Negro', 'Puracé', 2.220833, -76.479512, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-18 00:00:00', '2025-02-18 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 2, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('10538012', 'Jose Roberto Gutierrez Sanchez', 'Yerbas Buenas 2', 'Josefina', 'Puracé', 2.210854, -76.495165, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-18 00:00:00', '2025-02-18 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('10290482', 'Jander Andres Perdomo Yace', 'Los Humedales', 'Rio Negro', 'Puracé', 2.21391, -76.485678, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-18 00:00:00', '2025-02-18 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 2, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('1060237679', 'Ferney Alexander Yalanda Pausa', 'San luis', 'Rio Negro', 'Puracé', 2.209862, -76.487829, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-18 00:00:00', '2025-02-18 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('76328222', 'Jorge Enrique Charo Peteche', 'Campo Alegre', 'Josefina', 'Puracé', 2.232367, -76.490467, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-19 00:00:00', '2025-02-19 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('1061730721', 'Nery Viviana Sanchez Coaji', 'Campo Alegre 16', 'Josefina', 'Puracé', 2.239167, -76.488458, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-19 00:00:00', '2025-02-19 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 3, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('10575063', 'Laurentino Sanchez Sanchez', 'Campo Alegre 2', 'Josefina', 'Puracé', 2.237505, -76.493562, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-19 00:00:00', '2025-02-19 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('1061703828', 'Paola Andrea Sánchez Serna', 'Campo Alegre 11', 'Josefina', 'Puracé', 2.238944, -76.490151, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-19 00:00:00', '2025-02-19 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('76290044', 'Ruben Dario Basto', 'El Asombro', 'Josefina', 'Puracé', 2.253742, -76.502032, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-21 00:00:00', '2025-02-21 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('10535219', 'Carlos Alberto Narvaez Muñoz', 'El Asombro', 'Josefina', 'Puracé', 2.2489, -76.48685, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-21 00:00:00', '2025-02-21 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 2, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('10297398', 'Jesus Alfonso Chapues Caso', 'Jose Fina 2', 'Josefina', 'Puracé', 2.254815, -76.487048, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-21 00:00:00', '2025-02-21 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('34330598', 'Sixta Tulia Chapues Caso', 'Jose Fina', 'Josefina', 'Puracé', 2.253542, -76.486203, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-21 00:00:00', '2025-02-21 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('76325946', 'Jose Guillermo Chapues Caso', 'Jose Fina 4', 'Josefina', 'Puracé', 2.248725, -76.485084, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-21 00:00:00', '2025-02-21 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('1060238630', 'Juan Pablo Termal Tutalcha', 'Jose Fina 5', 'Josefina', 'Puracé', 2.249648, -76.483595, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-21 00:00:00', '2025-02-21 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('1002876646', 'Blanca Magnolia Hormiga Chapues', 'Jose Fina Bajo', 'Josefina', 'Puracé', 2.250412, -76.481323, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-21 00:00:00', '2025-02-21 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 2, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('1060239261', 'Dany Bibiana Hormiga Chapues', 'El Asombro', 'Josefina', 'Puracé', 2.24989, -76.480938, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-21 00:00:00', '2025-02-21 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('10532555', 'Marco Aurelio Granados Herrera', 'El Playon', 'Josefina', 'Puracé', 2.249624, -76.478124, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-22 00:00:00', '2025-02-22 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('25276463', 'Blanca Nelli Ydrobo Santiago', 'Caleras', 'Josefina', 'Puracé', 2.248877, -76.475669, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-22 00:00:00', '2025-02-22 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('76290101', 'Jose Gerardo Levaza Gurrute', 'El Playon', 'Josefina', 'Puracé', 2.248242, -76.472393, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-22 00:00:00', '2025-02-22 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('10575121', 'Lucio Mapallo Melenge', 'El Playon', 'Josefina', 'Puracé', 2.24918, -76.47091, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-22 00:00:00', '2025-02-22 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('76303647', 'Magliony Narvaez Muñoz', 'Alto Jose Fina', 'Josefina', 'Puracé', 2.249295, -76.451822, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-24 00:00:00', '2025-02-24 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('5253954', 'Jose Miguel Termal Malte', 'Jose Fina Alto', 'Josefina', 'Puracé', 2.249128, -76.455908, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-24 00:00:00', '2025-02-24 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('76290538', 'Eyver Alfredo Melenje', 'Campo Alegre Alto', 'Josefina', 'Puracé', 2.259054, -76.453119, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-24 00:00:00', '2025-02-24 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('76290307', 'Ramiro Narvaez Mapallo', 'Alizo', 'Josefina', 'Puracé', 2.252381, -76.466194, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-24 00:00:00', '2025-02-24 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('25682684', 'Alba Ceneida Fernández Solarte', 'Alto la Jose Fina', 'Josefina', 'Puracé', 2.249316, -76.46252, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-24 00:00:00', '2025-02-24 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('25628034', 'Yeni Amparo Bolaños Muñoz', 'La Jose Fina', 'Josefina', 'Puracé', 2.245322, -76.464845, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-24 00:00:00', '2025-02-24 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('10541232', 'Marino Narvaez Muñoz', 'La Jose Fina', 'Josefina', 'Puracé', 2.243938, -76.465463, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-24 00:00:00', '2025-02-24 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('1060238812', 'Duber Alveiro Vasquez Chilito', 'Campo Alegre 1', 'Josefina', 'Puracé', 2.2315, -76.476145, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-25 00:00:00', '2025-02-25 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 4, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('34563358', 'Gloria Stella Bolaños Yace', 'El Asombro', 'Josefina', 'Puracé', 2.237441, -76.471425, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-25 00:00:00', '2025-02-25 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('1061724409', 'Dinael Francisco Velasco Camayo', 'San Luiz', 'Rio Negro', 'Puracé', 2.227023, -76.473458, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-25 00:00:00', '2025-02-25 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('4611925', 'Wilfredo Guauña Niquinas', 'San Luis 7', 'Rio Negro', 'Puracé', 2.225968, -76.473469, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-25 00:00:00', '2025-02-25 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('10575100', 'Jesús María Tombe Yace', 'Eucalipto', 'Rio Negro', 'Puracé', 2.224122, -76.442028, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-26 00:00:00', '2025-02-26 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('76310062', 'Benjamin Meneses Paredes', 'Las Margaritas', 'Rio Negro', 'Puracé', 2.22918, -76.441145, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-26 00:00:00', '2025-02-26 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 2, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('25628702', 'Maria Cecilia Tombe Yace', 'Las Brisas', 'Rio Negro', 'Puracé', 2.232438, -76.439273, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-26 00:00:00', '2025-02-26 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('10575058', 'Jose Rafael Gutierrez Sanchez', 'El Pino', 'Rio Negro', 'Puracé', 2.229723, -76.441468, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-26 00:00:00', '2025-02-26 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('34532677', 'Maria Cruz Sánchez de Conejo', 'El Pino 1', 'Rio Negro', 'Puracé', 2.224849, -76.445134, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-26 00:00:00', '2025-02-26 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('10575132', 'Ever Omar Zambrano Muñoz', 'El Canelal', 'Piedra de león', 'Sotará', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-17 00:00:00', '2025-02-17 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('10575125', 'Hector Willard Chalapu Muñoz', 'La Cumbre', 'Piedra de león', 'Sotará', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-17 00:00:00', '2025-02-17 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('76327892', 'Ramiro Castillo Mosca', 'La Palma', 'Piedra de león', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-17 00:00:00', '2025-02-17 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('10575117', 'Jose Gerardo Anacona Yace', 'Canelal 2', 'Piedra de león', 'Sotará', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-17 00:00:00', '2025-02-17 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, 'La finca no cuenta con bosques');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, 'La finca no cuenta con bosques');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, 'La finca no cuenta con bosques');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, 'La finca no cuenta con bosques');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, 'La finca no cuenta con bosques');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, 'La finca no cuenta con bosques');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 1, 'La finca no cuenta con bosques');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, 'La finca no cuenta con bosques');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, 'La finca no cuenta con bosques');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 1, 'La finca no cuenta con bosques');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, 'La finca no cuenta con bosques');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, 'La finca no cuenta con bosques');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, 'La finca no cuenta con bosques');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'La finca no cuenta con bosques');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, 'La finca no cuenta con bosques');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, 'La finca no cuenta con bosques');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 2, 'La finca no cuenta con bosques');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 1, 'La finca no cuenta con bosques');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, 'La finca no cuenta con bosques');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, 'La finca no cuenta con bosques');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, 'La finca no cuenta con bosques');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 4, 'La finca no cuenta con bosques');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, 'La finca no cuenta con bosques');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, 'La finca no cuenta con bosques');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 3, 'La finca no cuenta con bosques');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 4, 'La finca no cuenta con bosques');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, 'La finca no cuenta con bosques');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 3, 'La finca no cuenta con bosques');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, 'La finca no cuenta con bosques');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('25628222', 'Sandra Lorena Chalapu Muñoz', 'La Cumbre', 'Piedra de león', 'Sotará', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-18 00:00:00', '2025-02-18 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 3, 'La finca no cuenta con bosque.
Únicamente ganadería');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, 'La finca no cuenta con bosque.
Únicamente ganadería');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, 'La finca no cuenta con bosque.
Únicamente ganadería');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, 'La finca no cuenta con bosque.
Únicamente ganadería');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 5, 'La finca no cuenta con bosque.
Únicamente ganadería');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 4, 'La finca no cuenta con bosque.
Únicamente ganadería');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 1, 'La finca no cuenta con bosque.
Únicamente ganadería');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, 'La finca no cuenta con bosque.
Únicamente ganadería');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, 'La finca no cuenta con bosque.
Únicamente ganadería');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 5, 'La finca no cuenta con bosque.
Únicamente ganadería');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 1, 'La finca no cuenta con bosque.
Únicamente ganadería');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, 'La finca no cuenta con bosque.
Únicamente ganadería');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, 'La finca no cuenta con bosque.
Únicamente ganadería');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'La finca no cuenta con bosque.
Únicamente ganadería');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, 'La finca no cuenta con bosque.
Únicamente ganadería');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 5, 'La finca no cuenta con bosque.
Únicamente ganadería');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 3, 'La finca no cuenta con bosque.
Únicamente ganadería');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, 'La finca no cuenta con bosque.
Únicamente ganadería');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 1, 'La finca no cuenta con bosque.
Únicamente ganadería');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, 'La finca no cuenta con bosque.
Únicamente ganadería');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 4, 'La finca no cuenta con bosque.
Únicamente ganadería');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 3, 'La finca no cuenta con bosque.
Únicamente ganadería');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, 'La finca no cuenta con bosque.
Únicamente ganadería');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, 'La finca no cuenta con bosque.
Únicamente ganadería');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, 'La finca no cuenta con bosque.
Únicamente ganadería');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, 'La finca no cuenta con bosque.
Únicamente ganadería');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, 'La finca no cuenta con bosque.
Únicamente ganadería');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, 'La finca no cuenta con bosque.
Únicamente ganadería');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 2, 'La finca no cuenta con bosque.
Únicamente ganadería');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('34557594', 'Ximena Sotelo', 'Canelal', 'Piedra de león', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-18 00:00:00', '2025-02-18 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, 'El ganado macho se vende apenas Destetos para cría');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, 'El ganado macho se vende apenas Destetos para cría');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, 'El ganado macho se vende apenas Destetos para cría');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, 'El ganado macho se vende apenas Destetos para cría');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, 'El ganado macho se vende apenas Destetos para cría');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, 'El ganado macho se vende apenas Destetos para cría');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 2, 'El ganado macho se vende apenas Destetos para cría');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, 'El ganado macho se vende apenas Destetos para cría');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, 'El ganado macho se vende apenas Destetos para cría');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 2, 'El ganado macho se vende apenas Destetos para cría');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, 'El ganado macho se vende apenas Destetos para cría');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, 'El ganado macho se vende apenas Destetos para cría');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, 'El ganado macho se vende apenas Destetos para cría');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'El ganado macho se vende apenas Destetos para cría');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, 'El ganado macho se vende apenas Destetos para cría');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 3, 'El ganado macho se vende apenas Destetos para cría');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 2, 'El ganado macho se vende apenas Destetos para cría');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 3, 'El ganado macho se vende apenas Destetos para cría');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, 'El ganado macho se vende apenas Destetos para cría');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, 'El ganado macho se vende apenas Destetos para cría');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 3, 'El ganado macho se vende apenas Destetos para cría');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 4, 'El ganado macho se vende apenas Destetos para cría');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, 'El ganado macho se vende apenas Destetos para cría');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 1, 'El ganado macho se vende apenas Destetos para cría');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 3, 'El ganado macho se vende apenas Destetos para cría');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, 'El ganado macho se vende apenas Destetos para cría');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, 'El ganado macho se vende apenas Destetos para cría');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 3, 'El ganado macho se vende apenas Destetos para cría');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, 'El ganado macho se vende apenas Destetos para cría');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('1060236279', 'Ana Ruth Avirama Meneses', 'Ramal', 'Piedra de león', 'Sotará', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-18 00:00:00', '2025-02-18 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 4, 'La finca es dedicada a la agricultura y ganadería de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, 'La finca es dedicada a la agricultura y ganadería de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 5, 'La finca es dedicada a la agricultura y ganadería de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, 'La finca es dedicada a la agricultura y ganadería de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, 'La finca es dedicada a la agricultura y ganadería de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 2, 'La finca es dedicada a la agricultura y ganadería de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 5, 'La finca es dedicada a la agricultura y ganadería de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, 'La finca es dedicada a la agricultura y ganadería de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 3, 'La finca es dedicada a la agricultura y ganadería de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 2, 'La finca es dedicada a la agricultura y ganadería de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 2, 'La finca es dedicada a la agricultura y ganadería de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, 'La finca es dedicada a la agricultura y ganadería de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 1, 'La finca es dedicada a la agricultura y ganadería de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'La finca es dedicada a la agricultura y ganadería de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, 'La finca es dedicada a la agricultura y ganadería de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, 'La finca es dedicada a la agricultura y ganadería de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 2, 'La finca es dedicada a la agricultura y ganadería de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 4, 'La finca es dedicada a la agricultura y ganadería de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, 'La finca es dedicada a la agricultura y ganadería de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, 'La finca es dedicada a la agricultura y ganadería de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 3, 'La finca es dedicada a la agricultura y ganadería de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, 'La finca es dedicada a la agricultura y ganadería de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 1, 'La finca es dedicada a la agricultura y ganadería de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, 'La finca es dedicada a la agricultura y ganadería de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 3, 'La finca es dedicada a la agricultura y ganadería de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 1, 'La finca es dedicada a la agricultura y ganadería de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, 'La finca es dedicada a la agricultura y ganadería de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 1, 'La finca es dedicada a la agricultura y ganadería de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, 'La finca es dedicada a la agricultura y ganadería de ceba');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('34543804', 'Maria Carlina Chilito Astaiza', 'El Ramal', 'Piedra de león', 'Sotará', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-18 00:00:00', '2025-02-18 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('1061763987', 'Maicol Eduart Mueses Yace', 'Madeyejo', 'Piedra de león', 'Sotará', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-18 00:00:00', '2025-02-18 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('76327826', 'Eider Arnulfo Zambrano Chilito', 'Libertad', 'Piedra de león', 'Sotará', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-19 00:00:00', '2025-02-19 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('25628392', 'Mariela Coque', 'Los Sauces', 'Piedra de león', 'Sotará', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-19 00:00:00', '2025-02-19 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, 'Todos los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, 'Todos los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, 'Todos los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, 'Todos los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, 'Todos los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, 'Todos los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 2, 'Todos los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, 'Todos los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, 'Todos los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 1, 'Todos los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 2, 'Todos los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, 'Todos los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, 'Todos los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'Todos los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, 'Todos los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, 'Todos los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 2, 'Todos los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, 'Todos los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, 'Todos los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, 'Todos los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, 'Todos los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 3, 'Todos los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 3, 'Todos los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, 'Todos los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 3, 'Todos los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 2, 'Todos los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, 'Todos los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 3, 'Todos los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, 'Todos los terneros se venden Destetos');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('76321243', 'Alfonso Ordoñez Salazar', 'La Libertad', 'Piedra de león', 'Sotará', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-19 00:00:00', '2025-02-19 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 2, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('1061707699', 'Wildeman Mauricio Coque Chilito', 'Molino', 'Mirador', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-19 00:00:00', '2025-02-19 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 2, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 2, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 2, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 1, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 1, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 5, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 4, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 1, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 3, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 5, 'Los terneros se venden Destetos');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('4788051', 'Oscar Armando Quilindo Camayo', 'El Lago', 'Mirador', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-19 00:00:00', '2025-02-19 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 5, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 5, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 5, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 5, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 2, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 1, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 1, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 3, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 4, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 5, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 5, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 1, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 5, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, 'Los terneros se venden Destetos');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('1061735931', 'Alexander Tintinago Fernández', 'El Arrayan 1', 'Mirador', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-21 00:00:00', '2025-02-21 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('25628454', 'Yudy Paola Coque Astaiza', 'El Encenillo', 'Mirador', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-21 00:00:00', '2025-02-21 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 4, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 2, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 5, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 2, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 4, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 3, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 3, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 3, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 4, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 4, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 1, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, 'Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, 'Los terneros se venden Destetos');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('1060237379', 'Marisol Coque Hoyos', 'El Mango 2', 'Mirador', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-21 00:00:00', '2025-02-21 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 2, 'El predio no tiene bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 2, 'El predio no tiene bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 2, 'El predio no tiene bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, 'El predio no tiene bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, 'El predio no tiene bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 1, 'El predio no tiene bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 1, 'El predio no tiene bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, 'El predio no tiene bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 2, 'El predio no tiene bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, 'El predio no tiene bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 2, 'El predio no tiene bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 1, 'El predio no tiene bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, 'El predio no tiene bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'El predio no tiene bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 3, 'El predio no tiene bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, 'El predio no tiene bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 2, 'El predio no tiene bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, 'El predio no tiene bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 1, 'El predio no tiene bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, 'El predio no tiene bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, 'El predio no tiene bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 3, 'El predio no tiene bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, 'El predio no tiene bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, 'El predio no tiene bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, 'El predio no tiene bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, 'El predio no tiene bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, 'El predio no tiene bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, 'El predio no tiene bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, 'El predio no tiene bosque');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('25628736', 'Maria Cristina Astaiza Hernández', 'Mirador 4', 'Mirador', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-21 00:00:00', '2025-02-21 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('34324603', 'Yina Cecilia Pillimur Benavides', 'Lacasia', 'Mirador', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-24 00:00:00', '2025-02-24 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 4, 'La finca no cuenta con bosque. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, 'La finca no cuenta con bosque. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, 'La finca no cuenta con bosque. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, 'La finca no cuenta con bosque. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, 'La finca no cuenta con bosque. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, 'La finca no cuenta con bosque. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 1, 'La finca no cuenta con bosque. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, 'La finca no cuenta con bosque. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, 'La finca no cuenta con bosque. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, 'La finca no cuenta con bosque. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 3, 'La finca no cuenta con bosque. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, 'La finca no cuenta con bosque. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 1, 'La finca no cuenta con bosque. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'La finca no cuenta con bosque. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, 'La finca no cuenta con bosque. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, 'La finca no cuenta con bosque. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 5, 'La finca no cuenta con bosque. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, 'La finca no cuenta con bosque. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, 'La finca no cuenta con bosque. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, 'La finca no cuenta con bosque. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, 'La finca no cuenta con bosque. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 4, 'La finca no cuenta con bosque. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, 'La finca no cuenta con bosque. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 1, 'La finca no cuenta con bosque. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, 'La finca no cuenta con bosque. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, 'La finca no cuenta con bosque. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, 'La finca no cuenta con bosque. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 3, 'La finca no cuenta con bosque. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, 'La finca no cuenta con bosque. Los terneros se venden Destetos');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('76317893', 'Alirio Tombe Hoyos', 'Los Eucaliptos', 'Mirador', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-24 00:00:00', '2025-02-24 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('25628696', 'Carmen Delia Coque Urrea', 'Rincones 1', 'El Jigual 2', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-24 00:00:00', '2025-02-24 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 3, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('10575078', 'Luis Carlos Astaiza', 'Palmar', 'Mirador', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-24 00:00:00', '2025-02-24 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('1060236659', 'Jadyr Astaiza Coque', 'El palmar', 'Mirador', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-24 00:00:00', '2025-02-24 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('34536875', 'Luz Eddy Mosquera Diaz', 'Buena Vista', 'Mirador', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-24 00:00:00', '2025-02-24 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('76290446', 'Jaime Humberto Hoyos Ocoro', 'La Merced 1', 'Mirador', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-26 00:00:00', '2025-02-26 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, 'El predio no cuenta con área en bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 2, 'El predio no cuenta con área en bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, 'El predio no cuenta con área en bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, 'El predio no cuenta con área en bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, 'El predio no cuenta con área en bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, 'El predio no cuenta con área en bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 1, 'El predio no cuenta con área en bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, 'El predio no cuenta con área en bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, 'El predio no cuenta con área en bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, 'El predio no cuenta con área en bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, 'El predio no cuenta con área en bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 1, 'El predio no cuenta con área en bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 1, 'El predio no cuenta con área en bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'El predio no cuenta con área en bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, 'El predio no cuenta con área en bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 5, 'El predio no cuenta con área en bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 2, 'El predio no cuenta con área en bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, 'El predio no cuenta con área en bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, 'El predio no cuenta con área en bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 4, 'El predio no cuenta con área en bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, 'El predio no cuenta con área en bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 3, 'El predio no cuenta con área en bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, 'El predio no cuenta con área en bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, 'El predio no cuenta con área en bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, 'El predio no cuenta con área en bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, 'El predio no cuenta con área en bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, 'El predio no cuenta con área en bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, 'El predio no cuenta con área en bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, 'El predio no cuenta con área en bosque');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('34536354', 'Suli del Carmen Ruiz', 'La Lajita', 'Mirador', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-26 00:00:00', '2025-02-26 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('25628171', 'Yeim Sofia Vargas Gutierres', 'Porvenir 5', 'El Jigual 2', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-26 00:00:00', '2025-02-26 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 2, 'La finca no cuenta con bosque, no se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 2, 'La finca no cuenta con bosque, no se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, 'La finca no cuenta con bosque, no se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, 'La finca no cuenta con bosque, no se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, 'La finca no cuenta con bosque, no se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, 'La finca no cuenta con bosque, no se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 1, 'La finca no cuenta con bosque, no se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, 'La finca no cuenta con bosque, no se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, 'La finca no cuenta con bosque, no se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, 'La finca no cuenta con bosque, no se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, 'La finca no cuenta con bosque, no se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 1, 'La finca no cuenta con bosque, no se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, 'La finca no cuenta con bosque, no se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'La finca no cuenta con bosque, no se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, 'La finca no cuenta con bosque, no se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, 'La finca no cuenta con bosque, no se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 3, 'La finca no cuenta con bosque, no se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 1, 'La finca no cuenta con bosque, no se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 1, 'La finca no cuenta con bosque, no se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, 'La finca no cuenta con bosque, no se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, 'La finca no cuenta con bosque, no se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 3, 'La finca no cuenta con bosque, no se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 1, 'La finca no cuenta con bosque, no se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, 'La finca no cuenta con bosque, no se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, 'La finca no cuenta con bosque, no se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, 'La finca no cuenta con bosque, no se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, 'La finca no cuenta con bosque, no se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, 'La finca no cuenta con bosque, no se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, 'La finca no cuenta con bosque, no se lleva registros');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('10575065', 'Ismael Antonio Cuaji', 'Los Rincones', 'El Jigual 2', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-26 00:00:00', '2025-02-26 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 4, 'No lleva registros,');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, 'No lleva registros,');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, 'No lleva registros,');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, 'No lleva registros,');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, 'No lleva registros,');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 1, 'No lleva registros,');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, 'No lleva registros,');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, 'No lleva registros,');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 2, 'No lleva registros,');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, 'No lleva registros,');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, 'No lleva registros,');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 1, 'No lleva registros,');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, 'No lleva registros,');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'No lleva registros,');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, 'No lleva registros,');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, 'No lleva registros,');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 3, 'No lleva registros,');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, 'No lleva registros,');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, 'No lleva registros,');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, 'No lleva registros,');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, 'No lleva registros,');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 3, 'No lleva registros,');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 1, 'No lleva registros,');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, 'No lleva registros,');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 2, 'No lleva registros,');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, 'No lleva registros,');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, 'No lleva registros,');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 3, 'No lleva registros,');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, 'No lleva registros,');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('25628735', 'Sandra Patricia Astaiza Hernandez', 'Acuario 4', 'El Jigual 2', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-26 00:00:00', '2025-02-26 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 2, 'La finca no cuenta con bosque. El suministro de agua es acueducto regional. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 2, 'La finca no cuenta con bosque. El suministro de agua es acueducto regional. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, 'La finca no cuenta con bosque. El suministro de agua es acueducto regional. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, 'La finca no cuenta con bosque. El suministro de agua es acueducto regional. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, 'La finca no cuenta con bosque. El suministro de agua es acueducto regional. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, 'La finca no cuenta con bosque. El suministro de agua es acueducto regional. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 1, 'La finca no cuenta con bosque. El suministro de agua es acueducto regional. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, 'La finca no cuenta con bosque. El suministro de agua es acueducto regional. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 4, 'La finca no cuenta con bosque. El suministro de agua es acueducto regional. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 2, 'La finca no cuenta con bosque. El suministro de agua es acueducto regional. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, 'La finca no cuenta con bosque. El suministro de agua es acueducto regional. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 1, 'La finca no cuenta con bosque. El suministro de agua es acueducto regional. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 3, 'La finca no cuenta con bosque. El suministro de agua es acueducto regional. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'La finca no cuenta con bosque. El suministro de agua es acueducto regional. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, 'La finca no cuenta con bosque. El suministro de agua es acueducto regional. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, 'La finca no cuenta con bosque. El suministro de agua es acueducto regional. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, 'La finca no cuenta con bosque. El suministro de agua es acueducto regional. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 3, 'La finca no cuenta con bosque. El suministro de agua es acueducto regional. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, 'La finca no cuenta con bosque. El suministro de agua es acueducto regional. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, 'La finca no cuenta con bosque. El suministro de agua es acueducto regional. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, 'La finca no cuenta con bosque. El suministro de agua es acueducto regional. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 3, 'La finca no cuenta con bosque. El suministro de agua es acueducto regional. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, 'La finca no cuenta con bosque. El suministro de agua es acueducto regional. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 1, 'La finca no cuenta con bosque. El suministro de agua es acueducto regional. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 3, 'La finca no cuenta con bosque. El suministro de agua es acueducto regional. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 4, 'La finca no cuenta con bosque. El suministro de agua es acueducto regional. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, 'La finca no cuenta con bosque. El suministro de agua es acueducto regional. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, 'La finca no cuenta con bosque. El suministro de agua es acueducto regional. Los terneros se venden Destetos');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 3, 'La finca no cuenta con bosque. El suministro de agua es acueducto regional. Los terneros se venden Destetos');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('10575136', 'Jose Andres Narvaez Guañarita', 'Margaritas 4', 'El Jigual 2', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-26 00:00:00', '2025-02-26 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 5, 'En la parte baja de la fin hay bosque y nacimiento los cuales están protegidos. El agua utilizada para el ganado es de acueducto.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, 'En la parte baja de la fin hay bosque y nacimiento los cuales están protegidos. El agua utilizada para el ganado es de acueducto.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, 'En la parte baja de la fin hay bosque y nacimiento los cuales están protegidos. El agua utilizada para el ganado es de acueducto.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, 'En la parte baja de la fin hay bosque y nacimiento los cuales están protegidos. El agua utilizada para el ganado es de acueducto.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, 'En la parte baja de la fin hay bosque y nacimiento los cuales están protegidos. El agua utilizada para el ganado es de acueducto.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 4, 'En la parte baja de la fin hay bosque y nacimiento los cuales están protegidos. El agua utilizada para el ganado es de acueducto.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 5, 'En la parte baja de la fin hay bosque y nacimiento los cuales están protegidos. El agua utilizada para el ganado es de acueducto.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, 'En la parte baja de la fin hay bosque y nacimiento los cuales están protegidos. El agua utilizada para el ganado es de acueducto.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, 'En la parte baja de la fin hay bosque y nacimiento los cuales están protegidos. El agua utilizada para el ganado es de acueducto.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 4, 'En la parte baja de la fin hay bosque y nacimiento los cuales están protegidos. El agua utilizada para el ganado es de acueducto.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 5, 'En la parte baja de la fin hay bosque y nacimiento los cuales están protegidos. El agua utilizada para el ganado es de acueducto.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 1, 'En la parte baja de la fin hay bosque y nacimiento los cuales están protegidos. El agua utilizada para el ganado es de acueducto.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, 'En la parte baja de la fin hay bosque y nacimiento los cuales están protegidos. El agua utilizada para el ganado es de acueducto.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'En la parte baja de la fin hay bosque y nacimiento los cuales están protegidos. El agua utilizada para el ganado es de acueducto.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, 'En la parte baja de la fin hay bosque y nacimiento los cuales están protegidos. El agua utilizada para el ganado es de acueducto.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, 'En la parte baja de la fin hay bosque y nacimiento los cuales están protegidos. El agua utilizada para el ganado es de acueducto.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 3, 'En la parte baja de la fin hay bosque y nacimiento los cuales están protegidos. El agua utilizada para el ganado es de acueducto.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 1, 'En la parte baja de la fin hay bosque y nacimiento los cuales están protegidos. El agua utilizada para el ganado es de acueducto.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 1, 'En la parte baja de la fin hay bosque y nacimiento los cuales están protegidos. El agua utilizada para el ganado es de acueducto.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, 'En la parte baja de la fin hay bosque y nacimiento los cuales están protegidos. El agua utilizada para el ganado es de acueducto.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 4, 'En la parte baja de la fin hay bosque y nacimiento los cuales están protegidos. El agua utilizada para el ganado es de acueducto.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 3, 'En la parte baja de la fin hay bosque y nacimiento los cuales están protegidos. El agua utilizada para el ganado es de acueducto.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, 'En la parte baja de la fin hay bosque y nacimiento los cuales están protegidos. El agua utilizada para el ganado es de acueducto.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, 'En la parte baja de la fin hay bosque y nacimiento los cuales están protegidos. El agua utilizada para el ganado es de acueducto.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, 'En la parte baja de la fin hay bosque y nacimiento los cuales están protegidos. El agua utilizada para el ganado es de acueducto.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 4, 'En la parte baja de la fin hay bosque y nacimiento los cuales están protegidos. El agua utilizada para el ganado es de acueducto.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, 'En la parte baja de la fin hay bosque y nacimiento los cuales están protegidos. El agua utilizada para el ganado es de acueducto.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, 'En la parte baja de la fin hay bosque y nacimiento los cuales están protegidos. El agua utilizada para el ganado es de acueducto.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, 'En la parte baja de la fin hay bosque y nacimiento los cuales están protegidos. El agua utilizada para el ganado es de acueducto.');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('34554040', 'Maria de Lourdes Mensa Cerquera', 'Retorno 4', 'El Jigual 2', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-27 00:00:00', '2025-02-27 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 2, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('10106323', 'Alirio Sanchez Muñoz', 'Laureles 2', 'El Jigual 2', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-27 00:00:00', '2025-02-27 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('34523881', 'Irma Ines Astaiza', 'Retorno 7', 'El Jigual 2', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-27 00:00:00', '2025-02-27 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, 'En la finca no hay suministro de agua en los potreros por fuente natural.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 1, 'En la finca no hay suministro de agua en los potreros por fuente natural.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 2, 'En la finca no hay suministro de agua en los potreros por fuente natural.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, 'En la finca no hay suministro de agua en los potreros por fuente natural.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, 'En la finca no hay suministro de agua en los potreros por fuente natural.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 2, 'En la finca no hay suministro de agua en los potreros por fuente natural.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, 'En la finca no hay suministro de agua en los potreros por fuente natural.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, 'En la finca no hay suministro de agua en los potreros por fuente natural.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 3, 'En la finca no hay suministro de agua en los potreros por fuente natural.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, 'En la finca no hay suministro de agua en los potreros por fuente natural.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 3, 'En la finca no hay suministro de agua en los potreros por fuente natural.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 1, 'En la finca no hay suministro de agua en los potreros por fuente natural.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, 'En la finca no hay suministro de agua en los potreros por fuente natural.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'En la finca no hay suministro de agua en los potreros por fuente natural.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, 'En la finca no hay suministro de agua en los potreros por fuente natural.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, 'En la finca no hay suministro de agua en los potreros por fuente natural.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, 'En la finca no hay suministro de agua en los potreros por fuente natural.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, 'En la finca no hay suministro de agua en los potreros por fuente natural.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, 'En la finca no hay suministro de agua en los potreros por fuente natural.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, 'En la finca no hay suministro de agua en los potreros por fuente natural.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 4, 'En la finca no hay suministro de agua en los potreros por fuente natural.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 3, 'En la finca no hay suministro de agua en los potreros por fuente natural.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, 'En la finca no hay suministro de agua en los potreros por fuente natural.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, 'En la finca no hay suministro de agua en los potreros por fuente natural.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 3, 'En la finca no hay suministro de agua en los potreros por fuente natural.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, 'En la finca no hay suministro de agua en los potreros por fuente natural.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, 'En la finca no hay suministro de agua en los potreros por fuente natural.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, 'En la finca no hay suministro de agua en los potreros por fuente natural.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, 'En la finca no hay suministro de agua en los potreros por fuente natural.');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('25627862', 'Armida Ordoñez Narváez', 'Los Rincones 3', 'El Jigual 2', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-27 00:00:00', '2025-02-27 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('1060238864', 'Anuar Adrian Astaiza Muñoz', 'La Primavera', 'El Jigual 2', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-27 00:00:00', '2025-02-27 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, 'En la finca no hay fuentes naturales de agua.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, 'En la finca no hay fuentes naturales de agua.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, 'En la finca no hay fuentes naturales de agua.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, 'En la finca no hay fuentes naturales de agua.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, 'En la finca no hay fuentes naturales de agua.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, 'En la finca no hay fuentes naturales de agua.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 1, 'En la finca no hay fuentes naturales de agua.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, 'En la finca no hay fuentes naturales de agua.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, 'En la finca no hay fuentes naturales de agua.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, 'En la finca no hay fuentes naturales de agua.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, 'En la finca no hay fuentes naturales de agua.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 1, 'En la finca no hay fuentes naturales de agua.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 1, 'En la finca no hay fuentes naturales de agua.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'En la finca no hay fuentes naturales de agua.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, 'En la finca no hay fuentes naturales de agua.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, 'En la finca no hay fuentes naturales de agua.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 3, 'En la finca no hay fuentes naturales de agua.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, 'En la finca no hay fuentes naturales de agua.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, 'En la finca no hay fuentes naturales de agua.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, 'En la finca no hay fuentes naturales de agua.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 3, 'En la finca no hay fuentes naturales de agua.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 3, 'En la finca no hay fuentes naturales de agua.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, 'En la finca no hay fuentes naturales de agua.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 4, 'En la finca no hay fuentes naturales de agua.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, 'En la finca no hay fuentes naturales de agua.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 4, 'En la finca no hay fuentes naturales de agua.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, 'En la finca no hay fuentes naturales de agua.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, 'En la finca no hay fuentes naturales de agua.');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, 'En la finca no hay fuentes naturales de agua.');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('34330581', 'Rosalba Andrea Astaiza Bolaños', 'El Retorno 6', 'El Jigual 2', 'Puracé', 0.005454, 0.001091, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-03-11 00:00:00', '2025-03-11 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 4, 'No se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, 'No se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 5, 'No se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, 'No se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, 'No se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, 'No se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, 'No se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, 'No se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, 'No se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 4, 'No se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, 'No se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, 'No se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, 'No se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'No se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, 'No se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, 'No se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, 'No se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 3, 'No se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 1, 'No se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, 'No se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, 'No se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 5, 'No se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, 'No se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, 'No se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 3, 'No se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, 'No se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, 'No se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, 'No se lleva registros');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, 'No se lleva registros');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('76306436', 'Felipe Muñoz Astaiza', 'El Semillero 1', 'El Jigual 2', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-03-11 00:00:00', '2025-03-11 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 4, 'el área de bosque es de 0,5 h');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, 'el área de bosque es de 0,5 h');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, 'el área de bosque es de 0,5 h');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, 'el área de bosque es de 0,5 h');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, 'el área de bosque es de 0,5 h');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, 'el área de bosque es de 0,5 h');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, 'el área de bosque es de 0,5 h');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, 'el área de bosque es de 0,5 h');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, 'el área de bosque es de 0,5 h');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, 'el área de bosque es de 0,5 h');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, 'el área de bosque es de 0,5 h');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, 'el área de bosque es de 0,5 h');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, 'el área de bosque es de 0,5 h');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'el área de bosque es de 0,5 h');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, 'el área de bosque es de 0,5 h');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, 'el área de bosque es de 0,5 h');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, 'el área de bosque es de 0,5 h');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, 'el área de bosque es de 0,5 h');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 1, 'el área de bosque es de 0,5 h');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, 'el área de bosque es de 0,5 h');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, 'el área de bosque es de 0,5 h');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 4, 'el área de bosque es de 0,5 h');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, 'el área de bosque es de 0,5 h');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, 'el área de bosque es de 0,5 h');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, 'el área de bosque es de 0,5 h');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, 'el área de bosque es de 0,5 h');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, 'el área de bosque es de 0,5 h');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, 'el área de bosque es de 0,5 h');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 3, 'el área de bosque es de 0,5 h');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('76314811', 'Ruben Dario Chilito Astaiza', 'Lagunitas', 'Mirador', 'Puracé', 0.002134, 0.00051, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-03-11 00:00:00', '2025-03-11 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('10291996', 'Elias Bolaños Mosquera', 'Estrecho', 'Mirador', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-03-11 00:00:00', '2025-03-11 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('25627858', 'Gabi Stella Collazos Astaiza', 'Margaritas', 'El Jigual 2', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-03-11 00:00:00', '2025-03-11 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 4, 'La finca no cuenta con área de bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, 'La finca no cuenta con área de bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, 'La finca no cuenta con área de bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, 'La finca no cuenta con área de bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, 'La finca no cuenta con área de bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, 'La finca no cuenta con área de bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 1, 'La finca no cuenta con área de bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, 'La finca no cuenta con área de bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, 'La finca no cuenta con área de bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, 'La finca no cuenta con área de bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, 'La finca no cuenta con área de bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 1, 'La finca no cuenta con área de bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, 'La finca no cuenta con área de bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'La finca no cuenta con área de bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, 'La finca no cuenta con área de bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, 'La finca no cuenta con área de bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, 'La finca no cuenta con área de bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, 'La finca no cuenta con área de bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, 'La finca no cuenta con área de bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, 'La finca no cuenta con área de bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 4, 'La finca no cuenta con área de bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 3, 'La finca no cuenta con área de bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, 'La finca no cuenta con área de bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, 'La finca no cuenta con área de bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, 'La finca no cuenta con área de bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, 'La finca no cuenta con área de bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, 'La finca no cuenta con área de bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, 'La finca no cuenta con área de bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 2, 'La finca no cuenta con área de bosque');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('76320685', 'Carlos Adelmo Silva Atehortua', 'El Desierto', 'El Jigual 2', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-03-11 00:00:00', '2025-03-11 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, 'La finca no cuenta con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, 'La finca no cuenta con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, 'La finca no cuenta con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, 'La finca no cuenta con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, 'La finca no cuenta con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 2, 'La finca no cuenta con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 1, 'La finca no cuenta con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, 'La finca no cuenta con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, 'La finca no cuenta con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, 'La finca no cuenta con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, 'La finca no cuenta con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, 'La finca no cuenta con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, 'La finca no cuenta con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'La finca no cuenta con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, 'La finca no cuenta con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, 'La finca no cuenta con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, 'La finca no cuenta con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 1, 'La finca no cuenta con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 1, 'La finca no cuenta con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, 'La finca no cuenta con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, 'La finca no cuenta con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, 'La finca no cuenta con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, 'La finca no cuenta con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, 'La finca no cuenta con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 3, 'La finca no cuenta con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, 'La finca no cuenta con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, 'La finca no cuenta con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, 'La finca no cuenta con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, 'La finca no cuenta con bosque');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('1061716801', 'Duban Ernesto Collazos', 'Margaritas', 'El Jigual 2', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-03-12 00:00:00', '2025-03-12 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, 'En la finca no hay fuentes de agua natural, los terneros se venden Destetos, no cuenta  con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, 'En la finca no hay fuentes de agua natural, los terneros se venden Destetos, no cuenta  con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, 'En la finca no hay fuentes de agua natural, los terneros se venden Destetos, no cuenta  con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, 'En la finca no hay fuentes de agua natural, los terneros se venden Destetos, no cuenta  con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, 'En la finca no hay fuentes de agua natural, los terneros se venden Destetos, no cuenta  con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, 'En la finca no hay fuentes de agua natural, los terneros se venden Destetos, no cuenta  con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 1, 'En la finca no hay fuentes de agua natural, los terneros se venden Destetos, no cuenta  con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, 'En la finca no hay fuentes de agua natural, los terneros se venden Destetos, no cuenta  con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, 'En la finca no hay fuentes de agua natural, los terneros se venden Destetos, no cuenta  con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, 'En la finca no hay fuentes de agua natural, los terneros se venden Destetos, no cuenta  con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, 'En la finca no hay fuentes de agua natural, los terneros se venden Destetos, no cuenta  con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 1, 'En la finca no hay fuentes de agua natural, los terneros se venden Destetos, no cuenta  con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, 'En la finca no hay fuentes de agua natural, los terneros se venden Destetos, no cuenta  con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'En la finca no hay fuentes de agua natural, los terneros se venden Destetos, no cuenta  con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, 'En la finca no hay fuentes de agua natural, los terneros se venden Destetos, no cuenta  con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, 'En la finca no hay fuentes de agua natural, los terneros se venden Destetos, no cuenta  con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, 'En la finca no hay fuentes de agua natural, los terneros se venden Destetos, no cuenta  con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, 'En la finca no hay fuentes de agua natural, los terneros se venden Destetos, no cuenta  con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 1, 'En la finca no hay fuentes de agua natural, los terneros se venden Destetos, no cuenta  con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, 'En la finca no hay fuentes de agua natural, los terneros se venden Destetos, no cuenta  con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 3, 'En la finca no hay fuentes de agua natural, los terneros se venden Destetos, no cuenta  con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 5, 'En la finca no hay fuentes de agua natural, los terneros se venden Destetos, no cuenta  con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, 'En la finca no hay fuentes de agua natural, los terneros se venden Destetos, no cuenta  con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 3, 'En la finca no hay fuentes de agua natural, los terneros se venden Destetos, no cuenta  con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, 'En la finca no hay fuentes de agua natural, los terneros se venden Destetos, no cuenta  con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, 'En la finca no hay fuentes de agua natural, los terneros se venden Destetos, no cuenta  con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, 'En la finca no hay fuentes de agua natural, los terneros se venden Destetos, no cuenta  con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, 'En la finca no hay fuentes de agua natural, los terneros se venden Destetos, no cuenta  con bosque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 3, 'En la finca no hay fuentes de agua natural, los terneros se venden Destetos, no cuenta  con bosque');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('76290507', 'Guillermo Humberto Moncada Menza', 'Laureles 1', 'El Jigual 2', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-03-12 00:00:00', '2025-03-12 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 2, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('10544540', 'Atanasio Garcia Perez', 'El Retorno Lote 2', 'El Jigual 2', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-03-12 00:00:00', '2025-03-12 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('76276263', 'Carlos Albeiro Orozco Bahos', 'San Roque Bajo', 'Mirador', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-03-12 00:00:00', '2025-03-12 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('25628657', 'Carmelina Muñoz de Mosca', 'Cumbre Alta', 'Rio Claro', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-18 00:00:00', '2025-02-18 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 2, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('25706853', 'Olga Fani Velazco Salazar', 'El Lago', 'Rio Claro', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-18 00:00:00', '2025-02-18 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 5, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('25628649', 'Miriam Ester Magin Olave', 'San Emidio', 'Rio Claro', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-18 00:00:00', '2025-02-18 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 4, 'Visitas atendida por el hijo de la productora');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 2, 'Visitas atendida por el hijo de la productora');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, 'Visitas atendida por el hijo de la productora');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, 'Visitas atendida por el hijo de la productora');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, 'Visitas atendida por el hijo de la productora');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 4, 'Visitas atendida por el hijo de la productora');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, 'Visitas atendida por el hijo de la productora');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, 'Visitas atendida por el hijo de la productora');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 3, 'Visitas atendida por el hijo de la productora');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, 'Visitas atendida por el hijo de la productora');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 2, 'Visitas atendida por el hijo de la productora');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, 'Visitas atendida por el hijo de la productora');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, 'Visitas atendida por el hijo de la productora');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'Visitas atendida por el hijo de la productora');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, 'Visitas atendida por el hijo de la productora');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, 'Visitas atendida por el hijo de la productora');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 4, 'Visitas atendida por el hijo de la productora');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 4, 'Visitas atendida por el hijo de la productora');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, 'Visitas atendida por el hijo de la productora');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, 'Visitas atendida por el hijo de la productora');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 5, 'Visitas atendida por el hijo de la productora');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 2, 'Visitas atendida por el hijo de la productora');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, 'Visitas atendida por el hijo de la productora');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 4, 'Visitas atendida por el hijo de la productora');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, 'Visitas atendida por el hijo de la productora');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 3, 'Visitas atendida por el hijo de la productora');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, 'Visitas atendida por el hijo de la productora');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 5, 'Visitas atendida por el hijo de la productora');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, 'Visitas atendida por el hijo de la productora');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('76307245', 'Fernando Arturo Olave Mosquera', 'La Arenera', 'Rio Claro', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-18 00:00:00', '2025-02-18 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, 'Efectúa el pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 1, 'Efectúa el pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 2, 'Efectúa el pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, 'Efectúa el pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, 'Efectúa el pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 2, 'Efectúa el pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 1, 'Efectúa el pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, 'Efectúa el pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 3, 'Efectúa el pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 2, 'Efectúa el pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 1, 'Efectúa el pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, 'Efectúa el pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, 'Efectúa el pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 4, 'Efectúa el pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, 'Efectúa el pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, 'Efectúa el pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 2, 'Efectúa el pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 3, 'Efectúa el pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 1, 'Efectúa el pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, 'Efectúa el pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 5, 'Efectúa el pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 2, 'Efectúa el pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, 'Efectúa el pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, 'Efectúa el pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 3, 'Efectúa el pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, 'Efectúa el pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, 'Efectúa el pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 5, 'Efectúa el pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, 'Efectúa el pastoreo en otros predios');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('25628600', 'Maria Esther Gutierrez de Callapu', 'Nueva Esperanza', 'Rio Claro', 'Puracé', 2.195055, -76.519409, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-19 00:00:00', '2025-02-19 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 2, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('4611633', 'Helber Olmedo Camayo', 'Las Acasias', 'Rio Claro', 'Puracé', 2.209376, -76.513385, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-19 00:00:00', '2025-02-19 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 3, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('10530463', 'Pedro Leon Perdomo Gutierrez', 'San Emidio', 'Rio Claro', 'Puracé', 2.194442, -76.514138, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-19 00:00:00', '2025-02-19 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 2, 'El aliado efectua pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 1, 'El aliado efectua pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 2, 'El aliado efectua pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, 'El aliado efectua pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, 'El aliado efectua pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 2, 'El aliado efectua pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, 'El aliado efectua pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, 'El aliado efectua pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, 'El aliado efectua pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, 'El aliado efectua pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 2, 'El aliado efectua pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, 'El aliado efectua pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 1, 'El aliado efectua pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'El aliado efectua pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 3, 'El aliado efectua pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, 'El aliado efectua pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, 'El aliado efectua pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 3, 'El aliado efectua pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 4, 'El aliado efectua pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, 'El aliado efectua pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 5, 'El aliado efectua pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, 'El aliado efectua pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 3, 'El aliado efectua pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 4, 'El aliado efectua pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, 'El aliado efectua pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, 'El aliado efectua pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, 'El aliado efectua pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 5, 'El aliado efectua pastoreo en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, 'El aliado efectua pastoreo en otros predios');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('25628666', 'Esperanza Rivera Garzón', 'La Florida', 'Deposito', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-21 00:00:00', '2025-02-21 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('25628714', 'Rut Deomira Olave Mosquera', 'El Arenal', 'Rio Claro', 'Puracé', 2.212465, -76.520477, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-21 00:00:00', '2025-02-21 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('35511195', 'Luz Marina Quintero Muñoz', 'Arenal', 'Rio Claro', 'Puracé', 2.212436, -76.516426, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-21 00:00:00', '2025-02-21 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('4749488', 'Jose Cipriano Avirama', 'La Quebrada', 'Rio Claro', 'Puracé', 2.198508, -76.508037, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-21 00:00:00', '2025-02-21 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('52222636', 'Aura Elisa Olave Mosquera', 'La pelota San Emidio', 'Rio Claro', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-21 00:00:00', '2025-02-21 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('25290321', 'Ismenia Coaji Guadir', 'Planadas San Luis', 'Rio Negro', 'Puracé', 2.207572, -76.489405, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-26 00:00:00', '2025-02-26 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 4, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('25628072', 'Maria Isabel Yalanda Pausa', 'El Bosque', 'Centro', 'Puracé', 2.207588, -76.489396, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-26 00:00:00', '2025-02-26 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('1060238172', 'Yoher Alexis Quelal Coaji', 'San Luiz', 'El Jigual 2', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-26 00:00:00', '2025-02-26 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('25628664', 'Edelmira Quilindo Astaiza', 'El Arrayan', 'Deposito', 'Puracé', 2.205366, -76.498836, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-26 00:00:00', '2025-02-26 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 2, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('25628709', 'Maria Rubiela Magon Niquinaz', 'Plán Bajo', 'Centro', 'Puracé', 2.202848, -76.49151, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-26 00:00:00', '2025-02-26 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('1064427718', 'Carmen Nery Velasco Almendra', 'Los Planes', 'Rio Negro', 'Puracé', 2.202878, -76.491572, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-26 00:00:00', '2025-02-26 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('34562649', 'Aida Ligia Olave Mosquera', 'El Pino', 'Rio Claro', 'Puracé', 2.218637, -76.536807, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-27 00:00:00', '2025-02-27 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('34599376', 'Rosa Elena Yule Guasaquillo', 'Dos Quebradas', 'Rio Claro', 'Puracé', 2.218616, -76.536743, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-27 00:00:00', '2025-02-27 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 2, 'En el predio se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, 'En el predio se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, 'En el predio se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 4, 'En el predio se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, 'En el predio se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, 'En el predio se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, 'En el predio se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, 'En el predio se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, 'En el predio se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, 'En el predio se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 3, 'En el predio se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, 'En el predio se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, 'En el predio se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'En el predio se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, 'En el predio se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 3, 'En el predio se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, 'En el predio se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 1, 'En el predio se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, 'En el predio se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, 'En el predio se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, 'En el predio se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, 'En el predio se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, 'En el predio se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, 'En el predio se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, 'En el predio se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, 'En el predio se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, 'En el predio se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, 'En el predio se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, 'En el predio se maneja ganado de ceba');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('25628697', 'Gerardina Gurrute', 'Arenal', 'Rio Claro', 'Puracé', 2.206079, -76.530177, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-27 00:00:00', '2025-02-27 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('76313627', 'Jose Glenis Serna Bolaños', 'El Arenal', 'Rio Claro', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-27 00:00:00', '2025-02-27 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('25628731', 'Luz Mila Cuaji Perdomo', 'El Amparo 7', 'Rio Claro', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-27 00:00:00', '2025-02-27 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('76290304', 'Milton Dario Cerquera Urrutia', 'El Diviso', 'Rio Negro', 'Puracé', 2.205142, -76.473361, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-28 00:00:00', '2025-02-28 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 4, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('76290488', 'Luis Humberto Morales Perafan', 'Canelo', 'Centro', 'Puracé', 2.196938, -76.487209, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-28 00:00:00', '2025-02-28 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 2, 'Visita atendida por la esposa del aliado');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 1, 'Visita atendida por la esposa del aliado');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 2, 'Visita atendida por la esposa del aliado');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, 'Visita atendida por la esposa del aliado');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, 'Visita atendida por la esposa del aliado');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, 'Visita atendida por la esposa del aliado');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, 'Visita atendida por la esposa del aliado');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, 'Visita atendida por la esposa del aliado');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, 'Visita atendida por la esposa del aliado');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, 'Visita atendida por la esposa del aliado');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, 'Visita atendida por la esposa del aliado');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, 'Visita atendida por la esposa del aliado');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, 'Visita atendida por la esposa del aliado');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'Visita atendida por la esposa del aliado');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, 'Visita atendida por la esposa del aliado');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, 'Visita atendida por la esposa del aliado');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, 'Visita atendida por la esposa del aliado');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 4, 'Visita atendida por la esposa del aliado');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, 'Visita atendida por la esposa del aliado');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, 'Visita atendida por la esposa del aliado');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 5, 'Visita atendida por la esposa del aliado');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 3, 'Visita atendida por la esposa del aliado');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, 'Visita atendida por la esposa del aliado');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, 'Visita atendida por la esposa del aliado');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 3, 'Visita atendida por la esposa del aliado');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, 'Visita atendida por la esposa del aliado');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, 'Visita atendida por la esposa del aliado');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 5, 'Visita atendida por la esposa del aliado');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, 'Visita atendida por la esposa del aliado');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('34528698', 'Maria Doris Perdomo Coque', 'Santa Ana', 'Deposito', 'Puracé', 2.18947, -76.508978, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-28 00:00:00', '2025-02-28 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('1061709854', 'Jeison Almir Yacumal Coque', 'Los Pinos', 'Deposito', 'Puracé', 2.17618, -76.509828, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-28 00:00:00', '2025-02-28 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 3, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('1060238794', 'Sandra Mileth Susatama Astaiza', 'Brasilia', 'Deposito', 'Puracé', 2.178775, -76.509996, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-28 00:00:00', '2025-02-28 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 2, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('1061758574', 'Hector Ignacio Narvaez Bolaños', '', '', 'Puracé', 2.195156, -76.50635, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-02-28 00:00:00', '2025-02-28 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, 'Se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, 'Se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, 'Se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, 'Se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, 'Se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, 'Se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 1, 'Se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, 'Se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, 'Se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, 'Se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 2, 'Se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, 'Se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, 'Se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'Se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, 'Se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, 'Se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, 'Se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 1, 'Se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, 'Se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 2, 'Se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, 'Se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, 'Se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, 'Se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, 'Se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 3, 'Se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 3, 'Se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, 'Se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 3, 'Se maneja ganado de ceba');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, 'Se maneja ganado de ceba');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('1060237167', 'Maria Claudia Muñoz Olave', 'El Lago', 'Rio Claro', 'Puracé', 2.197438, -76.528695, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-03-19 00:00:00', '2025-03-19 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('10526417', 'Pedro Anibal Cuaji Susatama', 'Pajonal 3', 'Deposito', 'Puracé', 2.192608, -76.500281, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-03-19 00:00:00', '2025-03-19 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('76322728', 'Rodrigo Golondrino Melenje', 'El Guacharaco', 'Deposito', 'Puracé', 2.192578, -76.500235, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-03-19 00:00:00', '2025-03-19 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('25628734', 'Aura Matilde Muñoz Alonso', 'La Peña', 'Rio Claro', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-03-20 00:00:00', '2025-03-20 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('10545716', 'Guido Hernan Meneses', 'Cortaderal', 'Deposito', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-03-20 00:00:00', '2025-03-20 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('10575126', 'Macister Muñoz Alonso', 'Cortaderal', 'Deposito', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-03-20 00:00:00', '2025-03-20 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('10575076', 'Jose Rey Cuaji Susatama', 'San Rafael', 'Deposito', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-03-20 00:00:00', '2025-03-20 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 5, 'El aliado maneja la rotación en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 5, 'El aliado maneja la rotación en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 5, 'El aliado maneja la rotación en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, 'El aliado maneja la rotación en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, 'El aliado maneja la rotación en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 4, 'El aliado maneja la rotación en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, 'El aliado maneja la rotación en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, 'El aliado maneja la rotación en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, 'El aliado maneja la rotación en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, 'El aliado maneja la rotación en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, 'El aliado maneja la rotación en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, 'El aliado maneja la rotación en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, 'El aliado maneja la rotación en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'El aliado maneja la rotación en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 3, 'El aliado maneja la rotación en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, 'El aliado maneja la rotación en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, 'El aliado maneja la rotación en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 1, 'El aliado maneja la rotación en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, 'El aliado maneja la rotación en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, 'El aliado maneja la rotación en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 5, 'El aliado maneja la rotación en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, 'El aliado maneja la rotación en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, 'El aliado maneja la rotación en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, 'El aliado maneja la rotación en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 3, 'El aliado maneja la rotación en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 4, 'El aliado maneja la rotación en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, 'El aliado maneja la rotación en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, 'El aliado maneja la rotación en otros predios');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, 'El aliado maneja la rotación en otros predios');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('76290685', 'Omar Adriano Coque', 'El Canelo', 'Centro', 'Puracé', 2.200101, -76.488287, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-03-20 00:00:00', '2025-03-20 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('4749246', 'Juan Bautista Coque Rivera', 'Arrayan 2', 'Deposito', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-03-21 00:00:00', '2025-03-21 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 2, 'Visita atendida por el hijo del aliado, José Wilmar Coque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, 'Visita atendida por el hijo del aliado, José Wilmar Coque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, 'Visita atendida por el hijo del aliado, José Wilmar Coque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, 'Visita atendida por el hijo del aliado, José Wilmar Coque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, 'Visita atendida por el hijo del aliado, José Wilmar Coque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, 'Visita atendida por el hijo del aliado, José Wilmar Coque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, 'Visita atendida por el hijo del aliado, José Wilmar Coque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, 'Visita atendida por el hijo del aliado, José Wilmar Coque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, 'Visita atendida por el hijo del aliado, José Wilmar Coque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, 'Visita atendida por el hijo del aliado, José Wilmar Coque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, 'Visita atendida por el hijo del aliado, José Wilmar Coque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, 'Visita atendida por el hijo del aliado, José Wilmar Coque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 4, 'Visita atendida por el hijo del aliado, José Wilmar Coque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'Visita atendida por el hijo del aliado, José Wilmar Coque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, 'Visita atendida por el hijo del aliado, José Wilmar Coque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, 'Visita atendida por el hijo del aliado, José Wilmar Coque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, 'Visita atendida por el hijo del aliado, José Wilmar Coque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, 'Visita atendida por el hijo del aliado, José Wilmar Coque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, 'Visita atendida por el hijo del aliado, José Wilmar Coque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, 'Visita atendida por el hijo del aliado, José Wilmar Coque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, 'Visita atendida por el hijo del aliado, José Wilmar Coque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, 'Visita atendida por el hijo del aliado, José Wilmar Coque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, 'Visita atendida por el hijo del aliado, José Wilmar Coque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, 'Visita atendida por el hijo del aliado, José Wilmar Coque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 3, 'Visita atendida por el hijo del aliado, José Wilmar Coque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, 'Visita atendida por el hijo del aliado, José Wilmar Coque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, 'Visita atendida por el hijo del aliado, José Wilmar Coque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, 'Visita atendida por el hijo del aliado, José Wilmar Coque');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, 'Visita atendida por el hijo del aliado, José Wilmar Coque');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('10535942', 'Arnulfo Muñoz', 'Planadas', 'Deposito', 'Puracé', 2.182075, -76.507107, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-03-21 00:00:00', '2025-03-21 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('1430695', 'Francisco Arnol Chalapu Muñoz', 'Nueva Granada', 'Deposito', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-03-21 00:00:00', '2025-03-21 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('1060236288', 'Anderson Muñoz Olave', 'Planadas', 'Deposito', 'Puracé', 2.182131, -76.5041, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-03-21 00:00:00', '2025-03-21 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, 'Visita atendida por la hija del aliada Erika Andrea Muñoz Chalapu');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 2, 'Visita atendida por la hija del aliada Erika Andrea Muñoz Chalapu');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, 'Visita atendida por la hija del aliada Erika Andrea Muñoz Chalapu');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 2, 'Visita atendida por la hija del aliada Erika Andrea Muñoz Chalapu');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 2, 'Visita atendida por la hija del aliada Erika Andrea Muñoz Chalapu');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, 'Visita atendida por la hija del aliada Erika Andrea Muñoz Chalapu');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 2, 'Visita atendida por la hija del aliada Erika Andrea Muñoz Chalapu');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, 'Visita atendida por la hija del aliada Erika Andrea Muñoz Chalapu');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, 'Visita atendida por la hija del aliada Erika Andrea Muñoz Chalapu');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, 'Visita atendida por la hija del aliada Erika Andrea Muñoz Chalapu');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 2, 'Visita atendida por la hija del aliada Erika Andrea Muñoz Chalapu');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, 'Visita atendida por la hija del aliada Erika Andrea Muñoz Chalapu');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 1, 'Visita atendida por la hija del aliada Erika Andrea Muñoz Chalapu');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'Visita atendida por la hija del aliada Erika Andrea Muñoz Chalapu');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 3, 'Visita atendida por la hija del aliada Erika Andrea Muñoz Chalapu');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, 'Visita atendida por la hija del aliada Erika Andrea Muñoz Chalapu');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, 'Visita atendida por la hija del aliada Erika Andrea Muñoz Chalapu');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 3, 'Visita atendida por la hija del aliada Erika Andrea Muñoz Chalapu');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, 'Visita atendida por la hija del aliada Erika Andrea Muñoz Chalapu');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, 'Visita atendida por la hija del aliada Erika Andrea Muñoz Chalapu');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, 'Visita atendida por la hija del aliada Erika Andrea Muñoz Chalapu');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, 'Visita atendida por la hija del aliada Erika Andrea Muñoz Chalapu');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, 'Visita atendida por la hija del aliada Erika Andrea Muñoz Chalapu');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, 'Visita atendida por la hija del aliada Erika Andrea Muñoz Chalapu');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 3, 'Visita atendida por la hija del aliada Erika Andrea Muñoz Chalapu');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, 'Visita atendida por la hija del aliada Erika Andrea Muñoz Chalapu');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 3, 'Visita atendida por la hija del aliada Erika Andrea Muñoz Chalapu');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, 'Visita atendida por la hija del aliada Erika Andrea Muñoz Chalapu');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, 'Visita atendida por la hija del aliada Erika Andrea Muñoz Chalapu');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('1061744523', 'Nestor Fabian Conejo Perdomo', 'Arrayan', 'Deposito', 'Puracé', 2.182161, -76.504086, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-03-21 00:00:00', '2025-03-21 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, 'Visita atendida por la cuñada de aliado deicy Zambrano');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, 'Visita atendida por la cuñada de aliado deicy Zambrano');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, 'Visita atendida por la cuñada de aliado deicy Zambrano');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, 'Visita atendida por la cuñada de aliado deicy Zambrano');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, 'Visita atendida por la cuñada de aliado deicy Zambrano');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, 'Visita atendida por la cuñada de aliado deicy Zambrano');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 2, 'Visita atendida por la cuñada de aliado deicy Zambrano');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, 'Visita atendida por la cuñada de aliado deicy Zambrano');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, 'Visita atendida por la cuñada de aliado deicy Zambrano');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, 'Visita atendida por la cuñada de aliado deicy Zambrano');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 3, 'Visita atendida por la cuñada de aliado deicy Zambrano');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, 'Visita atendida por la cuñada de aliado deicy Zambrano');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 4, 'Visita atendida por la cuñada de aliado deicy Zambrano');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'Visita atendida por la cuñada de aliado deicy Zambrano');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, 'Visita atendida por la cuñada de aliado deicy Zambrano');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, 'Visita atendida por la cuñada de aliado deicy Zambrano');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, 'Visita atendida por la cuñada de aliado deicy Zambrano');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 1, 'Visita atendida por la cuñada de aliado deicy Zambrano');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 4, 'Visita atendida por la cuñada de aliado deicy Zambrano');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, 'Visita atendida por la cuñada de aliado deicy Zambrano');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, 'Visita atendida por la cuñada de aliado deicy Zambrano');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, 'Visita atendida por la cuñada de aliado deicy Zambrano');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, 'Visita atendida por la cuñada de aliado deicy Zambrano');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, 'Visita atendida por la cuñada de aliado deicy Zambrano');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, 'Visita atendida por la cuñada de aliado deicy Zambrano');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, 'Visita atendida por la cuñada de aliado deicy Zambrano');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, 'Visita atendida por la cuñada de aliado deicy Zambrano');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, 'Visita atendida por la cuñada de aliado deicy Zambrano');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, 'Visita atendida por la cuñada de aliado deicy Zambrano');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('83042886', 'Fabio Nelson Termal Basto', 'El Plan', 'Deposito', 'Puracé', 2.193654, -76.498785, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-03-26 00:00:00', '2025-03-26 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('76307746', 'Jabier Magon Gurrute', 'Pajonal', 'Deposito', 'Puracé', 2.194799, -76.495312, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-03-26 00:00:00', '2025-03-26 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('1060236089', 'Nilson Jair Muñoz Muñoz', 'El Diviso', 'Deposito', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-03-26 00:00:00', '2025-03-26 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('76290325', 'Jorge Apolinar Mensa Cerquera', 'Hacienda Paletara', 'El Jigual 2', 'Puracé', 2.207647, -76.497833, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-03-26 00:00:00', '2025-03-26 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 2, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 3, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 5, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, '');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, '');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('1002961956', 'Juan Camilo Velasco Sandoval', 'Lomitas el canelo', 'Deposito', 'Puracé', 0.0, 0.0, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-03-26 00:00:00', '2025-03-26 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 1, 'En el predio se maneja novillas');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 3, 'En el predio se maneja novillas');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 2, 'En el predio se maneja novillas');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, 'En el predio se maneja novillas');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 2, 'En el predio se maneja novillas');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, 'En el predio se maneja novillas');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 2, 'En el predio se maneja novillas');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 2, 'En el predio se maneja novillas');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, 'En el predio se maneja novillas');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, 'En el predio se maneja novillas');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 3, 'En el predio se maneja novillas');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 3, 'En el predio se maneja novillas');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 4, 'En el predio se maneja novillas');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'En el predio se maneja novillas');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 4, 'En el predio se maneja novillas');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, 'En el predio se maneja novillas');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 1, 'En el predio se maneja novillas');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 2, 'En el predio se maneja novillas');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 3, 'En el predio se maneja novillas');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 3, 'En el predio se maneja novillas');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, 'En el predio se maneja novillas');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, 'En el predio se maneja novillas');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 5, 'En el predio se maneja novillas');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 5, 'En el predio se maneja novillas');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 3, 'En el predio se maneja novillas');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, 'En el predio se maneja novillas');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, 'En el predio se maneja novillas');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 4, 'En el predio se maneja novillas');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 2, 'En el predio se maneja novillas');

  INSERT INTO productores (cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, created_by) 
  VALUES ('1002876437', 'Miller Fernando Muñoz Pardo', 'El Estrecho 2', 'Mirador', 'Puracé', 2.230612, -76.525625, v_usuario_id)
  ON CONFLICT (cedula) DO UPDATE SET nombre_completo=EXCLUDED.nombre_completo
  RETURNING id INTO v_productor_id;


  INSERT INTO calificaciones (productor_id, usuario_id, estado, fecha_inicio, fecha_fin)
  VALUES (v_productor_id, v_usuario_id, 'completada', '2025-04-28 00:00:00', '2025-04-28 00:00:00')
  RETURNING id INTO v_calificacion_id;

  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 1, 3, 'La finca es dedicada a cría y levante. No se hace ordeño');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 2, 2, 'La finca es dedicada a cría y levante. No se hace ordeño');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 3, 3, 'La finca es dedicada a cría y levante. No se hace ordeño');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 4, 3, 'La finca es dedicada a cría y levante. No se hace ordeño');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 5, 2, 'La finca es dedicada a cría y levante. No se hace ordeño');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 6, 3, 'La finca es dedicada a cría y levante. No se hace ordeño');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 7, 2, 'La finca es dedicada a cría y levante. No se hace ordeño');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 8, 2, 'La finca es dedicada a cría y levante. No se hace ordeño');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 9, 1, 'La finca es dedicada a cría y levante. No se hace ordeño');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 10, 3, 'La finca es dedicada a cría y levante. No se hace ordeño');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 11, 4, 'La finca es dedicada a cría y levante. No se hace ordeño');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 12, 2, 'La finca es dedicada a cría y levante. No se hace ordeño');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 13, 5, 'La finca es dedicada a cría y levante. No se hace ordeño');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 14, 1, 'La finca es dedicada a cría y levante. No se hace ordeño');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 15, 3, 'La finca es dedicada a cría y levante. No se hace ordeño');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 16, 1, 'La finca es dedicada a cría y levante. No se hace ordeño');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 17, 2, 'La finca es dedicada a cría y levante. No se hace ordeño');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 18, 3, 'La finca es dedicada a cría y levante. No se hace ordeño');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 19, 2, 'La finca es dedicada a cría y levante. No se hace ordeño');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 20, 2, 'La finca es dedicada a cría y levante. No se hace ordeño');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 21, 1, 'La finca es dedicada a cría y levante. No se hace ordeño');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 22, 1, 'La finca es dedicada a cría y levante. No se hace ordeño');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 23, 4, 'La finca es dedicada a cría y levante. No se hace ordeño');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 24, 4, 'La finca es dedicada a cría y levante. No se hace ordeño');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 25, 3, 'La finca es dedicada a cría y levante. No se hace ordeño');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 26, 5, 'La finca es dedicada a cría y levante. No se hace ordeño');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 27, 4, 'La finca es dedicada a cría y levante. No se hace ordeño');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 28, 3, 'La finca es dedicada a cría y levante. No se hace ordeño');
  INSERT INTO calificacion_detalle (calificacion_id, indicador_id, puntaje, observacion) VALUES (v_calificacion_id, 29, 1, 'La finca es dedicada a cría y levante. No se hace ordeño');
END $$;