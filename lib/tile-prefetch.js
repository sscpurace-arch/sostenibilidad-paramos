/**
 * Pre-descarga de teselas de mapa (OSM) para la zona del PNN Puracé,
 * de modo que el mapa funcione sin conexión en campo.
 *
 * Las peticiones pasan por el service worker (regla CacheFirst 'osm-tiles'
 * en next.config.js), que es quien realmente las guarda.
 */

// Zona de demo: PNN Puracé y alrededores
const REGION = { minLat: 2.25, maxLat: 2.45, minLng: -76.55, maxLng: -76.25 };
// Detalle extra (zoom 16) solo alrededor del centro del área de trabajo
const CENTER = { lat: 2.342, lng: -76.385, delta: 0.025 };

const FLAG = 'osm-tiles-prefetched-v1';
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

function tilesForBbox(bbox, z) {
  const x1 = lngToTileX(bbox.minLng, z);
  const x2 = lngToTileX(bbox.maxLng, z);
  const y1 = latToTileY(bbox.maxLat, z); // lat mayor → y menor
  const y2 = latToTileY(bbox.minLat, z);
  const urls = [];
  for (let x = x1; x <= x2; x++) {
    for (let y = y1; y <= y2; y++) {
      urls.push(TILE_URL(z, x, y));
    }
  }
  return urls;
}

export function tilesYaDescargadas() {
  if (typeof window === 'undefined') return true;
  return !!localStorage.getItem(FLAG);
}

/**
 * Descarga las teselas de la zona de demo (zoom 11–15 + 16 cerca del centro).
 * onProgress(hechas, total) se llama por lote. Devuelve true si terminó.
 */
export async function prefetchDemoTiles(onProgress) {
  if (typeof window === 'undefined' || !navigator.onLine) return false;
  if (tilesYaDescargadas()) return true;
  // Sin service worker (modo desarrollo) no tiene sentido descargar
  if (!('serviceWorker' in navigator) || !navigator.serviceWorker.controller) return false;

  const urls = [];
  for (let z = 11; z <= 15; z++) {
    urls.push(...tilesForBbox(REGION, z));
  }
  urls.push(
    ...tilesForBbox(
      {
        minLat: CENTER.lat - CENTER.delta,
        maxLat: CENTER.lat + CENTER.delta,
        minLng: CENTER.lng - CENTER.delta,
        maxLng: CENTER.lng + CENTER.delta,
      },
      16
    )
  );

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

  // Si fallaron demasiadas, no marcar como completado para reintentar luego
  if (fallos > urls.length * 0.1) return false;
  localStorage.setItem(FLAG, new Date().toISOString());
  return true;
}
