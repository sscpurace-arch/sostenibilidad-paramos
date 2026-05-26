# 🔬 Reporte de Auditoría y Diagnóstico de Producción
## Sostenibilidad Páramos — PNN Puracé

**Fecha:** 23 de mayo de 2026  
**Stack:** Next.js 14 (App Router) + Supabase + Dexie + Leaflet + PWA  
**Auditor:** Orquestador Antigravity — Análisis multi-especialidad  
**Archivos analizados:** 35+ archivos fuente (todas las rutas, componentes, hooks, libs y configuraciones)

---

## 📊 Resumen Ejecutivo

| Dimensión | Calificación | Nota |
|-----------|-------------|------|
| **Seguridad** | 🟡 Media | 1 bug crítico que rompe funcionalidad; exposición de credenciales controlable |
| **Arquitectura y Rendimiento** | 🟢 Alta | Código limpio, bien modularizado; deuda técnica menor |
| **Funcionalidad / QA** | 🟡 Media | Flujos principales sólidos, pero edge cases sin cubrir |

### **Calificación General: 🟡 MEDIA PREPARACIÓN para Producción**

> [!IMPORTANT]
> La app tiene una base sólida y bien diseñada. Sin embargo, hay **1 bug crítico** que rompe por completo el flujo de registro de productores, además de configuración PWA incompleta y oportunidades de hardening de seguridad que deben resolverse antes del despliegue.

---

## 🔒 Diagnóstico de Seguridad

### SEC-01 · Variables de entorno expuestas con prefijo `NEXT_PUBLIC_`
| Severidad | Archivo | Líneas |
|-----------|---------|--------|
| **Sugerencia** | [.env.local](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/.env.local) | L1-2 |

Las claves `NEXT_PUBLIC_SUPABASE_URL` y `NEXT_PUBLIC_SUPABASE_ANON_KEY` son públicas por diseño (el `anon key` de Supabase está diseñado para ser expuesto al cliente). **Esto es aceptable SIEMPRE que Row Level Security (RLS) esté habilitado en todas las tablas de Supabase.** Si RLS no está activo, cualquier usuario con la anon key puede leer/escribir toda la base de datos.

**Impacto:** Alto si no hay RLS; bajo si RLS está bien configurado.  
**Recomendación:** Verificar que **todas** las tablas (`productores`, `evaluaciones`, `respuestas_indicadores`, `indicadores`, `diagnosticos`, `usuarios`) tengan políticas RLS activas y estrictas.

---

