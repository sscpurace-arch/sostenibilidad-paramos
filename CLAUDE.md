# CLAUDE.md — Sostenibilidad Páramos · PNN Puracé

Archivo de instrucciones para agentes de IA (Antigravity, Claude Code, etc.).
Lee esto COMPLETO antes de tocar cualquier archivo.

---

## 1. Qué es este proyecto

Aplicación web **PWA offline-first** para que técnicos del PNN Puracé evalúen la sostenibilidad de fincas ganaderas en el Macizo Colombiano. Los técnicos visitan predios sin internet y registran 29 indicadores distribuidos en 3 dimensiones (Ambiental, Socioeconómica, Productiva). Los datos se sincronizan a Supabase cuando hay conexión.

**Stack:**
- Next.js 14 · App Router · JavaScript (no TypeScript en pages/components)
- Tailwind CSS 3 con paleta institucional PNN (ver `tailwind.config.js`)
- Supabase (auth + base de datos remota)
- Dexie.js v4 (IndexedDB — almacenamiento local offline)
- React Leaflet + Leaflet 1.9 (mapas)
- React ApexCharts / ApexCharts 5 (radar chart de sostenibilidad)
- Zod v4 (validación de formularios)
- next-pwa 5.6 (service worker)

**Producción:** Vercel. Variables de entorno en `.env.local` (nunca en código).

---

## 2. Arquitectura de carpetas

```
app/
  layout.js              ← Root layout: fuentes, metadata, initSyncEngine
  globals.css            ← Variables CSS, fuente Nunito, estilos globales
  sw.js                  ← Service worker (fuente de @serwist/next, compila a public/sw.js)
  ~offline/page.jsx      ← Fallback cuando una navegación no tiene ni red ni caché
  (app)/                 ← Rutas protegidas (requieren auth)
    layout.jsx           ← NavBar + OfflineBanner + UpdateBanner + TopographicBg + Watermark + calentarPantallas()
    error.jsx            ← Error boundary de toda la sección — sin esto, un fallo dejaba la pantalla en blanco
    page.jsx             ← Dashboard principal (métricas, últimas evaluaciones)
    buscar/page.jsx      ← Búsqueda de productores con debounce
    nuevo-productor/page.jsx ← Registro de nuevo productor
    en-proceso/page.jsx  ← Evaluaciones en curso / pendientes
    mapa/page.jsx        ← MultiMap con todos los productores
    mapa/detalle/page.jsx ← Mapa de un predio (query ?id=, NO ruta dinámica)
    calificacion/nueva/page.jsx ← Perfil del productor + arranque de evaluación (query ?productor=)
    calificacion/page.jsx ← Formulario de evaluación, 29 indicadores (query ?id=)
    diagnostico/page.jsx ← Pantalla de mantenimiento: prueba cada cambio atascado contra el servidor, fuerza actualización de versión (borra SW/caché, conserva IndexedDB). Enlazada desde el pie del inicio
    base-datos/page.jsx  ← Exportación de datos (XLSX dinámico)
  (auth)/
    login/page.jsx       ← Login con Supabase Auth
```

**IMPORTANTE: no hay rutas dinámicas (`[id]`, `[productorId]`) dentro de `(app)`.** Todo es ruta estática + query param, a propósito, para que el service worker pueda precachear un solo documento por pantalla y sirva para cualquier registro (ver sección 9). Nunca crear una carpeta `[algo]/page.jsx` ahí.

