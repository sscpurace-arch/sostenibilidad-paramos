-- Carga los criterios oficiales (5 niveles + pregunta guía) de los 29 indicadores
-- en la tabla real de Supabase. Correr en el SQL Editor:
-- https://supabase.com/dashboard/project/vxtzvadknxmstdcwfwhb/sql

alter table indicadores add column if not exists pregunta_guia text;
alter table indicadores add column if not exists niveles jsonb;
alter table indicadores add column if not exists nota_criterio text;

update indicadores set
  pregunta_guia = '¿Qué tan protegidas están las fuentes de agua del predio (nacimientos, ríos, quebradas) frente a la deforestación u otras afectaciones?',
  niveles = '[{"valor":5,"texto":"Hay protección mayor al 81% de las fuentes de agua."},{"valor":4,"texto":"Protección entre el 61% y el 80%."},{"valor":3,"texto":"Protección entre el 41% y el 60%."},{"valor":2,"texto":"Protección entre el 21% y el 40%."},{"valor":1,"texto":"La protección es menor del 20%."}]'::jsonb,
  nota_criterio = NULL
where id = 1;

update indicadores set
  pregunta_guia = 'El agua para las actividades domésticas y agropecuarias, ¿es suficiente, de buena calidad y permanente durante todo el año?',
  niveles = '[{"valor":5,"texto":"La finca cuenta con agua permanente, suficiente caudal y de buena calidad."},{"valor":4,"texto":"La finca cuenta con agua permanente, bajo caudal y de buena calidad."},{"valor":3,"texto":"La finca cuenta con agua permanente, bajo caudal y de mala calidad."},{"valor":2,"texto":"La finca cuenta con agua intermitente, bajo caudal y de mala calidad."},{"valor":1,"texto":"La finca NO cuenta con agua durante cierta época del año."}]'::jsonb,
  nota_criterio = NULL
where id = 2;

update indicadores set
  pregunta_guia = '¿Cómo se abastece de agua el predio (canal, bombeo, acueducto, acarreo) y están protegidas las fuentes con cercas, sin deforestación?',
  niveles = '[{"valor":5,"texto":"La finca cuenta con solución de agua, las fuentes están protegidas con cercas y no se realiza deforestación."},{"valor":4,"texto":"La finca cuenta con canal abierto, las fuentes se conservan pero no tienen protección, y no se realiza deforestación."},{"valor":3,"texto":"La finca cuenta con bombeo, las fuentes no se protegen, pero no se realiza deforestación."},{"valor":2,"texto":"La finca cuenta con acequia, las fuentes no están protegidas con cercas y se realiza deforestación."},{"valor":1,"texto":"En la finca se acarrea el agua y/o se cuenta con aljibe, no hay fuentes de agua y se realiza deforestación."}]'::jsonb,
  nota_criterio = 'Referencia rápida según el método: acueducto rural = 3; canal abierto o bombeo = 2; acarreo = 1. Otros casos dependen del tratamiento y las condiciones sépticas de la conducción.'
where id = 3;

update indicadores set
  pregunta_guia = 'Las aguas residuales domésticas y agropecuarias, ¿reciben tratamiento y a dónde se vierten finalmente?',
  niveles = '[{"valor":5,"texto":"Tienen tratamiento y se vierten a trampa de grasa con filtro (aguas grises), pozo séptico (aguas negras) y tanque de sedimentación u ordeño en campo (agropecuarias)."},{"valor":4,"texto":"Tienen tratamiento y se vierten a pozo séptico (negras y grises) y acequia (agropecuarias)."},{"valor":3,"texto":"Las aguas negras se vierten a letrina; las grises no tienen tratamiento y van a fuente hídrica; las agropecuarias van a una acequia."},{"valor":2,"texto":"Tienen tratamiento (domésticas y agropecuarias) pero se vierten a una fuente hídrica."},{"valor":1,"texto":"No tienen tratamiento y se vierten directamente a una fuente hídrica."}]'::jsonb,
  nota_criterio = NULL
