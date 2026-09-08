# Nota técnica — Complemento de seguimiento para la App Sostenibilidad Páramos

**Fecha:** 22 de junio de 2026
**Autor:** Santiago Jaramillo / SSC PNN Puracé (con apoyo de análisis asistido)
**Contexto:** Estrategia SSC – GEF Páramos. App de calificación de los 29 indicadores de sostenibilidad.
**Estado:** Propuesta aprobada en concepto — pendiente de ejecución por fases.

---

## 1. Origen de la idea

La App actualmente captura **29 indicadores de sostenibilidad** (agrupados en 4 dimensiones:
socio-ambiental, ambiental, socio-económico, productivo) mediante una **calificación cualitativa 1–5**.
Esto produce un buen *índice de estado* (una fotografía del productor en un momento dado).

Surge la pregunta: *¿los 29 indicadores cubren el seguimiento a la evolución, o conviene complementar
con otros factores?*

### Documentos revisados

- **Avance del Diagnóstico del Área SSC** (P-2, abril 2026, Santiago Jaramillo): línea base real de
  Paletará (n=140) y Sotará (n=130), 29 indicadores por territorio. *Fuente primaria propia.*
- **Reporte de Análisis de Producción Lechera 2026** (base FAO: 3.324 registros / 1.662 fincas):
  correlaciones de referencia a gran escala.
- **Hojas "Visitas técnicas extensionistas" / "Análisis de visitas"**: instrumento de campo de 31
  campos ya aplicado en Paletará (datos crudos: SSP%, carga animal UGG/ha, aforo, condición corporal,
  producción lechera, rotación, etc.).
- *Pendiente de abrir:* `P-2 Diagnóstico Avanzado Iniciativas Productivas.rar` y `Analisis
  inseminaciones`. Pueden aportar hallazgos adicionales.

## 2. Hallazgo central del análisis

**Las correlaciones del reporte FAO salieron de datos crudos (números y categorías), no de
calificaciones 1–5.** Cuando un factor se reduce a un puntaje 1–5, se pierde el dato crudo que hace
posible el análisis estadístico.

Ejemplos:

