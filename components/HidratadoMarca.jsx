'use client';
import { useEffect } from 'react';

/**
 * Avisa al vigilante de carga (script en app/layout.js) de que el código de la
 * pantalla sí arrancó. Si esto nunca corre, el vigilante muestra por qué.
 */
export default function HidratadoMarca() {
  useEffect(() => {
    window.__hidratado = true;
    document.getElementById('aviso-carga-fallida')?.remove();
  }, []);
  return null;
}
