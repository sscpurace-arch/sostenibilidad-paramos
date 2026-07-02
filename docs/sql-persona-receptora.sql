-- Campos de "persona receptora de la visita" en evaluaciones.
-- IMPORTANTE: correr ANTES de que un usuario REAL (no modo prueba) inicie una
-- evaluación nueva — la app ya envía estos campos en cada evaluación creada,
-- y sin estas columnas Supabase rechazará el guardado con error de columna
-- desconocida. El modo prueba no se ve afectado (nunca sincroniza a Supabase).
-- Correr en el SQL Editor: https://supabase.com/dashboard/project/vxtzvadknxmstdcwfwhb/sql

alter table evaluaciones add column if not exists receptor_es_otro boolean default false;
alter table evaluaciones add column if not exists receptor_nombre text default '';
alter table evaluaciones add column if not exists receptor_cedula text default '';
alter table evaluaciones add column if not exists receptor_parentesco text default '';
