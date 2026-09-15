-- ============================================================================
-- Archivo de los PDF generados (diagnóstico y plan de acción)
-- Ajuste de campo tras el taller de Paletará, 7-sep-2026.
--
-- El TEXTO de ambos documentos ya vive en Postgres (`diagnosticos`,
-- `planes_accion`) y no se duplica. Lo que faltaba es el ARCHIVO tal como se
-- le entregó al productor, para tener historial y analizar después.
--
-- Mismo diseño que fotos_evidencia: binario en Storage (bucket privado
-- `reportes`), metadata aquí. Path: {evaluacion_id}/{tipo}.pdf — regenerar
-- reemplaza (upsert en Storage + unique (evaluacion_id, tipo) aquí).
-- ============================================================================

-- ---------------------------------------------------------------------------
-- 1. Metadata
-- ---------------------------------------------------------------------------
create table if not exists public.reportes_pdf (
  id            uuid primary key,
  evaluacion_id uuid not null references public.evaluaciones(id) on delete cascade,
  tipo          text not null check (tipo in ('diagnostico', 'plan_accion')),
  storage_path  text not null unique,
  generado_en   timestamptz not null,
  bytes         int,
  tecnico_id    uuid not null default auth.uid(),
  es_prueba     boolean not null default false,
  created_at    timestamptz not null default now(),
  updated_at    timestamptz not null default now(),
  unique (evaluacion_id, tipo)
);

create index if not exists idx_reportes_evaluacion on public.reportes_pdf(evaluacion_id);

-- ---------------------------------------------------------------------------
-- 2. RLS — espejo de fotos_evidencia: dueño de la evaluación o admin
-- ---------------------------------------------------------------------------
alter table public.reportes_pdf enable row level security;

drop policy if exists "Leer reportes propios" on public.reportes_pdf;
create policy "Leer reportes propios" on public.reportes_pdf
  for select using (
    evaluacion_id in (select id from public.evaluaciones where tecnico_id = auth.uid())
    or public.es_admin()
  );

drop policy if exists "Crear reportes" on public.reportes_pdf;
create policy "Crear reportes" on public.reportes_pdf
  for insert with check (
    evaluacion_id in (select id from public.evaluaciones where tecnico_id = auth.uid())
    or public.es_admin()
  );

drop policy if exists "Actualizar reportes propios" on public.reportes_pdf;
create policy "Actualizar reportes propios" on public.reportes_pdf
  for update using (
    evaluacion_id in (select id from public.evaluaciones where tecnico_id = auth.uid())
    or public.es_admin()
  ) with check (
    evaluacion_id in (select id from public.evaluaciones where tecnico_id = auth.uid())
    or public.es_admin()
  );

drop policy if exists "Eliminar reportes propios" on public.reportes_pdf;
create policy "Eliminar reportes propios" on public.reportes_pdf
  for delete using (
    evaluacion_id in (select id from public.evaluaciones where tecnico_id = auth.uid())
    or public.es_admin()
  );

-- ---------------------------------------------------------------------------
-- 3. Bucket privado
--
-- El primer segmento del path es el id de la evaluación, no el del técnico
-- (así lo pide el requerimiento: {evaluacion_id}/{tipo}.pdf). Las policies
-- de Storage resuelven el dueño a través de `evaluaciones`.
-- ---------------------------------------------------------------------------
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('reportes', 'reportes', false, 10485760, array['application/pdf'])
on conflict (id) do nothing;

create or replace function public.es_dueno_reporte(p_name text)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1 from public.evaluaciones e
    where e.id::text = (storage.foldername(p_name))[1]
      and e.tecnico_id = auth.uid()
  ) or public.es_admin();
$$;

revoke all on function public.es_dueno_reporte(text) from public;
grant execute on function public.es_dueno_reporte(text) to authenticated;

drop policy if exists "Subir reporte propio" on storage.objects;
create policy "Subir reporte propio" on storage.objects
  for insert with check (bucket_id = 'reportes' and public.es_dueno_reporte(name));

drop policy if exists "Leer reporte propio" on storage.objects;
create policy "Leer reporte propio" on storage.objects
  for select using (bucket_id = 'reportes' and public.es_dueno_reporte(name));

drop policy if exists "Reemplazar reporte propio" on storage.objects;
create policy "Reemplazar reporte propio" on storage.objects
  for update using (bucket_id = 'reportes' and public.es_dueno_reporte(name));

drop policy if exists "Eliminar reporte propio" on storage.objects;
create policy "Eliminar reporte propio" on storage.objects
  for delete using (bucket_id = 'reportes' and public.es_dueno_reporte(name));

-- ---------------------------------------------------------------------------
-- 4. Huérfanos: misma tabla y criterio que fotos_evidencia
-- ---------------------------------------------------------------------------
create or replace function public.registrar_reporte_huerfano()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.storage_huerfanos (bucket, path) values ('reportes', old.storage_path);
  return old;
end;
$$;

drop trigger if exists trg_reporte_huerfano on public.reportes_pdf;
create trigger trg_reporte_huerfano
  after delete on public.reportes_pdf
  for each row execute function public.registrar_reporte_huerfano();
