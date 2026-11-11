# Diagnóstico y mejoras de la app — noviembre 2026

Rama: `fable/diagnostico-2026-11` (subida a GitHub, **sin fusionar a `main`**: producción no ha cambiado).
Fecha: 11 de noviembre de 2026.

---

## 0. Antes que nada: dos cosas urgentes que no toqué

1. **El repositorio de GitHub es público y tiene los datos personales de los 270 productores.** El archivo `data/seed-data.json` trae nombre completo y cédula real de cada uno (lo verifiqué: 270 de 270 con cédula). Ya estaba anotado desde septiembre y sigue igual. No cambié la visibilidad del repositorio porque me pediste no tocar la configuración de GitHub. Recomendación: volverlo privado desde GitHub → Settings → General → Danger Zone → Change visibility. Vercel sigue publicando igual con un repositorio privado. Ojo: aunque se vuelva privado, lo que ya fue público pudo quedar copiado.
2. **La vista previa de esta rama en Vercel falló**, por eso no pude probar en una dirección real. La causa la reproduje en el computador: sin las variables de Supabase (dirección y clave pública) ninguna pantalla compila, y en Vercel están configuradas solo para producción, no para las vistas previas (era la primera vista previa que se hacía en este proyecto). Compilé `main` de la misma forma y falla igual, así que no lo causan estos cambios. Ver la sección 5, paso 0.

---

## 1. Estado de la app y qué cambió, en pocas palabras

La app ya hacía lo principal, pero sin señal fallaba de una forma muy concreta: con señal débil el celular podía quedar con las pantallas de una versión y el código de otra, y entonces se quedaba en "Cargando perfil…" justo en la finca. Eso quedó resuelto de raíz: ahora el celular guarda cada versión completa o no la guarda, y si no puede, sigue con la anterior entera. También se cerraron varias formas de perder datos sin que nadie se enterara (un guardado que fallaba en silencio, una cola que no subía nunca con señal débil, borrados que podían salir hacia el servidor desde el modo prueba) y se corrigieron cálculos que daban un puntaje distinto según la pantalla. Todo está en la rama, probado en el computador con el servidor apagado para simular la falta de señal; falta tu prueba en el celular antes de fusionar.

---

## 2. Qué se arregló o mejoró

Cada punto dice qué le pasaba al técnico antes, qué pasa ahora, en qué commit está y cómo lo verifiqué.

### Trabajo sin señal

**2.1 "Cargando perfil…" para siempre en la finca** — commit `b5abd76` (más `c5183ca`)
- **Antes:** el celular guardaba las pantallas en un paso y el código en otro. Si en medio había una versión nueva o se caía la señal, quedaba una mezcla de dos versiones y la pantalla del productor o "Iniciar calificación" no abría sin señal. Es muy probablemente lo que pasó en la prueba del 19 de octubre.
- **Ahora:** al instalar una versión, el celular baja sus 9 pantallas y su código juntos, y solo da la versión por instalada si todo es de la misma versión. Si la red falla a mitad, la instalación falla y sigue funcionando la versión anterior completa. "Actualizar la app" ya no borra lo guardado.
- **Verificado:** en Chrome con la app compilada: instalación con "9 de 9" pantallas; servidor apagado y se abrieron inicio, buscar, pendientes, diagnóstico, el perfil de un productor con historial y una calificación en curso, y se calificó un indicador sin servidor (quedó guardado). También el paso de una versión a la siguiente: borró las copias viejas y quedó la nueva completa.

**2.2 Supabase caído o pausado sacaba a todos al login** — commit `b5abd76`
- **Antes:** cuando Supabase se pausó en septiembre, cualquier técnico con señal era enviado a la pantalla de ingreso aunque tuviera todo guardado en el celular; y si fallaba la consulta del perfil, lo mandaba a "completar registro".
- **Ahora:** si Supabase no responde y el técnico ya tenía sesión, lo deja seguir trabajando.
- **Verificado:** prueba con un Supabase simulado: 14 de 14 casos correctos (con sesión, sin sesión, servidor caído, usuario sin aprobar, etc.).

**2.3 Guía de calificación, logos y marcadores disponibles sin señal** — commit `b5abd76`
- **Antes:** dependían de que alguien los hubiera abierto antes con señal.
- **Ahora:** se guardan al instalar la versión.
- **Verificado:** en Chrome, sin servidor.

**2.4 `/diagnostico` dice si la copia sin señal está completa y es de la versión abierta** — commits `b5abd76` y `278949f`
- **Verificado:** en Chrome: "9 de 9 guardadas · código completo · copia de esta misma versión".

