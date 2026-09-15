-- ============================================================================
-- "No aplica" (N/A) por indicador
-- Ajuste de campo tras el taller de Paletará, 7-sep-2026.
--
-- Hasta ahora el evaluador estaba obligado a poner 1-5 en los 29 indicadores,
-- aunque el sistema productivo del predio no permitiera medirlo (litros de
-- leche en una finca de ceba sin ordeño). El puntaje forzado —casi siempre un
-- 1— hundía el promedio del predio sin razón.
--
-- Regla de promedio: un N/A NO vale 0 ni 1. Se excluye del denominador, por
-- dimensión y global. Si una dimensión queda toda en N/A, tampoco entra al
-- promedio global. La app aplica esa regla en lib/validation.js.
--
-- Almacenamiento: valor = NULL + no_aplica = true. El CHECK existente
-- (valor between 1 and 5) deja pasar NULL, así que no hay que tocarlo.
-- ============================================================================

alter table public.respuestas_indicadores
  add column if not exists no_aplica boolean not null default false;

-- Un N/A no puede llevar puntaje: o es N/A o tiene valor, nunca ambos.
alter table public.respuestas_indicadores
  drop constraint if exists respuestas_indicadores_no_aplica_sin_valor;
alter table public.respuestas_indicadores
  add constraint respuestas_indicadores_no_aplica_sin_valor
  check (not no_aplica or valor is null);
