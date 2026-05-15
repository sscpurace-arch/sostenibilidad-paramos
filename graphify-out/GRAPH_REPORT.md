# Graph Report - .  (2026-05-08)

## Corpus Check
- 53 files · ~249,794 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 230 nodes · 310 edges · 41 communities (33 shown, 8 thin omitted)
- Extraction: 97% EXTRACTED · 3% INFERRED · 0% AMBIGUOUS · INFERRED: 9 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- [[_COMMUNITY_Community 0|Community 0]]
- [[_COMMUNITY_Community 1|Community 1]]
- [[_COMMUNITY_Community 2|Community 2]]
- [[_COMMUNITY_Community 3|Community 3]]
- [[_COMMUNITY_Community 4|Community 4]]
- [[_COMMUNITY_Community 5|Community 5]]
- [[_COMMUNITY_Community 6|Community 6]]
- [[_COMMUNITY_Community 7|Community 7]]
- [[_COMMUNITY_Community 8|Community 8]]
- [[_COMMUNITY_Community 9|Community 9]]
- [[_COMMUNITY_Community 10|Community 10]]
- [[_COMMUNITY_Community 11|Community 11]]
- [[_COMMUNITY_Community 13|Community 13]]
- [[_COMMUNITY_Community 14|Community 14]]
- [[_COMMUNITY_Community 15|Community 15]]
- [[_COMMUNITY_Community 16|Community 16]]
- [[_COMMUNITY_Community 17|Community 17]]

## God Nodes (most connected - your core abstractions)
1. `a` - 18 edges
2. `v` - 15 edges
3. `z()` - 14 edges
4. `f()` - 8 edges
5. `T()` - 8 edges
6. `createClient()` - 7 edges
7. `updatePendingCount()` - 7 edges
8. `r` - 7 edges
9. `syncQueue()` - 6 edges
10. `u` - 6 edges

## Surprising Connections (you probably didn't know these)
- `AppLayout()` --calls--> `createClient()`  [INFERRED]
  app/(app)/layout.jsx → lib/supabase.js
- `Dashboard()` --calls--> `createClient()`  [INFERRED]
  app/(app)/page.jsx → lib/supabase.js
- `PerfilProductorPage()` --calls--> `createClient()`  [INFERRED]
  app/(app)/calificacion/nueva/[productorId]/page.jsx → lib/supabase.js
- `NuevoProductorPage()` --calls--> `createClient()`  [INFERRED]
  app/(app)/nuevo-productor/page.jsx → lib/supabase.js
- `LoginPage()` --calls--> `createClient()`  [INFERRED]
  app/(auth)/login/page.jsx → lib/supabase.js

## Communities (41 total, 8 thin omitted)

### Community 0 - "Community 0"
Cohesion: 0.09
Nodes (19): b(), d(), deleteCacheAndMetadata(), e(), et, f(), g, i (+11 more)

### Community 1 - "Community 1"
Cohesion: 0.16
Nodes (16): OfflineBanner(), useOfflineSync(), EvaluacionPage(), db, DIMENSION_COLORS, deleteRecord(), deleteRecordBulk(), getState() (+8 more)

### Community 2 - "Community 2"
Cohesion: 0.15
Nodes (3): a, c(), h()

### Community 3 - "Community 3"
Cohesion: 0.12
Nodes (8): AppLayout(), Dashboard(), ResultadosEvaluacion(), useDiagnostico(), createClient(), LoginPage(), NuevoProductorPage(), PerfilProductorPage()

### Community 6 - "Community 6"
Cohesion: 0.21
Nodes (3): j(), q(), r

### Community 7 - "Community 7"
Cohesion: 0.18
Nodes (10): CompositeTypes, Constants, Database, DatabaseWithoutInternals, DefaultSchema, Enums, Json, Tables (+2 more)

### Community 9 - "Community 9"
Cohesion: 0.4
Nodes (5): a(), c, d, r(), s

### Community 10 - "Community 10"
Cohesion: 0.4
Nodes (3): metadata, nunito, viewport

### Community 11 - "Community 11"
Cohesion: 0.4
Nodes (3): BASE_OPTIONS, Chart, RadarChart

## Knowledge Gaps
- **30 isolated node(s):** `config`, `withPWA`, `nextConfig`, `config`, `nunito` (+25 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **8 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `a` connect `Community 2` to `Community 0`, `Community 6`?**
  _High betweenness centrality (0.041) - this node is a cross-community bridge._
- **Why does `z()` connect `Community 5` to `Community 0`, `Community 4`?**
  _High betweenness centrality (0.036) - this node is a cross-community bridge._
- **Why does `v` connect `Community 4` to `Community 0`, `Community 5`, `Community 6`?**
  _High betweenness centrality (0.025) - this node is a cross-community bridge._
- **What connects `config`, `withPWA`, `nextConfig` to the rest of the system?**
  _30 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Community 0` be split into smaller, more focused modules?**
  _Cohesion score 0.09 - nodes in this community are weakly interconnected._
- **Should `Community 3` be split into smaller, more focused modules?**
  _Cohesion score 0.12 - nodes in this community are weakly interconnected._