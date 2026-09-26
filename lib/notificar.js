/**
 * Aviso por Telegram de "calificación enviada", con cola para trabajar sin
 * señal. Antes, si el técnico enviaba en finca sin cobertura, el fetch fallaba
 * en silencio y el aviso se perdía para siempre. Ahora queda guardado en el
 * celular y sale cuando vuelve la conexión.
 */
const COLA_KEY = 'notificaciones-pendientes-v1';
const MAX_EN_COLA = 50;

function leerCola() {
  try { return JSON.parse(localStorage.getItem(COLA_KEY) || '[]'); } catch { return []; }
}

function escribirCola(cola) {
  try { localStorage.setItem(COLA_KEY, JSON.stringify(cola.slice(-MAX_EN_COLA))); } catch { /* silent */ }
}

async function enviar(body) {
  const res = await fetch('/api/notificar', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'x-notify-key': process.env.NEXT_PUBLIC_NOTIFY_KEY || '',
    },
    body: JSON.stringify(body),
  });
  // 4xx = el servidor lo rechazó (llave, configuración): reintentar no sirve
  if (res.status >= 500) throw new Error(`notificar ${res.status}`);
}

/** Envía el aviso ya, o lo deja en cola si no hay señal. */
export async function notificarEnvio(body) {
  if (typeof window === 'undefined') return;
  if (!navigator.onLine) {
    escribirCola([...leerCola(), body]);
    return;
  }
  try {
    await enviar(body);
  } catch {
    escribirCola([...leerCola(), body]);
  }
}

let _enviando = false;

/** Manda los avisos que quedaron en cola. Se llama al abrir la app y al volver la señal. */
export async function enviarNotificacionesPendientes() {
  if (typeof window === 'undefined' || !navigator.onLine || _enviando) return;
  const cola = leerCola();
  if (cola.length === 0) return;
  _enviando = true;
  const quedan = [];
  for (const body of cola) {
    try { await enviar(body); } catch { quedan.push(body); }
  }
  escribirCola(quedan);
  _enviando = false;
}
