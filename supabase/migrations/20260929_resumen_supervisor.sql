-- ============================================================================
-- Panel del supervisor (/supervisor): resumen del proyecto calculado en la base.
--
-- Antes la pantalla bajaba las tablas completas al navegador. Fallaba por dos
-- razones: (1) no existía ninguna regla de lectura para el rol 'supervisor', así
-- que solo veía lo propio (nada) y (2) aunque la hubiera, el servidor corta las
-- consultas en 1.000 filas y hay ~8.000 respuestas, con lo que los promedios
-- salían de una parte de los datos.
--
-- Ahora una función de solo lectura devuelve las cifras ya calculadas. No abre
-- las tablas: el supervisor no puede leer respuestas ni evaluaciones sueltas de
-- los técnicos, solo este resumen. Excluye las evaluaciones de prueba y los N/A.
-- Aplicar en el SQL Editor del proyecto vxtzvadknxmstdcwfwhb.
-- ============================================================================

create or replace function public.es_supervisor()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1 from public.usuarios
    where id = auth.uid() and rol in ('supervisor', 'admin') and activo
  );
$$;

revoke all on function public.es_supervisor() from public;
grant execute on function public.es_supervisor() to authenticated;

create or replace function public.resumen_supervisor()
returns jsonb
language plpgsql
stable
security definer
set search_path = public
as $$
declare
  resultado jsonb;
begin
  if not public.es_supervisor() then
    raise exception 'No autorizado' using errcode = '42501';
  end if;

  with ev as (
    select id, finca_id, fecha, estado
    from public.evaluaciones
    where coalesce(es_prueba, false) = false
  ),
  enviadas as (select * from ev where estado = 'enviada'),
  valores as (
    -- una fila por respuesta con puntaje, de evaluaciones enviadas; el N/A no cuenta
    select r.evaluacion_id, i.id as indicador_id, i.dimension, r.valor
    from enviadas e
    join public.respuestas_indicadores r on r.evaluacion_id = e.id
    join public.indicadores i on i.id = r.indicador_id
    where r.valor is not null and coalesce(r.no_aplica, false) = false
  ),
  por_dimension as (
    select dimension, avg(valor)::numeric as promedio, min(indicador_id) as primero
    from valores
    group by dimension
  ),
  por_eval_dim as (
    select evaluacion_id, dimension, avg(valor)::numeric as prom
    from valores
    group by evaluacion_id, dimension
  ),
  por_eval as (
    -- Mismo criterio que la app (lib/validation.js): promedio de los promedios
    -- por dimensión, para que coincida con lo que ve el técnico en resultados.
    select evaluacion_id, avg(prom)::numeric as promedio
    from por_eval_dim
    group by evaluacion_id
  ),
  ultimas as (
    select e.id, e.fecha, p.nombre_completo, p.vereda, pe.promedio
    from enviadas e
    left join public.productores p on p.id = e.finca_id
    left join por_eval pe on pe.evaluacion_id = e.id
    order by e.fecha desc
    limit 10
  )
  select jsonb_build_object(
    'productores', (select count(*) from public.productores),
    'completadas', (select count(*) from enviadas),
    'pendientes', (select count(*) from ev where estado = 'borrador'),
    'promedio_global', (select avg(promedio) from por_dimension),
    'dimensiones', coalesce((
      select jsonb_agg(jsonb_build_object('dimension', dimension, 'promedio', promedio) order by primero)
      from por_dimension), '[]'::jsonb),
    'ultimas', coalesce((
      select jsonb_agg(jsonb_build_object(
        'id', id, 'fecha', fecha, 'productor', nombre_completo,
        'vereda', vereda, 'promedio', promedio) order by fecha desc)
      from ultimas), '[]'::jsonb)
  ) into resultado;

  return resultado;
end;
$$;

revoke all on function public.resumen_supervisor() from public;
grant execute on function public.resumen_supervisor() to authenticated;
