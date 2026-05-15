# GUÍA COMPLETA — Antigravity con MCP de Supabase
## Versión actualizada: sin trabajo manual en Supabase, con importación de 140 productores

---

## LO QUE TIENES DISPONIBLE
- ✅ Google Antigravity instalado
- ✅ MCP de Supabase conectado en Antigravity
- ✅ MCP de Vercel conectado en Antigravity
- ✅ Proyecto Supabase ya creado (con URL y ANON KEY)
- ✅ Archivos SQL listos (los que acabas de descargar)
- ✅ 140 productores con sus 29 indicadores listos para importar

---

## PASO PREVIO — Crear el archivo .env.local y las reglas

**Antes de cualquier misión**, en la carpeta `sostenibilidad-paramos` crea dos archivos manualmente:

### Archivo 1: `.env.local`
```
NEXT_PUBLIC_SUPABASE_URL=https://tu-proyecto.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=tu-clave-anon-aqui
```

### Archivo 2: `.antigravity/rules.md`
```markdown
# Reglas del proyecto Sostenibilidad Páramos

## Stack
- Next.js 14 con App Router
- Tailwind CSS mobile-first (pantalla mínima 375px)
- Supabase para auth y base de datos
- Dexie.js para IndexedDB (offline-first)
- react-chartjs-2 + chart.js para gráficas radar

## Reglas de código
- Todo el texto de la UI en español
- Offline-first: escribir primero en IndexedDB, sincronizar con Supabase
- Cada registro guarda: usuario_id + timestamp
- Botones mínimo 48px de alto, mobile-first
- No usar etiqueta <form> HTML — usar onClick/onChange de React
- Escala de calificación: 1 a 5 (enteros)

## Tablas Supabase
- usuarios, productores, dimensiones, indicadores (29, IDs 1-29), calificaciones, calificacion_detalle

## Colores
- Verde: #2E7D32 | Azul: #1565C0 | Naranja: #E65100 | Fondo: #F5F5F5
```

---

## MISIÓN 0-A — Crear el schema en Supabase (vía MCP)

**Pega esto en el Agent Manager:**

```
Usando el MCP de Supabase disponible, ejecuta el siguiente SQL en mi proyecto de Supabase para crear todas las tablas, insertar los 29 indicadores y configurar Row Level Security.

[PEGA AQUÍ TODO EL CONTENIDO DEL ARCHIVO: 01_schema_supabase.sql]

Cuando termines, confirma que se crearon estas tablas: usuarios, productores, dimensiones, indicadores, calificaciones, calificacion_detalle.
Verifica que la consulta de verificación al final muestre: Ambiental=12, Socioeconómica=8, Productiva=9.
```

**Qué hace el agente:** Usa el MCP de Supabase para ejecutar todo el SQL directamente. No tienes que entrar a supabase.com.

**Cuando responda bien:** Pasa a la Misión 0-B.

**Si hay error:** Dile → `Hubo un error: [copia el error]. Corrígelo y ejecuta de nuevo.`

---

## MISIÓN 0-B — Crear el primer usuario en Supabase

```
Usando el MCP de Supabase, crea un usuario en Supabase Auth con estos datos:
- Email: [tu email del equipo PNN]
- Password: [tu contraseña]
- Rol: evaluador

Luego inserta ese usuario también en la tabla "usuarios" con:
- id: el mismo UUID que asignó Supabase Auth
- nombre: [tu nombre]
- email: [tu email]
- rol: 'evaluador'
- activo: true
```

---

## MISIÓN 0-C — Importar los 140 productores e histórico de calificaciones

```
Usando el MCP de Supabase, ejecuta el siguiente SQL para importar 140 productores con su información básica y sus 4.060 registros de calificación histórica (29 indicadores por productor, estado='completada').

[PEGA AQUÍ TODO EL CONTENIDO DEL ARCHIVO: 02_import_datos_historicos.sql]

IMPORTANTE: Si el SQL es muy largo para pegarlo completo, divídelo en dos partes:
- Parte 1: todos los INSERT INTO productores
- Parte 2: todos los INSERT INTO calificaciones y calificacion_detalle

Cuando termines, ejecuta estas consultas de verificación:
SELECT COUNT(*) FROM productores;         -- debe dar 140
SELECT COUNT(*) FROM calificaciones;      -- debe dar 140
SELECT COUNT(*) FROM calificacion_detalle; -- debe dar 4060
```