where id = 4;

update indicadores set
  pregunta_guia = '¿Se hacen quemas en el predio, y qué tanta cobertura vegetal y pendiente tiene el suelo?',
  niveles = '[{"valor":5,"texto":"No se hacen quemas, hay alta cobertura vegetal del suelo y las pendientes son moderadas."},{"valor":4,"texto":"No se hacen quemas, cobertura vegetal media y pendiente moderada."},{"valor":3,"texto":"No se hacen quemas y la cobertura del suelo es baja."},{"valor":2,"texto":"No se hacen quemas, mínima cobertura vegetal y pendiente severa."},{"valor":1,"texto":"Se hacen quemas, baja cobertura vegetal y pendiente muy severa."}]'::jsonb,
  nota_criterio = NULL
where id = 5;

update indicadores set
  pregunta_guia = '¿La fertilización se basa en análisis de suelos, y hay problemas de encharcamiento, resequedad o baja actividad biológica?',
  niveles = '[{"valor":5,"texto":"Según análisis de suelos la finca no requiere fertilizantes, no hay encharcamiento/resequedad y la actividad biológica es alta."},{"valor":4,"texto":"La fertilización se basa en análisis de suelos que sí indica necesidad de insumos; no hay encharcamiento/resequedad y alta actividad biológica."},{"valor":3,"texto":"La fertilización se basa en la experiencia del productor; no hay encharcamiento/resequedad y media actividad biológica."},{"valor":2,"texto":"La fertilización se hace por moda o voz a voz; no hay severidad de encharcamiento/resequedad y baja actividad biológica."},{"valor":1,"texto":"La fertilización se hace sin análisis de suelos; hay encharcamiento/resequedad y baja actividad biológica."}]'::jsonb,
  nota_criterio = NULL
where id = 6;

update indicadores set
  pregunta_guia = '¿Se protege el bosque, se aprovecha de forma sostenible, se enriquece con especies nativas y se permite su regeneración natural?',
  niveles = '[{"valor":5,"texto":"Se protege, se aprovecha sosteniblemente, hay esfuerzos de enriquecimiento con especies nativas, se permite regeneración natural y mantiene conexión con otros bosques del área."},{"valor":4,"texto":"Se protege parcialmente, se aprovecha sosteniblemente y se permite regeneración natural, pero sin conectividad con otros bosques."},{"valor":3,"texto":"Se protege parcialmente, se aprovecha sosteniblemente, NO se enriquece con especies nativas y se permite regeneración natural."},{"valor":2,"texto":"NO se protege, se aprovecha, NO se enriquece con especies nativas y NO se permite regeneración natural."},{"valor":1,"texto":"NO se protege, aprovechamiento indiscriminado, NO se enriquece con especies nativas y NO se permite regeneración natural."}]'::jsonb,
  nota_criterio = NULL
where id = 7;

update indicadores set
  pregunta_guia = '¿Cuántos árboles por hectárea hay distribuidos en los potreros (dispersos, en franjas o en cualquier arreglo)?',
  niveles = '[{"valor":5,"texto":"Entre 70 y 100 árboles por hectárea."},{"valor":4,"texto":"Entre 30 y 69 árboles por hectárea."},{"valor":3,"texto":"Entre 10 y 29 árboles por hectárea."},{"valor":2,"texto":"Entre 5 y 9 árboles por hectárea."},{"valor":1,"texto":"Menos de 5 árboles por hectárea."}]'::jsonb,
  nota_criterio = 'Referencia para trópico alto (páramo).'
where id = 8;

update indicadores set
  pregunta_guia = '¿Qué porcentaje de las cercas de potreros y linderos son cercas vivas (con árboles)?',
  niveles = '[{"valor":5,"texto":"Más del 50% de las cercas son vivas."},{"valor":4,"texto":"Entre el 25% y el 49%."},{"valor":3,"texto":"Entre el 10% y el 24%."},{"valor":2,"texto":"Entre el 5% y el 9%."},{"valor":1,"texto":"Menos del 5%."}]'::jsonb,
  nota_criterio = NULL
