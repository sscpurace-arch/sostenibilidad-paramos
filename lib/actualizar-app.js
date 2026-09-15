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
 *  2. Si hay una versión instalada esperando, activarla y recargar.
 *  3. Si no apareció nada nuevo, limpieza dura: desregistrar el service
 *     worker, borrar los cachés y recargar desde el servidor.
 *     IndexedDB NO se toca: las calificaciones y fotos sin subir quedan intactas.
 *
 * El paso 3 solo se hace con señal: sin red y sin caché la app no volvería a
 * abrir hasta tener conexión.
 */

const ESPERA_INSTALACION_MS = 7000;

function esperar(ms) {
  return new Promise((r) => setTimeout(r, ms));
}

// Devuelve el worker en espera (instalado, listo para activarse) o null si en
// `timeout` ms no apareció ninguno.
function esperarWorkerEnEspera(reg, timeout) {
  return new Promise((resolve) => {
    if (reg.waiting) return resolve(reg.waiting);
    let terminado = false;
    const fin = (w) => { if (!terminado) { terminado = true; resolve(w); } };
    const vigilar = (worker) => {
      if (!worker) return;
      worker.addEventListener('statechange', () => {
        if (worker.state === 'installed') fin(reg.waiting || worker);
        if (worker.state === 'redundant') fin(null);
      });
    };
    vigilar(reg.installing);
    reg.addEventListener('updatefound', () => vigilar(reg.installing));
    setTimeout(() => fin(reg.waiting || null), timeout);
  });
}

/**
 * @param {(msg: string) => void} reportar  texto de estado para la UI
 * @returns {Promise<'nueva'|'limpiado'|'sin-red'|'sin-sw'>}
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

  if (reg) {
    try { await reg.update(); } catch { /* sin red estable: se sigue al paso 3 */ }
    const nuevo = await esperarWorkerEnEspera(reg, ESPERA_INSTALACION_MS);
    if (nuevo) {
      reportar('Instalando la versión nueva…');
      navigator.serviceWorker.addEventListener('controllerchange', recargar, { once: true });
      nuevo.postMessage({ type: 'SKIP_WAITING' });
      // Red de seguridad: si controllerchange no llega, recargar igual
      setTimeout(recargar, 3000);
      return 'nueva';
    }
  }

  // Nada nuevo en espera: puede ser que ya esté al día, o que el caché esté
  // trabado. Limpieza dura y recarga desde el servidor (IndexedDB intacta).
  reportar('Limpiando la versión guardada…');
  try {
    const regs = await navigator.serviceWorker.getRegistrations();
    await Promise.all(regs.map((r) => r.unregister()));
    if ('caches' in window) {
      const claves = await caches.keys();
      await Promise.all(claves.map((k) => caches.delete(k)));
    }
  } catch { /* si algo falla, la recarga normal sigue siendo mejor que nada */ }
  await esperar(300);
  recargar();
  return 'limpiado';
}