**Qué pasa si el SQL es demasiado largo para el MCP:**
Dile al agente: `El SQL es muy largo. Lee el archivo 02_import_datos_historicos.sql desde el disco y ejecútalo en partes de 50 productores a la vez usando el MCP de Supabase.`

---

## MISIÓN 1 — Crear estructura base Next.js

```
Crea un proyecto Next.js 14 completo en la carpeta actual.

1. Ejecuta: npx create-next-app@latest . --no-typescript --tailwind --app --no-src-dir --no-git
   Si pregunta algo interactivo, responde No a todo excepto Tailwind.

2. Instala dependencias:
   npm install @supabase/supabase-js @supabase/ssr dexie react-chartjs-2 chart.js next-pwa

3. Configura next.config.js con next-pwa (disable en development)

4. Crea public/manifest.json para PWA:
   name: "Sostenibilidad Páramos", short_name: "Páramos",
   theme_color: "#2E7D32", display: "standalone", start_url: "/"

5. Crea esta estructura de archivos con esqueleto básico en cada uno:
   app/(auth)/login/page.jsx
   app/(app)/layout.jsx
   app/(app)/page.jsx
   app/(app)/buscar/page.jsx
   app/(app)/nuevo-productor/page.jsx
   app/(app)/calificacion/nueva/[productorId]/page.jsx
   app/(app)/calificacion/[id]/page.jsx
   app/(app)/en-proceso/page.jsx
   components/NavBar.jsx
   components/RadarChart.jsx
   components/IndicadorCard.jsx
   components/OfflineBanner.jsx
   lib/supabase.js
   lib/db-offline.js
   lib/sync.js

Dime qué archivos creaste y si hubo algún error.
```

**Cuando termine bien → pregúntale:**
```
Abre el navegador, ve a localhost:3000 y confirma que la app base carga sin errores.
```

---

## MISIÓN 2 — Autenticación con Supabase

```
Implementa autenticación completa con Supabase Auth. Las credenciales están en .env.local.

1. lib/supabase.js: cliente Supabase con createBrowserClient de @supabase/ssr

2. middleware.js en raíz: proteger rutas /app/**, redirigir a /login si no hay sesión

3. app/(auth)/login/page.jsx:
   - Título "PNN Puracé" + subtítulo "Sostenibilidad Páramos"
   - Ícono circular verde con letra P
   - Campos: Email y Contraseña
   - Botón "Ingresar" color #2E7D32
   - Error en español si falla
   - Al éxito: redirigir a /
   - Mobile-first, fondo #E8F5E9
   - Sin etiqueta <form>, usar onClick async/await

4. app/(app)/layout.jsx: incluir componente NavBar (texto temporal por ahora)

Prueba en localhost:3000 que el login funciona con el usuario creado en Supabase.
```

---

## MISIÓN 3 — Offline con Dexie

```
Implementa almacenamiento offline con IndexedDB.

1. lib/db-offline.js — base de datos Dexie "SostenibilidadParamos":
   stores: productores "id, cedula, nombre_completo", dimensiones "id",
   indicadores "id, dimension_id", calificaciones "id, productor_id, usuario_id, estado",
   calificacion_detalle "id, calificacion_id, indicador_id",
   sync_queue "++localId, tabla, operacion, sincronizado, timestamp"

2. lib/sync.js — exportar 4 funciones:
   
   inicializarDatosLocales(supabase):
   - Solo si navigator.onLine
   - Descargar dimensiones, indicadores, productores de Supabase
   - Guardar con db.[tabla].bulkPut()
   
   agregarACola(tabla, operacion, payload):
   - Guardar en sync_queue con sincronizado:false
   
   procesarCola(supabase):
   - Items con sincronizado===false → upsert en Supabase
   - Si éxito: marcar sincronizado:true
   - Retornar {exito: N, pendientes: M}
   
   configurarSincronizacionAutomatica(supabase):
   - window.addEventListener('online') → llamar procesarCola()
   - Retornar función cleanup

3. components/OfflineBanner.jsx:
   - Escuchar 'online'/'offline'
   - Si offline: barra roja "📡 Sin conexión — se sincronizará al recuperar señal"
   - Si online: no mostrar nada
```

---

## MISIÓN 4 — Buscar productor