where id = 9;

update indicadores set
  pregunta_guia = '¿Qué tipo de fertilizantes, herbicidas o pesticidas se usan en la finca, y de qué categoría toxicológica son?',
  niveles = '[{"valor":5,"texto":"No usa herbicidas ni pesticidas químicos; usa productos de origen biológico u orgánico."},{"valor":4,"texto":"No usa productos de la \"docena sucia\"; usa categoría toxicológica III y IV, y eventualmente productos biológicos u orgánicos."},{"valor":3,"texto":"No usa productos de la \"docena sucia\"; usa categoría toxicológica III y IV; no usa productos biológicos u orgánicos."},{"valor":2,"texto":"No usa productos químicos de la \"docena sucia\"; usa categoría toxicológica I y II."},{"valor":1,"texto":"Usa herbicidas y pesticidas de la \"docena sucia\" y de categoría toxicológica I y II."}]'::jsonb,
  nota_criterio = '"Docena sucia" = lista de plaguicidas de mayor riesgo para salud y ambiente. Categoría toxicológica I y II = alta y extrema peligrosidad.'
where id = 10;

update indicadores set
  pregunta_guia = '¿Hay tránsito de fauna nativa/silvestre en el predio, y se realiza cacería o pesca?',
  niveles = '[{"valor":5,"texto":"Permanentemente hay tránsito de fauna en el predio y no se realiza cacería."},{"valor":4,"texto":"Hay tránsito de fauna en el predio y no se realiza cacería."},{"valor":3,"texto":"Hay tránsito de fauna en el predio y sí se realiza cacería."},{"valor":2,"texto":"Eventualmente hay tránsito de fauna en el predio y se realiza cacería."},{"valor":1,"texto":"No hay tránsito de fauna en el predio."}]'::jsonb,
  nota_criterio = NULL
where id = 11;

update indicadores set
  pregunta_guia = '¿Qué porcentaje de los residuos sólidos y líquidos de la finca se reciclan o reutilizan?',
  niveles = '[{"valor":5,"texto":"Reciclan y reutilizan el 100% de los residuos."},{"valor":4,"texto":"Reciclan y reutilizan más de la mitad (>50%)."},{"valor":3,"texto":"Reciclan y reutilizan menos de la mitad (<50%)."},{"valor":2,"texto":"No les dan utilidad, pero un tercero los recicla y reutiliza."},{"valor":1,"texto":"No les dan utilidad y tienen una disposición final inadecuada."}]'::jsonb,
  nota_criterio = NULL
where id = 12;

update indicadores set
  pregunta_guia = '¿El productor tiene o ha tenido acceso a crédito, cuenta con garantías, y está reportado en centrales de riesgo?',
  niveles = '[{"valor":5,"texto":"Tiene o ha tenido crédito, tiene garantías y no está reportado en centrales de riesgo."},{"valor":4,"texto":"No tiene ni ha tenido crédito, tiene garantías y no está reportado en centrales de riesgo."},{"valor":3,"texto":"Tiene crédito, baja capacidad de mayor endeudamiento y no está reportado en centrales de riesgo."},{"valor":2,"texto":"Tiene crédito y no tiene capacidad para mayor endeudamiento."},{"valor":1,"texto":"No tiene crédito, tiene garantía y está reportado en centrales de riesgo."}]'::jsonb,
  nota_criterio = NULL
where id = 13;

update indicadores set
  pregunta_guia = '¿El productor lleva algún tipo de registro contable o de costos de las actividades de la finca?',
  niveles = '[{"valor":5,"texto":"Maneja contabilidad financiera y de costos."},{"valor":4,"texto":"Maneja contabilidad financiera sin análisis de costos."},{"valor":3,"texto":"Maneja un sistema contable financiero básico."},{"valor":2,"texto":"Registra informalmente algunos costos."},{"valor":1,"texto":"No maneja registros contables ni de costos."}]'::jsonb,
  nota_criterio = NULL
