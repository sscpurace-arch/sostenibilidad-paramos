-- ============================================================
-- MIGRACIÓN V2: Normalización del Schema
-- Fecha: 2026-04-29
-- Decisiones aprobadas:
--   1. productores NO se renombra a fincas
--   2. Datos migrados, tablas antiguas renombradas a _legacy
--   3. dimensiones absorbida en indicadores como TEXT
--   4. UNIQUE(evaluacion_id, indicador_id) para prevenir duplicados
-- ============================================================

-- Paso 1: Eliminar vista dependiente
DROP VIEW IF EXISTS vista_detallada_calificaciones;

-- Paso 2: Enriquecer tabla indicadores
ALTER TABLE indicadores
  ADD COLUMN IF NOT EXISTS dimension text,
  ADD COLUMN IF NOT EXISTS tipo_dato text DEFAULT 'escala_1_5';

UPDATE indicadores i
SET dimension = d.nombre
FROM dimensiones d
WHERE i.dimension_id = d.id;

ALTER TABLE indicadores RENAME COLUMN puntaje_min TO rango_min;
ALTER TABLE indicadores RENAME COLUMN puntaje_max TO rango_max;

-- Paso 3: Crear tabla evaluaciones
CREATE TABLE evaluaciones (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  finca_id uuid NOT NULL REFERENCES productores(id),
  tecnico_id uuid NOT NULL REFERENCES usuarios(id),
  fecha timestamptz NOT NULL DEFAULT now(),
  estado text NOT NULL DEFAULT 'borrador'
    CHECK (estado IN ('borrador', 'enviada')),
  es_prueba boolean DEFAULT false,
  observaciones_generales text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Paso 4: Crear tabla respuestas_indicadores
CREATE TABLE respuestas_indicadores (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  evaluacion_id uuid NOT NULL REFERENCES evaluaciones(id) ON DELETE CASCADE,
  indicador_id smallint NOT NULL REFERENCES indicadores(id),
  valor smallint CHECK (valor >= 1 AND valor <= 5),
  observacion text,
  evidencia_url text,
  updated_at timestamptz DEFAULT now(),
  UNIQUE(evaluacion_id, indicador_id)
);

-- Paso 5: Migrar calificaciones → evaluaciones
INSERT INTO evaluaciones (id, finca_id, tecnico_id, fecha, estado, es_prueba, observaciones_generales, created_at, updated_at)
SELECT
  id,
  productor_id,
  usuario_id,
  COALESCE(fecha_inicio, created_at, now()),
  CASE WHEN estado = 'completada' THEN 'enviada' ELSE 'borrador' END,
  COALESCE(es_prueba, false),
  observaciones_generales,
  COALESCE(created_at, now()),
  COALESCE(updated_at, now())
FROM calificaciones;

-- Paso 6: Migrar calificacion_detalle → respuestas_indicadores (con dedup)
INSERT INTO respuestas_indicadores (id, evaluacion_id, indicador_id, valor, observacion, updated_at)
SELECT DISTINCT ON (calificacion_id, indicador_id)
  id,
  calificacion_id,
  indicador_id,
  puntaje,
  observacion,
  COALESCE(updated_at, now())
FROM calificacion_detalle
ORDER BY calificacion_id, indicador_id, updated_at DESC NULLS LAST;

-- Paso 7: Renombrar tablas antiguas como backup
ALTER TABLE calificaciones RENAME TO calificaciones_legacy;
ALTER TABLE calificacion_detalle RENAME TO calificacion_detalle_legacy;
ALTER TABLE dimensiones RENAME TO dimensiones_legacy;

-- Paso 8: Índices
CREATE INDEX idx_evaluaciones_finca_id ON evaluaciones(finca_id);
CREATE INDEX idx_evaluaciones_tecnico_id ON evaluaciones(tecnico_id);
CREATE INDEX idx_evaluaciones_estado ON evaluaciones(estado);
CREATE INDEX idx_respuestas_evaluacion_id ON respuestas_indicadores(evaluacion_id);
CREATE INDEX idx_respuestas_indicador_id ON respuestas_indicadores(indicador_id);

-- Paso 9: RLS
ALTER TABLE evaluaciones ENABLE ROW LEVEL SECURITY;
ALTER TABLE respuestas_indicadores ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Leer evaluaciones propias" ON evaluaciones
  FOR SELECT USING (tecnico_id = auth.uid());
CREATE POLICY "Crear evaluaciones" ON evaluaciones
  FOR INSERT WITH CHECK (tecnico_id = auth.uid());
CREATE POLICY "Actualizar evaluaciones propias" ON evaluaciones
  FOR UPDATE USING (tecnico_id = auth.uid());
CREATE POLICY "Eliminar evaluaciones propias" ON evaluaciones
  FOR DELETE USING (tecnico_id = auth.uid());

CREATE POLICY "Leer respuestas propias" ON respuestas_indicadores
  FOR SELECT USING (evaluacion_id IN (SELECT id FROM evaluaciones WHERE tecnico_id = auth.uid()));
CREATE POLICY "Crear respuestas" ON respuestas_indicadores
  FOR INSERT WITH CHECK (evaluacion_id IN (SELECT id FROM evaluaciones WHERE tecnico_id = auth.uid()));
CREATE POLICY "Actualizar respuestas propias" ON respuestas_indicadores
  FOR UPDATE USING (evaluacion_id IN (SELECT id FROM evaluaciones WHERE tecnico_id = auth.uid()));
CREATE POLICY "Eliminar respuestas propias" ON respuestas_indicadores
  FOR DELETE USING (evaluacion_id IN (SELECT id FROM evaluaciones WHERE tecnico_id = auth.uid()));

-- Paso 10: Recrear vista con nuevo schema
CREATE VIEW vista_detallada_calificaciones AS
SELECT
  ri.id AS detalle_id,
  p.cedula,
  p.nombre_completo AS productor,
  p.municipio,
  p.vereda,
  p.proyecto,
  i.dimension,
  i.nombre AS indicador,
  ri.valor AS puntaje,
  ri.observacion,
  ri.evidencia_url,
  e.fecha AS fecha_evaluacion
FROM respuestas_indicadores ri
JOIN evaluaciones e ON ri.evaluacion_id = e.id
JOIN productores p ON e.finca_id = p.id
JOIN indicadores i ON ri.indicador_id = i.id
ORDER BY e.fecha DESC, p.nombre_completo;
