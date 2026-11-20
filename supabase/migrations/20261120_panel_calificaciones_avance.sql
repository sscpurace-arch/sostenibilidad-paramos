-- ============================================================================
-- Panel de calificaciones: agrega a cada evaluación cuántas respuestas y cuántas
-- fotos tiene en el servidor (n_respuestas, n_fotos), para el resumen de
-- seguimiento: productores por completar (borradores con avance) y visitas
-- enviadas sin fotos.
--
-- Reemplaza la función de 20261119_panel_calificaciones.sql sin cambiar nada de
-- lo que ya devolvía: solo AGREGA dos campos por evaluación. Mismas reglas de
-- quién ve qué (administrador: todo; los demás: solo lo suyo; nunca pruebas).
-- La pantalla funciona igual si esta migración no se ha aplicado (simplemente
-- no muestra lo de fotos ni el avance exacto).
--
-- Solo LECTURA. No toca ninguna tabla ni política.
-- Aplicar en el SQL Editor del proyecto vxtzvadknxmstdcwfwhb.
--
-- Para deshacer: volver a correr 20261119_panel_calificaciones.sql.
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
  ),
  n_resp as (
    -- respuestas guardadas (calificadas o "No aplica"), para medir el avance
    select r.evaluacion_id, count(*)::int as n
    from ev
    join public.respuestas_indicadores r on r.evaluacion_id = ev.id
    where r.valor is not null or coalesce(r.no_aplica, false)
    group by r.evaluacion_id
  ),
  n_fot as (
    select f.evaluacion_id, count(*)::int as n
    from ev
    join public.fotos_evidencia f on f.evaluacion_id = ev.id
    group by f.evaluacion_id
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
        'dimensiones', coalesce(pe.dimensiones, '{}'::jsonb),
        'n_respuestas', coalesce(nr.n, 0),
        'n_fotos', coalesce(nf.n, 0)
      ) order by ev.fecha desc)
      from ev
      left join public.usuarios u on u.id = ev.tecnico_id
      left join public.productores p on p.id = ev.finca_id
      left join por_eval pe on pe.evaluacion_id = ev.id
      left join n_resp nr on nr.evaluacion_id = ev.id
      left join n_fot nf on nf.evaluacion_id = ev.id
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
