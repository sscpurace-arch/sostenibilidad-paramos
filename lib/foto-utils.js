/**
 * foto-utils — comprimir fotos de evidencia antes de guardarlas.
 *
 * El técnico dispara con la cámara nativa del celular, que en gama media
 * entrega archivos de 3 a 6 MB. Sin comprimir, una visita de 12 fotos son
 * 50 MB en IndexedDB y otros tantos de subida sobre una red rural. Bajarlas a
 * 1280 px / JPEG 0.7 las deja en ~200 KB sin perder nada de lo que importa:
 * la evidencia es "se ve o no se ve el árbol establecido", no un peritaje.
 */

const ANCHO_MAX = 1280;
const ANCHO_THUMB = 200;
const CALIDAD = 0.7;
const CALIDAD_FALLBACK = 0.55;
const BYTES_MAX = 350 * 1024;

/**
 * Dibuja un bitmap en canvas y devuelve un Blob JPEG.
 */
function canvasABlob(canvas, calidad) {
  return new Promise((resolve, reject) => {
    canvas.toBlob(
      (blob) => (blob ? resolve(blob) : reject(new Error('toBlob devolvió null'))),
      'image/jpeg',
      calidad
    );
  });
}

/**
 * Redimensiona una fuente (ImageBitmap o HTMLImageElement) a un ancho máximo,
 * conservando proporción. Si ya es más pequeña, no la agranda.
 */
async function redimensionar(fuente, anchoMax, calidad) {
  const w = fuente.width;
  const h = fuente.height;
  const escala = Math.min(1, anchoMax / Math.max(w, h));
  const ancho = Math.round(w * escala);
  const alto = Math.round(h * escala);

  const canvas = document.createElement('canvas');
  canvas.width = ancho;
  canvas.height = alto;
  const ctx = canvas.getContext('2d');
  ctx.drawImage(fuente, 0, 0, ancho, alto);

  const blob = await canvasABlob(canvas, calidad);
  return { blob, ancho, alto };
}

/**
 * Carga el archivo como bitmap con la orientación EXIF ya aplicada.
 *
 * `imageOrientation: 'from-image'` resuelve en un paso el clásico problema de
 * la foto vertical que sale acostada. Si el navegador no soporta
 * createImageBitmap con opciones, cae a <img>, que en Chrome moderno también
 * respeta la orientación.
 */
async function cargarBitmap(file) {
  if (typeof createImageBitmap === 'function') {
    try {
      return await createImageBitmap(file, { imageOrientation: 'from-image' });
    } catch (e) {
      // Safari viejo lanza si no reconoce las opciones — reintentar sin ellas
      try {
        return await createImageBitmap(file);
      } catch (e2) { /* cae al <img> */ }
    }
  }

  return new Promise((resolve, reject) => {
    const url = URL.createObjectURL(file);
    const img = new Image();
    img.onload = () => { URL.revokeObjectURL(url); resolve(img); };
    img.onerror = () => { URL.revokeObjectURL(url); reject(new Error('No se pudo leer la imagen')); };
    img.src = url;
  });
}

/**
 * Comprime un archivo de imagen y genera además una miniatura.
 *
 * Devuelve { blob, thumb, ancho, alto, bytes }.
 * Procesar varias fotos: hacerlo SECUENCIALMENTE. Son ~200 ms cada una en
 * gama media y en paralelo la pestaña se congela.
 */
export async function comprimirFoto(file) {
  const bitmap = await cargarBitmap(file);

  try {
    let { blob, ancho, alto } = await redimensionar(bitmap, ANCHO_MAX, CALIDAD);

    // Fotos de mucho detalle (potrero con pasto) no bajan de 350 KB a q0.7
    if (blob.size > BYTES_MAX) {
      const reintento = await redimensionar(bitmap, ANCHO_MAX, CALIDAD_FALLBACK);
      blob = reintento.blob;
    }

    const { blob: thumb } = await redimensionar(bitmap, ANCHO_THUMB, 0.6);

    return { blob, thumb, ancho, alto, bytes: blob.size };
  } finally {
    if (typeof bitmap.close === 'function') bitmap.close();
  }
}

/**
 * Ubicación de la foto.
 *
 * Se captura aparte porque recomprimir en canvas destruye el EXIF, incluido el
 * GPS. getCurrentPosition funciona sin conexión (es GPS puro, no depende de la
 * red), y permite después contrastar la foto contra las coordenadas del predio.
 *
 * NUNCA bloquea: si el GPS no engancha en 10 s, la foto se guarda sin ubicación.
 */
export function obtenerUbicacion() {
  return new Promise((resolve) => {
    if (typeof navigator === 'undefined' || !navigator.geolocation) {
      resolve({ lat: null, lng: null, precision_m: null });
      return;
    }
    navigator.geolocation.getCurrentPosition(
      (pos) => resolve({
        lat: pos.coords.latitude,
        lng: pos.coords.longitude,
        precision_m: pos.coords.accuracy ?? null,
      }),
      () => resolve({ lat: null, lng: null, precision_m: null }),
      { enableHighAccuracy: true, timeout: 10000, maximumAge: 60000 }
    );
  });
}

/**
 * Espacio disponible en el dispositivo.
 *
 * Devuelve { usage, quota, ratio, casiLleno } o null si el navegador no
 * expone la API. Se consulta antes de capturar para avisar a tiempo, no
 * cuando ya se llenó y las escrituras empiezan a fallar en silencio.
 */
export async function espacioDisponible() {
  if (typeof navigator === 'undefined' || !navigator.storage?.estimate) return null;
  try {
    const { usage = 0, quota = 0 } = await navigator.storage.estimate();
    if (!quota) return null;
    const ratio = usage / quota;
    return { usage, quota, ratio, casiLleno: ratio > 0.8 };
  } catch (e) {
    return null;
  }
}

/**
 * Pide almacenamiento persistente para que el navegador no desaloje las fotos
 * que todavía no se han subido cuando el disco se llene.
 */
export async function pedirPersistencia() {
  if (typeof navigator === 'undefined' || !navigator.storage?.persist) return false;
  try {
    if (await navigator.storage.persisted?.()) return true;
    return await navigator.storage.persist();
  } catch (e) {
    return false;
  }
}

export function formatearBytes(bytes) {
  if (!bytes) return '0 KB';
  if (bytes < 1024 * 1024) return `${Math.round(bytes / 1024)} KB`;
  return `${(bytes / (1024 * 1024)).toFixed(1)} MB`;
}
