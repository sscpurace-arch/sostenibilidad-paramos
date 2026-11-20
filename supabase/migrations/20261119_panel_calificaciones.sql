-- ============================================================================
-- Panel de calificaciones: una fila por evaluación, con su promedio ya
-- calculado, para el panel del administrador (/admin) y el de cada técnico
-- (/mis-calificaciones).
--
-- Por qué una función y no consultas desde el navegador: el servidor corta
-- cualquier consulta en 1.000 filas y hay ~8.000 respuestas, así que los
-- promedios salían de una fracción de los datos (mismo problema que tuvo el
-- panel del supervisor, ver 20260929_resumen_supervisor.sql).
--
-- Quién ve qué (se decide DENTRO de la función, no en el navegador):
--   · administrador  → todas las evaluaciones reales (enviadas y borradores)
--   · cualquier otro usuario activo → solo las suyas
-- Las evaluaciones de prueba (es_prueba) nunca salen. Los "No aplica" no
-- entran al promedio. El promedio de una evaluación es el promedio de los
-- promedios por dimensión: el mismo criterio de lib/validation.js, para que
-- coincida con lo que el técnico vio en su pantalla de resultados.
--
-- Solo LECTURA. No cambia ninguna política ni ninguna tabla.
-- Aplicar en el SQL Editor del proyecto vxtzvadknxmstdcwfwhb.
--
-- Para deshacer:  drop function public.panel_calificaciones();
-- ============================================================================

create or replace function public.panel_calificaciones()
returns jsonb
language plpgsql
stable
security definer
set search_path = public
as $$
declare
  admin boolean := public.es_admin();
  resultado jsonb;
begin
  if auth.uid() is null or not (admin or public.es_usuario_activo()) then
    raise exception 'No autorizado' using errcode = '42501';
  end if;

  with ev as (
    select e.id, e.finca_id, e.tecnico_id, e.fecha, e.estado, e.tecnico_nombre
    from public.evaluaciones e
    where coalesce(e.es_prueba, false) = false
      and (admin or e.tecnico_id = auth.uid())
  ),
  valores as (
    -- una fila por respuesta con puntaje; el N/A no cuenta
    select r.evaluacion_id, i.dimension, r.valor
    from ev
    join public.respuestas_indicadores r on r.evaluacion_id = ev.id
    join public.indicadores i on i.id = r.indicador_id
    where r.valor is not null and coalesce(r.no_aplica, false) = false
  ),
  por_dim as (
    select evaluacion_id, dimension, avg(valor)::numeric as prom
    from valores
    group by evaluacion_id, dimension
  ),
  por_eval as (
    select evaluacion_id,
           avg(prom)::numeric as promedio,
           jsonb_object_agg(dimension, round(prom, 2)) as dimensiones
    from por_dim
    group by evaluacion_id
  )
  select jsonb_build_object(
    'es_admin', admin,
    'evaluaciones', coalesce((
      select jsonb_agg(jsonb_build_object(
        'id', ev.id,
        'fecha', ev.fecha,
        'estado', ev.estado,
        'tecnico_id', ev.tecnico_id,
        'tecnico', coalesce(u.nombre, ev.tecnico_nombre),
        'productor_id', ev.finca_id,
        'productor', p.nombre_completo,
        'cedula', p.cedula,
        'vereda', p.vereda,
        'municipio', p.municipio,
        'promedio', round(pe.promedio, 2),
        'dimensiones', coalesce(pe.dimensiones, '{}'::jsonb)
      ) order by ev.fecha desc)
      from ev
      left join public.usuarios u on u.id = ev.tecnico_id
      left join public.productores p on p.id = ev.finca_id
      left join por_eval pe on pe.evaluacion_id = ev.id
    ), '[]'::jsonb),
    -- Universo de productores, para saber cuántos faltan por visitar en cada
    -- vereda o municipio (cobertura).
    'productores', coalesce((
      select jsonb_agg(jsonb_build_object(
        'id', id, 'vereda', vereda, 'municipio', municipio))
      from public.productores
    ), '[]'::jsonb)
  ) into resultado;

  return resultado;
end;
$$;

revoke all on function public.panel_calificaciones() from public;
grant execute on function public.panel_calificaciones() to authenticated;
