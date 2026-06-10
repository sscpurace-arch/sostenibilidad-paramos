# Graph Report - .  (2026-06-07)

## Corpus Check
- 60 files · ~20,912 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 240 nodes · 266 edges · 39 communities (29 shown, 10 thin omitted)
- Extraction: 82% EXTRACTED · 18% INFERRED · 0% AMBIGUOUS · INFERRED: 48 edges (avg confidence: 0.82)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- [[_COMMUNITY_Dependencies & Config|Dependencies & Config]]
- [[_COMMUNITY_Search & Evaluation Flow|Search & Evaluation Flow]]
- [[_COMMUNITY_Pages & Routing|Pages & Routing]]
- [[_COMMUNITY_Admin Dashboard|Admin Dashboard]]
- [[_COMMUNITY_Base de Datos & Dashboard|Base de Datos & Dashboard]]
- [[_COMMUNITY_App Shell & Auth|App Shell & Auth]]
- [[_COMMUNITY_Supabase DB Schema|Supabase DB Schema]]
- [[_COMMUNITY_Root Layout & Metadata|Root Layout & Metadata]]
- [[_COMMUNITY_Global Map View|Global Map View]]
- [[_COMMUNITY_Individual Farm Map|Individual Farm Map]]
- [[_COMMUNITY_AI Diagnostico (Gemini)|AI Diagnostico (Gemini)]]
- [[_COMMUNITY_Supabase Project Config|Supabase Project Config]]
- [[_COMMUNITY_Producer History & Info|Producer History & Info]]
- [[_COMMUNITY_Radar Chart Visualization|Radar Chart Visualization]]
- [[_COMMUNITY_JS Path Config|JS Path Config]]
- [[_COMMUNITY_Auth Middleware|Auth Middleware]]
- [[_COMMUNITY_Farm Detail Page|Farm Detail Page]]
- [[_COMMUNITY_Mapa Page Duplicate|Mapa Page Duplicate]]
- [[_COMMUNITY_Validation Logic|Validation Logic]]
- [[_COMMUNITY_Watermark Component|Watermark Component]]
- [[_COMMUNITY_Tailwind Theme|Tailwind Theme]]
- [[_COMMUNITY_ESLint Config|ESLint Config]]
- [[_COMMUNITY_Next.js Config|Next.js Config]]

## God Nodes (most connected - your core abstractions)
1. `createClient()` - 11 edges
2. `syncQueue()` - 9 edges
3. `db` - 9 edges
4. `db (Dexie IndexedDB)` - 8 edges
5. `updatePendingCount()` - 7 edges
6. `NavBar()` - 7 edges
7. `useDiagnostico` - 7 edges
8. `PerfilProductorPage` - 7 edges
9. `Table: evaluaciones` - 7 edges
10. `Table: indicadores` - 7 edges

## Surprising Connections (you probably didn't know these)
- `EvaluacionPage` --references--> `29 SSC indicators (3 dimensions)`  [INFERRED]
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
- **Offline Sync Architecture** — lib_sync_engine_syncengine, lib_db_offline_db, components_offlinebanner_offlinebanner, app_app_layout_applayout, concept_offline_first_sync, concept_indexeddb_queue [INFERRED 0.95]
- **Map Display Flow** — app_app_mapa_mapaglobalpage, components_multimap_multimap, components_multimap_setbounds, components_multimap_fixsize, concept_leaflet_map, lib_db_offline_db [EXTRACTED 1.00]
- **NavBar Icon System** — components_navbar_navbar, components_icons_iconinicio_iconinicio, components_icons_iconbuscar_iconbuscar, components_icons_iconmapa_iconmapa, components_icons_iconproceso_iconproceso, components_icons_iconcalificar_iconcalificar [EXTRACTED 1.00]
- **AI-Powered Evaluation Results** — components_resultadosevaluacion_resultadosevaluacion, lib_hooks_usediagnostico_usediagnostico, concept_gemini_ai_diagnostico, components_radarchart_radarchart [EXTRACTED 1.00]
- **Offline-first data pattern: IndexedDB + Supabase sync** — lib_dboffline_db, lib_hooks_usediagnostico_usediagnostico, app_app_calificacion_nueva_productorId_page_perfilproductorpage, app_app_page_dashboard, app_app_basedatos_page_basedatospage [INFERRED 0.90]
- **Evaluación scoring flow** — components_indicadorcard_indicadorcard, components_evaluacionfooter_evaluacionfooter, lib_validation_crearschema, lib_database_types_table_respuestas_indicadores, lib_database_types_table_evaluaciones [INFERRED 0.85]
- **Radar chart visualization pipeline** — components_radarchart_radarchart, components_sostenibilidadpanel_sostenibilidadpanel, lib_database_types_table_respuestas_indicadores, lib_database_types_table_indicadores, lib_dboffline_dimension_colors [INFERRED 0.90]
- **Auth flow (mock + real Supabase)** — app_auth_login_page_loginpage, middleware_middleware, lib_database_types_table_usuarios [INFERRED 0.90]
- **Mock session system (dev login bypass)** — concept_mock_session, lib_supabase_mock_auth, lib_supabase, app_nuevo_productor_page, app_calificacion_id_page, components_appheader, supabase_functions_generar_diagnostico [EXTRACTED 1.00]
- **Offline-first PWA stack** — concept_offline_first, package_json_dexie, package_json_nextpwa, lib_hooks_useofflinesync [INFERRED 0.85]
- **PNN institutional brand system** — tailwind_config_pnn_palette, tailwind_config_paramo_theme, components_watermark, components_appheader [INFERRED 0.75]

