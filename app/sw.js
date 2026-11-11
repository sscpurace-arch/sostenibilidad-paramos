// Service worker de la app (compilado por @serwist/next en el build).
// Objetivo: que la app arranque y funcione completa sin conexión
// después de haberse abierto al menos una vez con internet.
//
// ─── Regla de oro: UNA VERSIÓN COMPLETA O NINGUNA ──────────────────────────
// Cada pantalla es un documento que pide archivos de código con nombre propio
// de su versión. Hasta nov-2026 el celular guardaba las pantallas y el código
// en dos pasos distintos (el código al instalar la versión; las pantallas
// después, desde la página, con peticiones sueltas). Si la señal se cortaba
// entre un paso y el otro —lo normal en el páramo— quedaban pantallas de una
// versión con código de otra y, sin señal, la pantalla se quedaba en
// "Cargando…" para siempre (pruebas de campo de sep y oct-2026).
//
// Ahora:
//  1. Al INSTALAR una versión se bajan su código Y sus pantallas. Si algo
//     falla por la señal, la instalación entera falla y el celular sigue con la
//     versión anterior, que está completa.
//  2. Solo se guardan pantallas que sean de ESTA versión (se comprueba el
//     identificador de versión dentro de cada una).
//  3. Si el servidor entrega una pantalla de otra versión (recién publicada, o
//     una copia vieja de la red de distribución), se sirve la copia guardada:
//     la página siempre corre con el código que el celular tiene completo. La
//     versión nueva entra entera, por el paso 1.
import { defaultCache } from '@serwist/next/worker';
import {
  Serwist,
  CacheFirst,
  NetworkOnly,
  StaleWhileRevalidate,
  ExpirationPlugin,
  CacheableResponsePlugin,
} from 'serwist';
import { RUTAS_APP, CABECERA_COPIA } from '../lib/rutas-app.js';

// Lista de archivos de esta versión (la inyecta el build; debe aparecer una
// sola vez en este archivo).
const MANIFIESTO = self.__SW_MANIFEST || [];
const urlDe = (entrada) => (typeof entrada === 'string' ? entrada : entrada.url);

// Identificador de la versión: el mismo que Next escribe dentro de cada
// pantalla y de cada carga interna. Sale del nombre de un archivo del build.
const VERSION = (() => {
  for (const entrada of MANIFIESTO) {
    const m = /\/_next\/static\/([^/]+)\/_buildManifest\.js$/.exec(urlDe(entrada));
    if (m) return m[1];
  }
  return null;
})();
// Etiqueta para nombrar los cachés. Si no se pudo leer la versión se usa la
// revisión del aviso "Sin conexión", que también cambia en cada build.
const ETIQUETA = VERSION
  || (MANIFIESTO.find((e) => urlDe(e) === '/~offline') || {}).revision
  || 'sin-version';

const CACHE_HTML = `pantallas-${ETIQUETA}`;      // documentos de las pantallas
const CACHE_RSC = `pantallas-rsc-${ETIQUETA}`;   // cargas internas (navegación sin recargar)
// Cachés de versiones anteriores de este archivo: se borran al activar.
const CACHES_ANTIGUOS = ['paginas-html', 'rsc-paginas', 'rsc-paginas-v2'];

// Cuánto se espera al servidor antes de abrir la copia guardada. Con "una
// rayita" de señal el servidor no contesta y la pantalla no puede quedarse
// esperando.
const ESPERA_RED_MS = 2500;
const ESPERA_COPIA_MS = 20000;

const esperar = (ms) => new Promise((r) => setTimeout(r, ms));
const esDeEstaVersion = (texto) => !VERSION || texto.includes(VERSION);
const claveDe = (ruta) => self.location.origin + ruta;

function conLimite(promesa, ms) {
  return new Promise((resolve, reject) => {
    const t = setTimeout(() => reject(new Error('tiempo')), ms);
    promesa.then(
      (v) => { clearTimeout(t); resolve(v); },
      (e) => { clearTimeout(t); reject(e); },
    );
  });
}

/**
 * Copia para guardar: solo el contenido y su tipo. Se arma de cero para que
 * NO herede la dirección con la que se bajó ni la marca de redirección: Next
 * usa la dirección de la respuesta para decidir a dónde ir, y una copia
 * guardada con otra dirección abría el productor sin su ?productor=
 * ("No se indicó qué productor abrir", iPhone, 30-sep-2026).
 */