where id = 14;

update indicadores set
  pregunta_guia = '¿Los ingresos de la finca cubren los costos y generan utilidad, y durante cuánto tiempo del año?',
  niveles = '[{"valor":5,"texto":"Los ingresos cubren costos y generan utilidad durante todo el año."},{"valor":4,"texto":"Los ingresos cubren costos y generan utilidad más de la mitad del año."},{"valor":3,"texto":"Los ingresos cubren costos y eventualmente generan utilidad."},{"valor":2,"texto":"Los ingresos cubren costos pero no generan utilidad."},{"valor":1,"texto":"Los ingresos NO cubren los costos."}]'::jsonb,
  nota_criterio = NULL
where id = 15;

update indicadores set
  pregunta_guia = '¿La finca genera empleos (permanentes o temporales), y con qué frecuencia durante el año?',
  niveles = '[{"valor":5,"texto":"Genera empleos permanentes y temporales todo el año."},{"valor":4,"texto":"Genera empleos permanentes todo el año."},{"valor":3,"texto":"Genera empleos temporales todo el año."},{"valor":2,"texto":"Genera empleos temporales solo en algunas épocas del año."},{"valor":1,"texto":"No genera nuevos empleos."}]'::jsonb,
  nota_criterio = NULL
where id = 16;

update indicadores set
  pregunta_guia = '¿El productor y su familia aplican y comparten las técnicas y capacitaciones recibidas?',
  niveles = '[{"valor":5,"texto":"Aplican y difunden las técnicas propuestas, y comparten sus experiencias."},{"valor":4,"texto":"Aplican y difunden parcialmente las técnicas propuestas, y comparten experiencias."},{"valor":3,"texto":"Aplican las técnicas propuestas pero NO las difunden."},{"valor":2,"texto":"Aplican parcialmente y NO difunden las técnicas propuestas."},{"valor":1,"texto":"NO aplican ni difunden las técnicas propuestas."}]'::jsonb,
  nota_criterio = NULL
where id = 17;

update indicadores set
  pregunta_guia = '¿La finca produce alimentos para el autoconsumo familiar, y genera excedentes para vender?',
  niveles = '[{"valor":5,"texto":"Producción permanente de alimentos, con excedentes para comercializar."},{"valor":4,"texto":"Producción permanente, con excedentes ocasionales para comercializar."},{"valor":3,"texto":"Producción permanente durante seis meses del año."},{"valor":2,"texto":"Producción eventual durante el año."},{"valor":1,"texto":"No produce alimentos para la familia."}]'::jsonb,
  nota_criterio = NULL
where id = 18;

update indicadores set
  pregunta_guia = '¿Los sistemas agrícolas, pecuarios y forestales de la finca están diversificados e integrados entre sí?',
  niveles = '[{"valor":5,"texto":"Diversificación de cultivos, sistemas integrados (agrícola, pecuario y forestal) en arreglos multiestrato."},{"valor":4,"texto":"Diversificación de cultivos, sistemas integrados, pero sin arreglos espaciales."},{"valor":3,"texto":"Al menos dos sistemas (agrícola, pecuario o forestal) integrados."},{"valor":2,"texto":"Al menos dos sistemas (agrícola, pecuario o forestal), sin integrar."},{"valor":1,"texto":"Monocultivo."}]'::jsonb,
  nota_criterio = NULL
where id = 19;

