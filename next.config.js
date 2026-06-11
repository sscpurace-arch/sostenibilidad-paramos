// PWA con Serwist (sucesor mantenido de next-pwa, compatible con App Router).
// El service worker se define explícitamente en app/sw.js.
// Revisión nueva por build para que el documento /~offline se refresque en clientes
const revision = Date.now().toString(36);

const withSerwist = require('@serwist/next').default({
  swSrc: 'app/sw.js',
  swDest: 'public/sw.js',
  disable: process.env.NODE_ENV === 'development',
  // El fallback offline se sirve desde el precache: hay que incluirlo explícitamente
  additionalPrecacheEntries: [{ url: '/~offline', revision }],
});

/** @type {import('next').NextConfig} */
const nextConfig = {};

module.exports = withSerwist(nextConfig);
