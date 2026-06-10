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
  (app)/                 ← Rutas protegidas (requieren auth)
    layout.jsx           ← NavBar + OfflineBanner + TopographicBg + Watermark
    page.jsx             ← Dashboard principal (métricas, últimas evaluaciones)
    buscar/page.jsx      ← Búsqueda de productores con debounce
    nuevo-productor/page.jsx ← Registro de nuevo productor
    en-proceso/page.jsx  ← Evaluaciones en curso / pendientes
    mapa/page.jsx        ← MultiMap con todos los productores
    mapa/[id]/page.jsx   ← Mapa individual de un predio
    calificacion/nueva/[productorId]/page.jsx ← Formulario de evaluación (29 indicadores)
    calificacion/[id]/page.jsx ← Detalle de evaluación existente
    base-datos/page.jsx  ← Exportación de datos (XLSX dinámico)
  (auth)/
    login/page.jsx       ← Login con Supabase Auth
lib/
  db-offline.js          ← Esquema Dexie (versiones 3→6), DIMENSION_COLORS
  sync-engine.js         ← Motor offline-first: saveRecord, deleteRecord, syncQueue, initSyncEngine
  supabase.js            ← createClient() para browser
  validation.js          ← crearSchemaEvaluacion() con Zod
components/
  NavBar.jsx             ← Barra inferior fija con FAB central
  AppHeader.jsx          ← Header institucional con logos PNN
  OfflineBanner.jsx      ← Banner sticky de estado de sync
  RadarChart.jsx         ← Radar ApexCharts (memo, dynamic import, SSR:false)
  Map.jsx                ← Mapa individual (Leaflet, carga dinámica)
  MultiMap.jsx           ← Mapa multi-productor con leyenda de veredas
  IndicadorCard.jsx      ← Tarjeta de calificación por indicador (rango dinámico)
  EvaluacionHeader.jsx   ← Header sticky con progreso de evaluación
  EvaluacionFooter.jsx   ← Footer fijo con guardar/finalizar
  ResultadosEvaluacion.jsx ← Pantalla post-evaluación con diagnóstico IA (Gemini)
  SostenibilidadPanel.jsx ← Panel radar comparativo en perfil del productor
  ProductorInfoCard.jsx  ← Card de datos del productor
  HistorialEvals.jsx     ← Lista de evaluaciones con borrado en 2 pasos
  NuevaEvalForm.jsx      ← Form para iniciar nueva evaluación
  ValidationBanner.jsx   ← Banner de errores de validación
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

---

## 4. Schema de base de datos (Supabase + Dexie)

### Tablas principales
| Tabla | Descripción |
|-------|-------------|
| `productores` | Ganaderos evaluados. Campos: id, cedula, nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat, ubicacion_lng |
| `evaluaciones` | Cada visita de evaluación. Campos: id, finca_id (=productor_id), tecnico_id, fecha, estado, es_prueba |
| `respuestas_indicadores` | Calificaciones por indicador. Campos: id, evaluacion_id, indicador_id, valor (1-5), observacion |
| `indicadores` | Catálogo de 29 indicadores. Campos: id, nombre, descripcion, dimension, orden, rango_min, rango_max |
| `usuarios` | Técnicos. Campos: id, nombre, email, rol, activo |
| `sync_queue` | Cola offline interna de Dexie (NO existe en Supabase) |
| `diagnosticos` | Diagnósticos IA generados por Gemini (IndexedDB v6, cache offline) |

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

- `next-pwa` genera el service worker automáticamente en build
- Manifest en `public/manifest.json`
- Iconos requeridos: `public/icons/icon-192x192.png` y `public/icons/icon-512x512.png`
- El GeoJSON de Puracé debe estar en cache offline (ver QA-05 completado)

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
1. **No modificar** `lib/sync-engine.js` sin entender el flujo completo offline-first
2. **No importar** Leaflet o ApexCharts directamente — siempre `dynamic(..., { ssr: false })`
3. **No hardcodear** correos, contraseñas, ni URLs de Supabase
4. **No agregar** `console.log` en producción — usar el logger condicional si existe
5. **Respetar** las versiones de Dexie: si se agrega una tabla nueva, crear versión `db.version(7)...`
6. **Preservar** todos los cambios previos al editar un archivo — este proyecto tiene 24 correcciones aplicadas

---

## 13. Estado actual del proyecto

### Funcionando ✅
- Todas las 24 correcciones de la auditoría técnica aplicadas (ver `task.md`)
- Auth con Supabase (email/password), RLS activo
- Sync offline-first (IndexedDB → Supabase) con cola de reintentos
- Mapa con perímetro GeoJSON del PNN Puracé + localización GPS
- RadarChart con comparación multi-evaluación
- Diagnóstico IA con Gemini 2.5 (con cache offline en IndexedDB)
- PWA instalable en Android (iconos correctos, service worker)
- Panel de administración (`/admin`) — lista de usuarios + stats
- Notificaciones Telegram al completar sync (`/api/notificar`)
- En producción en Vercel (deploy automático desde rama `main`)

### Pendiente / advertencias ⚠️
- `GEMINI_API_KEY` **no está en `.env.local`** — el diagnóstico IA corre en modo mock. Agregar la clave real si se necesita IA en local.
- El `.env.local` actual NO tiene `GEMINI_API_KEY`. Agregar así:
  ```
  GEMINI_API_KEY=AIza...tu_clave_aquí
  ```
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