update indicadores set
  pregunta_guia = '¿Se usan los subproductos de cosecha (agrícolas, pecuarios, agroindustriales) para compostaje o abonos?',
  niveles = '[{"valor":5,"texto":"Se usa el 100% de los subproductos utilizables para compostaje o abonos."},{"valor":4,"texto":"Se usa más de la mitad (>50%)."},{"valor":3,"texto":"Se usa menos de la mitad (<50%)."},{"valor":2,"texto":"No se les da utilidad, pero un tercero los recicla y reutiliza."},{"valor":1,"texto":"No se les da utilidad y tienen disposición final inadecuada."}]'::jsonb,
  nota_criterio = NULL
where id = 20;

update indicadores set
  pregunta_guia = '¿Cuántas divisiones de potrero (para pastoreo) tiene la finca?',
  niveles = '[{"valor":5,"texto":"Más de 20 potreros."},{"valor":4,"texto":"De 16 a 20 potreros."},{"valor":3,"texto":"De 11 a 15 potreros."},{"valor":2,"texto":"De 6 a 10 potreros."},{"valor":1,"texto":"Menos de 5 potreros."}]'::jsonb,
  nota_criterio = NULL
where id = 21;

update indicadores set
  pregunta_guia = '¿Cuántos litros de leche produce la finca por hectárea al año?',
  niveles = '[{"valor":5,"texto":"Más de 2500 litros por hectárea/año."},{"valor":4,"texto":"Entre 2001 y 2500 litros por hectárea/año."},{"valor":3,"texto":"Entre 1501 y 2000 litros por hectárea/año."},{"valor":2,"texto":"Entre 1001 y 1500 litros por hectárea/año."},{"valor":1,"texto":"1000 litros por hectárea/año o menos."}]'::jsonb,
  nota_criterio = 'Banda mostrada: Doble Propósito, trópico alto (páramo). Para sistemas de Lechería especializada en trópico alto los rangos son distintos (mayores): 5=≥20001, 4=16001-20000, 3=12001-16000, 2=8001-12000, 1=≤8000 litros/ha/año. Confirmar con Santiago cuál sistema predomina en el área para fijar la banda por defecto.'
where id = 22;

update indicadores set
  pregunta_guia = '¿Cuál es el peso promedio al destete de las crías (machos y hembras) de la finca?',
  niveles = '[{"valor":5,"texto":"171 kilos promedio o más."},{"valor":4,"texto":"Entre 159 y 170 kilos promedio."},{"valor":3,"texto":"Entre 149 y 160 kilos promedio."},{"valor":2,"texto":"Entre 140 y 150 kilos promedio."},{"valor":1,"texto":"Menos de 140 kilos promedio."}]'::jsonb,
  nota_criterio = 'Banda mostrada: Doble Propósito (trópico bajo-alto). Para sistemas de Cría en trópico bajo los rangos son distintos (mayores): 5=≥200, 4=180-199, 3=170-179, 2=160-169, 1=<160 kg. Confirmar con Santiago cuál sistema predomina.'
where id = 23;

update indicadores set
  pregunta_guia = '¿A qué edad promedio se sacrifican los machos de ceba vendidos para matadero?',
  niveles = '[{"valor":5,"texto":"30 meses o menos."},{"valor":4,"texto":"De 31 a 35 meses."},{"valor":3,"texto":"De 36 a 40 meses."},{"valor":2,"texto":"De 41 a 44 meses."},{"valor":1,"texto":"Más de 45 meses."}]'::jsonb,
  nota_criterio = NULL
where id = 24;

update indicadores set
  pregunta_guia = '¿Cuál es la carga animal por hectárea de pastoreo, en Unidades de Gran Ganado (1 UGG = 450 kg)?',
  niveles = '[{"valor":5,"texto":"Más de 1,5 UGG por hectárea."},{"valor":4,"texto":"Entre 1,1 y 1,5 UGG por hectárea."},{"valor":3,"texto":"Entre 0,9 y 1 UGG por hectárea."},{"valor":2,"texto":"Entre 0,7 y 0,8 UGG por hectárea."},{"valor":1,"texto":"Menos de 0,6 UGG por hectárea."}]'::jsonb,
  nota_criterio = NULL