```
lib/
  db-offline.js          ← Esquema Dexie (versiones 3→10), DIMENSION_COLORS
  sync-engine.js         ← Motor offline-first: saveRecord, deleteRecord, syncQueue, initSyncEngine, retryFailed
  foto-sync.js           ← Canal SEPARADO para fotos de evidencia (Storage), no toca sync-engine.js
  foto-utils.js          ← Compresión de imágenes (canvas → JPEG ~200KB) y geolocalización
  data-prefetch.js       ← prepararOffline(), calentarPantallas() (precachea pantallas a mano)
  pdf-utils.js, pdf-diagnostico.js, pdf-plan-accion.js ← Generación de PDFs institucionales (jsPDF)
  supabase.js            ← createClient() para browser
  validation.js          ← crearSchemaEvaluacion() con Zod; validarEvidenciaFotografica() (regla del 2, actualmente NO llamada — ver sección 13)
  hooks/
    useFotos.js           ← Fotos de una evaluación (metadata + blobs + subida)
    useDiagnostico.js      ← Diagnóstico IA (Edge Function generar-diagnostico)
    usePlanAccion.js        ← Plan de acción SMART (Edge Function sugerir-plan-accion)
    useOfflineSync.js      ← Estado de la cola de sync para la UI
components/
  NavBar.jsx             ← Barra inferior fija con FAB central
  AppHeader.jsx          ← Header institucional con logos PNN
  OfflineBanner.jsx      ← Banner sticky de estado de sync (cambios pendientes/fallidos + motivo del error)
  UpdateBanner.jsx        ← Nueva versión: se activa sola al abrir la app; a mitad de sesión pregunta
  RadarChart.jsx         ← Radar ApexCharts (memo, dynamic import, SSR:false, error boundary propio)
  Map.jsx                ← Mapa individual (Leaflet, carga dinámica)
  MultiMap.jsx           ← Mapa multi-productor con leyenda de veredas
  IndicadorCard.jsx      ← Tarjeta de calificación (rango dinámico, calculadora, fotos, motivo_sin_foto)
  CalculadoraIndicador.jsx ← Calculadoras de los indicadores 22/25/27/28 (fórmula visible, guarda entradas)
  ConteoArboles.jsx      ← Indicador 8: sembrados vs. establecidos y vivos
  FotoEvidencia.jsx      ← Captura/galería de fotos por indicador
  PanoramicaCard.jsx     ← Foto panorámica del predio, al inicio del formulario
  EvaluacionHeader.jsx   ← Header sticky con progreso de evaluación
  EvaluacionFooter.jsx   ← Footer fijo con guardar/finalizar
  ResultadosEvaluacion.jsx ← Pantalla post-evaluación con diagnóstico IA (Gemini) y firma
  PlanAccionSMART.jsx    ← Plan de acción con IA, 5 indicadores priorizados
  FirmaModal.jsx         ← Captura de firma en canvas (técnico + productor)
  SostenibilidadPanel.jsx ← Panel radar comparativo en perfil del productor
  ProductorInfoCard.jsx  ← Card de datos del productor
  HistorialEvals.jsx     ← Lista de evaluaciones con borrado en 2 pasos (borra fotos en cascada)
  NuevaEvalForm.jsx      ← Form para iniciar nueva evaluación
  ValidationBanner.jsx   ← Banner de errores de validación (indicadores sin calificar + fotos faltantes)
  TopographicBg.jsx      ← SVG decorativo (líneas topográficas animadas)
  Watermark.jsx          ← Marca de agua con logo Puracé (opacity 0.03)
  icons/                 ← SVGs personalizados: IconInicio, IconBuscar, IconMapa, IconProceso, IconCalificar, IconNuevo
public/
  images/
    logo-purace.png
    logo-pnn-nacional.png
    marker-icon.png        ← Iconos Leaflet locales (offline)
    marker-icon-2x.png
    marker-shadow.png
  purace-boundary.json   ← GeoJSON del perímetro PNN Puracé (~1.2MB)
  docs/guia-calificacion-matriz.pdf ← Guía completa de calificación (23 pág.), descargable en campo
  icons/                 ← Iconos PWA (icon-192x192.png, icon-512x512.png)
```

---

## 3. Flujo de datos crítico (offline-first)

