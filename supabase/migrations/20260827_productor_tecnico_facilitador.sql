-- ============================================================================
-- Columnas faltantes en `productores`
--
-- El formulario de nuevo productor captura desde hace tiempo el nombre del
-- técnico y del facilitador, pero esas columnas nunca existieron en Postgres.
-- Cada alta devolvía PGRST204 ("Could not find the 'nombre_facilitador'
-- column") y, como la cola sube el lote entero de una tabla en un solo upsert,
-- una sola fila mala bloqueaba TODAS las demás. Resultado: 212 cambios
-- atascados y ningún productor nuevo sincronizado desde mayo de 2026.
--
-- Se agregan las columnas en vez de descartar los campos: es información real
-- que los técnicos ya vienen registrando en campo.
-- ============================================================================

alter table public.productores add column if not exists nombre_tecnico text;
alter table public.productores add column if not exists nombre_facilitador text;
