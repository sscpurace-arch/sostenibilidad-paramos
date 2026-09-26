/**
 * Pre-descarga de teselas de mapa (OSM) para que el mapa funcione sin
 * conexión en campo.
 *
 * La zona sale de las COORDENADAS REALES de los productores guardados en el
 * celular, no de un rectángulo fijo. Antes se descargaba un rectángulo
 * alrededor del parque (lat 2,25–2,45) y 249 de las 270 fincas —que están
 * más al sur y al occidente, hacia Paletará y Sotará— quedaban por fuera:
 * sin señal, el mapa de esas fincas salía en gris.
 *
 * Qué se baja (~1.000 teselas, unos 15–25 MB):
 *  - zoom 11–14: la zona de las fincas + el perímetro del parque
 *  - zoom 15: la zona de las fincas
 *  - zoom 16: un cuadro de 3×3 teselas (~1,8 km) alrededor de cada finca
 *
 * Las peticiones pasan por el service worker (regla CacheFirst 'osm-tiles'
 * en app/sw.js), que es quien realmente las guarda.
 */
import { db } from './db-offline';

// Perímetro aproximado del PNN Puracé (siempre se incluye)
const PARQUE = { minLat: 2.25, maxLat: 2.45, minLng: -76.55, maxLng: -76.25 };
// Margen alrededor de las fincas (~2 km)
const MARGEN = 0.02;

// La marca guarda también la "firma" de la zona: si aparecen productores
// nuevos fuera de lo ya descargado, se vuelve a descargar lo que falte.
const FLAG = 'osm-tiles-prefetched-v2';
const TILE_URL = (z, x, y) => `https://tile.openstreetmap.org/${z}/${x}/${y}.png`;

function lngToTileX(lng, z) {
  return Math.floor(((lng + 180) / 360) * Math.pow(2, z));
}

function latToTileY(lat, z) {
  const rad = (lat * Math.PI) / 180;
  return Math.floor(
    ((1 - Math.log(Math.tan(rad) + 1 / Math.cos(rad)) / Math.PI) / 2) * Math.pow(2, z)
  );
}

function agregarBbox(set, bbox, z) {
  const x1 = lngToTileX(bbox.minLng, z);
  const x2 = lngToTileX(bbox.maxLng, z);
  const y1 = latToTileY(bbox.maxLat, z); // lat mayor → y menor
  const y2 = latToTileY(bbox.minLat, z);
  for (let x = x1; x <= x2; x++) {
    for (let y = y1; y <= y2; y++) set.add(TILE_URL(z, x, y));
  }
}

async function coordenadasProductores() {
  try {
    const prods = await db.productores.toArray();
    return prods
      .map((p) => [Number(p.ubicacion_lat), Number(p.ubicacion_lng)])
      .filter(([lat, lng]) => Number.isFinite(lat) && Number.isFinite(lng) && lat !== 0 && lng !== 0);
  } catch {
    return [];
  }
}

function teselasParaCampo(coords) {
  const urls = new Set();
  for (let z = 11; z <= 14; z++) agregarBbox(urls, PARQUE, z);
  if (coords.length) {
    const lats = coords.map((c) => c[0]);
    const lngs = coords.map((c) => c[1]);
    const zona = {
      minLat: Math.min(...lats) - MARGEN,
      maxLat: Math.max(...lats) + MARGEN,
      minLng: Math.min(...lngs) - MARGEN,
      maxLng: Math.max(...lngs) + MARGEN,
    };
    for (let z = 11; z <= 15; z++) agregarBbox(urls, zona, z);
    for (const [lat, lng] of coords) {
      const x = lngToTileX(lng, 16);
      const y = latToTileY(lat, 16);
      for (let dx = -1; dx <= 1; dx++) {
        for (let dy = -1; dy <= 1; dy++) urls.add(TILE_URL(16, x + dx, y + dy));
      }
    }
  }
  return [...urls];
}

// Firma corta de la zona: cambia si cambian las fincas
function firma(urls) {
  let h = 0;
  for (const u of urls) {
    for (let i = 0; i < u.length; i++) h = (h * 31 + u.charCodeAt(i)) | 0;
  }
  return `${urls.length}:${h}`;
}

function leerMarca() {
  try { return JSON.parse(localStorage.getItem(FLAG) || 'null'); } catch { return null; }
}

export function tilesYaDescargadas() {
  if (typeof window === 'undefined') return true;
  return !!leerMarca();
}

/**
 * Descarga las teselas de la zona de trabajo. Idempotente: si la zona no
 * cambió desde la última descarga completa, no hace nada.
 * onProgress(hechas, total) se llama por lote. Devuelve true si terminó.
 */
export async function prefetchDemoTiles(onProgress) {
  if (typeof window === 'undefined' || !navigator.onLine) return false;
  // Sin service worker (modo desarrollo) no tiene sentido descargar
  if (!('serviceWorker' in navigator) || !navigator.serviceWorker.controller) return false;

  const coords = await coordenadasProductores();
  const hayFincas = coords.length > 0;
  const urls = teselasParaCampo(coords);
  const f = firma(urls);
  if (leerMarca()?.firma === f) return true;

  const CONCURRENCY = 6;
  let fallos = 0;
  for (let i = 0; i < urls.length; i += CONCURRENCY) {
    if (!navigator.onLine) return false;
    const lote = urls.slice(i, i + CONCURRENCY);
    await Promise.all(
      lote.map((u) =>
        fetch(u, { mode: 'cors' }).then(
          (r) => { if (!r.ok) fallos++; },
          () => { fallos++; }
        )
      )
    );
    onProgress?.(Math.min(i + CONCURRENCY, urls.length), urls.length);
  }

  // Si fallaron demasiadas, no marcar como completado para reintentar luego.
  // Tampoco si todavía no había productores: faltan las teselas de las fincas.
  if (fallos > urls.length * 0.1 || !hayFincas) return false;
  try {
    localStorage.setItem(FLAG, JSON.stringify({ fecha: new Date().toISOString(), firma: f, teselas: urls.length }));
  } catch { /* silent */ }
  return true;
}