```
Usuario → componente
  → saveRecord(tabla, payload)   [lib/sync-engine.js]
    → db[tabla].put(record)      [IndexedDB / Dexie — NUNCA falla]
    → db.sync_queue.add(...)     [encola para sync]
    → syncQueue()                [si navigator.onLine]
      → supabase.from(tabla).upsert(...)
      → marca sync_pending=0
```

**Regla de oro:** NUNCA escribir directo a Supabase desde componentes. Siempre usar `saveRecord()` o `deleteRecord()` del sync-engine.

**Lectura:** leer primero de IndexedDB (`db.tabla.toArray()`), luego refrescar desde Supabase si hay conexión.

**Cómo funciona `_runSyncQueue` por dentro (crítico, no romper de nuevo):**
1. **Orden de tablas fijo**, no el orden en que Object.keys() los devuelva: `productores → evaluaciones → respuestas_indicadores/planes_accion/diagnosticos/fotos_evidencia`. Las tablas tienen dependencias (una respuesta no puede subir antes que su evaluación); recorrerlas en orden arbitrario causó rechazos permanentes por clave foránea. Los DELETE van en el orden inverso.
2. Si el `upsert` por lote falla, se **reintenta fila por fila**: las válidas suben, solo la culpable queda marcada con su error real en `ultimo_error`. Nunca reintroducir un upsert de lote sin ese camino de degradación — una sola fila mala bloqueaba cientos de cambios (ver `sync-cola-fila-invalida` en memoria de sesión).
3. **Cada fila tiene una sola oportunidad por corrida del `while`.** Subir el contador de reintentos sin marcarla de alguna forma (sincronizada o con contador incrementado) hace que el bucle la vuelva a tomar en la siguiente vuelta y no termine nunca — la interfaz queda girando y parpadeando. Hay además un tope duro de 50 vueltas como red de seguridad.
4. Registros con `es_prueba: true` **nunca** se encolan hacia Supabase — quedan solo en IndexedDB.

**Fotos: canal aparte, no tocar sync-engine.** `lib/foto-sync.js` sube a Supabase Storage (bucket `evidencias`) de forma completamente independiente: primero el blob a Storage, y solo si eso confirma OK se encola la metadata via `saveRecord('fotos_evidencia', ...)`. Nunca meter la subida de Storage dentro de `_runSyncQueue` — es otra API, sin batching, y debe ser secuencial.

---

## 4. Schema de base de datos (Supabase + Dexie)

### Tablas principales
| Tabla | Descripción |
|-------|-------------|
| `productores` | Ganaderos evaluados. Campos: id, cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng, nombre_tecnico, nombre_facilitador |
| `evaluaciones` | Cada visita de evaluación. Campos: id, finca_id (=productor_id), tecnico_id, fecha, estado, es_prueba |
| `respuestas_indicadores` | Calificaciones por indicador. Campos: id, evaluacion_id, indicador_id, valor (1-5), observacion, motivo_sin_foto, entradas (jsonb, datos crudos de las calculadoras) |
| `fotos_evidencia` | Fotos por indicador + panorámica del predio. Campos: id, evaluacion_id, indicador_id (null=panorámica), tipo, storage_path, lat/lng, tomada_en, tecnico_id. Binario en Storage (bucket `evidencias`, privado), no en Postgres |
| `indicadores` | Catálogo de 29 indicadores. Campos: id, nombre, descripcion, dimension, orden, rango_min, rango_max, pregunta_guia, niveles (jsonb), nota_criterio |
| `planes_accion` | Plan de acción SMART, sugerido por IA. Campos: id, evaluacion_id, indicador_id, especifico, medible, alcanzable, relevante, plazo |
| `usuarios` | Técnicos. Campos: id, nombre, email, rol (admin/tecnico/supervisor), activo |
| `sync_queue` | Cola offline interna de Dexie (NO existe en Supabase) |
| `diagnosticos` | Diagnósticos IA generados por Gemini (IndexedDB v6, cache offline) |

