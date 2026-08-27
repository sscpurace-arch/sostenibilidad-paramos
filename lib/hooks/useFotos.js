'use client';
import { useState, useEffect, useCallback, useRef } from 'react';
import {
  guardarFoto,
  guardarPanoramica,
  eliminarFoto,
  listarFotosPorEvaluacion,
  obtenerThumb,
} from '@/lib/foto-sync';
import { espacioDisponible } from '@/lib/foto-utils';

/**
 * useFotos — fotos de evidencia de una evaluación.
 *
 * Mantiene dos cosas separadas: la metadata (liviana, se lista) y los
 * objectURL de las miniaturas (pesados, hay que revocarlos). Olvidar el
 * revoke es la fuga de memoria clásica con blobs: la pestaña crece hasta que
 * Android mata la app en pleno recorrido.
 */
export function useFotos(evaluacionId, { tecnicoId, esPrueba = false } = {}) {
  const [porIndicador, setPorIndicador] = useState({});
  const [panoramica, setPanoramica] = useState(null);
  const [urls, setUrls] = useState({});        // fotoId -> objectURL de la miniatura
  const [guardando, setGuardando] = useState(false);
  const [aviso, setAviso] = useState(null);    // p.ej. almacenamiento casi lleno

  const urlsRef = useRef({});

  // Un solo lugar que crea y revoca objectURLs, para que ninguno quede suelto
  const sincronizarUrls = useCallback(async (metas) => {
    const vigentes = {};
    for (const meta of metas) {
      if (urlsRef.current[meta.id]) {
        vigentes[meta.id] = urlsRef.current[meta.id];
        continue;
      }
      const blob = await obtenerThumb(meta.id);
      if (blob) vigentes[meta.id] = URL.createObjectURL(blob);
    }
    // Revocar los que ya no corresponden a ninguna foto viva
    for (const [id, url] of Object.entries(urlsRef.current)) {
      if (!vigentes[id]) URL.revokeObjectURL(url);
    }
    urlsRef.current = vigentes;
    setUrls(vigentes);
  }, []);

  const recargar = useCallback(async () => {
    if (!evaluacionId) return;
    const { porIndicador: pi, panoramica: pan } = await listarFotosPorEvaluacion(evaluacionId);
    setPorIndicador(pi);
    setPanoramica(pan);

    const todas = Object.values(pi).flat();
    if (pan) todas.push(pan);
    await sincronizarUrls(todas);
  }, [evaluacionId, sincronizarUrls]);

  useEffect(() => { recargar(); }, [recargar]);

  // Revocar todo al desmontar
  useEffect(() => () => {
    Object.values(urlsRef.current).forEach(URL.revokeObjectURL);
    urlsRef.current = {};
  }, []);

  const avisarSiFaltaEspacio = useCallback(async () => {
    const espacio = await espacioDisponible();
    if (espacio && espacio.casiLleno) {
      setAviso('El almacenamiento del celular está casi lleno. Sincroniza cuando tengas señal para liberar espacio.');
    }
  }, []);

  /**
   * Agrega fotos a un indicador. Procesa SECUENCIALMENTE: comprimir son
   * ~200 ms por foto y en paralelo la pantalla se congela.
   */
  const agregar = useCallback(async (indicadorId, files) => {
    if (!evaluacionId || !files || files.length === 0) return;
    setGuardando(true);
    try {
      for (const file of Array.from(files)) {
        await guardarFoto({ evaluacionId, indicadorId, tecnicoId, esPrueba, file });
      }
      await recargar();
      await avisarSiFaltaEspacio();
    } finally {
      setGuardando(false);
    }
  }, [evaluacionId, tecnicoId, esPrueba, recargar, avisarSiFaltaEspacio]);

  const agregarPanoramica = useCallback(async (file) => {
    if (!evaluacionId || !file) return;
    setGuardando(true);
    try {
      await guardarPanoramica({ evaluacionId, tecnicoId, esPrueba, file });
      await recargar();
      await avisarSiFaltaEspacio();
    } finally {
      setGuardando(false);
    }
  }, [evaluacionId, tecnicoId, esPrueba, recargar, avisarSiFaltaEspacio]);

  const borrar = useCallback(async (fotoId) => {
    await eliminarFoto(fotoId);
    await recargar();
  }, [recargar]);

  return {
    porIndicador,
    panoramica,
    urls,
    guardando,
    aviso,
    descartarAviso: () => setAviso(null),
    agregar,
    agregarPanoramica,
    borrar,
    recargar,
  };
}