### SEC-02 · Email de usuario hardcodeado en la página de login
| Severidad | Archivo | Líneas |
|-----------|---------|--------|
| **Importante** | [login/page.jsx](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/app/(auth)/login/page.jsx#L7) | L7 |

```javascript
const [email, setEmail] = useState('sscpurace@gmail.com');
```

El email del usuario está pre-rellenado como valor por defecto del estado. Esto:
- Expone un correo institucional real en el código fuente
- Reduce la fricción para un atacante (solo necesita adivinar la contraseña)
- Puede confundir a otros usuarios que usen la misma instancia

**Impacto:** Medio — facilita ataques de fuerza bruta dirigidos.  
**Recomendación:** Cambiar a `useState('')` y eliminar el correo del código fuente.

---

### SEC-03 · Ausencia de rate limiting en autenticación
| Severidad | Archivo | Líneas |
|-----------|---------|--------|
| **Importante** | [login/page.jsx](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/app/(auth)/login/page.jsx#L14-L34) | L14-34 |

El handler `handleLogin` no implementa ningún mecanismo para limitar intentos fallidos. Supabase tiene rate limiting del lado del servidor por defecto, pero es recomendable implementar un conteo de intentos en el cliente para bloquear la UI tras N intentos fallidos.

**Impacto:** Bajo-medio (Supabase tiene su propio rate limiting).  
**Recomendación:** Agregar un contador de intentos fallidos con cooldown exponencial en el cliente.

---

### SEC-04 · Middleware de autenticación bien configurado
| Severidad | Archivo | Líneas |
|-----------|---------|--------|
| **✅ Aprobado** | [middleware.js](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/middleware.js) | L1-84 |

El middleware implementa correctamente el patrón `@supabase/ssr`:
- ✅ Verifica `getUser()` (no solo `getSession()` — más seguro)
- ✅ Redirige a `/login` si no hay usuario
- ✅ Redirige a `/` si el usuario ya autenticado visita `/login`
- ✅ Excluye correctamente archivos estáticos del matcher
- ✅ Manejo correcto de cookies (set, remove)

---

### SEC-05 · Sin vulnerabilidades XSS detectadas
| Severidad | Archivo |
|-----------|---------|
| **✅ Aprobado** | Todos los componentes |

No se encontró uso de `dangerouslySetInnerHTML` en ningún componente. Toda la renderización se hace a través de JSX seguro de React. El único HTML embebido está en los iconos de Leaflet (`L.DivIcon`), que son cadenas estáticas sin interpolación de datos de usuario.

---

### SEC-06 · `.gitignore` correctamente configurado
| Severidad | Archivo |
|-----------|---------|
| **✅ Aprobado** | [.gitignore](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/.gitignore) |

Incluye `.env*.local`, `/node_modules`, `/.next/`, y archivos sensibles. **Sin embargo**, hay archivos debug (`debug_*.html`) y un directorio `backup_v1/` que probablemente no deberían estar en el repositorio.

---

### SEC-07 · Operaciones de borrado sin autorización server-side
| Severidad | Archivo | Líneas |
|-----------|---------|--------|
| **Importante** | [calificacion/nueva/[productorId]/page.jsx](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/app/(app)/calificacion/nueva/[productorId]/page.jsx#L83-L116) | L83-116 |

La función `handleEliminar` borra evaluaciones y respuestas tanto de IndexedDB como de Supabase sin verificar si el usuario actual es el técnico que creó esa evaluación. El sync engine envía DELETE directamente a Supabase con la anon key. **La seguridad depende enteramente de las políticas RLS de Supabase.**

**Impacto:** Crítico si no hay RLS adecuada; bajo si hay políticas que restringen DELETE al creador.

---

### SEC-08 · Descarga inicial sin paginación descarga TODOS los datos
| Severidad | Archivo | Líneas |
|-----------|---------|--------|
| **Importante** | [sync-engine.js](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/lib/sync-engine.js#L263-L291) | L263-291 |

```javascript
_supabase.from('productores').select('*'),
_supabase.from('evaluaciones').select('*'),
_supabase.from('respuestas_indicadores').select('*')
```

La función `syncInitialData()` descarga **todas** las filas de 4 tablas sin límite. Esto expone potencialmente datos de otros usuarios/técnicos (si RLS no filtra) y causará problemas de rendimiento con datos grandes (Supabase tiene un límite de 1000 filas por defecto).

**Impacto:** Alto en escalabilidad y potencialmente en privacidad de datos.  
**Recomendación:** Agregar filtros por `tecnico_id` del usuario actual y paginación.

---

## 🏗️ Diagnóstico de Arquitectura y Rendimiento

### ARQ-01 · **BUG CRÍTICO:** Funciones no definidas en `nuevo-productor/page.jsx`
| Severidad | Archivo | Líneas |
|-----------|---------|--------|
| **🔴 CRÍTICO** | [nuevo-productor/page.jsx](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/app/(app)/nuevo-productor/page.jsx#L65-L69) | L65, L69 |

```javascript
// Línea 65: Función NO IMPORTADA ni DEFINIDA
await agregarACola('productores', 'INSERT', newProductor);
// Línea 69: Función NO IMPORTADA ni DEFINIDA
await procesarCola(supabase);
```

Las funciones `agregarACola` y `procesarCola` **no existen en ningún archivo del proyecto**. El archivo importa `saveRecord` del sync-engine (L4) pero no lo usa. Esto hará que **cualquier intento de registrar un nuevo productor falle con `ReferenceError`** en tiempo de ejecución.

**Impacto:** 🔴 El flujo completo de creación de productores está roto.  
**Recomendación:** Reemplazar L62-69 por `await saveRecord('productores', newProductor);` que es la API correcta del sync engine.

---

### ARQ-02 · Todos los componentes de página son `'use client'`
| Severidad | Archivo |
|-----------|---------|
| **Importante** | Todas las 11 páginas del App Router |

Todas las páginas usan la directiva `'use client'`, lo que significa que **ninguna** aprovecha Server Components de Next.js 14. Esto implica:
- Todo el JavaScript de la app se envía al cliente
- No hay renderizado en el servidor (SSR real)
- No se aprovechan las ventajas de streaming/suspense server-side
- El SEO es mínimo (solo metadata estática en root layout)

**Impacto:** Medio — comprensible dado que la app es offline-first con Dexie, pero hay componentes que podrían ser server components (layouts, datos estáticos).  
**Recomendación:** Evaluar si las páginas de solo lectura (base-datos, mapa) podrían usar Server Components con hydración selectiva.

---

### ARQ-03 · Instanciación repetida del cliente Supabase
| Severidad | Archivo | Líneas |
|-----------|---------|--------|
| **Sugerencia** | [supabase.js](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/lib/supabase.js) + múltiples páginas | — |

`createClient()` se invoca directamente en el cuerpo del componente (fuera de hooks/effects) en múltiples páginas:
- [page.jsx (home)](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/app/(app)/page.jsx#L25) L25
- [layout.jsx (app)](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/app/(app)/layout.jsx#L10) L10
- [login/page.jsx](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/app/(auth)/login/page.jsx#L12) L12
- [nuevo-productor/page.jsx](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/app/(app)/nuevo-productor/page.jsx#L24) L24
- [calificacion/nueva/[productorId]/page.jsx](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/app/(app)/calificacion/nueva/[productorId]/page.jsx#L25) L25

Esto crea una nueva instancia del cliente en cada render. `createBrowserClient` de `@supabase/ssr` cachea internamente (singleton), así que no es un bug funcional, pero es un patrón inconsistente.

**Recomendación:** Considerar exportar una instancia singleton o usar un Context Provider.

---

### ARQ-04 · Progreso hardcodeado a 29 indicadores en `en-proceso`
| Severidad | Archivo | Líneas |
|-----------|---------|--------|
| **Importante** | [en-proceso/page.jsx](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/app/(app)/en-proceso/page.jsx#L56-L59) | L56, L59 |

```javascript
style={{ width: `${(item.respondidos / 29) * 100}%` }}
<span>{item.respondidos} / 29</span>
```

El número total de indicadores está hardcodeado como `29`. Si se agregan o eliminan indicadores de la tabla, la barra de progreso será incorrecta.

**Impacto:** Medio — datos incorrectos al usuario.  
**Recomendación:** Obtener `totalIndicadores` dinámicamente desde IndexedDB (`db.indicadores.count()`).

---

### ARQ-05 · Deuda técnica: archivos de debug y backup en el repositorio
| Severidad | Archivos |
|-----------|----------|
| **Sugerencia** | `debug_3.html`, `debug_4.html`, `debug_full.html`, `debug_no_auth.html`, `page_debug.html`, `backup_v1/` (directorio completo), `02_import_datos_historicos.sql` (664KB), `scripts/` (52 archivos SQL de migración, ~1.2MB total) |

Hay **5 archivos debug HTML**, un directorio `backup_v1/` con una versión anterior completa de la app, y un gran archivo SQL de importación de datos históricos en la raíz del proyecto. También 52 scripts SQL de migración en `scripts/`.

**Impacto:** Aumenta el tamaño del repositorio innecesariamente; confusión para otros desarrolladores.  
**Recomendación:** Mover scripts SQL a un directorio `migrations/` o eliminarlos; borrar archivos debug y backup_v1/.

---

### ARQ-06 · `console.log` de debug en código de producción
| Severidad | Archivos | Líneas |
|-----------|----------|--------|
| **Sugerencia** | [base-datos/page.jsx](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/app/(app)/base-datos/page.jsx#L13-L20) L13,20 · [calificacion/nueva/[productorId]/page.jsx](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/app/(app)/calificacion/nueva/[productorId]/page.jsx#L85-L107) L85,92,107 · [sync-engine.js](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/lib/sync-engine.js) (múltiples) | — |

Hay al menos 8+ `console.log` y `console.error` esparcidos en código de producción, incluyendo emojis de debug (`🗑️`, `📦`, `⏳`).

**Recomendación:** Implementar un logger condicional que solo imprima en `NODE_ENV === 'development'`.

---

### ARQ-07 · Bundle size: librerías pesadas sin code splitting granular
| Severidad | Archivo |
|-----------|---------|
| **Sugerencia** | [package.json](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/package.json) |

La app incluye 3 librerías pesadas del lado del cliente:
- **leaflet** + **react-leaflet** (~400KB sin minificar)
- **apexcharts** + **react-apexcharts** (~500KB sin minificar)
- **xlsx** (~300KB sin minificar)

✅ Los componentes de mapa ya usan `next/dynamic` con `ssr: false` (bien hecho).  
✅ `RadarChart` usa `next/dynamic` para importar `react-apexcharts`.  
⚠️ **xlsx** se importa en algún lugar pero no se detectó uso activo en los archivos analizados — verificar si es necesario.

**Recomendación:** Verificar que `xlsx` se importe dinámicamente solo donde se use (exportar a Excel). Considerar alternativas más ligeras si solo se necesita exportación básica.

---

### ARQ-08 · Schema de Dexie con tablas eliminadas pero no limpiadas
| Severidad | Archivo | Líneas |
|-----------|---------|--------|
| **Sugerencia** | [db-offline.js](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/lib/db-offline.js#L6-L36) | L6-36 |

El schema de Dexie tiene 6 versiones. Las versiones 3 y 4 definen tablas que luego se eliminan (`dimensiones: null`, `calificaciones: null`, `calificacion_detalle: null`). Esto es correcto para migraciones, pero los nombres legacy generan confusión.

---

### ARQ-09 · Estado `completadas` siempre es 0 en el dashboard
| Severidad | Archivo | Líneas |
|-----------|---------|--------|
| **Importante** | [page.jsx (home)](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/app/(app)/page.jsx#L47) | L47 |

```javascript
setStats({ total, pendientes, completadas: 0 });
```

La estadística "Completadas" del dashboard siempre muestra `0` porque está hardcodeada. Nunca se calcula el conteo real de evaluaciones con `estado === 'enviada'`.

**Impacto:** Datos incorrectos al usuario en la pantalla principal.  
**Recomendación:** Agregar `db.evaluaciones.where('estado').equals('enviada').count()` al `Promise.all` de `cargarDatos()`.

---

### ARQ-10 · Excelente modularización de componentes
| Severidad | Archivos |
|-----------|----------|
| **✅ Aprobado** | `components/` (17 componentes) |

La separación de componentes es excelente:
- ✅ `IndicadorCard`, `RadarChart`, `SostenibilidadPanel` son componentes especializados y reutilizables
- ✅ `EvaluacionHeader/Footer` encapsulan lógica de UI del flujo de evaluación
- ✅ `OfflineBanner` es autocontenido y reactivo
- ✅ `RadarChart` usa `memo` and `useMemo` correctamente
- ✅ Hooks customizados (`useDiagnostico`, `useOfflineSync`) encapsulan lógica compleja

---

### ARQ-11 · Sync Engine bien diseñado
| Severidad | Archivo |
|-----------|---------|
| **✅ Aprobado** | [sync-engine.js](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/lib/sync-engine.js) |

El motor de sincronización offline-first es robusto:
- ✅ Patrón IndexedDB-first con cola de sincronización
- ✅ Last-write-wins con deduplicación por ID
- ✅ Retry con máximo de 5 intentos + limpieza automática
- ✅ Auto-sync al recuperar conexión (`window.online`)
- ✅ Batch operations (UPSERT y DELETE agrupados por tabla)
- ✅ Limpieza de registros sincronizados después de 24h

---

## 🧪 Diagnóstico de QA / Testing Funcional

### QA-01 · Flujo de Autenticación
| Estado | Descripción |
|--------|-------------|
| **✅ PASS** | Login con email/password funciona correctamente |
| **✅ PASS** | Middleware redirige a `/login` si no hay sesión |
| **✅ PASS** | Middleware redirige a `/` si usuario autenticado visita `/login` |
| **⚠️ WARNING** | No hay funcionalidad de "olvidé mi contraseña" |
| **⚠️ WARNING** | No hay funcionalidad de logout visible |

---

### QA-02 · Flujo de Creación de Productor
| Estado | Descripción |
|--------|-------------|
| **🔴 FAIL** | `agregarACola()` y `procesarCola()` no están definidas — **ReferenceError en runtime** |
| **⚠️ WARNING** | `form.id` nunca se asigna al estado del form (L87: `router.push(\`/calificacion/nueva/\${form.id || ''}\`)`) — el botón "Evaluar ahora" redirige a URL incorrecta |
| **✅ PASS** | Validación básica de cédula y nombre (campos obligatorios) |
| **✅ PASS** | Detección de duplicados por cédula en DB local |
| **✅ PASS** | Obtención de GPS funciona correctamente |

---

### QA-03 · Flujo de Evaluación (Calificación)
| Estado | Descripción |
|--------|-------------|
| **✅ PASS** | Carga de indicadores desde IndexedDB |
| **✅ PASS** | Guardado por indicador con saveRecord |
| **✅ PASS** | Autosave cada 30 segundos (bien implementado con ref) |
| **✅ PASS** | Validación con Zod al finalizar (requiere todos los indicadores) |
| **✅ PASS** | Scroll automático al primer error de validación |
| **✅ PASS** | Guardar y salir como borrador |
| **✅ PASS** | Diálogo de confirmación al cancelar |
| **✅ PASS** | Resultados con radar chart comparativo (actual vs anterior) |

---

### QA-04 · Flujo de Búsqueda
| Estado | Descripción |
|--------|-------------|
| **✅ PASS** | Búsqueda local por nombre y cédula |
| **✅ PASS** | Estado vacío con enlace a registro |
| **✅ PASS** | FAB flotante para nuevo productor |
| **⚠️ WARNING** | No hay debounce en el input de búsqueda — con muchos productores puede ser lento |

---

### QA-05 · Flujo de Mapa
| Estado | Descripción |
|--------|-------------|
| **✅ PASS** | Carga dinámica de Leaflet (evita SSR crash) |
| **✅ PASS** | Colores por vereda con distribución áurea |
| **✅ PASS** | Perímetro PNN cargado desde GeoJSON |
| **✅ PASS** | Popup con navegación a perfil del productor |
| **✅ PASS** | Leyenda de veredas dinámica |
| **⚠️ WARNING** | GeoJSON del perímetro (1.2MB) se descarga en cada visita sin caching |

---

### QA-06 · Evaluaciones en Proceso
| Estado | Descripción |
|--------|-------------|
| **✅ PASS** | Lista de borradores con información del productor |
| **✅ PASS** | Barra de progreso visual |
| **🔴 ISSUE** | Progreso hardcodeado a 29 indicadores (ver ARQ-04) |
| **✅ PASS** | Navegación para continuar evaluación |

---

### QA-07 · Eliminación de Evaluaciones
| Estado | Descripción |
|--------|-------------|
| **✅ PASS** | Confirmación de dos pasos (botón → confirmar/cancelar) |
| **✅ PASS** | Optimistic UI (elimina del estado inmediatamente) |
| **✅ PASS** | Borrado en cascada (respuestas + diagnóstico + evaluación) |
| **⚠️ WARNING** | `setTimeout` de 1.5s para recargar datos es frágil — debería usar await |

---

### QA-08 · PWA / Modo Offline
| Severidad | Archivo | Líneas |
|-----------|---------|--------|
| **Importante** | [manifest.json](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/public/manifest.json#L10-L19) | L10-19 |

```json
"icons": [
  { "src": "/icon-192x192.png", ... },
  { "src": "/icon-512x512.png", ... }
]
```

Los archivos `icon-192x192.png` y `icon-512x512.png` **NO EXISTEN** en el directorio `public/`. Solo existe `public/icons/icon-nuevo-test.svg` (3.8MB, un SVG excesivamente grande). Esto impedirá:
- ❌ La instalación como PWA en dispositivos móviles
- ❌ El icono en la pantalla de inicio
- ❌ La validación del manifest por el navegador

**Impacto:** 🔴 La funcionalidad PWA está incompleta.  
**Recomendación:** Generar los iconos PNG en los tamaños requeridos (192x192 y 512x512) a partir del logo existente.

---

### QA-09 · Accesibilidad
| Severidad | Archivos |
|-----------|----------|
| **Sugerencia** | Múltiples componentes |

- ⚠️ Botones de navegación (`←`) usan texto plano sin `aria-label` — los lectores de pantalla no pueden interpretar la función
- ⚠️ La tabla de base de datos no tiene `scope` en los headers
- ⚠️ Los botones de score en `IndicadorCard` no tienen `aria-label` con la calificación
- ✅ `TopographicBg` y `Watermark` usan `aria-hidden="true"` correctamente
- ✅ Los formularios tienen `<label>` asociados con `htmlFor`

---

### QA-10 · Viewport bloqueado para accesibilidad
| Severidad | Archivo | Líneas |
|-----------|---------|--------|
| **Sugerencia** | [layout.js](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/app/layout.js#L17-L23) | L17-23 |

```javascript
export const viewport = {
  maximumScale: 1,
  userScalable: false,
};
```

Esto impide que los usuarios hagan pinch-to-zoom, lo cual es una barrera de accesibilidad para personas con visión reducida. Mientras es común en apps PWA tipo native, es una mala práctica general.

---

### QA-11 · Leaflet CSS importado desde CDN en globals.css
| Severidad | Archivo | Líneas |
|-----------|---------|--------|
| **Sugerencia** | [globals.css](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/app/globals.css#L5) | L5 |

```css
@import url('https://unpkg.com/leaflet@1.9.4/dist/leaflet.css');
```

El CSS de Leaflet se importa desde unpkg CDN, que es una dependencia externa. Si unpkg está caído o lento, el mapa se renderizará sin estilos. Además, `Map.jsx` (L2) ya importa `'leaflet/dist/leaflet.css'` localmente — **hay importación duplicada**.

**Recomendación:** Eliminar la importación CDN de `globals.css` (el import local en los componentes de mapa es suficiente).

---

### QA-12 · Iconos de Leaflet cargados desde CDN
| Severidad | Archivo | Líneas |
|-----------|---------|--------|
| **Importante** | [Map.jsx](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/components/Map.jsx#L8-L16) | L8-16 |

```javascript
const farmIcon = new L.Icon({
  iconUrl: 'https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon.png',
  ...
});
```

Los iconos del marcador de mapa se cargan desde `unpkg.com`. En modo offline (que es un feature core de la app), estos iconos **no se cargarán**, dejando marcadores invisibles.

**Impacto:** Alto — contradice directamente la promesa offline-first.  
**Recomendación:** Copiar los iconos a `public/images/` y referenciarlos localmente.

---

### QA-13 · Ruta `/mapa/[id]` sin link de acceso directo desde el mapa global
| Severidad | Archivo |
|-----------|---------|
| **Sugerencia** | [mapa/[id]/page.jsx](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/app/(app)/mapa/[id]/page.jsx) |

La ruta individual del mapa existe y funciona, pero el popup del `MultiMap` navega a `/calificacion/nueva/{id}` en vez de a `/mapa/{id}`. El botón dice "Ver Perfil" pero lleva a la evaluación, no al mapa individual. Inconsistencia UX menor.

---

## 📋 Plan de Acción Sugerido (Priorizado)

### 🔴 Prioridad CRÍTICA (Bloquean producción)

| # | Tarea | Archivo(s) | Esfuerzo |
|---|-------|------------|----------|
| 1 | **Corregir `agregarACola`/`procesarCola` undefined** — Reemplazar por `saveRecord()` del sync engine | [nuevo-productor/page.jsx](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/app/(app)/nuevo-productor/page.jsx#L62-L69) L62-69 | 15 min |
| 2 | **Arreglar `form.id` no asignado** — El botón "Evaluar ahora" tras crear productor apunta a URL vacía | [nuevo-productor/page.jsx](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/app/(app)/nuevo-productor/page.jsx#L87) L87 | 10 min |
| 3 | **Generar iconos PWA** (192x192 y 512x512 PNG) y colocarlos en `public/` | [manifest.json](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/public/manifest.json) | 20 min |

### 🟠 Prioridad ALTA (Impacto significativo)

| # | Tarea | Archivo(s) | Esfuerzo |
|---|-------|------------|----------|
| 4 | **Verificar RLS en todas las tablas de Supabase** — Sin esto, cualquiera puede leer/escribir toda la DB | Dashboard Supabase | 30 min |
| 5 | **Mover iconos Leaflet a `public/`** para soporte offline real | [Map.jsx](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/components/Map.jsx#L8-L16) | 15 min |
| 6 | **Hacer dinámico el conteo de indicadores** (eliminar hardcode de 29) | [en-proceso/page.jsx](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/app/(app)/en-proceso/page.jsx#L56-L59) | 15 min |
| 7 | **Corregir stat `completadas: 0` hardcodeada** en dashboard | [page.jsx (home)](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/app/(app)/page.jsx#L47) | 10 min |
| 8 | **Eliminar email hardcodeado** en login | [login/page.jsx](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/app/(auth)/login/page.jsx#L7) | 2 min |
| 9 | **Agregar paginación a `syncInitialData()`** con filtro por usuario | [sync-engine.js](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/lib/sync-engine.js#L263-L291) | 45 min |

### 🟡 Prioridad MEDIA (Mejoras importantes)

| # | Tarea | Archivo(s) | Esfuerzo |
|---|-------|------------|----------|
| 10 | **Eliminar importación duplicada de Leaflet CSS** de globals.css | [globals.css](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/app/globals.css#L5) | 2 min |
| 11 | **Agregar funcionalidad de logout** | NavBar o AppHeader | 30 min |
| 12 | **Implementar "Olvidé mi contraseña"** | [login/page.jsx](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/app/(auth)/login/page.jsx) | 45 min |
| 13 | **Eliminar `console.log` de debug** o reemplazar con logger condicional | Múltiples archivos | 20 min |
| 14 | **Cachear el GeoJSON del perímetro** PNN en IndexedDB | [Map.jsx](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/components/Map.jsx) / [MultiMap.jsx](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/components/MultiMap.jsx) | 30 min |
| 15 | **Agregar rate limiting** al login (contador de intentos) | [login/page.jsx](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/app/(auth)/login/page.jsx) | 20 min |

### 🔵 Prioridad BAJA (Limpieza y polish)

| # | Tarea | Archivo(s) | Esfuerzo |
|---|-------|------------|----------|
| 16 | Eliminar archivos debug (`debug_*.html`, `page_debug.html`) | Raíz del proyecto | 5 min |
| 17 | Eliminar o mover `backup_v1/` fuera del repositorio | Raíz del proyecto | 5 min |
| 18 | Agregar `aria-label` a botones de navegación (`←`) | Múltiples componentes | 20 min |
| 19 | Verificar si `xlsx` se usa activamente; si no, eliminar la dependencia | [package.json](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/package.json) | 10 min |
| 20 | Considerar permitir `userScalable: true` para accesibilidad | [layout.js](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/app/layout.js#L22) | 2 min |
| 21 | Reemplazar `setTimeout(cargarDatos, 1500)` por await determinístico | [calificacion/nueva/[productorId]/page.jsx](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/app/(app)/calificacion/nueva/[productorId]/page.jsx#L109) | 10 min |
| 22 | Mover `02_import_datos_historicos.sql` fuera de la raíz | Raíz del proyecto | 2 min |
| 23 | Agregar debounce al input de búsqueda | [buscar/page.jsx](file:///h:/Otros%20ordenadores/Mi%20portátil/sostenibilidad-paramos/app/(app)/buscar/page.jsx) | 15 min |
| 24 | Reducir tamaño del SVG en `public/icons/` (3.8MB es excesivo) | `public/icons/icon-nuevo-test.svg` | 10 min |

---

## ✅ Fortalezas Destacadas

| Área | Detalle |
|------|---------|
| **Sync Engine** | Arquitectura offline-first robusta con cola, reintentos, deduplicación y auto-sync |
| **Validación** | Uso correcto de Zod v4 con schemas dinámicos por indicador |
| **Componentización** | Excelente separación de responsabilidades (17 componentes enfocados) |
| **UX/Design System** | Sistema de diseño cohesivo con glassmorphism, animaciones y paleta PNN oficial |
| **Middleware Auth** | Implementación correcta del patrón `@supabase/ssr` con `getUser()` |
| **RadarChart** | Uso correcto de `memo`, `useMemo`, y dynamic import sin SSR |
| **Hooks** | `useDiagnostico` con patrón offline-first (local primero, remote en background) |
| **CSS Architecture** | Design tokens bien organizados, animaciones suaves, scrollbar custom |

---

## 📈 Estimación de Esfuerzo Total

| Prioridad | Tareas | Esfuerzo estimado |
|-----------|--------|-------------------|
| 🔴 Crítica | 3 tareas | ~45 min |
| 🟠 Alta | 6 tareas | ~2 horas |
| 🟡 Media | 6 tareas | ~2.5 horas |
| 🔵 Baja | 9 tareas | ~1.5 horas |
| **Total** | **24 tareas** | **~6.5 horas** |

> [!TIP]
> Las 3 tareas **críticas** pueden resolverse en menos de 1 hora y desbloquean el despliegue a producción. Recomiendo priorizarlas inmediatamente.
