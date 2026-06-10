// Reglas de caché por defecto de next-pwa (assets de Next, fuentes, etc.)
let defaultCache = [];
try {
  defaultCache = require('next-pwa/cache');
} catch {
  defaultCache = [];
}

const withPWA = require('next-pwa')({
  dest: 'public',
  disable: process.env.NODE_ENV === 'development',
  runtimeCaching: [
    // Teselas de OpenStreetMap — CacheFirst para que el mapa funcione sin conexión
    {
      urlPattern: /^https:\/\/tile\.openstreetmap\.org\/.*/i,
      handler: 'CacheFirst',
      options: {
        cacheName: 'osm-tiles',
        expiration: { maxEntries: 3000, maxAgeSeconds: 60 * 24 * 60 * 60 },
        cacheableResponse: { statuses: [0, 200] },
      },
    },
    // Teselas satelitales de Esri
    {
      urlPattern: /^https:\/\/server\.arcgisonline\.com\/.*/i,
      handler: 'CacheFirst',
      options: {
        cacheName: 'esri-tiles',
        expiration: { maxEntries: 1500, maxAgeSeconds: 60 * 24 * 60 * 60 },
        cacheableResponse: { statuses: [0, 200] },
      },
    },
    // Datos críticos para arranque sin conexión (semilla y perímetro del parque)
    {
      urlPattern: /\/(seed-data|purace-boundary)\.json$/i,
      handler: 'StaleWhileRevalidate',
      options: {
        cacheName: 'datos-criticos',
        expiration: { maxEntries: 4 },
      },
    },
    ...defaultCache,
  ],
});

/** @type {import('next').NextConfig} */
const nextConfig = {};

module.exports = process.env.NODE_ENV === 'production' ? withPWA(nextConfig) : nextConfig;
