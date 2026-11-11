/**
 * actualizar-app — traer la última versión sin pasar por /diagnostico.
 *
 * Hay dos mecanismos automáticos (UpdateBanner: la versión en espera se
 * activa al abrir la app; a mitad de sesión pregunta). Pero en campo, con
 * señal intermitente, a veces el celular sigue mostrando la versión vieja y
 * el técnico necesita un botón que diga "actualízate ya" — sin ver la pantalla
 * de diagnóstico, que es para depurar, no para usuarios.
 *
 * Pasos:
 *  1. Pedirle al service worker que busque versión nueva (registration.update()).
 *  2. Si hay una, esperar a que termine de bajar COMPLETA (código y pantallas),
 *     activarla y recargar.
 *  3. Si no hay ninguna, comprobar que lo guardado en el celular esté completo
 *     y reponer lo que falte.
 *
 * Este botón NUNCA borra lo que ya está guardado. Antes, si no encontraba una
 * versión nueva, borraba el service worker y todas las copias para bajarlas
 * otra vez: con señal débil la descarga no terminaba y el celular quedaba sin
 * poder abrir la app sin internet, justo antes de salir a campo. Ese borrado
 * solo queda en /diagnostico ("Forzar actualización"), con su advertencia.
 *
 * IndexedDB no se toca en ningún caso: las calificaciones y fotos sin subir
 * quedan intactas.
 */
import { calentarPantallas } from './data-prefetch';

// Una versión nueva baja ~3 MB de código la primera vez y unas 18 pantallas.
const ESPERA_INSTALACION_MS = 150000;

/**
 * Espera a que la versión que se está instalando termine.
 * @returns {Promise<{estado: 'lista'|'fallo'|'sigue'|'ninguna', worker?: ServiceWorker}>}
 */
function esperarVersionNueva(reg, timeout) {
  return new Promise((resolve) => {
    if (reg.waiting) return resolve({ estado: 'lista', worker: reg.waiting });
    const instalando = reg.installing;
    if (!instalando) return resolve({ estado: 'ninguna' });
    let terminado = false;
    const fin = (r) => { if (!terminado) { terminado = true; resolve(r); } };
    instalando.addEventListener('statechange', () => {
      if (instalando.state === 'installed') fin({ estado: 'lista', worker: reg.waiting || instalando });
      // Activada sola (primera instalación): ya está en uso
      if (instalando.state === 'activated') fin({ estado: 'ninguna' });
      if (instalando.state === 'redundant') fin({ estado: 'fallo' });
    });
    setTimeout(() => fin(reg.waiting ? { estado: 'lista', worker: reg.waiting } : { estado: 'sigue' }), timeout);
  });
}

/**
 * @param {(msg: string) => void} reportar  texto de estado para la UI
 * @returns {Promise<'nueva'|'al-dia'|'fallo'|'descargando'|'sin-red'|'sin-sw'>}
 *   'nueva' y 'sin-sw' terminan en una recarga de la página; los demás no.
 */
export async function actualizarApp(reportar = () => {}) {
  if (typeof window === 'undefined') return 'sin-sw';

  let recargado = false;
  const recargar = () => {
    if (recargado) return;
    recargado = true;
    window.location.reload();
  };

  if (!navigator.onLine) {
    reportar('Sin conexión: la actualización necesita señal.');
    return 'sin-red';
  }

  if (!('serviceWorker' in navigator)) {
    reportar('Recargando…');
    recargar();
    return 'sin-sw';
  }

  reportar('Buscando versión nueva…');
  let reg = null;
  try { reg = await navigator.serviceWorker.getRegistration(); } catch { /* sin registro */ }
  if (!reg) {
    // Sin service worker registrado: al recargar, la app lo registra de nuevo
    reportar('Recargando…');
    recargar();
    return 'sin-sw';
  }

  try { await reg.update(); } catch { /* sin red estable: se revisa lo que haya */ }

  if (reg.installing && !reg.waiting) reportar('Descargando la versión nueva…');
  const nueva = await esperarVersionNueva(reg, ESPERA_INSTALACION_MS);

  if (nueva.estado === 'lista' && nueva.worker) {
    reportar('Instalando la versión nueva…');
    navigator.serviceWorker.addEventListener('controllerchange', recargar, { once: true });
    nueva.worker.postMessage({ type: 'SKIP_WAITING' });
    // Red de seguridad: si controllerchange no llega, recargar igual
    setTimeout(recargar, 3000);
    return 'nueva';
  }
  if (nueva.estado === 'fallo') {
    reportar('No se pudo bajar completa la versión nueva (señal débil). La app sigue con la que ya tiene: intenta otra vez con mejor señal.');
    return 'fallo';
  }
  if (nueva.estado === 'sigue') {
    reportar('La versión nueva sigue bajando. Cuando termine, la app se actualiza sola.');
    return 'descargando';
  }

  // No hay versión nueva: comprobar (y reponer) lo guardado en el celular.
  reportar('Comprobando lo guardado en el celular…');
  let guardado = null;
  try { guardado = await calentarPantallas(); } catch { /* se informa abajo */ }
  if (guardado?.versionNueva) {
    reportar('Hay una versión nueva bajando. Cuando termine, la app se actualiza sola.');
    return 'descargando';
  }
  reportar(guardado?.ok
    ? 'Ya tienes la última versión, completa para usar sin señal.'
    : 'Ya tienes la última versión, pero faltan pantallas por guardar: revisa la señal y toca de nuevo.');
  return 'al-dia';
}
