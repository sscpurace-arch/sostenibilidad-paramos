-- ============================================================================
-- Hectáreas del predio
-- Ajuste de campo tras el taller de Paletará, 7-sep-2026.
--
-- La app no tenía el área del predio, aunque dos calculadoras (22 litros de
-- leche/ha/año y 25 carga animal UGG/ha) la piden cada vez. La fuente es la
-- Base Maestra Consolidada del diagnóstico SSP (hoja "Maestra", 2026-06-22),
-- cruzada por cédula. Los UPDATE de datos los genera
-- scripts/import-hectareas.mjs y quedan en docs/sql-hectareas-datos.sql.
-- ============================================================================

alter table public.productores add column if not exists area_total_ha     numeric;
alter table public.productores add column if not exists area_ganaderia_ha numeric;