where id = 25;

update indicadores set
  pregunta_guia = '¿Cuál es el tiempo promedio entre el nacimiento y el primer parto de las vacas de la finca?',
  niveles = '[{"valor":5,"texto":"De 30 a 36 meses."},{"valor":4,"texto":"De 36 a 40 meses."},{"valor":3,"texto":"De 41 a 45 meses."},{"valor":2,"texto":"De 46 a 48 meses."},{"valor":1,"texto":"Más de 48 meses."}]'::jsonb,
  nota_criterio = NULL
where id = 26;

update indicadores set
  pregunta_guia = '¿Cuál es el porcentaje anual de muertes de ganado en la finca?',
  niveles = '[{"valor":5,"texto":"Menor al 2% anual."},{"valor":4,"texto":"Entre 2,5% y 5% anual."},{"valor":3,"texto":"Entre 5% y 7,5% anual."},{"valor":2,"texto":"Entre 7,5% y 10% anual."},{"valor":1,"texto":"Mayor al 10% anual."}]'::jsonb,
  nota_criterio = NULL
where id = 27;

update indicadores set
  pregunta_guia = '¿Cuál es el tiempo promedio transcurrido entre dos partos de las vacas de la finca?',
  niveles = '[{"valor":5,"texto":"De 12 a 13 meses."},{"valor":4,"texto":"De 14 a 15 meses."},{"valor":3,"texto":"De 16 a 18 meses."},{"valor":2,"texto":"De 19 a 21 meses."},{"valor":1,"texto":"21 meses o más."}]'::jsonb,
  nota_criterio = NULL
where id = 28;

update indicadores set
  pregunta_guia = '¿Se toma, registra y analiza información técnica y reproductiva de la finca, y se usa para tomar decisiones?',
  niveles = '[{"valor":5,"texto":"Se toma la información periódicamente, se registra, se analiza y se usa para tomar decisiones."},{"valor":4,"texto":"Se toma periódicamente, se registra, se analiza y se usa eventualmente para decisiones."},{"valor":3,"texto":"Se toma periódicamente, se registra, se analiza pero NO se usa para decisiones."},{"valor":2,"texto":"Se toma eventualmente, se registra, no se analiza y NO se usa para decisiones."},{"valor":1,"texto":"No se toma ninguna información de la finca."}]'::jsonb,
  nota_criterio = NULL
where id = 29;


-- ============================================================================
-- R3 · Fórmula y método de levantamiento visibles al calificar
-- Taller de calibración, Paletará, 31-jul-2026.
--
-- El objetivo del taller es que el evaluador interiorice el cálculo y con el
-- tiempo pueda prescindir de la guía impresa. Una fórmula visible en el momento
-- de uso enseña; una escondida en un manual aparte, no.
--
-- OJO: estas notas CONSERVAN la guía que ya traían los indicadores 3, 8, 10,
-- 22 y 23, y le agregan el método detrás. No las reemplazan.
-- El indicador 7 no pertenece a ninguna familia de levantamiento: queda sin nota.
-- ============================================================================

