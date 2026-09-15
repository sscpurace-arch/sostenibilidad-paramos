-- ============================================================================
-- Nombre y cargo del funcionario que hizo la visita
-- Ajuste de campo tras el taller de Paletará, 7-sep-2026.
--
-- 1. Snapshot en la evaluación. El PDF se puede regenerar meses después; para
--    entonces la persona pudo cambiar de cargo o salir del equipo. Lo que diga
--    el documento debe ser quién hizo la visita ese día, no quién es hoy.
--
-- 2. RPC para que cada usuario complete SU nombre y cargo. La policy de
--    UPDATE en `usuarios` es solo para admin (y debe seguir así: un técnico no
--    puede tocar su rol ni su estado activo). Abrir una policy de UPDATE
--    propio dejaría esas columnas expuestas, porque RLS no filtra por columna.
--    Esta función SECURITY DEFINER toca exactamente dos columnas de la fila
--    del propio auth.uid() y nada más.
-- ============================================================================

alter table public.evaluaciones add column if not exists tecnico_nombre text;
alter table public.evaluaciones add column if not exists tecnico_cargo  text;

create or replace function public.completar_perfil(p_nombre text, p_cargo text)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if auth.uid() is null then
    raise exception 'Sin sesion';
  end if;
  if coalesce(trim(p_nombre), '') = '' or coalesce(trim(p_cargo), '') = '' then
    raise exception 'Nombre y cargo son obligatorios';
  end if;
  update public.usuarios
     set nombre = trim(p_nombre),
         cargo  = trim(p_cargo)
   where id = auth.uid();
end;
$$;

revoke all on function public.completar_perfil(text, text) from public;
grant execute on function public.completar_perfil(text, text) to authenticated;
