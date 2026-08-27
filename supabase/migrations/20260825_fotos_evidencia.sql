-- ============================================================================
-- Registro fotográfico de evidencia por indicador
-- Requerimiento R4 del taller de calibración, Paletará, 31-jul-2026.
--
-- La tercera regla de aplicación de la guía exige al menos una fotografía por
-- cada indicador calificado en nivel 2 o inferior, más una panorámica del
-- predio. Hasta ahora esa exigencia existía en la guía pero no tenía canal de
-- registro en la app, así que la evidencia se quedaba en el carrete del celular.
--
-- El binario NO va en Postgres: va al bucket `evidencias` de Storage. Aquí
-- solo queda la metadata y la ruta. Ver docs/NOTA-TECNICA-fotos-evidencia.md
-- ============================================================================

-- ---------------------------------------------------------------------------
-- 1. Tabla de metadata
-- ---------------------------------------------------------------------------
create table if not exists public.fotos_evidencia (
  id            uuid primary key,
  evaluacion_id uuid not null references public.evaluaciones(id) on delete cascade,
  indicador_id  int  null references public.indicadores(id),  -- NULL = panorámica de la visita
  tipo          text not null default 'indicador'
                  check (tipo in ('indicador', 'panoramica')),
  storage_path  text not null unique,
  nota          text,

  -- Ubicación: se captura aparte porque recomprimir la foto en canvas destruye
  -- el EXIF, incluido el GPS. getCurrentPosition funciona sin red (GPS puro).
  lat           double precision,
  lng           double precision,
  precision_m   real,

  tomada_en     timestamptz not null,
  ancho         int,
  alto          int,
  bytes         int,

  tecnico_id    uuid not null default auth.uid(),
  es_prueba     boolean not null default false,
  created_at    timestamptz not null default now(),
  updated_at    timestamptz not null default now()
);

create index if not exists idx_fotos_evaluacion on public.fotos_evidencia(evaluacion_id);
create index if not exists idx_fotos_indicador  on public.fotos_evidencia(indicador_id);

-- Una sola panorámica por visita
create unique index if not exists idx_fotos_panoramica
  on public.fotos_evidencia(evaluacion_id)
  where tipo = 'panoramica';

-- ---------------------------------------------------------------------------
-- 2. RLS — espejo exacto de respuestas_indicadores
-- ---------------------------------------------------------------------------
alter table public.fotos_evidencia enable row level security;

drop policy if exists "Leer fotos propias" on public.fotos_evidencia;
create policy "Leer fotos propias" on public.fotos_evidencia
  for select using (evaluacion_id in (select id from public.evaluaciones where tecnico_id = auth.uid()));

drop policy if exists "Crear fotos" on public.fotos_evidencia;
create policy "Crear fotos" on public.fotos_evidencia
  for insert with check (evaluacion_id in (select id from public.evaluaciones where tecnico_id = auth.uid()));

drop policy if exists "Actualizar fotos propias" on public.fotos_evidencia;
create policy "Actualizar fotos propias" on public.fotos_evidencia
  for update using (evaluacion_id in (select id from public.evaluaciones where tecnico_id = auth.uid()));

drop policy if exists "Eliminar fotos propias" on public.fotos_evidencia;
create policy "Eliminar fotos propias" on public.fotos_evidencia
  for delete using (evaluacion_id in (select id from public.evaluaciones where tecnico_id = auth.uid()));

-- ---------------------------------------------------------------------------
-- 3. Motivo de foto faltante
--
-- La regla del 2 bloquea el cierre de la visita, pero con escape justificado:
-- un bloqueo absoluto en campo (celular mojado, sin batería) empujaría al
-- evaluador a subir la nota de 2 a 3 solo para poder cerrar, que es un sesgo
-- silencioso en el dato, peor que una foto faltante documentada.
-- ---------------------------------------------------------------------------
alter table public.respuestas_indicadores
  add column if not exists motivo_sin_foto text;

-- Entradas crudas de las calculadoras (litros/día, nº animales, hectáreas...).
-- Se guardan las entradas y no solo el resultado, para que el dato sea
-- auditable y recalculable si una fórmula cambia.
alter table public.respuestas_indicadores
  add column if not exists entradas jsonb;

-- ---------------------------------------------------------------------------
-- 4. Bucket de Storage
--
-- Privado, no público: son predios privados y personas identificables
-- (Ley 1581/2012 de habeas data). Un bucket público deja URLs enumerables.
-- El costo del signed URL (necesita red) es nulo acá: offline se lee el blob
-- que la app guarda en IndexedDB.
--
-- Path: {tecnico_id}/{evaluacion_id}/{foto_id}.jpg — el primer segmento hace
-- triviales las policies de storage.objects.
-- ---------------------------------------------------------------------------
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('evidencias', 'evidencias', false, 5242880, array['image/jpeg', 'image/png'])
on conflict (id) do nothing;

drop policy if exists "Subir evidencia propia" on storage.objects;
create policy "Subir evidencia propia" on storage.objects
  for insert with check (
    bucket_id = 'evidencias'
    and (storage.foldername(name))[1] = auth.uid()::text
  );

drop policy if exists "Leer evidencia propia" on storage.objects;
create policy "Leer evidencia propia" on storage.objects
  for select using (
    bucket_id = 'evidencias'
    and (storage.foldername(name))[1] = auth.uid()::text
  );

drop policy if exists "Reemplazar evidencia propia" on storage.objects;
create policy "Reemplazar evidencia propia" on storage.objects
  for update using (
    bucket_id = 'evidencias'
    and (storage.foldername(name))[1] = auth.uid()::text
  );

drop policy if exists "Eliminar evidencia propia" on storage.objects;
create policy "Eliminar evidencia propia" on storage.objects
  for delete using (
    bucket_id = 'evidencias'
    and (storage.foldername(name))[1] = auth.uid()::text
  );

-- ---------------------------------------------------------------------------
-- 5. Objetos huérfanos
--
-- El `on delete cascade` borra la fila de metadata pero NO el objeto en
-- Storage. No se borra automáticamente: las fotos son evidencia contractual y
-- conservarlas es defendible. Se deja el rastro para una limpieza posterior.
-- ---------------------------------------------------------------------------
create table if not exists public.storage_huerfanos (
  id serial primary key,
  bucket text not null,
  path text not null,
  registrado_en timestamptz not null default now()
);

create or replace function public.registrar_foto_huerfana()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.storage_huerfanos (bucket, path) values ('evidencias', old.storage_path);
  return old;
end;
$$;

drop trigger if exists trg_foto_huerfana on public.fotos_evidencia;
create trigger trg_foto_huerfana
  after delete on public.fotos_evidencia
  for each row execute function public.registrar_foto_huerfana();