### No perder datos

**2.5 Un guardado que fallaba no avisaba** — commits `77f83fb` y `278949f`
- **Antes:** si el celular se quedaba sin espacio, lo marcado no se guardaba y el técnico seguía calificando creyendo que sí. Además, el registro y su entrada en la cola de subida se escribían por separado: si la app se cerraba entre los dos, el dato quedaba en el celular y nunca subía.
- **Ahora:** los dos se escriben juntos o ninguno. Si algo no queda guardado, sale un aviso rojo arriba que dice qué hacer, y "Guardar y salir", "Enviar", "Iniciar calificación", "Guardar Productor" y la firma no siguen como si nada.
- **Verificado:** lint y compilación correctos. **No pude provocar un "celular lleno" real**, así que el aviso rojo no lo vi aparecer.

**2.6 Con señal débil, la cola no subía nunca** — commits `77f83fb`, `c5183ca` y `cf565d8`
- **Antes:** todo lo pendiente se mandaba en un solo paquete. Con tres visitas sin señal (más de 100 respuestas) el paquete no alcanzaba a llegar, y cada intento gastaba "oportunidades", hasta marcar los cambios como fallidos sin que fueran culpables de nada.
- **Ahora:** se sube en paquetes de 25. Lo que alcanza a subir queda registrado. Si el servidor no responde, no se gastan intentos y el banner dice "el servidor no responde (señal débil), se reintenta solo". Si la sesión venció, lo dice.
- **Verificado:** lectura del código por mí y por una revisión independiente. **No lo pude probar contra Supabase real** (solo tengo permiso de lectura).

**2.7 Un cambio viejo podía pisar uno nuevo en el servidor** — commit `77f83fb`
- **Antes:** si un cambio quedaba atascado y después se hacía otro del mismo registro, al reabrir la app el viejo podía subir de último. Así una visita enviada podía volver a "borrador".
- **Ahora:** cada cambio nuevo de un registro reemplaza a los pendientes anteriores del mismo registro.

**2.8 El modo prueba podía borrar datos reales del servidor** — commits `77f83fb` y `c5183ca`
- **Antes:** los datos de prueba usan los mismos identificadores que los reales. Un borrado hecho en modo prueba quedaba en la cola; si después entraba en ese celular una cuenta real (sobre todo la de administrador), el borrado salía hacia Supabase y borraba el registro real, sin respaldo.
- **Ahora:** en modo prueba los borrados no se encolan. Los borrados viejos que estuvieran en cola al llegar esta versión se descartan una sola vez, junto con los cambios anteriores de ese mismo registro.
- **Ojo:** si alguien tenía en cola un borrado legítimo, ese registro sigue en el servidor y hay que borrarlo de nuevo.

**2.9 Borrar evaluaciones desde el historial** — commits `278949f` y `c5183ca`
- **Antes:** el bote de basura aparecía también en la línea base de otros técnicos, que desde octubre todos pueden ver.
- **Ahora:**
  - Solo aparece en las evaluaciones propias o de prueba.
  - Para borrar una evaluación ya enviada hay que escribir BORRAR, porque se borra también del servidor y no hay respaldo.
  - Se borra también su plan de acción, que antes quedaba huérfano.
  - Si algún paso falla, se detiene y lo dice.

**2.10 Cerrar sesión en el páramo** — commit `278949f`
- **Ahora:** avisa si no hay señal (para volver a entrar se necesita internet) o si hay cambios sin subir.

### Cálculos

**2.11 El puntaje global salía distinto según la pantalla** — commit `c991022`
- **Antes:** la pantalla de resultados y el PDF del diagnóstico mostraban el puntaje que guardó la IA: el promedio de los 29 indicadores sueltos. El resto de la app (inicio, Telegram, supervisor) usa el promedio de las 4 dimensiones. Como las dimensiones tienen distinto número de indicadores, los dos números no coinciden.
- **Ahora:** todo usa el promedio de las dimensiones, que es la regla ya documentada (el N/A fuera del denominador por dimensión y en el global).
- **La función de IA:** `generar-diagnostico` quedó corregida en el código, pero **NO la desplegué**. Mientras no se despliegue, el número guardado por la IA sigue con la fórmula vieja, pero ya no se muestra en ninguna parte.
- **Verificado:** lectura y revisión independiente.

**2.12 La comparación con la "visita anterior" podía ser contra una visita posterior o de prueba** — commits `c991022` y `c5183ca`
- **Ahora:** se compara contra la visita enviada anterior en fecha, y las reales solo contra reales. Corregido igual en la función de IA (sin desplegar).
- Las fechas de la línea base ("2024-06-15 12:00:00+00") ahora se leen bien también en iPhone, donde antes salían como fecha inválida.