```
Implementa app/(app)/buscar/page.jsx:

Al cargar:
- Llamar inicializarDatosLocales() para sincronizar
- Cargar todos los productores desde IndexedDB

Input de búsqueda:
- Filtrar en tiempo real por nombre_completo O cedula (insensible a mayúsculas)
- Sin botón, filtrar con onChange

Cada resultado muestra:
- Nombre completo (bold), Cédula, Predio | Vereda | Municipio
- Al tocar → navega a /calificacion/nueva/[id]

Sin resultados: "No encontrado. ¿Registrar nuevo?" + botón a /nuevo-productor

Botón flotante "+" abajo derecha (#2E7D32) → /nuevo-productor

Diseño mobile-first, items mínimo 60px de alto.
```

---

## MISIÓN 5 — Nuevo productor

```
Implementa app/(app)/nuevo-productor/page.jsx:

Campos del formulario:
- Cédula * (number, único — verificar en IndexedDB)
- Nombre completo *
- Nombre del predio
- Vereda
- Municipio (select: Popayán, Puracé, Totoró, Sotará, La Sierra, Otro)
- Nombre técnico
- Nombre facilitador
- Botón "Obtener ubicación GPS" → navigator.geolocation → mostrar lat/lng

Al guardar:
a) Validar cédula y nombre
b) Verificar que la cédula no exista en db.productores
c) id = crypto.randomUUID()
d) created_by = id del usuario activo de Supabase
e) Guardar en db.productores.add()
f) agregarACola('productores', 'INSERT', productor)
g) Si online: procesarCola()
h) Éxito: "Registrado" + botones "Evaluar ahora" y "Registrar otro"

Header con "← Volver" a /buscar. Campos en tarjeta blanca, botón guardar verde.
```

---

## MISIÓN 6 — Perfil + inicio de calificación + RadarChart

```
Implementa app/(app)/calificacion/nueva/[productorId]/page.jsx:

Al cargar:
- Cargar productor desde IndexedDB por productorId
- Buscar última calificación completada del productor
- Si existe: cargar su calificacion_detalle completo

Mostrar:
A) Ficha: nombre (H1), predio|vereda|municipio, cédula, técnico|facilitador
B) Histórico: si existe calificación anterior → "Última evaluación: [fecha]" + RadarChart
   Si no existe → "Primera evaluación de este productor ⭐"
C) Botón grande verde "Iniciar nueva calificación"

Al presionar el botón:
- Crear calificacion: {id: crypto.randomUUID(), productor_id, usuario_id, estado:'en_proceso', fecha_inicio: now()}
- Guardar en db.calificaciones + agregarACola + procesarCola si online
- Navegar a /calificacion/[nuevo_id]

Componente components/RadarChart.jsx:
- Props: datosAnteriores (array 29 nums), indicadores (array de objetos)
- react-chartjs-2 tipo Radar, registrar módulos necesarios
- Labels: primeras 25 letras del nombre de cada indicador
- Serie anterior: rgba(100,100,100,0.4) gris
- Serie actual (si existe): rgba(46,125,50,0.5) verde
- Escala 0 a 5, responsivo 100% de ancho
```

---

## MISIÓN 7 — Los 29 indicadores (la más importante)

```
Implementa app/(app)/calificacion/[id]/page.jsx:

Al cargar:
- Cargar calificación por id desde IndexedDB
- Si no existe → redirigir a /
- Cargar productor, todos los indicadores (orderBy orden), todas las dimensiones
- Cargar puntajes guardados en calificacion_detalle para esta calificación
- Estado local: objeto { [indicador_id]: { puntaje, observacion } }

Header sticky:
- Nombre del productor
- Barra de progreso: X/29 con barra visual

Indicadores agrupados por dimensión:
- Encabezado de grupo con color (verde/azul/naranja) y nombre
- Por indicador: número + nombre (bold), descripción colapsable
- 5 botones circulares 44x44px con 1,2,3,4,5
  * Sin puntaje: gris | Con puntaje: color de la dimensión
- Campo observación (textarea) aparece solo cuando hay puntaje seleccionado

Al seleccionar puntaje:
- Actualizar estado local inmediatamente
- db.calificacion_detalle.put({id: existing o nuevo UUID, calificacion_id, indicador_id, puntaje, updated_at})
- agregarACola('calificacion_detalle', 'INSERT', detalle)

Footer sticky dos botones:
- "Guardar y continuar después" (gris) → guardar updated_at → navegar a /
- "Finalizar evaluación" (verde) → solo activo si hay ≥1 calificado
  Al finalizar:
  * estado='completada', fecha_fin=now() en IndexedDB
  * agregarACola('calificaciones', 'UPDATE', calificacion)
  * Mostrar pantalla de resultados

Pantalla resultados (modal pantalla completa):
- "Evaluación completada ✓"
- Nombre del productor + fecha
- RadarChart con DOS series: anterior (gris) + actual (verde)
- Promedio general: "X.X / 5"
- Promedio por dimensión
- Botón "Volver al inicio" → /
```

