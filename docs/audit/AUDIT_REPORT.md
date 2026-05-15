# 📋 AUDIT REPORT — sostenibilidad-paramos

**Fecha:** 2026-04-29 | **Stack:** Next.js 14 + Supabase + Dexie (offline-first) + TailwindCSS + Leaflet + ApexCharts

---

## 1. Archivos JSX/JS clasificados por módulo

### 🏗️ Core / Infraestructura (4 archivos)
| Archivo | Líneas | Rol |
|---------|--------|-----|
| [layout.js](file:///c:/Users/Maria%20Mercedez/Documents/Estrategia%20SSC%20-%20GEF%20P%C3%A1ramos/sostenibilidad-paramos/app/layout.js) | 28 | Root layout (fonts, metadata, PWA) |
| [middleware.js](file:///c:/Users/Maria%20Mercedez/Documents/Estrategia%20SSC%20-%20GEF%20P%C3%A1ramos/sostenibilidad-paramos/middleware.js) | 84 | Auth guard SSR (Supabase SSR cookies) |
| [supabase.js](file:///c:/Users/Maria%20Mercedez/Documents/Estrategia%20SSC%20-%20GEF%20P%C3%A1ramos/sostenibilidad-paramos/lib/supabase.js) | 8 | Supabase browser client factory |
| [db-offline.js](file:///c:/Users/Maria%20Mercedez/Documents/Estrategia%20SSC%20-%20GEF%20P%C3%A1ramos/sostenibilidad-paramos/lib/db-offline.js) | 13 | Dexie schema (v3, 6 stores) |

### 🔄 Sincronización (1 archivo)
| Archivo | Líneas | Rol |
|---------|--------|-----|
| [sync.js](file:///c:/Users/Maria%20Mercedez/Documents/Estrategia%20SSC%20-%20GEF%20P%C3%A1ramos/sostenibilidad-paramos/lib/sync.js) | 85 | Cola offline, sync automática, bulk download |

### 📱 Páginas — App Group (8 archivos)
| Archivo | Líneas | Rol |
|---------|--------|-----|
| [(app)/layout.jsx](file:///c:/Users/Maria%20Mercedez/Documents/Estrategia%20SSC%20-%20GEF%20P%C3%A1ramos/sostenibilidad-paramos/app/(app)/layout.jsx) | 30 | Shell: OfflineBanner + NavBar + sync init |
| [(app)/page.jsx](file:///c:/Users/Maria%20Mercedez/Documents/Estrategia%20SSC%20-%20GEF%20P%C3%A1ramos/sostenibilidad-paramos/app/(app)/page.jsx) | 97 | Dashboard principal |
| [buscar/page.jsx](file:///c:/Users/Maria%20Mercedez/Documents/Estrategia%20SSC%20-%20GEF%20P%C3%A1ramos/sostenibilidad-paramos/app/(app)/buscar/page.jsx) | 100 | Búsqueda de productores |
| [base-datos/page.jsx](file:///c:/Users/Maria%20Mercedez/Documents/Estrategia%20SSC%20-%20GEF%20P%C3%A1ramos/sostenibilidad-paramos/app/(app)/base-datos/page.jsx) | 115 | Tabla de productores sorteable |
| [en-proceso/page.jsx](file:///c:/Users/Maria%20Mercedez/Documents/Estrategia%20SSC%20-%20GEF%20P%C3%A1ramos/sostenibilidad-paramos/app/(app)/en-proceso/page.jsx) | 85 | Evaluaciones pendientes |
| [mapa/page.jsx](file:///c:/Users/Maria%20Mercedez/Documents/Estrategia%20SSC%20-%20GEF%20P%C3%A1ramos/sostenibilidad-paramos/app/(app)/mapa/page.jsx) | 95 | Mapa global de productores |
| [mapa/[id]/page.jsx](file:///c:/Users/Maria%20Mercedez/Documents/Estrategia%20SSC%20-%20GEF%20P%C3%A1ramos/sostenibilidad-paramos/app/(app)/mapa/[id]/page.jsx) | 75 | Mapa individual de predio |
| [nuevo-productor/page.jsx](file:///c:/Users/Maria%20Mercedez/Documents/Estrategia%20SSC%20-%20GEF%20P%C3%A1ramos/sostenibilidad-paramos/app/(app)/nuevo-productor/page.jsx) | 176 | Formulario nuevo productor + GPS |

### 📊 Páginas — Calificación (2 archivos)
| Archivo | Líneas | Rol |
|---------|--------|-----|
| [calificacion/[id]/page.jsx](file:///c:/Users/Maria%20Mercedez/Documents/Estrategia%20SSC%20-%20GEF%20P%C3%A1ramos/sostenibilidad-paramos/app/(app)/calificacion/[id]/page.jsx) | **240** | Formulario de evaluación 29 indicadores |
| [calificacion/nueva/[productorId]/page.jsx](file:///c:/Users/Maria%20Mercedez/Documents/Estrategia%20SSC%20-%20GEF%20P%C3%A1ramos/sostenibilidad-paramos/app/(app)/calificacion/nueva/[productorId]/page.jsx) | **301** | Perfil productor + historial + radar |

### 🔐 Auth (1 archivo)
| Archivo | Líneas | Rol |
|---------|--------|-----|
| [login/page.jsx](file:///c:/Users/Maria%20Mercedez/Documents/Estrategia%20SSC%20-%20GEF%20P%C3%A1ramos/sostenibilidad-paramos/app/(auth)/login/page.jsx) | 77 | Login con email/password |

### 🧩 Componentes compartidos (6 archivos)
| Archivo | Líneas | Rol |
|---------|--------|-----|
| [RadarChart.jsx](file:///c:/Users/Maria%20Mercedez/Documents/Estrategia%20SSC%20-%20GEF%20P%C3%A1ramos/sostenibilidad-paramos/components/RadarChart.jsx) | **211** | Gráfica radar ApexCharts (memo) |
| [MultiMap.jsx](file:///c:/Users/Maria%20Mercedez/Documents/Estrategia%20SSC%20-%20GEF%20P%C3%A1ramos/sostenibilidad-paramos/components/MultiMap.jsx) | 157 | Mapa Leaflet multi-marcador + leyenda |
| [Map.jsx](file:///c:/Users/Maria%20Mercedez/Documents/Estrategia%20SSC%20-%20GEF%20P%C3%A1ramos/sostenibilidad-paramos/components/Map.jsx) | 110 | Mapa individual Leaflet |
| [NavBar.jsx](file:///c:/Users/Maria%20Mercedez/Documents/Estrategia%20SSC%20-%20GEF%20P%C3%A1ramos/sostenibilidad-paramos/components/NavBar.jsx) | 36 | Barra de navegación inferior |
| [IndicadorCard.jsx](file:///c:/Users/Maria%20Mercedez/Documents/Estrategia%20SSC%20-%20GEF%20P%C3%A1ramos/sostenibilidad-paramos/components/IndicadorCard.jsx) | 33 | Card de puntaje 1-5 + observación |
| [OfflineBanner.jsx](file:///c:/Users/Maria%20Mercedez/Documents/Estrategia%20SSC%20-%20GEF%20P%C3%A1ramos/sostenibilidad-paramos/components/OfflineBanner.jsx) | 29 | Banner de estado offline |

**Total: 22 archivos JS/JSX** | **~1,771 líneas de código**

---

## 2. Componentes con más de 200 líneas (candidatos a refactorización)

| Archivo | Líneas | Razón de riesgo |
|---------|--------|-----------------|
| **calificacion/nueva/[productorId]/page.jsx** | **301** | 🔴 Mezcla: perfil, historial, radar multi-dataset, eliminación, creación de evaluación. Dios-componente. |
| **calificacion/[id]/page.jsx** | **240** | 🟠 Formulario completo de 29 indicadores + vista de resultados + sync. Dos vistas en un solo componente (evaluación + resultados). |
| **RadarChart.jsx** | **211** | 🟡 Aceptable por complejidad de ApexCharts. Bien memoizado. Podría extraerse la leyenda de indicadores. |

---

## 3. Mapeo de llamadas a Supabase

### Tablas en la BD (6 tablas + 1 vista)

| Tabla | Filas | Columnas clave | FK / Relaciones |
|-------|-------|----------------|-----------------|
| `usuarios` | 1 | id(uuid), nombre, email, rol, activo | → calificaciones.usuario_id, productores.created_by |
| `productores` | 270 | id(uuid), cedula(unique), nombre_completo, nombre_predio, vereda, municipio, ubicacion_lat/lng, proyecto | → calificaciones.productor_id |
| `dimensiones` | 3 | id(int2), nombre, color | → indicadores.dimension_id |
| `indicadores` | 29 | id(int2), nombre, descripcion, dimension_id, puntaje_min/max, orden | → calificacion_detalle.indicador_id |
| `calificaciones` | 282 | id(uuid), productor_id, usuario_id, estado(CHECK), es_prueba, fecha_inicio/fin | → calificacion_detalle.calificacion_id |
| `calificacion_detalle` | 7,820 | id(uuid), calificacion_id, indicador_id, puntaje(CHECK 1-5), observacion | — |
| `vista_detallada_calificaciones` | — | Vista de consulta | — |

---

## 4. Deuda técnica priorizada

| # | Severidad | Categoría | Problema | Impacto |
|---|-----------|-----------|----------|---------|
| 1 | 🔴 Crítica | Datos | **Sync descarga TODAS las filas** sin paginación. | Performance y consumo de datos. |
| 2 | 🔴 Crítica | Arquitectura | **Sin reconciliación de conflictos** offline/online. | Riesgo de pérdida de datos. |
| 3 | 🔴 Crítica | Arquitectura | **Dios-componente** `calificacion/nueva/[productorId]`. | Mantenibilidad nula. |
| 4 | 🟠 Alta | UX | **Descripción del indicador invisible** en formulario. | Error en recolección de datos. |

---

## 5. Registro de revisión y ajustes (En curso)

- [x] Inventario exhaustivo inicial completado.
- [x] **Backup V1** guardado en `/backup_v1/` (2026-04-29).
- [x] **Migración V2 — Normalización del schema** (2026-04-29):
  - `calificaciones` → `evaluaciones` (finca_id, tecnico_id, estado borrador/enviada)
  - `calificacion_detalle` → `respuestas_indicadores` (valor, evidencia_url, UNIQUE)
  - `indicadores` enriquecida: dimension(text), tipo_dato, rango_min/max
  - Tablas antiguas preservadas como `*_legacy`
  - RLS: técnicos solo ven sus propias evaluaciones
  - Índices: finca_id, tecnico_id, evaluacion_id, indicador_id
  - Tipos TypeScript generados en `lib/database.types.ts`
  - SQL de referencia en `docs/audit/migration_v2_normalize.sql`
  - ✅ Integridad verificada: 282 evaluaciones, 7,820 respuestas
- [x] **Frontend actualizado para schema V2** (2026-04-29):
  - `db-offline.js`: Dexie v4, stores evaluaciones/respuestas_indicadores, DIMENSION_COLORS
  - `sync.js`: tablas nuevas, eliminada descarga de dimensiones
  - `page.jsx` (Dashboard): evaluaciones + borrador
  - `en-proceso/page.jsx`: evaluaciones + borrador + evaluacion_id
  - `calificacion/[id]/page.jsx`: reescrito completo (evaluaciones, valor, dimension por nombre)
  - `calificacion/nueva/[productorId]/page.jsx`: reescrito completo (finca_id, tecnico_id, enviada)
  - `RadarChart.jsx`: agrupación por dimension nombre
  - ✅ Build exitoso: 0 errores
- [ ] Refactorización de componentes largos.
- [x] **Sync Engine V2 implementado** (2026-04-29):
  - `lib/sync-engine.js`: Motor con batch upsert, last-write-wins, auto-reconnect, max 5 reintentos
  - `lib/hooks/useOfflineSync.js`: Hook React `{ isSyncing, pendingCount, lastSyncAt }` (error-safe)
  - `lib/db-offline.js`: Dexie v5 con sync_queue mejorada (sync_pending, updated_at indexes)
  - `components/OfflineBanner.jsx`: Banner inteligente (rojo=offline, azul=syncing, ámbar=pendiente)
  - Páginas actualizadas: `saveRecord()` reemplaza patrón manual `db.put + agregarACola + procesarCola`
  - `lib/sync.js` eliminado (reemplazado por sync-engine.js)
  - ✅ Build exitoso: 0 errores
- [x] **Formulario de indicadores mejorado** (2026-04-29):
  - `components/IndicadorCard.jsx`: Rango dinámico (rango_min/rango_max), descripción expandible, error inline `--color-danger`, checkmark de completado
  - `lib/validation.js`: Schema Zod dinámico por indicador, mensajes descriptivos
  - `app/(app)/calificacion/[id]/page.jsx`: Autosave 30s, validación al finalizar, guardar parcial siempre, scroll a primer error, banner de validación global
  - `app/globals.css`: Variables `--color-danger` y `--color-warning`
  - Dependencia: `zod` (~2 KB gzip)
  - ✅ Build exitoso: 0 errores
- [x] **Refactorización de componentes largos** (2026-04-29):
  - `calificacion/[id]/page.jsx`: 343 → 170 líneas
    - Extraído: `ResultadosEvaluacion`, `EvaluacionHeader`, `EvaluacionFooter`, `ValidationBanner`
  - `calificacion/nueva/[productorId]/page.jsx`: 296 → 115 líneas
    - Extraído: `ProductorInfoCard`, `SostenibilidadPanel`, `HistorialEvals`, `NuevaEvalForm`
  - 8 componentes presentacionales nuevos en `components/`
  - ✅ Build exitoso: 0 errores, sin cambios funcionales