function copiaLimpia(texto, original) {
  const headers = new Headers();
  for (const nombre of ['content-type', 'vary']) {
    const valor = original.headers.get(nombre);
    if (valor) headers.set(nombre, valor);
  }
  headers.set('x-version-app', ETIQUETA);
  return new Response(texto, { status: 200, statusText: 'OK', headers });
}

const serwist = new Serwist({
  precacheEntries: MANIFIESTO,
  // No activar la versión nueva automáticamente: queda en estado "waiting"
  // hasta que la página lo pide (ver components/UpdateBanner.jsx).
  // En la primera instalación (sin SW previo) igual se activa de inmediato.
  skipWaiting: false,
  clientsClaim: true,
  navigationPreload: true,
  runtimeCaching: [
    // Pantallas (navegaciones): ver responderPantalla. Los archivos sueltos que
    // se abren como navegación (la guía en PDF) no entran aquí.
    {
      matcher: ({ request, url, sameOrigin }) =>
        sameOrigin && request.mode === 'navigate' && !/\.[a-z0-9]{2,5}$/i.test(url.pathname),
      handler: (opciones) => responderPantalla(opciones, false),
    },
    // Cargas internas de Next (navegación entre pantallas sin recargar).
    {
      matcher: ({ url, request, sameOrigin }) =>
        sameOrigin && (url.searchParams.has('_rsc') || request.headers.has('RSC')),
      handler: (opciones) => responderPantalla(opciones, true),
    },
    // Rutas del servidor (/api/seed trae cédulas y coordenadas): nunca se
    // guardan en el celular por esta vía. Los datos viven en IndexedDB.
    {
      matcher: ({ url, sameOrigin }) => sameOrigin && url.pathname.startsWith('/api/'),
      handler: new NetworkOnly(),
    },
    // Teselas de OpenStreetMap — CacheFirst para que el mapa funcione sin conexión.
    // SIN vencimiento por edad: antes vencían a los 60 días y, como la marca de
    // "ya descargadas" no vencía, el mapa quedaba en gris sin aviso. El mapa
    // del páramo casi no cambia; solo se limita la cantidad (las menos usadas
    // salen primero). lib/tile-prefetch.js baja ~1.000 para la zona de trabajo.
    {
      matcher: /^https:\/\/tile\.openstreetmap\.org\/.*/i,
      handler: new CacheFirst({
        cacheName: 'osm-tiles',
        plugins: [
          new ExpirationPlugin({ maxEntries: 4000, purgeOnQuotaError: true }),
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
    // Datos críticos para arranque sin conexión (semilla del modo prueba y
    // perímetro del parque).
    {
      matcher: /\/(seed-demo|purace-boundary)\.json$/i,
      handler: new StaleWhileRevalidate({
        cacheName: 'datos-criticos',
        plugins: [new ExpirationPlugin({ maxEntries: 4 })],
      }),
    },
    // Otros PDF de /docs (la guía de calificación va precargada con la
    // versión: ver next.config.js). Se renuevan solos cuando hay señal: con
    // CacheFirst el celular se quedaba para siempre con la guía vieja.
    {
      matcher: /\/docs\/.*\.pdf$/i,
      handler: new StaleWhileRevalidate({
        cacheName: 'guias-pdf',
        plugins: [new ExpirationPlugin({ maxEntries: 5 })],
      }),
    },
    // Reglas por defecto de Serwist para Next.js: imágenes, fuentes, etc.
    ...defaultCache,
  ],
  // Respaldo para documentos que no pasan por responderPantalla.
  fallbacks: {
    entries: [
      {
        url: '/~offline',
        matcher: ({ request }) => request.destination === 'document',
      },
    ],
  },
});

/**
 * Responde una pantalla (documento) o una carga interna.
 *
 * - Carga interna con copia de esta versión: se sirve la copia de una vez. El
 *   contenido de una versión no cambia, así que no hay nada que ganar
 *   esperando a la red, y con señal débil cada cambio de pestaña tardaba
 *   segundos.
 * - Documento: primero el servidor (así valen sus redirecciones: login,
 *   completar registro), pero solo se le espera ESPERA_RED_MS si hay copia.
 * - Si lo que llega del servidor es de otra versión, gana la copia guardada.
 * - Sin red y sin copia: aviso "Sin conexión" (solo documentos).
 */
async function responderPantalla({ request, event, url }, esInterna) {
  const cache = await caches.open(esInterna ? CACHE_RSC : CACHE_HTML);
  const clave = url.origin + url.pathname;
  const copia = await cache.match(clave);

  if (esInterna && copia) return copia;

  const red = (async () => {
    // Precarga de navegación: el navegador ya empezó a pedir la pantalla
    // mientras arrancaba el service worker.
    if (request.mode === 'navigate' && event && 'preloadResponse' in event) {
      try {
        const precarga = await event.preloadResponse;
        if (precarga) return precarga;
      } catch { /* se pide normal */ }
    }
    return fetch(request);
  })();
  red.catch(() => {}); // si se abandona por tiempo, que no quede un error suelto

  let respuesta = null;
  try {
    respuesta = copia ? await conLimite(red, ESPERA_RED_MS) : await red;
  } catch {
    respuesta = null;
  }

  if (respuesta) {
    // Redirecciones y errores: tal cual, sin guardar. (Guardar la redirección
    // a /login dejaría el login pegado como si fuera la pantalla.)
    if (respuesta.status !== 200 || respuesta.redirected) return respuesta;
    let texto = null;
    try { texto = await respuesta.clone().text(); } catch { return respuesta; }
    if (esDeEstaVersion(texto)) {
      if (!copia && event) {
        event.waitUntil(cache.put(clave, copiaLimpia(texto, respuesta)).catch(() => {}));
      }
      return respuesta;
    }
    // El servidor ya va en otra versión (o entregó una copia vieja): con la
    // copia guardada la pantalla usa el código que el celular tiene completo.
    return copia || respuesta;
  }

  if (copia) return copia;
  if (!esInterna) {
    const sinConexion = await serwist.matchPrecache('/~offline');
    if (sinConexion) return sinConexion;
  }
  return Response.error();
}

// ─── Guardar las pantallas de esta versión ────────────────────────────────

/** Baja del servidor la copia de una pantalla. */
async function bajarCopia(ruta, esInterna) {
  const headers = { [CABECERA_COPIA]: '1' };
  if (esInterna) headers.RSC = '1';
  let motivo = 'sin respuesta del servidor';
  let tipo = 'red';
  for (let intento = 1; intento <= 3; intento++) {
    const control = new AbortController();
    const t = setTimeout(() => control.abort(), ESPERA_COPIA_MS);
    try {
      // El parámetro cambia en cada petición para que el servidor entregue la
      // pantalla recién publicada y no una copia vieja de su red de
      // distribución.
      const res = await fetch(`${ruta}?_cb=${Date.now()}`, {
        headers, cache: 'no-store', credentials: 'same-origin', signal: control.signal,
      });
      if (res.redirected) return { tipo: 'servidor', motivo: 'el servidor la redirigió' };
      // Un error pasajero del servidor (5xx, 429) se trata como falla de red:
      // se reintenta y, si sigue, la instalación falla y queda la versión
      // anterior completa. Antes la versión se instalaba sin esa pantalla.
      if (res.status >= 500 || res.status === 429) {
        tipo = 'red';
        motivo = `el servidor dice ${res.status}`;
        if (intento < 3) await esperar(800 * intento);
        continue;
      }
      if (res.status !== 200) return { tipo: 'servidor', motivo: `el servidor dice ${res.status}` };
      const esperado = esInterna ? 'text/x-component' : 'text/html';
      if (!(res.headers.get('content-type') || '').includes(esperado)) {
        return { tipo: 'servidor', motivo: 'el servidor contestó otra cosa' };
      }
      const texto = await res.text();
      if (esDeEstaVersion(texto)) return { copia: copiaLimpia(texto, res) };
      tipo = 'otra-version';
      motivo = 'el servidor ya tiene otra versión de la app';
    } catch {
      tipo = 'red';
      motivo = 'sin respuesta del servidor';
    } finally {
      clearTimeout(t);
    }
    if (intento < 3) await esperar(800 * intento);
  }
  return { tipo, motivo };
}

let _guardando = null;

/**
 * Deja guardadas las pantallas de esta versión que falten.
 * @returns {Promise<{ok:boolean, falta:string[], motivos:string[], fatal:boolean, otraVersion:boolean}>}
 *   fatal: faltó alguna por la señal o porque el servidor ya va en otra
 *   versión (lo que el servidor rechaza de plano no es fatal: no se arregla
 *   reintentando y no debe impedir instalar la versión que lo corrige).
 */
function guardarPantallas() {
  if (!_guardando) _guardando = _guardarPantallas().finally(() => { _guardando = null; });
  return _guardando;
}

async function _guardarPantallas() {
  const falta = new Set();
  const motivos = [];
  let fatal = false;
  let otraVersion = false;
  let cortar = null; // si la red o la versión fallan, no insistir con las demás

  for (const [nombre, esInterna] of [[CACHE_HTML, false], [CACHE_RSC, true]]) {
    const cache = await caches.open(nombre);
    for (const ruta of RUTAS_APP) {
      const clave = claveDe(ruta);
      if (await cache.match(clave)) continue;
      if (cortar) { falta.add(ruta); continue; }

      const r = await bajarCopia(ruta, esInterna);
      if (r.copia) {
        try {
          await cache.put(clave, r.copia);
          continue;
        } catch (e) {
          r.tipo = 'celular';
          r.motivo = `no se pudo guardar en el celular (${String(e?.name || e).slice(0, 40)})`;
        }
      }
      falta.add(ruta);
      motivos.push(`pantalla ${ruta}: ${r.motivo}`);
      if (r.tipo !== 'servidor') {
        fatal = true;
        cortar = r.tipo;
        if (r.tipo === 'otra-version') otraVersion = true;
      }
    }
  }
  return { ok: falta.size === 0, falta: [...falta], motivos, fatal, otraVersion };
}

// ─── Comprobar y reparar el código de esta versión ────────────────────────

const nombreCorto = (url) => String(url).split('?')[0].split('/').slice(-2).join('/');

/**
 * ¿Lo guardado bajo esta dirección es otra cosa? Un archivo (.js, .css, .pdf,
 * .png…) cuyo contenido es una página web: pasa cuando el servidor contesta
 * con una redirección (p. ej. al login) y se guarda el destino.
 */
function esCopiaEquivocada(url, respuesta) {
  const esArchivo = /\.[a-z0-9]{2,5}$/i.test(new URL(url, self.location.origin).pathname);
  return esArchivo && (respuesta.headers.get('content-type') || '').includes('text/html');
}

/** Archivos de esta versión que no están guardados, o lo están mal (direcciones completas). */
async function codigoQueFalta() {
  const cache = await caches.open(serwist.precacheStrategy.cacheName);
  const faltan = [];
  for (const [url, clave] of serwist.getUrlsToPrecacheKeys()) {
    const guardado = await cache.match(clave);
    if (!guardado || esCopiaEquivocada(url, guardado)) faltan.push(url);
  }
  return faltan;
}

/** Vuelve a bajar los archivos de código que el celular haya perdido. */
async function repararCodigo() {
  const faltan = await codigoQueFalta();
  if (faltan.length === 0) return { motivos: [], otraVersion: false };
  const cache = await caches.open(serwist.precacheStrategy.cacheName);
  const motivos = [];
  let otraVersion = false;
  for (const url of faltan) {
    try {
      const res = await fetch(url, { cache: 'no-store', credentials: 'same-origin' });
      if (res.status === 200 && !res.redirected && !esCopiaEquivocada(url, res)) {
        await cache.put(serwist.getPrecacheKeyForUrl(url), res);
      } else if (res.redirected || res.status === 200) {
        motivos.push(`${nombreCorto(url)} (el servidor entregó otra cosa)`);
      } else {
        // El servidor ya no tiene los archivos de esta versión: solo queda
        // pasar a la versión nueva.
        if (res.status === 404) otraVersion = true;
        motivos.push(`${nombreCorto(url)} (el servidor dice ${res.status})`);
      }
    } catch (e) {
      motivos.push(`${nombreCorto(url)} (sin respuesta: ${String(e?.name || e).slice(0, 30)})`);
    }
  }
  return { motivos, otraVersion };
}

/** Qué hay guardado ahora mismo, leído de los cachés (no de una marca). */
async function estadoActual() {
  const [html, rsc] = await Promise.all([caches.open(CACHE_HTML), caches.open(CACHE_RSC)]);
  const falta = [];
  for (const ruta of RUTAS_APP) {
    const clave = claveDe(ruta);
    if (!(await html.match(clave)) || !(await rsc.match(clave))) falta.push(ruta);
  }
  const archivosFaltan = (await codigoQueFalta()).map(nombreCorto);
  return {
    total: RUTAS_APP.length,
    guardadas: RUTAS_APP.length - falta.length,
    falta,
    archivosFaltan,
    archivos: serwist.getPrecachedUrls().length,
  };
}

/**
 * @param {boolean} otrasVersiones  borrar también las pantallas de otras
 *   versiones. SOLO al activar: desde un mensaje, la versión activa borraba
 *   las pantallas que la versión nueva estaba guardando en ese momento.
 */
async function borrarCachesAntiguos(otrasVersiones = false) {
  try {
    for (const nombre of await caches.keys()) {
      const esPantallasDeOtraVersion = otrasVersiones &&
        nombre.startsWith('pantallas-') && nombre !== CACHE_HTML && nombre !== CACHE_RSC;
      if (CACHES_ANTIGUOS.includes(nombre) || esPantallasDeOtraVersion) await caches.delete(nombre);
    }
  } catch { /* sin Cache API */ }
}

// ─── Ciclo de vida ────────────────────────────────────────────────────────

// Instalar = código (lo hace Serwist) + pantallas (esto). Si las pantallas no
// se pueden bajar por la señal, la instalación falla y el navegador la
// reintenta en la siguiente revisión; mientras tanto sigue la versión
// anterior, completa.
self.addEventListener('install', (event) => {
  event.waitUntil((async () => {
    const r = await guardarPantallas();
    if (r.fatal) {
      throw new Error(`Versión ${ETIQUETA} sin instalar: ${r.motivos.join('; ')}`);
    }
    // Si otra versión borró estos cachés mientras se llenaban (las copias
    // quedan en un caché huérfano), no dar la instalación por buena.
    if (!(await caches.has(CACHE_HTML)) || !(await caches.has(CACHE_RSC))) {
      throw new Error(`Versión ${ETIQUETA} sin instalar: las pantallas guardadas se borraron durante la instalación`);
    }
  })());
});

serwist.addEventListeners();

// Al activar: fuera las pantallas de versiones anteriores (su código ya lo
// borró Serwist). Solo son copias de pantallas: los datos del técnico viven
// en IndexedDB y no se tocan.
self.addEventListener('activate', (event) => {
  // De paso se repone cualquier archivo que haya quedado mal guardado.
  event.waitUntil(Promise.all([
    borrarCachesAntiguos(true),
    repararCodigo().catch(() => {}),
  ]));
});

// Mensajes de la página.
//  - SKIP_WAITING: activar la versión en espera (components/UpdateBanner.jsx).
//  - PANTALLAS: informar qué hay guardado ('estado') o completar lo que falte
//    ('guardar'). Contesta por el puerto que trae el mensaje: primero un acuse
//    de recibo inmediato (así la página distingue un service worker viejo, que
//    no contesta) y luego el resultado.
self.addEventListener('message', (event) => {
  const datos = event.data;
  if (!datos) return;
  if (datos.type === 'SKIP_WAITING') {
    self.skipWaiting();
    return;
  }
  if (datos.type !== 'PANTALLAS') return;
  const puerto = event.ports && event.ports[0];
  if (!puerto) return;
  puerto.postMessage({ recibido: true, version: ETIQUETA });
  event.waitUntil((async () => {
    let resultado;
    try {
      if (datos.accion === 'guardar') {
        await borrarCachesAntiguos();
        const codigo = await repararCodigo();
        const pantallas = await guardarPantallas();
        resultado = {
          ...(await estadoActual()),
          motivos: [...pantallas.motivos, ...codigo.motivos],
          otraVersion: pantallas.otraVersion || codigo.otraVersion,
        };
      } else {
        resultado = { ...(await estadoActual()), motivos: [], otraVersion: false };
      }
    } catch (e) {
      resultado = { error: String(e?.message || e).slice(0, 200) };
    }
    puerto.postMessage({ ...resultado, version: ETIQUETA, listo: true });
  })());
});
