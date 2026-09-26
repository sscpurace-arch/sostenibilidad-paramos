/**
 * Clasificación de fallas al subir binarios (fotos, PDF) a Storage.
 * La usan lib/foto-sync.js y lib/reporte-sync.js.
 */

/**
 * ¿Falló la RED y no el archivo? (sin señal, señal débil que no termina,
 * corte por tiempo límite). Esos intentos NO deben contar para el tope de
 * reintentos: con "una rayita" en el páramo, cinco cortes seguidos dejaban la
 * foto marcada como fallida para siempre aunque no tuviera nada malo.
 */
export function esErrorDeRed(error) {
  if (typeof navigator !== 'undefined' && !navigator.onLine) return true;
  if (!error) return false;
  const status = error.statusCode ?? error.status;
  if (status !== undefined && status !== null && status !== '' && Number(status) !== 0) return false;
  const nombre = String(error.name || '') + ' ' + String(error.originalError?.name || '');
  const texto = String(error.message || '') + ' ' + String(error.originalError?.message || '');
  return /AbortError|TypeError|StorageUnknownError|FetchError/i.test(nombre) ||
    /fetch|network|timeout|abort|load failed|conexi/i.test(texto);
}

/**
 * ¿El error impide reintentar? Un archivo inválido o un path mal formado va a
 * fallar igual las 5 veces; solo gasta batería y datos del técnico.
 * 401 (sesión vencida) NO es permanente: pasa sola al renovar la sesión.
 */
export function esFalloPermanente(error) {
  const bruto = (error && (error.statusCode !== undefined ? error.statusCode : error.status));
  const n = typeof bruto === 'string' ? parseInt(bruto, 10) : bruto;
  return n === 400 || n === 403 || n === 413 || n === 415;
}

// Cada cuánto se reintentan las subidas pendientes con la app abierta
export const REINTENTO_SUBIDAS_MS = 3 * 60 * 1000;