**2.13 El radar comparativo dibujaba los "No aplica" como cero** — commit `c991022`
- **Antes:** con dos visitas, un indicador "No aplica" en una de ellas se veía como una caída a 0.
- **Ahora:** ese eje sale de la comparación y abajo se lista cuáles quedaron fuera.
- **Verificado:** en Chrome, productor con dos visitas: quedaron fuera los ejes 22, 26 y 28, con la nota.

**2.14 Calculadoras** — commits `c991022` y `c5183ca`
- **Indicador 25 (carga animal):**
  - 0,7, 0,9 y 1,1 exactos caían en el nivel de abajo por un error de aritmética del computador.
  - "Más de 1,5" ahora es 5. Antes el corte estaba en 1,51.
- **Indicador 27 (mortalidad):**
  - Con el campo de muertes vacío daba 0 % y puntaje 5; ahora hay que escribir el número (0 si no hubo).
  - Rechaza más muertes que animales.
  - Muestra dos decimales.
- **Indicador 28 (intervalo entre partos):** 20,5 meses daba nivel 2. Por la regla 2 de la guía ("un valor con decimales entre dos bandas va a la inferior") ahora da nivel 1. La guía nombra 13,5, 15,5 y 18,5; apliqué la misma regla a 20,5.
- **Pesos de referencia del 25:** un peso borrado contaba como 0 kg; ahora vuelve al valor por defecto.
- **Indicador 8 (árboles):** se muestra con un decimal. Avisa si hay más árboles establecidos que sembrados.
- **Número en pantalla y puntaje:** en los bordes ya no se contradicen. Se redondea siempre hacia el nivel inferior, como dice la regla 2.
- **Campos de las calculadoras:** letra de 16 px (en iPhone, con menos, el teléfono hace zoom al tocar el campo) y botón "Usar puntaje" más grande.
- **Verificado:** 29 casos de prueba automáticos de las bandas, todos correctos.

**2.15 Textos de niveles que dejaban valores sin nivel o en dos niveles** — commit `aa08b02`
- Indicadores 8, 21, 23, 24, 26 y 28. Por ejemplo, 21 meses entre partos aparecía en el nivel 2 y en el 1, y 5 potreros no cabía en ninguno.
- Se corrigieron con los textos de la guía v1.1 en los datos de la app y del modo prueba.
- En la base real hace falta correr la migración (sección 5).

### Uso en campo

**2.16** — commit `278949f`
- Botones del banner de sincronización de 36 px (antes ~20 px, difíciles con guantes).
- Textos más claros: "Subir ahora", "cambios guardados en el celular — subirán solos cuando haya señal".

**2.17 El menú del encabezado quedaba debajo de la barra inferior** — commit `066b5a6`
- En celulares pequeños tapaba "Cerrar sesión".
- Ahora va encima de todo y se puede desplazar.

**2.18 "Cancelar" en la calificación** — commit `066b5a6`
- Ya no dice que se pierden los cambios: todo lo marcado ya queda guardado como borrador.

**2.19 Evolución por dimensión en resultados** — commit `c991022`
- Ahora va en 2 columnas con el nombre completo.
- Antes, recortado a 6 letras, "Socioambiental" y "Socioeconómica" se leían igual.

### Pendientes de agosto que no necesitaban decisión metodológica

**2.20 Radar como imagen** — commits `26afaa5` y `cf565d8`
- **Dónde:** botón en el perfil del productor.
- **Qué arma:** una imagen con el nombre del propietario, el predio y la ubicación, el radar, la convención de cada evaluación (color, año y fecha de la visita) y la lista de los 29 indicadores numerados.
- **Cómo se entrega:** en el celular abre "compartir" (WhatsApp, galería); en el computador se descarga. Funciona sin señal.
- La leyenda del radar en pantalla también muestra el año.
- **Verificado:** en Chrome, con y sin servidor: imagen de 1080 × 2149 generada y revisada a ojo.
- **Sin probar en iPhone:** la revisión independiente advirtió que Safari bloquea exportar ese tipo de gráfica; quité la parte que lo causa, pero no tengo un iPhone para confirmarlo (paso 3 de la sección 5).

**2.21 Coordenadas escritas a mano al registrar un productor** — commit `26afaa5`
- Se pueden escribir latitud y longitud a mano, con coma o punto.
- Avisa si no parecen de Colombia, por ejemplo si se olvidó el signo menos.
- El GPS ahora explica por qué falla (permiso negado, sin satélites) en vez de quedarse callado.
- **Verificado:** en Chrome: sin el signo menos lo rechazó con un mensaje claro; corregido, guardó 2.3421 / -76.3854.