## Communities (39 total, 10 thin omitted)

### Community 0 - "Dependencies & Config"
Cohesion: 0.07
Nodes (28): dependencies, apexcharts, dexie, leaflet, next, next-pwa, pg, react (+20 more)

### Community 1 - "Search & Evaluation Flow"
Cohesion: 0.15
Nodes (21): BuscarPage, EnProcesoPage, EvaluacionHeader(), IconNuevo, OfflineBanner(), IndexedDB Sync Queue, Offline-First Sync Pattern, db (+13 more)

### Community 2 - "Pages & Routing"
Cohesion: 0.09
Nodes (21): NotificarRoute, EvaluacionPage, MapaPage, NuevoProductorPage, Admin panel (role-based access), Autosave every 30 seconds, Mock user session (dev/test mode), Offline-first PWA architecture (+13 more)

### Community 3 - "Admin Dashboard"
Cohesion: 0.10
Nodes (12): AdminPage(), AdminPage, Dashboard(), AppHeader(), Supabase Client, useDiagnostico(), useOfflineSync(), EvaluacionPage() (+4 more)

### Community 4 - "Base de Datos & Dashboard"
Cohesion: 0.17
Nodes (19): BaseDatosPage, PerfilProductorPage, Dashboard, IndicadorCard(), RadarChart, ResultadosEvaluacion(), SostenibilidadPanel(), Gemini AI Diagnóstico (+11 more)

### Community 5 - "App Shell & Auth"
Cohesion: 0.18
Nodes (9): AppLayout, LoginPage, IconBuscar, IconCalificar, IconInicio, IconMapa, IconProceso, NavBar() (+1 more)

### Community 6 - "Supabase DB Schema"
Cohesion: 0.18
Nodes (10): CompositeTypes, Constants, Database, DatabaseWithoutInternals, DefaultSchema, Enums, Json, Tables (+2 more)

### Community 7 - "Root Layout & Metadata"
Cohesion: 0.22
Nodes (7): metadata, nunito, RootLayout(), viewport, PWA (Progressive Web App), nextConfig, withPWA

### Community 8 - "Global Map View"
Cohesion: 0.47
Nodes (5): MapaGlobalPage, FixSize(), MultiMap(), SetBounds(), Leaflet Map Integration

### Community 10 - "AI Diagnostico (Gemini)"
Cohesion: 0.33
Nodes (4): corsHeaders, GEMINI_API_KEY, SUPABASE_SERVICE_ROLE_KEY, SUPABASE_URL

### Community 11 - "Supabase Project Config"
Cohesion: 0.40
Nodes (4): name, organization_id, organization_slug, ref

### Community 14 - "JS Path Config"
Cohesion: 0.50
Nodes (3): compilerOptions, paths, @/*

### Community 15 - "Auth Middleware"
Cohesion: 0.50
Nodes (3): config, middleware(), linked-project (Supabase project config)

## Knowledge Gaps
- **82 isolated node(s):** `nunito`, `metadata`, `viewport`, `_listeners`, `@/*` (+77 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **10 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `createClient()` connect `Admin Dashboard` to `Pages & Routing`, `App Shell & Auth`?**
  _High betweenness centrality (0.140) - this node is a cross-community bridge._
- **Why does `AppLayout` connect `App Shell & Auth` to `Search & Evaluation Flow`, `Admin Dashboard`?**
  _High betweenness centrality (0.093) - this node is a cross-community bridge._
- **Why does `useDiagnostico()` connect `Admin Dashboard` to `Base de Datos & Dashboard`?**
  _High betweenness centrality (0.048) - this node is a cross-community bridge._
- **Are the 8 inferred relationships involving `createClient()` (e.g. with `AdminPage()` and `Dashboard()`) actually correct?**
  _`createClient()` has 8 INFERRED edges - model-reasoned connections that need verification._
- **Are the 4 inferred relationships involving `db (Dexie IndexedDB)` (e.g. with `Table: evaluaciones` and `Table: indicadores`) actually correct?**
  _`db (Dexie IndexedDB)` has 4 INFERRED edges - model-reasoned connections that need verification._
- **What connects `nunito`, `metadata`, `viewport` to the rest of the system?**
  _82 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Dependencies & Config` be split into smaller, more focused modules?**
  _Cohesion score 0.06896551724137931 - nodes in this community are weakly interconnected._