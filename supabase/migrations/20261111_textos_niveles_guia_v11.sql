-- 2026-11-11 · Textos de niveles alineados con la Guía de Calificación v1.1
-- ESTADO: SIN CORRER. Revisar y correr a mano en el SQL Editor de Supabase.
--
-- Qué arregla: en seis indicadores el texto que ve el técnico en la tarjeta
-- dejaba un valor SIN nivel o en DOS niveles a la vez, y no coincidía con la
-- guía v1.1 (la única oficial, la que se anexa a los Comités):
--   8  · 101 árboles/ha o más no cabía en ningún nivel ("entre 70 y 100")
--   21 · 5 potreros exactos no cabía ("menos de 5" / "de 6 a 10")
--   23 · 159-160 kg y 149-150 kg cabían en dos niveles
--   24 · 45 meses exactos no cabía ("de 41 a 44" / "más de 45")
--   26 · 36 meses cabía en dos niveles ("30 a 36" / "36 a 40")
--   28 · 21 meses cabía en dos niveles ("19 a 21" / "21 o más")
--
-- Solo cambia TEXTOS (lo que se lee), no puntajes guardados ni bandas de las
-- calculadoras. Cada cambio se aplica únicamente si el texto actual es
-- exactamente el viejo: si alguien ya lo corrigió a mano, no se toca.
-- Se puede correr más de una vez sin efecto adicional.
--
-- Después de correrlo, los celulares toman los textos nuevos al abrir la app
-- con señal (syncInitialData baja el catálogo de indicadores).

begin;

create or replace function pg_temp.cambiar_nivel(p_id int, p_valor int, p_viejo text, p_nuevo text)
returns void language sql as $$
  update public.indicadores
     set niveles = (
       select jsonb_agg(
                case when (n->>'valor')::int = p_valor and n->>'texto' = p_viejo
                     then jsonb_set(n, '{texto}', to_jsonb(p_nuevo))
                     else n end
                order by ord)
         from jsonb_array_elements(niveles) with ordinality as t(n, ord))
   where id = p_id
     and exists (select 1 from jsonb_array_elements(niveles) n
                  where (n->>'valor')::int = p_valor and n->>'texto' = p_viejo);
$$;

select pg_temp.cambiar_nivel(8, 5, 'Entre 70 y 100 árboles por hectárea.', '70 árboles por hectárea o más (referencia: 70 a 100).');
select pg_temp.cambiar_nivel(21, 1, 'Menos de 5 potreros.', '5 potreros o menos.');
select pg_temp.cambiar_nivel(23, 5, '171 kilos promedio o más.', 'Doble propósito: 171 kilos promedio o más (cría: 200 kilos o más).');
select pg_temp.cambiar_nivel(23, 4, 'Entre 159 y 170 kilos promedio.', 'Doble propósito: entre 161 y 170 kilos promedio (cría: 180 a 199).');
select pg_temp.cambiar_nivel(23, 3, 'Entre 149 y 160 kilos promedio.', 'Doble propósito: entre 151 y 160 kilos promedio (cría: 170 a 179).');
select pg_temp.cambiar_nivel(23, 2, 'Entre 140 y 150 kilos promedio.', 'Doble propósito: entre 140 y 150 kilos promedio (cría: 160 a 169).');
select pg_temp.cambiar_nivel(23, 1, 'Menos de 140 kilos promedio.', 'Doble propósito: menos de 140 kilos promedio (cría: menos de 160).');
select pg_temp.cambiar_nivel(24, 1, 'Más de 45 meses.', '45 meses o más.');
select pg_temp.cambiar_nivel(26, 5, 'De 30 a 36 meses.', 'De 30 a 35 meses.');
select pg_temp.cambiar_nivel(28, 2, 'De 19 a 21 meses.', 'De 19 a 20 meses.');

-- Comprobación: debe mostrar los textos nuevos
select id, niveles from public.indicadores where id in (8, 21, 23, 24, 26, 28) order by id;

commit;