**2.22 Volver a generar el diagnóstico con IA de una evaluación guardada** — commits `26afaa5` y `cf565d8`
- El commit `e6ced74` ya permitía completar lo que faltara, y el plan ya se podía volver a pedir con "Sugerir con IA".
- Faltaba regenerar un diagnóstico existente: ahora hay un botón con confirmación que reemplaza el anterior.
- Con un puntaje corregido que aún no ha subido, la IA usa los datos del celular y no los viejos del servidor.
- En el celular queda un solo diagnóstico por evaluación (antes el nuevo podía quedar al lado del viejo y salir cualquiera de los dos).
- **No lo probé con la IA real:** en local no hay clave de la IA.

### Limpieza y seguridad

**2.23** — commit `d2f1475`
- Actualizaciones de seguridad sin cambios grandes. Entre ellas, la librería que limpia el HTML de los PDF tenía una falla crítica.
- `xlsx` y `pg` pasan a "solo desarrollo", porque solo los usan scripts.
- Fuera del repositorio:
  - Un ícono de prueba de 3,8 MB.
  - Dos carpetas con copias viejas de la app (`backup_v1`, `backup_v2`).
  - Seis archivos HTML de depuración.
- Todo sigue en el historial de git.
- **Verificado:** compilación correcta y la app abre sin servidor.

---

## 3. Lo que encontré y no toqué, por gravedad

**Alta**
- **Datos personales en el repositorio público** (sección 0). No es mi decisión.
- **Next.js 14.2.35 tiene alertas de seguridad que solo se cierran pasando a Next 16.**
  - Es un cambio grande, no corresponde a esta tanda.
  - El riesgo práctico es bajo en Vercel: son caídas del servidor por peticiones raras, no robo de datos.
  - `xlsx` no tiene arreglo publicado; solo lo usan scripts del computador.
- **Las copias de pantallas no sirven si el técnico nunca abrió la app con señal después de esta versión.** Es inevitable. Por eso el paso de prueba 3 pide abrirla con señal primero.

**Media**
- **Observaciones de los indicadores:**
  - Se guardan en cada tecla. Con señal, cada letra intenta una subida.
  - Con la nueva lógica la cola ya no crece, pero gasta batería y datos.
  - Arreglarlo bien (guardar al terminar de escribir) toca el formulario principal y no quise arriesgarlo sin tu prueba.
- **Filas borradas en el servidor siguen en el celular.** Si alguien borra un registro desde Supabase, el celular lo sigue mostrando. Necesita un diseño (marcar borrados en el servidor), no un parche.
- **Liberar espacio de fotos ya subidas:**
  - La función existe (`purgarBlobsSubidos`) pero nadie la llama.
  - No la conecté porque no confirmé que la galería pueda recuperar la foto original del servidor después.
  - Con ~10 GB disponibles en el celular de prueba no es urgente.
- **El mapa sin señal descarga ~1.200 teselas de OpenStreetMap por celular.** Va contra la política de uso de OSM y podrían bloquear la descarga. No lo toqué.
- **Puntaje global guardado por la IA:** el que quedó en los diagnósticos ya guardados (`diagnosticos.score_global`) sigue con la fórmula vieja. Ya no se muestra en ningún lado, así que no hace falta corregirlo en la base; si algún informe externo lo lee de Supabase, avísame.

**Baja**
- **El plan de acción muestra "0/5"** si se agrega un indicador sin calificar.
- **Quitar "No aplica" sin poner número** deja la fila marcada como N/A.
- **`lib/criterios-indicadores.json`** no se usa y tiene bandas viejas.
- **El seed tiene 14 identificadores de evaluación huérfanos.**
- **El panel de administración no puede editar registros de otros técnicos.** El permiso en la base existe; la pantalla no. Es el pendiente 3 de agosto.

---

## 4. Preguntas para ti

1. **¿Es oficial que el puntaje global es el promedio de las 4 dimensiones?**
   - Así quedó todo ahora, porque es lo que dice la regla de N/A ya acordada.
   - Si fuera el promedio simple de los 29, cambia el número en 118 de las 271 evaluaciones de la línea base y el nivel en 30.
   - **Recomiendo:** mantener el de dimensiones y desplegar `generar-diagnostico` cuando fusionemos.
2. **¿El "No aplica" debe exigir una justificación escrita?**
   - La regla 6 de la guía v1.1 la pide; la app no la exige.
   - **Recomiendo:** exigirla al enviar, no al marcar, para no frenar al técnico en la finca. No lo hice porque cambia el flujo acordado.
