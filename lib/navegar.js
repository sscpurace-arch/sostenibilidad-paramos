/**
 * Abrir una pantalla que depende de un parámetro en la dirección
 * (?productor=…, ?id=…) con carga COMPLETA, no con la navegación interna de
 * Next.
 *
 * Por qué: la navegación interna pide a Next un "payload RSC" y el service
 * worker puede contestar con una copia guardada de la pantalla, que se guarda
 * SIN el parámetro (una sola copia sirve para cualquier productor). En iPhone
 * esa copia llegó a reemplazar la dirección y la pantalla abría con
 * "No se indicó qué productor abrir" (comité, 30-sep-2026). Con carga completa
 * la dirección con el parámetro queda en la barra y la pantalla la lee de ahí,
 * con o sin señal (el documento guardado es el mismo para todos).
 */
export function abrirPantalla(url) {
  if (typeof window === 'undefined') return;
  window.location.assign(url);
}

/**
 * Lee un parámetro de la dirección. Si el enrutador de Next no lo trae (ver
 * arriba), lo toma directamente de la barra de direcciones.
 */
export function leerParametro(searchParams, clave) {
  const delRouter = searchParams?.get?.(clave);
  if (delRouter) return delRouter;
  if (typeof window === 'undefined') return null;
  try {
    return new URLSearchParams(window.location.search).get(clave);
  } catch {
    return null;
  }
}
