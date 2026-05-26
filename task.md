# 📋 Plan de Ejecución — Auditoría y Remedio de Producción
## Sostenibilidad Páramos — PNN Puracé

Este documento registra de forma detallada el progreso en la implementación de las 24 mejoras y correcciones aprobadas para la app de Sostenibilidad Páramos.

---

### 🔴 1. Correcciones Críticas (Bloqueo de Producción)
- `[x]` **ARQ-01**: Corregir error de funciones indefinidas (`agregarACola` / `procesarCola`) en `nuevo-productor/page.jsx` -> Reemplazar por `saveRecord()` del sync engine.
- `[x]` **QA-02**: Arreglar error de redireccionamiento de `form.id` en `nuevo-productor/page.jsx` -> Usar `newProductor.id` autogenerado tras guardado local.
- `[x]` **QA-08**: Generar e incluir los iconos PNG de PWA (`icon-192x192.png` y `icon-512x512.png`) en `public/` y validar en `manifest.json`.

---

### 🟠 2. Prioridad Alta (Seguridad, Datos e Integridad)
- `[x]` **ARQ-09**: Hacer dinámico el contador de evaluaciones "Completadas" en el Dashboard (`app/(app)/page.jsx`).
- `[x]` **SEC-02**: Eliminar el correo institucional hardcodeado (`sscpurace@gmail.com`) en `app/(auth)/login/page.jsx`.
- `[x]` **QA-12**: Localizar los iconos de Leaflet en `public/images/` para habilitar el modo offline real sin depender de CDN externo en marcadores (`components/Map.jsx`).
- `[x]` **SEC-08**: Optimizar `syncInitialData()` en `lib/sync-engine.js` para filtrar descargas por el usuario logueado (tecnico) y evitar descargas completas de la base de datos.
- `[x]` **SEC-07 & SEC-01**: Documentar y verificar el Row Level Security (RLS) en Supabase para proteger operaciones de eliminación del cliente.

---

### 🟡 3. Prioridad Media (UX y Estabilidad)
- `[x]` **ARQ-04**: Hacer dinámico el divisor de progreso (eliminar hardcode de 29 indicadores) en `app/(app)/en-proceso/page.jsx`.
- `[x]` **QA-11**: Eliminar la importación duplicada de Leaflet CSS desde el CDN unpkg en `app/globals.css`.
- `[x]` **QA-01**: Añadir botón y funcionalidad de Logout (cerrar sesión) visible en la interfaz principal.
- `[x]` **QA-01**: Añadir enlace de "Olvidé mi contraseña" en `app/(auth)/login/page.jsx`.
- `[x]` **QA-07**: Reemplazar recarga de datos con `setTimeout` de 1.5s por `await` determinístico tras eliminar calificación.
- `[x]` **QA-05**: Implementar almacenamiento local del archivo GeoJSON de perímetros PNN Puracé (1.2MB) en IndexedDB para no descargarlo en cada visita de mapa.
- `[x]` **SEC-03**: Añadir rate limiting local básico en login (bloqueo temporal del botón por N intentos fallidos).

---

### 🔵 4. Prioridad Baja (Limpieza y Polish)
- `[x]` **ARQ-05**: Limpiar el repositorio de archivos debug y archivos Sql pesados de la raíz.
- `[x]` **ARQ-06**: Quitar los `console.log` de debug y logs con emojis de producción, o implementar un logger condicional.
- `[x]` **QA-04**: Agregar debounce (150-300ms) al buscador de productores para evitar bloqueos táctiles en celulares lentos.
- `[x]` **ARQ-08**: Consolidar y limpiar las migraciones de IndexedDB en `lib/db-offline.js` (remover legacy null).
- `[x]` **QA-09**: Agregar atributos ARIA y roles para accesibilidad en componentes de interfaces táctiles.
- `[x]` **QA-10**: Remover el bloqueo de escala en el Viewport (`userScalable: true`) en `layout.js` para mejorar la accesibilidad de técnicos con dificultades visuales.
- `[x]` **ARQ-07**: Optimizar bundles importando XLSX dinámicamente solo en la función de exportación de datos.
