-- Rediseño del Plan de Acción: de un solo campo "meta" a los 4 componentes
-- SMART explícitos (Específico/Medible/Alcanzable/Relevante) + Tiempo (plazo).
-- Corrido directamente por Claude con autorización de Santiago (tabla tenía
-- 0 filas en producción al momento del cambio — sin riesgo de pérdida de datos).

alter table planes_accion drop column if exists meta;
alter table planes_accion add column if not exists especifico text default '';
alter table planes_accion add column if not exists medible text default '';
alter table planes_accion add column if not exists alcanzable text default '';
alter table planes_accion add column if not exists relevante text default '';