| Factor en el reporte | Cómo lo guardan los 29 indicadores | Qué necesitó el análisis |
|---|---|---|
| Carga animal | Puntaje 1–5 (indicador #25) | UGG/ha real (1,288 vs 0,593) |
| Producción lechera | Puntaje 1–5 (indicador #22) | Litros/vaca/día y litros/ha reales |
| Sistema productivo | **No existe** en los 29 | Intensivo / semi / extensivo (categoría) |

**Conclusión:** el complemento NO son "más indicadores para calificar". Es **capturar unos pocos
valores crudos en el mismo momento de la visita**, aprovechando que el evaluador ya está en el predio.

## 2.bis Hallazgos de la línea base local (Paletará / Sotará)

Más allá del reporte FAO, el diagnóstico propio aporta evidencia sobre **esta** población:

| Indicador | Paletará | Sotará | Lectura |
|---|:---:|:---:|---|
| Árboles en potreros (#8) | **1,7** | **1,0** | El más bajo de toda la matriz |
| Cercas vivas (#9) | **1,6** | 2,0 | Segundo más bajo |
| Registros contables (#14) | **1,1** | 2,0 | Casi nulos |
| Registros técnicos/reprod. (#29) | **1,4** | 4,0 | Brecha enorme en Paletará |
| Aprovech. subproductos (#20) | 2,4 | **1,0** | Débil |
| Protección fuentes de agua (#1) | **2,2** | 3,0 | Crítico en Paletará |

Hallazgos relevantes para el diseño del módulo:

1. **La dimensión ambiental es la más crítica** (árboles en potreros y cercas vivas son los valores
   más bajos). Son los candidatos naturales del plan de acción SMART.
2. **La correlación SSP ↔ protección de fuentes de agua se confirma localmente:** el 62% de las
   fincas con SSP protegen sus nacimientos — el mismo valor que el reporte FAO. Dos fuentes
   independientes lo respaldan → el SSP es la palanca de mayor efecto multiplicador.
3. **El complemento de caracterización ya existe como instrumento probado:** el formulario
   extensionista de 31 campos (secciones A–I) capturó en campo exactamente los datos crudos
   propuestos. El módulo es una **adaptación recortada** de ese formulario, no un diseño desde cero.
4. **La madurez de la intervención explica parte de la evolución** (Sotará > Paletará por acuerdo más
   antiguo y organización más consolidada) → conviene capturar la **antigüedad de vinculación / fecha
   de acuerdo** como variable.

## 3. Factores que el análisis probó determinantes

| Factor | Qué reveló | ¿Cubierto en los 29? | Qué capturar de más |
|---|---|---|---|
| **Sistema productivo** | Intensivo = 2,18× más eficiente por ha que extensivo | No está | Lista: intensivo / semi / extensivo |
| **Carga animal real** | Clave del uso sostenible del suelo en páramo | Parcial (puntaje) | N° animales + área en pasto (ha) |
| **Producción lechera real** | Base de toda la rentabilidad | Parcial (puntaje) | Litros/día + vacas en ordeño |
| **Riego / ensilaje / banco forrajero** | +$7.759 / +$5.593 / +$4.651 al margen bruto | Indirecto | 3 botones sí / parcial / no |
| **SSP (silvopastoril)** | "Puerta de entrada": cataliza protección hídrica y abono orgánico | Parcial (#8, #9) | 1 botón sí / parcial / no |
| **Área de conservación** | Distingue conservación activa de pasiva | No (en ha) | Hectáreas de bosque / conservación |
| **Calidad de leche (UFC / CCS)** | 47–48% fuera de norma: la mayor brecha económica | No | **Fuera de alcance** — requiere laboratorio |

> Limitación honesta: la calidad de leche (UFC/CCS) fue el mayor hallazgo del reporte, pero **no es
> capturable en campo** sin laboratorio. Se acepta como límite del alcance.

## 4. Realidad operativa (condiciones de diseño)

- **No es un programa de extensión técnica.** Es seguimiento de SSC a implementaciones sostenibles.
- **2–3 visitas por productor al año, máximo.** A veces una sola.
- **Sin equipo de extensionistas.** La fuerza es el personal (reducido) de PNN Puracé, actores
  comunitarios capacitados y, eventualmente, otras entidades.
- **Población objetivo:** productores ya en la App + productores de un proyecto FAO.

Implicación de diseño: los campos deben ser **observables o que el productor sepa de memoria**
(cuántas vacas, cuántos litros), **no caducan** (el dato crudo sigue siendo comparable aunque pasen
18 meses entre visitas) y se comparan como **dos fotografías separadas en el tiempo**, no como
verificación de compromisos mes a mes.

## 5. Propuesta — dos componentes, en dos partes distintas de la App

### Parte 1 — Plan de acción (después de calificar) · *Proyecto próximos días*

- Se habilita **al terminar de calificar los 29 indicadores**.
- Pestaña tipo **"Evaluar calificación y estructurar plan de acción"**.
- La App prioriza automáticamente los **5 indicadores más bajos**.
- Sobre cada uno se estructura un plan **SMART**: meta + unidad de medida + plazo.
- **Inyectar IA** para ayudar a estructurar el plan (por evaluar cómo: sugerencia de metas,
  redacción asistida, recomendaciones según el indicador). *Pendiente de diseño técnico.*
- Valor: convierte el diagnóstico en compromiso, y en la siguiente visita la App muestra
  "esto se propuso / esto está ahora".

### Parte 2 — Complemento de caracterización (datos crudos)

- Botón opcional en la ficha del productor.
- Captura los **datos crudos** de la sección 3, enfocados en los indicadores priorizados.
- Campos calculados automáticamente por la App (carga animal a partir de animales + área;
  litros/vaca a partir de litros/día + vacas en ordeño).
- Habilita reconstruir, sobre la población de Puracé + FAO, el mismo tipo de análisis del reporte FAO.

## 6. Recomendación

**Sí vale la pena**, con una condición de marco: entenderlo como **caracterización + plan**, no como
extensión técnica. Encaja con la realidad operativa porque los datos son fáciles de tomar, no caducan
y son comparables en el tiempo. Si se decidiera no hacerlo, quedarse con los 29 indicadores como
índice de sostenibilidad sigue siendo una opción válida.

## 7. Próximos pasos (pendientes)

1. Diseñar la Parte 1 (pestaña plan de acción SMART + integración de IA) — *prioridad próximos días*.
2. Diseñar la Parte 2 (formulario de caracterización, campos calculados, modelo de datos).
3. Definir cómo se relacionan los datos crudos con los 5 indicadores priorizados.
4. Revisar el modelo de datos Supabase / IndexedDB para alojar evaluaciones longitudinales.

---

*Insumos: 29 indicadores (`public/seed-data.json`), Reporte de Análisis de Producción Lechera 2026
(Drive, base FAO), hojas "Visitas técnicas extensionistas" y "Visitas de seguimiento facilitadores".*