**RLS:** todas las tablas de trabajo filtran por `tecnico_id = auth.uid()` (directo o vía `evaluacion_id`), **más `OR public.es_admin()`** — función SECURITY DEFINER que valida `rol='admin' AND activo` en `usuarios` sin recursar sobre sus propias policies. El admin (hoy solo Santiago) puede leer/escribir cualquier registro; un técnico normal sigue sin poder tocar lo ajeno. La UI para que el admin busque y edite registros de otros técnicos **todavía no existe** — el permiso de base de datos sí.

### Dimensiones (constante, no tabla)
```js
// lib/db-offline.js
export const DIMENSION_COLORS = {
  'Ambiental': '#03A64A',
  'Socioeconómica': '#1565C0',
  'Productiva': '#E65100'
};
```

### 29 indicadores distribuidos en 3 dimensiones
- Ambiental: indicadores relacionados con uso del suelo, agua, biodiversidad, páramo
- Socioeconómica: indicadores de organización, mercado, ingresos, familia
- Productiva: indicadores de manejo ganadero, sanidad, genética, alimentación

---

## 5. Convenciones de código

### Componentes
- Todos los componentes son `'use client'` (App Router)
- Importar con alias `@/components/...` y `@/lib/...`
- No usar TypeScript en componentes — este proyecto usa JavaScript puro
- Leaflet y ApexCharts se importan con `dynamic(..., { ssr: false })` — NUNCA importar directamente en SSR

### Tailwind
- Usar clases de la paleta `pnn-` y `paramo-` definidas en `tailwind.config.js`
- Colores primarios: `#03A64A` (verde PNN), `#049DD9` (azul PNN)
- Fondo oscuro: `#0A2E1C` (paramo.deep), `#0D3B23` (paramo.dark)
- No usar colores hardcodeados salvo los que no están en Tailwind (ej. estilos inline en SVG)

### Paleta de colores institucional
```
Verde principal:    #03A64A  (pnn-verde)
Verde oscuro:       #028A3D  (pnn-verde-oscuro)
Azul PNN:           #049DD9  (pnn-azul)
Amarillo Colombia:  #FFC800  (acento-amarillo)
Rojo alerta:        #D80025  (acento-rojo)
Fondo oscuro:       #0A2E1C  (paramo-deep)
```

### Sync engine
```js
import { saveRecord, deleteRecord, syncQueue, initSyncEngine, subscribe } from '@/lib/sync-engine';

// Escribir:
await saveRecord('productores', { id, nombre_completo, vereda, ... });
await saveRecord('evaluaciones', { id, finca_id, tecnico_id, fecha, estado });
await saveRecord('respuestas_indicadores', { id, evaluacion_id, indicador_id, valor });

// Eliminar:
await deleteRecord('evaluaciones', evaluacionId);
await deleteRecordBulk('respuestas_indicadores', [id1, id2, ...]);
```

### Dexie (lectura offline)
```js
import { db } from '@/lib/db-offline';

// Leer todo:
const productores = await db.productores.toArray();

// Filtrar:
const evals = await db.evaluaciones.where('finca_id').equals(productorId).toArray();

// Buscar por índice:
const respuestas = await db.respuestas_indicadores
  .where('evaluacion_id').equals(evalId).toArray();
```

---

## 6. Autenticación

- Supabase Auth con email/password
- `createClient()` de `lib/supabase.js` para browser
- El técnico autenticado se obtiene con: `const { data: { user } } = await supabase.auth.getUser()`
- El `user.id` es el `tecnico_id` en evaluaciones
- Row Level Security activo en Supabase — técnicos solo ven sus propias evaluaciones

---

## 7. Mapa / coordenadas

- Coordenadas en formato decimal (lat/lng), zona Puracé: lat ~2.2–2.5, lng ~-76.2 a -76.6
- Default center: `[2.342, -76.385]` (área Puracé)
- Iconos Leaflet locales en `public/images/` (marker-icon.png, marker-icon-2x.png, marker-shadow.png)
- GeoJSON del perímetro: `public/purace-boundary.json` — se fetcha con `fetch('/purace-boundary.json')`
- Mapas son `dynamic(() => import('@/components/Map'), { ssr: false })`

