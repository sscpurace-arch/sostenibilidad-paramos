# Graph Report - .  (2026-07-02)

## Corpus Check
- 73 files · ~2,417,848 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 394 nodes · 602 edges · 32 communities (24 shown, 8 thin omitted)
- Extraction: 89% EXTRACTED · 11% INFERRED · 0% AMBIGUOUS · INFERRED: 65 edges (avg confidence: 0.82)
- Token cost: 16,500 input · 4,200 output

## Community Hubs (Navigation)
- [[_COMMUNITY_Service Worker Serwist (runtime)|Service Worker Serwist (runtime)]]
- [[_COMMUNITY_Flujo de Calificación (matriz)|Flujo de Calificación (matriz)]]
- [[_COMMUNITY_Admin y Páginas Secundarias|Admin y Páginas Secundarias]]
- [[_COMMUNITY_SW Cache + API Notificar|SW Cache + API Notificar]]
- [[_COMMUNITY_Layout, Navegación y Sync Offline|Layout, Navegación y Sync Offline]]
- [[_COMMUNITY_Dependencias (package.json)|Dependencias (package.json)]]
- [[_COMMUNITY_Docs Auditoría y Contexto|Docs: Auditoría y Contexto]]
- [[_COMMUNITY_Prefetch Offline (datos + teselas)|Prefetch Offline (datos + teselas)]]
- [[_COMMUNITY_Tipos BD Supabase|Tipos BD Supabase]]
- [[_COMMUNITY_Config PWA y Layout Raíz|Config PWA y Layout Raíz]]
- [[_COMMUNITY_Mapa Global (Leaflet)|Mapa Global (Leaflet)]]
- [[_COMMUNITY_Navbar e Íconos|Navbar e Íconos]]
- [[_COMMUNITY_Manifest PWA|Manifest PWA]]
- [[_COMMUNITY_Mapa Individual|Mapa Individual]]
- [[_COMMUNITY_Edge Fn Generar Diagnóstico IA|Edge Fn: Generar Diagnóstico IA]]
- [[_COMMUNITY_Edge Fn Sugerir Plan Acción IA|Edge Fn: Sugerir Plan Acción IA]]
- [[_COMMUNITY_Config Supabase (temp)|Config Supabase (temp)]]
- [[_COMMUNITY_Detalle de Mapa|Detalle de Mapa]]
- [[_COMMUNITY_jsconfig Paths|jsconfig Paths]]
- [[_COMMUNITY_SW App (Serwist)|SW App (Serwist)]]
- [[_COMMUNITY_Config ESLint|Config ESLint]]
- [[_COMMUNITY_Guía Keepalive Supabase|Guía Keepalive Supabase]]
- [[_COMMUNITY_Config PostCSS|Config PostCSS]]
- [[_COMMUNITY_Vista Detallada BD|Vista Detallada BD]]
- [[_COMMUNITY_ApexCharts|ApexCharts]]

## God Nodes (most connected - your core abstractions)
1. `fetch()` - 15 edges
2. `get()` - 14 edges
3. `createClient()` - 13 edges
4. `handle()` - 13 edges
5. `cachePut()` - 12 edges
6. `syncQueue()` - 10 edges
7. `getDb()` - 10 edges
8. `clone()` - 10 edges
9. `PerfilProductorPage()` - 9 edges
10. `db` - 9 edges

## Surprising Connections (you probably didn't know these)
- `EvaluacionPage()` --references--> `29 SSC indicators (3 dimensions)`  [INFERRED]
  app/(app)/calificacion/[id]/page.jsx → CLAUDEdx.md
- `syncInitialData()` --references--> `Supabase Client`  [INFERRED]
  lib/sync-engine.js → app/(app)/admin/page.jsx
- `useOfflineSync hook` --implements--> `Offline-first PWA architecture`  [INFERRED]
  lib/hooks/useOfflineSync.js → CLAUDEdx.md
- `generar-diagnostico Edge Function` --references--> `29 SSC indicators (3 dimensions)`  [INFERRED]
  supabase/functions/generar-diagnostico/index.ts → CLAUDEdx.md
- `Offline-first PWA architecture` --conceptually_related_to--> `Dexie v4 (IndexedDB offline)`  [INFERRED]
  CLAUDEdx.md → package.json

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **Ciclo de auditoría y remediación de producción** — audit_report, health_dashboard, task, walkthrough [EXTRACTED 1.00]
- **Pipeline de datos offline-first (Dexie → cola → Supabase)** — claudedx_offline_first, claudedx_sync_engine, claudedx_db_offline, claudedx_supabase [EXTRACTED 1.00]
- **Configuración Keep-Alive de Supabase vía GitHub Actions** — readme_supabase_keepalive, guia_agente_supabase_keepalive_workflow_yml, guia_agente_supabase_keepalive_pat_workflow_scope, guia_agente_supabase_keepalive_cache_bypass [EXTRACTED 1.00]

## Communities (32 total, 8 thin omitted)

### Community 0 - "Service Worker Serwist (runtime)"
Cohesion: 0.06
Nodes (54): addEntry(), _addSyncListener(), addToPrecacheList(), cacheDidUpdate(), cachedResponseWillBeUsed(), constructor(), createHandlerBoundToUrl(), delete() (+46 more)

