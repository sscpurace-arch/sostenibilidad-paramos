-- ============================================================================
-- El administrador puede escribir cualquier registro
--
-- Sintoma: Santiago, entrando como admin (sscpurace@gmail.com), veia "41
-- cambios no se pudieron subir" de forma permanente. Reintentar nunca servia.
--
-- Causa: las policies solo permitian escribir lo propio
-- (tecnico_id = auth.uid()). Ser admin no otorgaba ningun privilegio. Cualquier
-- fila en la cola del dispositivo que perteneciera a otro tecnico era
-- rechazada por RLS en cada intento, sin forma de resolverse.
--
-- Ademas, `productores` no tenia policy de DELETE: toda eliminacion de
-- productor encolada quedaba atascada para siempre.
--
-- Esto tambien cubre el punto 3 del backlog: "que yo como administrador pueda
-- editar cualquier registro, solo yo".
-- ============================================================================

-- Helper. SECURITY DEFINER para poder leer `usuarios` sin quedar atrapado en
-- las policies de esa misma tabla (recursion infinita).
create or replace function public.es_admin()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1 from public.usuarios
    where id = auth.uid() and rol = 'admin' and activo
  );
$$;

revoke all on function public.es_admin() from public;
grant execute on function public.es_admin() to authenticated;

-- ---------------------------------------------------------------------------
-- evaluaciones
-- ---------------------------------------------------------------------------
drop policy if exists "Leer evaluaciones propias" on public.evaluaciones;
create policy "Leer evaluaciones propias" on public.evaluaciones
  for select using (tecnico_id = auth.uid() or public.es_admin());

drop policy if exists "Crear evaluaciones" on public.evaluaciones;
create policy "Crear evaluaciones" on public.evaluaciones
  for insert with check (tecnico_id = auth.uid() or public.es_admin());

drop policy if exists "Actualizar evaluaciones propias" on public.evaluaciones;
create policy "Actualizar evaluaciones propias" on public.evaluaciones
  for update using (tecnico_id = auth.uid() or public.es_admin())
  with check (tecnico_id = auth.uid() or public.es_admin());

drop policy if exists "Eliminar evaluaciones propias" on public.evaluaciones;
create policy "Eliminar evaluaciones propias" on public.evaluaciones
  for delete using (tecnico_id = auth.uid() or public.es_admin());

-- ---------------------------------------------------------------------------
-- respuestas_indicadores
-- ---------------------------------------------------------------------------
drop policy if exists "Leer respuestas propias" on public.respuestas_indicadores;
create policy "Leer respuestas propias" on public.respuestas_indicadores
  for select using (
    public.es_admin() or
    evaluacion_id in (select id from public.evaluaciones where tecnico_id = auth.uid())
  );

drop policy if exists "Crear respuestas" on public.respuestas_indicadores;
create policy "Crear respuestas" on public.respuestas_indicadores
  for insert with check (
    public.es_admin() or
    evaluacion_id in (select id from public.evaluaciones where tecnico_id = auth.uid())
  );

-- El upsert de PostgREST es INSERT ... ON CONFLICT DO UPDATE: necesita que la
-- policy de UPDATE traiga USING **y** WITH CHECK. Sin el WITH CHECK, el camino
-- de actualizacion del upsert se rechaza.
drop policy if exists "Actualizar respuestas propias" on public.respuestas_indicadores;
create policy "Actualizar respuestas propias" on public.respuestas_indicadores
  for update using (
    public.es_admin() or
    evaluacion_id in (select id from public.evaluaciones where tecnico_id = auth.uid())
  ) with check (
    public.es_admin() or
    evaluacion_id in (select id from public.evaluaciones where tecnico_id = auth.uid())
  );

drop policy if exists "Eliminar respuestas propias" on public.respuestas_indicadores;
create policy "Eliminar respuestas propias" on public.respuestas_indicadores
  for delete using (
    public.es_admin() or
    evaluacion_id in (select id from public.evaluaciones where tecnico_id = auth.uid())
  );

-- ---------------------------------------------------------------------------
-- productores — faltaba por completo el permiso de borrado
-- ---------------------------------------------------------------------------
drop policy if exists "Eliminar productores" on public.productores;
create policy "Eliminar productores" on public.productores
  for delete using (public.es_admin() or created_by = auth.uid());

-- ---------------------------------------------------------------------------
-- planes_accion, diagnosticos y fotos: mismo criterio
-- ---------------------------------------------------------------------------
do $$
declare t text;
begin
  foreach t in array array['planes_accion','diagnosticos','fotos_evidencia'] loop
    if exists (select 1 from information_schema.tables
               where table_schema='public' and table_name=t) then
      execute format('drop policy if exists "Admin escribe todo" on public.%I', t);
      execute format($f$
        create policy "Admin escribe todo" on public.%I
        for all using (public.es_admin()) with check (public.es_admin())
      $f$, t);
    end if;
  end loop;
end $$;