---

## MISIÓN 8 — Calificaciones en proceso

```
Implementa app/(app)/en-proceso/page.jsx:

Al cargar:
- Cargar calificaciones con estado='en_proceso' del usuario activo desde IndexedDB
- Para cada una: obtener productor + contar indicadores calificados

Cada tarjeta muestra:
- Nombre productor (bold), vereda - municipio
- Fecha inicio formateada
- "X / 29 indicadores" con mini barra
- Botón "Continuar →" verde → /calificacion/[id]

Ordenar por updated_at desc. Si vacío: "No hay evaluaciones en proceso" + botón a /buscar
```

---

## MISIÓN 9 — Dashboard y NavBar

```
1. app/(app)/layout.jsx:
   - OfflineBanner arriba
   - Al montar: inicializarDatosLocales() + configurarSincronizacionAutomatica()
   - NavBar abajo

2. components/NavBar.jsx — barra inferior fija:
   - 🏠 Inicio → /
   - 🔍 Buscar → /buscar
   - ⏳ En proceso → /en-proceso
   - ➕ Nuevo → /nuevo-productor
   - usePathname() para resaltar el activo (color #2E7D32)
   - Fondo blanco, sombra arriba, fixed bottom-0

3. app/(app)/page.jsx:
   - "Hola, [nombre del usuario]"
   - 3 tarjetas: total productores | en proceso | completadas esta semana
   - Botón grande verde "Evaluar un productor →" → /buscar
   - Últimas 3 calificaciones en proceso (acceso rápido)

Prueba navegación completa en el navegador.
```

---

## MISIÓN 10 — Deploy en Vercel vía MCP

```
Prepara y despliega la aplicación.

1. Crea .gitignore: node_modules, .next, .env.local

2. Inicializa git y sube a GitHub:
   git init
   git add .
   git commit -m "feat: app sostenibilidad paramos PNN Purace v1.0"
   git branch -M main
   git remote add origin https://github.com/[TU-USUARIO]/sostenibilidad-paramos.git
   git push -u origin main

3. Usando el MCP de Vercel:
   - Importar repositorio sostenibilidad-paramos de GitHub
   - Framework: Next.js
   - Variables de entorno:
     NEXT_PUBLIC_SUPABASE_URL = [valor de .env.local]
     NEXT_PUBLIC_SUPABASE_ANON_KEY = [valor de .env.local]
   - Iniciar deploy
   - Retornar la URL de producción

4. Abre la URL en el celular y verifica que carga el login.
```

---

## ORDEN COMPLETO DE EJECUCIÓN

```
PREPARACIÓN (tú, 5 min)
  └── Crear .env.local y .antigravity/rules.md

MISIÓN 0-A → Crear schema en Supabase vía MCP
MISIÓN 0-B → Crear usuario en Supabase Auth vía MCP
MISIÓN 0-C → Importar 140 productores + 4.060 calificaciones vía MCP

MISIÓN 1  → Estructura Next.js base
MISIÓN 2  → Autenticación
MISIÓN 3  → Offline con Dexie
MISIÓN 4  → Buscar productor
MISIÓN 5  → Nuevo productor
MISIÓN 6  → Perfil + RadarChart
MISIÓN 7  → Los 29 indicadores ← más larga (~20 min)
MISIÓN 8  → Calificaciones en proceso
MISIÓN 9  → Dashboard + NavBar
MISIÓN 10 → Deploy en Vercel
```

---

## MANEJO DE ERRORES

**El agente ejecuta algo y falla:**
→ `Hay este error: [copia el mensaje]. Corrígelo.`

**El agente se queda pensando +5 minutos:**
→ Clic en Stop → luego: `¿En qué punto quedaste? Continuemos.`

**Pantalla en blanco en el navegador:**
→ `Hay pantalla en blanco. Abre la consola del navegador (F12) y dime los errores que aparecen.`

**El MCP de Supabase falla con el SQL largo:**
→ `El SQL es muy largo para el MCP. Divídelo en partes de 30 registros a la vez y ejecuta cada parte.`

**Cualquier comando en terminal:**
→ Siempre aprueba. Clic en Allow/Aprobar.