### Community 1 - "Flujo de Calificación (matriz)"
Cohesion: 0.06
Nodes (25): Dashboard(), BaseDatosPage(), EvaluacionContent(), IndicadorCard(), BASE_OPTIONS, Chart, RadarChart, ABREV_DIMENSION (+17 more)

### Community 2 - "Admin y Páginas Secundarias"
Cohesion: 0.06
Nodes (27): AdminPage(), NotificarRoute, NuevoProductorPage, Admin panel (role-based access), Autosave every 30 seconds, Mock user session (dev/test mode), Offline-first PWA architecture, 29 SSC indicators (3 dimensions) (+19 more)

### Community 3 - "SW Cache + API Notificar"
Cohesion: 0.11
Nodes (33): POST(), A(), _addRequest(), _awaitComplete(), cacheMatch(), cachePut(), clone(), destroy() (+25 more)

### Community 4 - "Layout, Navegación y Sync Offline"
Cohesion: 0.12
Nodes (23): AppLayout(), BuscarPage(), IndexedDB Sync Queue, Offline-First Sync Pattern, EnProcesoPage(), IconNuevo(), db, deleteRecord() (+15 more)

### Community 5 - "Dependencias (package.json)"
Cohesion: 0.06
Nodes (30): dependencies, apexcharts, dexie, leaflet, next, next-pwa, pg, react (+22 more)

### Community 6 - "Docs: Auditoría y Contexto"
Cohesion: 0.10
Nodes (26): Reporte de Auditoría y Diagnóstico de Producción, ARQ-01: agregarACola/procesarCola indefinidas (bug crítico), SEC-01/SEC-07: seguridad depende enteramente de RLS, Plan de Acción Priorizado (24 tareas, ~6.5h), QA-08: iconos PWA faltantes en manifest, SEC-08: syncInitialData() descarga todo sin paginación, CLAUDEdx.md — Instrucciones para agentes IA, App Sostenibilidad Páramos (PWA offline-first) (+18 more)

### Community 7 - "Prefetch Offline (datos + teselas)"
Cohesion: 0.26
Nodes (10): prepararOffline(), getClient(), CENTER, latToTileY(), lngToTileX(), prefetchDemoTiles(), REGION, TILE_URL() (+2 more)

### Community 8 - "Tipos BD Supabase"
Cohesion: 0.18
Nodes (10): CompositeTypes, Constants, Database, DatabaseWithoutInternals, DefaultSchema, Enums, Json, Tables (+2 more)

### Community 9 - "Config PWA y Layout Raíz"
Cohesion: 0.20
Nodes (8): metadata, nunito, RootLayout(), viewport, PWA (Progressive Web App), revision, withPWA, withSerwist

### Community 10 - "Mapa Global (Leaflet)"
Cohesion: 0.28
Nodes (6): FixSize(), MultiMap(), SetBounds(), Leaflet Map Integration, MapaGlobalPage(), MultiMap

### Community 11 - "Navbar e Íconos"
Cohesion: 0.22
Nodes (3): NavBar(), IconInicio(), IconProceso()

### Community 12 - "Manifest PWA"
Cohesion: 0.25
Nodes (7): background_color, display, icons, name, short_name, start_url, theme_color

### Community 14 - "Edge Fn: Generar Diagnóstico IA"
Cohesion: 0.33
Nodes (4): corsHeaders, GEMINI_API_KEY, SUPABASE_SERVICE_ROLE_KEY, SUPABASE_URL

### Community 15 - "Edge Fn: Sugerir Plan Acción IA"
Cohesion: 0.33
Nodes (4): corsHeaders, GEMINI_API_KEY, SUPABASE_SERVICE_ROLE_KEY, SUPABASE_URL

### Community 16 - "Config Supabase (temp)"
Cohesion: 0.40
Nodes (4): name, organization_id, organization_slug, ref

### Community 18 - "jsconfig Paths"
Cohesion: 0.50
Nodes (3): compilerOptions, paths, @/*

## Knowledge Gaps
- **101 isolated node(s):** `nunito`, `metadata`, `viewport`, `_listeners`, `@/*` (+96 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **8 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `fetch()` connect `SW Cache + API Notificar` to `Service Worker Serwist (runtime)`, `Layout, Navegación y Sync Offline`, `Prefetch Offline (datos + teselas)`?**
  _High betweenness centrality (0.199) - this node is a cross-community bridge._
- **Why does `importSeedData()` connect `Layout, Navegación y Sync Offline` to `SW Cache + API Notificar`?**
  _High betweenness centrality (0.154) - this node is a cross-community bridge._
- **Why does `createClient()` connect `Flujo de Calificación (matriz)` to `Admin y Páginas Secundarias`, `Layout, Navegación y Sync Offline`?**
  _High betweenness centrality (0.088) - this node is a cross-community bridge._
- **Are the 3 inferred relationships involving `fetch()` (e.g. with `prepararOffline()` and `importSeedData()`) actually correct?**
  _`fetch()` has 3 INFERRED edges - model-reasoned connections that need verification._
- **Are the 11 inferred relationships involving `createClient()` (e.g. with `AdminPage()` and `NuevoProductorPage`) actually correct?**
  _`createClient()` has 11 INFERRED edges - model-reasoned connections that need verification._
- **What connects `nunito`, `metadata`, `viewport` to the rest of the system?**
  _103 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Service Worker Serwist (runtime)` be split into smaller, more focused modules?**
  _Cohesion score 0.05970149253731343 - nodes in this community are weakly interconnected._