---

## 8. RadarChart — notas importantes

- Usa `react-apexcharts` con `dynamic(..., { ssr: false })`
- Labels del eje X son números cortos (1, 2, 3...) — los nombres completos van en la leyenda debajo
- `yaxis.max: 5` — los indicadores van de 1 a 5
- El componente está memoizado (`memo`) — no pasar funciones anónimas como props
- Colores por serie: `['#03A64A', '#1976D2', '#F57C00', '#7B1FA2']`

---

## 9. PWA / Service Worker

- `serwist` genera el service worker automáticamente en build (no `next-pwa` — corregido 2026-07-23, ver `package.json`)
- Manifest en `public/manifest.json`
- Iconos requeridos: `public/icons/icon-192x192.png` y `public/icons/icon-512x512.png`
- El GeoJSON de Puracé debe estar en cache offline (ver QA-05 completado)
- Datos cacheados por el SW con estrategia StaleWhileRevalidate — si cambias `public/seed-data.json`, cambiar `SEED_VERSION` en `lib/sync-engine.js` para forzar recarga fresh (`cache:'no-store'` + `?v=SEED_VERSION`), y hacer commit + push del seed-data (Vercel sirve el viejo si no se pushea)
- **`fetch(ruta)` NO llena el caché de navegación.** El SW (`app/sw.js`) solo escribe en `paginas-html`/`rsc-paginas` las respuestas de peticiones con `request.mode === 'navigate'`; un `fetch()` normal no lo es. Para precachear una pantalla a mano hay que hacer `caches.open(nombreDelCache).put(ruta, respuesta)` explícitamente — es lo que hace `calentarPantallas()` en `lib/data-prefetch.js`. Se ejecuta al abrir la app con señal, no solo al tocar "Preparar sin conexión" (con señal intermitente, lo normal en el páramo, no hay que esperar a ese paso).
- **La versión en espera se activa sola al abrir la app** (único momento seguro: aún no hay nada a medio llenar). A mitad de sesión, `UpdateBanner.jsx` sigue preguntando en vez de recargar solo, para no cambiar el código bajo un formulario abierto.
- **`app/~offline/page.jsx`** es el fallback cuando una navegación no tiene ni red ni caché. Su botón "Reintentar" debe hacer `location.reload()` (reintenta ESA pantalla), nunca `router.push('/')` — si no, abrir cualquier pantalla nueva con señal débil parece que la app "se devuelve sola al inicio".
- **`/diagnostico`**: pantalla de mantenimiento, enlazada desde el pie del inicio. Muestra versión instalada, cambios pendientes, y un botón que prueba cada fila atascada de `sync_queue` contra Supabase directamente (trae el error real). "Forzar actualización" desregistra el SW y borra los cachés de `caches.keys()`, pero **nunca** toca IndexedDB.

---

## 10. Variables de entorno requeridas

```bash
NEXT_PUBLIC_SUPABASE_URL=https://xxx.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJ...
# Para diagnóstico IA (opcional):
GEMINI_API_KEY=AIza...
```

Nunca hardcodear estas variables. Nunca loguear su valor.

---

## 11. Comandos

```bash
npm run dev       # Desarrollo local (http://localhost:3000)
npm run build     # Build de producción
npm run start     # Iniciar servidor de producción
npm run lint      # ESLint
```

---

## 12. Instrucciones para agentes múltiples

### Agente Arquitecto
- Revisa coherencia entre `lib/db-offline.js` (schema Dexie) y el schema de Supabase
- Valida que `sync-engine.js` use las tablas correctas
- Detecta imports rotos o componentes no exportados

