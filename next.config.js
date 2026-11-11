// PWA con Serwist (sucesor mantenido de next-pwa, compatible con App Router).
// El service worker se define explícitamente en app/sw.js.
const fs = require('fs');
const path = require('path');
const crypto = require('crypto');

// Revisión nueva por build para que el documento /~offline se refresque en clientes
const revision = Date.now().toString(36);

// Archivos de public/ que el celular debe tener SIEMPRE guardados, aunque
// nunca los haya abierto con señal. Entran en la instalación de cada versión
// (todo o nada) y solo se vuelven a bajar cuando su contenido cambia.
//
// Ojo: al pasar `additionalPrecacheEntries`, Serwist deja de incluir sola la
// carpeta public/. Por eso lo que haga falta sin señal se lista aquí; antes
// estos archivos dependían de haberse usado alguna vez con señal (el PDF salía
// sin logos, el mapa sin marcadores) y la guía en PDF guardada no se
// actualizaba nunca.
const PUBLICOS_SIN_SENAL = [
  '/docs/guia-calificacion-matriz.pdf',      // guía de calificación, para consultarla en finca
  '/images/pdf/logo-patrimonio-small.png',   // logos de los PDF que genera la app
  '/images/pdf/logo-pnn-small.png',
  '/images/logo-purace-132.png',             // logos del encabezado
  '/images/logo-pnn-nacional-132.png',
  '/images/marker-icon.png',                 // marcadores del mapa
  '/images/marker-icon-2x.png',
  '/images/marker-shadow.png',
  '/icon-192x192.png',                       // ícono del aviso "Sin conexión"
];

function huella(rutaPublica) {
  const archivo = path.join(__dirname, 'public', rutaPublica);
  // Si falta un archivo de la lista, que falle el build: publicar sin él
  // dejaría la instalación de la app fallando en todos los celulares.
  return crypto.createHash('md5').update(fs.readFileSync(archivo)).digest('hex').slice(0, 12);
}

const withSerwist = require('@serwist/next').default({
  swSrc: 'app/sw.js',
  swDest: 'public/sw.js',
  disable: process.env.NODE_ENV === 'development',
  additionalPrecacheEntries: [
    // El fallback offline se sirve desde el precache: hay que incluirlo explícitamente
    { url: '/~offline', revision },
    ...PUBLICOS_SIN_SENAL.map((url) => ({ url, revision: huella(url) })),
  ],
});

/** @type {import('next').NextConfig} */
const nextConfig = {
  // El service worker NUNCA debe quedarse en la caché del servidor/CDN: justo
  // después de publicar, una copia vieja de /sw.js hacía que el celular
  // instalara el código anterior mientras las pantallas ya eran las nuevas
  // (prueba de campo, 19-oct-2026).
  async headers() {
    return [
      {
        source: '/sw.js',
        headers: [
          { key: 'Cache-Control', value: 'no-store, no-cache, must-revalidate, max-age=0' },
          { key: 'CDN-Cache-Control', value: 'no-store' },
          { key: 'Vercel-CDN-Cache-Control', value: 'no-store' },
        ],
      },
    ];
  },

  // Identificador de versión visible en /diagnostico. Sin esto no hay forma de
  // saber si el celular está corriendo la versión nueva o una vieja cacheada.
  env: {
    NEXT_PUBLIC_BUILD_ID:
      (process.env.VERCEL_GIT_COMMIT_SHA || '').slice(0, 7) || revision,
  },
};

module.exports = withSerwist(nextConfig);
