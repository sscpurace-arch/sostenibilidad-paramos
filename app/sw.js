// Service worker de la app (compilado por @serwist/next en el build).
// Objetivo: que la app arranque y funcione completa sin conexión
// después de haberse abierto al menos una vez con internet.
import { defaultCache } from '@serwist/next/worker';
import {
  Serwist,
  NetworkFirst,
  CacheFirst,
  StaleWhileRevalidate,
  ExpirationPlugin,
  CacheableResponsePlugin,
} from 'serwist';

// Nunca cachear respuestas redirigidas (p. ej. el 307 del middleware a /login):
// si se guardaran bajo "/", al reabrir offline se vería el login en vez de la app.
const soloRespuestasLimpias = {
  cacheWillUpdate: async ({ response }) =>
    response && response.status === 200 && !response.redirected ? response : null,
};

const serwist = new Serwist({
  precacheEntries: self.__SW_MANIFEST,
  // No activar la versión nueva automáticamente: queda en estado "waiting"
  // hasta que el usuario presione "Actualizar" (ver components/UpdateBanner.jsx).
  // En la primera instalación (sin SW previo) igual se activa de inmediato.
  skipWaiting: false,
  clientsClaim: true,
  navigationPreload: true,
  runtimeCaching: [
    // Documentos HTML (navegaciones): red primero con timeout corto,
    // y si no hay red se sirve la última versión cacheada.
    {
      matcher: ({ request }) => request.mode === 'navigate',
      handler: new NetworkFirst({
        cacheName: 'paginas-html',
        networkTimeoutSeconds: 3,
        plugins: [soloRespuestasLimpias, new ExpirationPlugin({ maxEntries: 32 })],
        matchOptions: { ignoreSearch: true, ignoreVary: true },
      }),
    },
    // Payloads RSC de la navegación interna de Next. Como todas las páginas
    // son estáticas y leen sus datos de IndexedDB (el ?productor=/?id= se lee
    // en el cliente), se sirven ignorando el query para que la navegación a
    // calificación/mapa funcione sin conexión.
    {
      matcher: ({ url, request, sameOrigin }) =>
        sameOrigin && (url.searchParams.has('_rsc') || request.headers.has('RSC')),
      handler: new StaleWhileRevalidate({
        cacheName: 'rsc-paginas',
        matchOptions: { ignoreSearch: true, ignoreVary: true },
        plugins: [new ExpirationPlugin({ maxEntries: 32 })],
      }),
    },
    // Teselas de OpenStreetMap — CacheFirst para que el mapa funcione sin conexión
    {
      matcher: /^https:\/\/tile\.openstreetmap\.org\/.*/i,
      handler: new CacheFirst({
        cacheName: 'osm-tiles',
        plugins: [
          new ExpirationPlugin({ maxEntries: 3000, maxAgeSeconds: 60 * 24 * 60 * 60 }),
          new CacheableResponsePlugin({ statuses: [0, 200] }),
        ],
      }),
    },
    // Teselas satelitales de Esri
    {
      matcher: /^https:\/\/server\.arcgisonline\.com\/.*/i,
      handler: new CacheFirst({
        cacheName: 'esri-tiles',
        plugins: [
          new ExpirationPlugin({ maxEntries: 1500, maxAgeSeconds: 60 * 24 * 60 * 60 }),
          new CacheableResponsePlugin({ statuses: [0, 200] }),
        ],
      }),
    },
    // Datos críticos para arranque sin conexión (semilla y perímetro del parque)
    {
      matcher: /\/(seed-data|purace-boundary)\.json$/i,
      handler: new StaleWhileRevalidate({
        cacheName: 'datos-criticos',
        plugins: [new ExpirationPlugin({ maxEntries: 4 })],
      }),
    },
    // Reglas por defecto de Serwist para Next.js:
    // _next/static, payloads RSC (?_rsc=), imágenes, fuentes, etc.
    ...defaultCache,
  ],
  // Si una ruta nunca visitada se abre sin red, mostrar /~offline
  // en vez del error del navegador.
  fallbacks: {
    entries: [
      {
        url: '/~offline',
        matcher: ({ request }) => request.destination === 'document',
      },
    ],
  },
});

serwist.addEventListeners();

// Activar la versión en espera bajo demanda, cuando el cliente lo pide
// (botón "Actualizar" en components/UpdateBanner.jsx).
self.addEventListener('message', (event) => {
  if (event.data && event.data.type === 'SKIP_WAITING') {
    self.skipWaiting();
  }
});
