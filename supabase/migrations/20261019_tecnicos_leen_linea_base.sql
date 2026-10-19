-- Los técnicos deben poder LEER las evaluaciones enviadas de todos los
-- productores (la línea base de 2024-2025 y las visitas de seguimiento), no
-- solo las que ellos mismos hicieron. Sin esto, todo productor aparecía
-- "sin evaluaciones previas" para cualquier cuenta que no fuera la del admin,
-- porque las 270 evaluaciones de línea base están a nombre del admin.
--
-- Autorizado por Santiago el 2026-10-19.
-- Solo LECTURA. Escribir y borrar sigue limitado al dueño (o admin).
-- No se exponen borradores ni evaluaciones de prueba de otros.

create or replace function public.es_usuario_activo()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1 from public.usuarios u
    where u.id = auth.uid() and u.activo is true
  );
$$;

revoke all on function public.es_usuario_activo() from public;
grant execute on function public.es_usuario_activo() to authenticated;

drop policy if exists "Leer evaluaciones enviadas de todos" on public.evaluaciones;
create policy "Leer evaluaciones enviadas de todos"
  on public.evaluaciones for select
  to authenticated
  using (
    estado = 'enviada'
    and coalesce(es_prueba, false) = false
    and public.es_usuario_activo()
  );

drop policy if exists "Leer respuestas de evaluaciones enviadas" on public.respuestas_indicadores;
create policy "Leer respuestas de evaluaciones enviadas"
  on public.respuestas_indicadores for select
  to authenticated
  using (
    public.es_usuario_activo()
    and exists (
      select 1 from public.evaluaciones e
      where e.id = respuestas_indicadores.evaluacion_id
        and e.estado = 'enviada'
        and coalesce(e.es_prueba, false) = false
    )
  );

-- Para deshacer:
--   drop policy "Leer evaluaciones enviadas de todos" on public.evaluaciones;
--   drop policy "Leer respuestas de evaluaciones enviadas" on public.respuestas_indicadores;
--   drop function public.es_usuario_activo();
