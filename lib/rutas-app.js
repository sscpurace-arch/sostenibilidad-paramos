/**
 * Pantallas que deben abrir sin señal. UN solo sitio para la lista: la usan
 *  - el service worker (app/sw.js), que guarda una copia de cada una al
 *    instalar cada versión de la app;
 *  - el middleware, que deja pasar esa descarga aunque no haya sesión;
 *  - lib/data-prefetch.js ("Preparar" y la pantalla de diagnóstico).
 *
 * Son cascarones estáticos: no llevan datos de ningún productor ni de ningún
 * usuario (eso sale de IndexedDB en el celular), por eso se pueden guardar
 * sin sesión.
 *
 * Al agregar a la app una pantalla que el técnico use en campo, agregarla
 * aquí. Sin eso, sin señal cae al aviso "Sin conexión".
 */
export const RUTAS_APP = [
  '/', '/buscar', '/en-proceso', '/nuevo-productor',
  '/calificacion', '/calificacion/nueva', '/mapa', '/mapa/detalle', '/diagnostico',
];

/** Cabecera con la que el service worker pide esas copias al servidor. */
export const CABECERA_COPIA = 'x-copia-sin-senal';