### Agente Frontend
- Sigue la paleta Tailwind de `tailwind.config.js` estrictamente
- No crear nuevos archivos CSS — usar clases Tailwind o `globals.css`
- Todos los mapas y gráficas: importar dinámicamente con `ssr: false`
- Mobile-first: la app es para técnicos con celulares Android

### Agente de Datos
- Al agregar indicadores: actualizar solo Supabase (tabla `indicadores`) — Dexie sincroniza automáticamente
- El catálogo de indicadores se descarga en `syncInitialData()` — no duplicar lógica
- Respetar el orden (`orden`) y dimensión (`dimension`) de cada indicador

### Agente de Testing / QA
- Verificar flujo offline: registrar productor → apagar red → calificar → encender red → verificar sync
- Los errores de sync quedan en `sync_queue` con `error_count` — máximo 5 reintentos
- Revisar que `OfflineBanner` muestre estado correcto en cada escenario

### Reglas generales para todos los agentes
1. **No modificar** `lib/sync-engine.js` sin entender el flujo completo offline-first — especialmente el orden de tablas y la degradación fila a fila (sección 3). Si se necesita subir binarios (fotos, PDFs), va en un canal aparte como `lib/foto-sync.js`, no dentro de `_runSyncQueue`.
2. **No importar** Leaflet, ApexCharts o jsPDF directamente en un componente que renderiza en servidor — siempre `dynamic(..., { ssr: false })`
3. **No hardcodear** correos, contraseñas, ni URLs de Supabase
4. **No agregar** `console.log` en producción — usar el logger condicional si existe
5. **Respetar** las versiones de Dexie: si se agrega una tabla nueva, crear versión `db.version(11)...` (la última usada es 10, `fotos_evidencia`/`fotos_blobs`)
6. **Preservar** todos los cambios previos al editar un archivo — este proyecto acumula decenas de correcciones aplicadas en producción real
7. **Nunca crear una ruta dinámica** (`[id]`, `[algo]`) dentro de `app/(app)/`. Todo es ruta estática + query param — ver sección 2
8. **Validar siempre en Vercel (producción), nunca en localhost.** Santiago prueba en la URL real; si algo "no funciona" para él, es ahí. `npm run build` corrompe `.next` si se corre con `npm run dev` activo al mismo tiempo — apagar el dev server primero

---

## 13. Estado actual del proyecto (act. 2026-09-08)

### Funcionando ✅
- Auth con Supabase (email/password + Google), RLS activo, admin puede escribir cualquier registro (`es_admin()`)
- Sync offline-first (IndexedDB → Supabase) con cola de reintentos: orden de tablas por dependencias, degradación fila a fila, un intento por corrida, motivo de error visible en `OfflineBanner`
- **Registro fotográfico** por indicador + panorámica del predio → Supabase Storage (`lib/foto-sync.js`, canal propio)
- **Calculadoras** para los indicadores 22 (litros leche/ha/año), 25 (carga animal UGG/ha), 27 (mortalidad), 28 (intervalo entre partos) — fórmula visible, guardan las entradas crudas
- **Indicador 8** distingue árboles sembrados de establecidos y vivos (`ConteoArboles.jsx`)
- Guía completa de calificación descargable, 23 páginas, generada por `scripts/generar-guia-pdf.mjs`
- Mapa con perímetro GeoJSON del PNN Puracé + localización GPS
- RadarChart con comparación multi-evaluación, con error boundary propio (una librería de gráficas rota no debe tumbar la pantalla de resultados)
- Diagnóstico IA con Gemini 2.5 y plan de acción SMART con IA (Edge Functions `generar-diagnostico`, `sugerir-plan-accion`, ambas ACTIVE)
- Firma digital (técnico + productor) en canvas
- PWA instalable en Android e iPhone; la versión nueva se activa sola al abrir la app
- **`/diagnostico`**: pantalla de autoservicio para cuando algo falla en campo (ver sección 9)
- Panel de administración (`/admin`) — lista de usuarios + stats
- Notificaciones Telegram al completar sync (`/api/notificar`)
- En producción en Vercel (deploy automático desde rama `main`)
- URL prod: https://sostenibilidad-paramos.vercel.app

