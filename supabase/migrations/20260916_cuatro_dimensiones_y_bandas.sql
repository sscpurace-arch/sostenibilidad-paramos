-- ============================================================================
-- Guía de Calificación v1.1 (septiembre 2026): cuatro dimensiones y huecos de
-- banda cerrados hacia la banda inferior.
--
-- 1) Dimensiones. La matriz aprobada por los Comités de Seguimiento (abr 2026)
--    y la Guía v1.1 usan CUATRO dimensiones: Socioambiental (1-6), Ambiental
--    (7-12), Socioeconómica (13-20) y Productiva (21-29). La app venía uniendo
--    Socioambiental con Ambiental. Mismos 29 indicadores, mismo orden; solo
--    cambia el agrupamiento del promedio. Los promedios se calculan siempre en
--    caliente a partir de esta tabla (lib/validation.js), así que las
--    evaluaciones históricas se reagrupan solas.
--
-- 2) Bandas. Los rangos oficiales de los indicadores 25 y 27 dejaban tramos
--    sin banda (25: 0,6-0,7, 0,8-0,9, 1,0-1,1 UGG/ha; 27: 2,0-2,5 %). Desde la
--    Guía v1.1 se cierran hacia la banda inferior en ambos, en aplicación de
--    la regla 2 ("si duda entre dos niveles, elija el inferior"). Antes el 27
--    cerraba hacia arriba. La calculadora (components/CalculadoraIndicador.jsx)
--    ya aplica la regla nueva; aquí se actualiza el texto que ve el técnico en
--    "¿Cómo califico esto?".
--
-- Aplicar en el SQL Editor del proyecto vxtzvadknxmstdcwfwhb ("Matriz de
-- sostenibilidad"). Después, cada técnico vuelve a tocar "Preparar sin
-- conexión" para refrescar el catálogo en su celular.
-- ============================================================================

update public.indicadores
   set dimension = 'Socioambiental'
 where id between 1 and 6;

-- dimension_id no existe en Supabase (solo en el caché Dexie y en seed-data.json); no se toca.

update public.indicadores
   set niveles = '[
     {"valor": 5, "texto": "Más de 1,5 UGG por hectárea."},
     {"valor": 4, "texto": "De 1,1 a 1,5 UGG por hectárea."},
     {"valor": 3, "texto": "De 0,9 a menos de 1,1 UGG por hectárea."},
     {"valor": 2, "texto": "De 0,7 a menos de 0,9 UGG por hectárea."},
     {"valor": 1, "texto": "Menos de 0,7 UGG por hectárea."}
   ]'::jsonb,
       nota_criterio = 'Fórmula: (nº animales × peso promedio) ÷ 450 kg = UGG; luego UGG ÷ hectáreas de pastoreo. Los tramos sin banda de la tabla original se cierran hacia la banda inferior (regla 2).'
 where id = 25;

update public.indicadores
   set niveles = '[
     {"valor": 5, "texto": "Menos de 2 % de mortalidad anual."},
     {"valor": 4, "texto": "De 2 % a menos de 5 % anual."},
     {"valor": 3, "texto": "De 5 % a menos de 7,5 % anual."},
     {"valor": 2, "texto": "De 7,5 % a 10 % anual."},
     {"valor": 1, "texto": "Más de 10 % anual."}
   ]'::jsonb,
       nota_criterio = 'Fórmula: (nº de muertes en el año ÷ total de animales) × 100. El tramo 2,0-2,5 % se asigna al nivel 4 (banda inferior, regla 2).'
 where id = 27;

-- Verificación
select id, dimension, niveles from public.indicadores where id in (1,6,7,25,27) order by id;
