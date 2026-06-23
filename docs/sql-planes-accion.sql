-- Tabla para planes de acción SMART por evaluación
-- Correr en Supabase SQL Editor: https://supabase.com/dashboard/project/vxtzvadknxmstdcwfwhb/sql

create table if not exists planes_accion (
  id            uuid primary key,
  evaluacion_id uuid not null references evaluaciones(id) on delete cascade,
  indicador_id  integer not null,
  meta          text not null default '',
  plazo         date,
  notas         text default '',
  sugerida_por_ia boolean default false,
  updated_at    timestamptz default now()
);

-- Índices para las consultas habituales
create index if not exists planes_accion_evaluacion_idx on planes_accion(evaluacion_id);

-- RLS: igual que las demás tablas del proyecto
alter table planes_accion enable row level security;

-- Técnicos autenticados pueden leer/escribir sus propios planes
create policy "planes_accion_auth" on planes_accion
  for all
  using (auth.role() = 'authenticated')
  with check (auth.role() = 'authenticated');