3. **Indicador 22: ¿hectáreas en pastoreo o hectáreas dedicadas a leche?**
   - La calculadora dice "hectáreas en pastoreo".
   - La guía dice "hectáreas dedicadas a la producción de leche (excluyendo potreros de cría…)".
   - **Recomiendo:** cambiar la etiqueta a lo que dice la guía. No lo hice porque cambia qué número anota el técnico.
4. **Indicador 25: ¿"más de 1,5 UGG/ha" debe seguir siendo el nivel 5?**
   - La misma guía dice que el óptimo es 1,1-1,5 y que 2,3-2,6 es insostenible.
   - Con la banda actual, una finca sobrecargada saca 5.
   - **Recomiendo:** dejarlo para la v2.0 de la matriz, como ya estaba previsto, pero avisarlo en el próximo comité.
5. **Indicadores 1, 9, 12 y 20: ¿qué nivel les toca a los valores que caen entre bandas?**
   - Los rangos tienen huecos (por ejemplo, 80-81 y 20-21 en el 1; 50 en el 9, el 12 y el 20).
   - **Recomiendo:** aplicar la regla 2 (nivel inferior) y escribirlo en la guía, como se hizo con el 25 y el 27.
6. **¿Desplegamos la función `generar-diagnostico` corregida?**
   - Mientras no, la IA compara contra la visita más reciente aunque sea posterior.
   - **Recomiendo:** desplegarla el mismo día que fusionemos la rama.

---

## 5. Qué probar en el celular antes de fusionar

**Paso 0 (para poder probar en una dirección real, sin tocar producción)**
1. En Vercel → proyecto `sostenibilidad-paramos` → Settings → Environment Variables, a `NEXT_PUBLIC_SUPABASE_URL` y `NEXT_PUBLIC_SUPABASE_ANON_KEY` márcales también **Preview** (hoy solo están en Production).
2. En Deployments, vuelve a desplegar el último de la rama `fable/diagnostico-2026-11`. Te da una dirección propia, distinta a la de producción.
3. Ojo: esa vista previa usa la misma base de Supabase que producción. Prueba con una evaluación marcada "de prueba" o con un productor de prueba.

**Paso 1 — Instalación sin señal (Android y, si se puede, iPhone)**
1. Abre la dirección de la vista previa con señal y entra con una cuenta técnica real (no "visitante").
2. Espera un minuto. En el menú → pie del inicio → "¿Algo no funciona? Ver diagnóstico", debe decir "9 de 9 guardadas", "código completo" y "copia de esta misma versión".
3. Pon el celular en modo avión. Abre: inicio, buscar, un productor con historial, "Iniciar calificación", el mapa y "Pendientes". Todas deben abrir.
4. Califica 3 indicadores, toma una foto, toca "Guardar y salir".
5. Quita el modo avión. El banner debe decir "Subiendo…" y luego desaparecer. Revisa en Supabase que llegaron las 3 respuestas.

**Paso 2 — Cálculos**
1. Indicador 28: escribe 20,5 meses. Debe sugerir nivel 1.
2. Indicador 27: deja vacías las muertes. No debe sugerir nada hasta escribir un número.
3. Termina y envía una evaluación de prueba. El puntaje global de la pantalla de resultados debe ser igual al del PDF del diagnóstico.

**Paso 3 — Lo nuevo**
1. En un productor con dos visitas: "Guardar o compartir el radar como imagen". Mira que se lea bien en WhatsApp. Si tienes un iPhone a mano, pruébalo también ahí: es el caso que no pude verificar.
2. "Nuevo productor": escribe coordenadas a mano y guarda.
3. En el historial de un productor de otro técnico no debe aparecer el bote de basura.

**Si todo sale bien:** fusiona la rama a `main` (eso publica en producción), despliega `generar-diagnostico` y corre la migración de abajo.

### Migración SQL pendiente (no la corrí)

`supabase/migrations/20261111_textos_niveles_guia_v11.sql`
- **Qué hace:** cambia solo los textos de los niveles de los indicadores 8, 21, 23, 24, 26 y 28 para que coincidan con la guía v1.1. No toca puntajes ni evaluaciones.
- **Por qué es segura:** cada texto solo cambia si en la base está exactamente el texto viejo. Se puede correr dos veces sin efecto.
- **Cómo correrla:** copia el archivo en Supabase → SQL Editor → Run. Al final muestra los textos nuevos para verificar.
- **Cuándo correrla:** después de fusionar.