### Pendiente / advertencias ⚠️
- 🔴 **La "regla del 2" (bloqueo de envío si un indicador ≤2 no tiene foto) está DESACTIVADA** desde el taller de campo del 7-sep-2026 (commit `7fd4ffa`). El código completo sigue en `lib/validation.js` (`validarEvidenciaFotografica`) — solo dejó de llamarse desde `calificacion/page.jsx`. Falta decidir con Santiago si se reactiva y con qué ajuste (probable relación con la falta de "N/A": ver el punto de abajo).
- 🟡 **No existe casilla de "no aplica" (N/A)** para indicadores que no corresponden al sistema productivo del predio (ej. leche en un predio de ceba). Se fuerza a calificar 1-5 igual. Decisión metodológica pendiente antes de codificar — un N/A no puede valer 0 ni 1, debe excluirse del denominador del promedio.
- 🟡 UI de edición para que el admin toque registros de otros técnicos: el permiso de base de datos existe, la pantalla no.
- 🟡 Divergencia de nomenclatura: los materiales de taller hablan de 4 dimensiones (separando Socioambiental de Ambiental); la app y Supabase manejan 3. Mismos 29 indicadores, mismo orden — cambia solo el agrupamiento del promedio.
- 🔴 **Validar siempre en Vercel, no en localhost.** Santiago prueba en la URL real — si dice "no funciona", es la URL de producción. Pedirle que cierre/reabra la app o, si sigue mal, mandarlo a `/diagnostico`.
- `GEMINI_API_KEY` **no está en `.env.local`** — el diagnóstico IA corre en modo mock si se prueba en local. Agregar la clave real si se necesita IA en local.
- Sector Sur (Valencia, San Sebastián) de productores aún sin caracterizar territorialmente.

---

## 14. Conexión Supabase

`.env.local` configurado correctamente con las variables del proyecto `vxtzvadknxmstdcwfwhb`:

```bash
NEXT_PUBLIC_SUPABASE_URL=https://vxtzvadknxmstdcwfwhb.supabase.co   # ✅
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJ...                                  # ✅
TELEGRAM_BOT_TOKEN=8699567333:...                                      # ✅
TELEGRAM_CHAT_ID=1494480340                                            # ✅
```

El proyecto está enlazado en `supabase/.temp/linked-project.json` (ref: `vxtzvadknxmstdcwfwhb`, nombre: "Matriz de sostenibilidad").

**Edge Function de IA:** `supabase/functions/generar-diagnostico/index.ts` — se despliega separado con CLI de Supabase (`supabase functions deploy generar-diagnostico`).

---

## 15. Conexión Vercel

- Deploy automático desde rama `main` en GitHub.
- No hay `vercel.json` local — Vercel detecta Next.js automáticamente.
- Variables de entorno de producción deben estar configuradas en el dashboard de Vercel (incluyendo `GEMINI_API_KEY` si se activa IA en producción).

---

## 16. Cómo arrancar en Windows (computador nuevo)

```powershell
# node_modules ya instalado — NO se necesita npm install si el repo se clonó correctamente
cd "C:\Users\DIEGO\Documents\SSC PURACE\APP sostenibilidad-paramos"
npm run dev
# → http://localhost:3000
```

Si el `node_modules` no existe (clon limpio):
```powershell
npm install
npm run dev
```

**Verificar antes de arrancar:**
1. `.env.local` existe en la raíz (no en subcarpeta)
2. Contiene `NEXT_PUBLIC_SUPABASE_URL` y `NEXT_PUBLIC_SUPABASE_ANON_KEY`
3. Si necesitas IA local: agregar `GEMINI_API_KEY`

El PWA/service worker solo se activa en `npm run build && npm run start` (producción). En `npm run dev` el service worker está deshabilitado intencionalmente.