update indicadores set nota_criterio = 'Levantamiento: estimación visual de proporción o densidad, recorriendo el predio completo. Se califica lo observado, no lo declarado.' where id = 1;
update indicadores set nota_criterio = 'Levantamiento: verificación directa de existencia y funcionamiento en el predio.' where id = 2;
update indicadores set nota_criterio = 'Referencia rápida según el método: acueducto rural = 3; canal abierto o bombeo = 2; acarreo = 1. Otros casos dependen del tratamiento y las condiciones sépticas de la conducción. Levantamiento: verificación directa de existencia y funcionamiento en el predio.' where id = 3;
update indicadores set nota_criterio = 'Levantamiento: verificación directa de existencia y funcionamiento en el predio.' where id = 4;
update indicadores set nota_criterio = 'Levantamiento: estimación visual de proporción o densidad, recorriendo el predio completo. Se califica lo observado, no lo declarado.' where id = 5;
update indicadores set nota_criterio = 'Levantamiento: verificación directa de existencia y funcionamiento en el predio.' where id = 6;
update indicadores set nota_criterio = 'Referencia para trópico alto (páramo). Se cuentan los árboles ESTABLECIDOS Y VIVOS por hectárea, no los sembrados.' where id = 8;
update indicadores set nota_criterio = 'Levantamiento: estimación visual de proporción o densidad, recorriendo el predio completo. Se califica lo observado, no lo declarado.' where id = 9;
update indicadores set nota_criterio = '"Docena sucia" = lista de plaguicidas de mayor riesgo para salud y ambiente. Categoría toxicológica I y II = alta y extrema peligrosidad. Levantamiento: verificación directa de existencia y funcionamiento en el predio.' where id = 10;
update indicadores set nota_criterio = 'Levantamiento: verificación directa de existencia y funcionamiento en el predio.' where id = 11;
update indicadores set nota_criterio = 'Levantamiento: estimación visual de proporción o densidad, recorriendo el predio completo. Se califica lo observado, no lo declarado.' where id = 12;
update indicadores set nota_criterio = 'Levantamiento: entrevista al productor y cálculo.' where id = 13;
update indicadores set nota_criterio = 'Levantamiento: entrevista al productor y cálculo.' where id = 14;
update indicadores set nota_criterio = 'Levantamiento: entrevista al productor y cálculo.' where id = 15;
update indicadores set nota_criterio = 'Levantamiento: entrevista al productor y cálculo.' where id = 16;
update indicadores set nota_criterio = 'Levantamiento: entrevista al productor y cálculo.' where id = 17;
update indicadores set nota_criterio = 'Levantamiento: verificación directa de existencia y funcionamiento en el predio.' where id = 18;
update indicadores set nota_criterio = 'Levantamiento: verificación directa de existencia y funcionamiento en el predio.' where id = 19;
update indicadores set nota_criterio = 'Levantamiento: estimación visual de proporción o densidad, recorriendo el predio completo. Se califica lo observado, no lo declarado.' where id = 20;
update indicadores set nota_criterio = 'Levantamiento: verificación directa de existencia y funcionamiento en el predio.' where id = 21;
update indicadores set nota_criterio = 'Banda mostrada: Doble Propósito, trópico alto (páramo). Para sistemas de Lechería especializada en trópico alto los rangos son distintos (mayores): 5=≥20001, 4=16001-20000, 3=12001-16000, 2=8001-12000, 1=≤8000 litros/ha/año. Confirmar con Santiago cuál sistema predomina en el área para fijar la banda por defecto. Fórmula: (litros por día × 365) ÷ hectáreas en pastoreo.' where id = 22;
update indicadores set nota_criterio = 'Banda mostrada: Doble Propósito (trópico bajo-alto). Para sistemas de Cría en trópico bajo los rangos son distintos (mayores): 5=≥200, 4=180-199, 3=170-179, 2=160-169, 1=<160 kg. Confirmar con Santiago cuál sistema predomina. Levantamiento: entrevista al productor y cálculo.' where id = 23;
update indicadores set nota_criterio = 'Levantamiento: entrevista al productor y cálculo.' where id = 24;
update indicadores set nota_criterio = 'Fórmula: (nº animales × peso promedio) ÷ 450 kg = UGG; luego UGG ÷ hectáreas de pastoreo.' where id = 25;
update indicadores set nota_criterio = 'Levantamiento: entrevista al productor y cálculo.' where id = 26;
update indicadores set nota_criterio = 'Fórmula: (nº de muertes en el año ÷ total de animales) × 100.' where id = 27;
update indicadores set nota_criterio = 'Promedio de meses transcurridos entre dos partos consecutivos.' where id = 28;
update indicadores set nota_criterio = 'Levantamiento: entrevista al productor y cálculo.' where id = 29;
