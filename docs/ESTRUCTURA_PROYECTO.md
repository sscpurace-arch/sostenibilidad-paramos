# 🏗️ Estructura de la Aplicación: Sostenibilidad Páramos

Este documento resume la arquitectura del proyecto basada en el análisis de **Graphify**.

![Mapa de Capas — Sostenibilidad Páramos](file:///c:/Users/Maria Mercedez/Documents/Estrategia SSC - GEF Páramos/sostenibilidad-paramos/graphify-out/sostenibilidad_paramos_capas_arquitectura.png)



## 📊 Resumen del Grafo
- **Nodos:** 230 (Componentes, funciones, archivos)
- **Relaciones:** 446 conexiones detectadas
- **Comunidades:** 41 módulos lógicos identificados

## 🧠 Núcleos del Sistema (God Nodes)
Los elementos más conectados que sostienen la lógica principal:
1. `createClient()` (Supabase) - Conexión central de datos.
2. `updatePendingCount()` & `syncQueue()` - Lógica de sincronización offline/online.
3. `RadarChart` - Visualización principal de resultados.
4. `EvaluacionPage()` - Flujo central de calificación.

## 📂 Organización por Comunidades
Basado en la cohesión de archivos, el sistema se divide en:

### 1. Sistema de Sincronización y Offline
- **Componentes:** `OfflineBanner`, `useOfflineSync`
- **Lógica:** `db` (Dexie), `deleteRecord`, `syncQueue`
- **Propósito:** Manejar la persistencia local y sincronización con Supabase en zonas sin internet.

### 2. Flujo de Calificación
- **Componentes:** `EvaluacionPage`, `PerfilProductorPage`, `NuevoProductorPage`
- **Propósito:** Registro y edición de matrices de sostenibilidad.

### 3. Visualización y Reportes
- **Componentes:** `RadarChart`, `ResultadosEvaluacion`
- **Lógica:** Configuración de ApexCharts para el radar de sostenibilidad.

### 4. Capa de Datos (Supabase)
- **Archivo:** `lib/supabase.js`
- **Propósito:** Cliente único para todas las peticiones a la base de datos.

## 🌐 Mapas Interactivos
Puedes explorar la estructura visualmente abriendo estos archivos en tu navegador:
1. **[Mapa de Galaxia](file:///c:/Users/Maria Mercedez/Documents/Estrategia SSC - GEF Páramos/sostenibilidad-paramos/graphify-out/graph.html)**: Vista relacional interactiva.
2. **[Mapa de Árbol](file:///c:/Users/Maria Mercedez/Documents/Estrategia SSC - GEF Páramos/sostenibilidad-paramos/graphify-out/GRAPH_TREE.html)**: Vista jerárquica de la estructura.

---
*Generado automáticamente mediante la integración de Graphify + Antigravity.*
