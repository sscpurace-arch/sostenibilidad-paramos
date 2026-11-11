// Imagen del radar de sostenibilidad para compartir o pegar en informes
// (pedido de Santiago, 27-ago-2026). Se compone en un canvas: encabezado con el
// propietario y la ubicación, la gráfica tal como se ve en pantalla, la
// convención de cada evaluación (color + fecha) y la lista de indicadores, que
// en el radar solo aparecen por número.
// No necesita señal: todo sale de lo que ya está dibujado en la pantalla.

import { fechaLegible } from './pdf-utils';

const ANCHO = 1080;
const MARGEN = 56;
const FUENTE = 'Nunito, "Segoe UI", Roboto, Arial, sans-serif';

function svgComoImagen(svg) {
  return new Promise((resolve, reject) => {
    const copia = svg.cloneNode(true);
    copia.setAttribute('xmlns', 'http://www.w3.org/2000/svg');
    // ApexCharts mete la leyenda en un <foreignObject>. En iPhone (Safari)
    // un SVG con foreignObject "contamina" el canvas y no deja exportarlo.
    // La leyenda se dibuja aparte, así que se quita de la copia.
    copia.querySelectorAll('foreignObject').forEach((n) => n.remove());
    const texto = new XMLSerializer().serializeToString(copia);
    const img = new Image();
    img.onload = () => resolve(img);
    img.onerror = () => reject(new Error('No se pudo leer la gráfica'));
    img.src = 'data:image/svg+xml;charset=utf-8,' + encodeURIComponent(texto);
  });
}

// Parte un texto en líneas que quepan en `ancho` px
function partir(ctx, texto, ancho) {
  const palabras = String(texto || '').split(/\s+/);
  const lineas = [];
  let linea = '';
  for (const p of palabras) {
    const prueba = linea ? `${linea} ${p}` : p;
    if (ctx.measureText(prueba).width > ancho && linea) {
      lineas.push(linea);
      linea = p;
    } else {
      linea = prueba;
    }
  }
  if (linea) lineas.push(linea);
  return lineas;
}

function nombreArchivo(productor) {
  const base = String(productor?.nombre_completo || 'productor')
    .normalize('NFD').replace(/[̀-ͯ]/g, '')
    .replace(/[^a-zA-Z0-9]+/g, '-').replace(/^-|-$/g, '').toLowerCase();
  const hoy = new Date().toISOString().slice(0, 10);
  return `radar-${base}-${hoy}.png`;
}

/**
 * @param {Object} p
 * @param {HTMLElement} p.contenedor  elemento que contiene el radar dibujado
 * @param {Object} p.productor        { nombre_completo, nombre_predio, vereda, municipio }
 * @param {Array}  p.evaluaciones     [{ nombre, fecha, color }] en el orden de las series
 * @param {Array}  p.indicadores      [{ orden, nombre }]
 * @returns {Promise<'compartida'|'descargada'>}
 */
export async function exportarRadarComoImagen({ contenedor, productor, evaluaciones, indicadores }) {
  const svg = contenedor?.querySelector('.apexcharts-canvas svg, svg.apexcharts-svg');
  if (!svg) throw new Error('La gráfica todavía no está lista. Espera un momento y vuelve a intentarlo.');
  const grafica = await svgComoImagen(svg);

  // Primero se mide todo en un canvas de prueba para saber el alto final
  const medir = document.createElement('canvas').getContext('2d');
  const anchoUtil = ANCHO - MARGEN * 2;
  const ladoGrafica = anchoUtil;
  const altoGrafica = Math.round(ladoGrafica * (grafica.height / grafica.width || 1));

  medir.font = `600 22px ${FUENTE}`;
  const columnas = 2;
  const anchoCol = (anchoUtil - 24) / columnas;
  const lineasInd = (indicadores || []).map((i) => partir(medir, `${i.orden}. ${i.nombre}`, anchoCol));
  const porColumna = Math.ceil(lineasInd.length / columnas);
  const altoCol = (desde) => lineasInd.slice(desde, desde + porColumna).reduce((a, l) => a + l.length * 28 + 6, 0);
  const altoIndicadores = Math.max(altoCol(0), altoCol(porColumna));

  const ubicacion = [productor?.nombre_predio, productor?.vereda, productor?.municipio].filter(Boolean).join(' · ');
  const alto = MARGEN + 40 + 56 + (ubicacion ? 40 : 0) + 24
    + altoGrafica + 24
    + (evaluaciones || []).length * 40 + 24
    + 36 + altoIndicadores + 40 + 32 + MARGEN;

  const canvas = document.createElement('canvas');
  canvas.width = ANCHO;
  canvas.height = alto;
  const ctx = canvas.getContext('2d');
  ctx.fillStyle = '#FFFFFF';
  ctx.fillRect(0, 0, ANCHO, alto);
  ctx.textBaseline = 'top';

  let y = MARGEN;
  ctx.fillStyle = '#028A3D';
  ctx.font = `800 26px ${FUENTE}`;
  ctx.fillText('ESTADO DE SOSTENIBILIDAD · PNN PURACÉ', MARGEN, y);
  y += 40;
  ctx.fillStyle = '#0A2E1C';
  ctx.font = `800 44px ${FUENTE}`;
  ctx.fillText(productor?.nombre_completo || 'Productor', MARGEN, y);
  y += 56;
  if (ubicacion) {
    ctx.fillStyle = '#4B5563';
    ctx.font = `600 26px ${FUENTE}`;
    ctx.fillText(ubicacion, MARGEN, y);
    y += 40;
  }
  y += 24;

  ctx.drawImage(grafica, MARGEN, y, ladoGrafica, altoGrafica);
  y += altoGrafica + 24;

  // Convención de cada telaraña: color + fecha de la visita
  for (const ev of evaluaciones || []) {
    ctx.fillStyle = ev.color;
    ctx.beginPath();
    ctx.arc(MARGEN + 12, y + 14, 12, 0, Math.PI * 2);
    ctx.fill();
    ctx.fillStyle = '#111827';
    ctx.font = `700 26px ${FUENTE}`;
    ctx.fillText(`${ev.nombre} — visita del ${fechaLegible(ev.fecha)}`, MARGEN + 36, y);
    y += 40;
  }
  y += 24;

  ctx.fillStyle = '#028A3D';
  ctx.font = `800 22px ${FUENTE}`;
  ctx.fillText('INDICADORES (número en la gráfica)', MARGEN, y);
  y += 36;
  ctx.fillStyle = '#374151';
  ctx.font = `600 22px ${FUENTE}`;
  for (let c = 0; c < columnas; c++) {
    let yc = y;
    const x = MARGEN + c * (anchoCol + 24);
    for (const lineas of lineasInd.slice(c * porColumna, (c + 1) * porColumna)) {
      for (const l of lineas) { ctx.fillText(l, x, yc); yc += 28; }
      yc += 6;
    }
  }
  y += altoIndicadores + 40;

  ctx.fillStyle = '#9CA3AF';
  ctx.font = `600 20px ${FUENTE}`;
  ctx.fillText(`Imagen generada el ${fechaLegible(new Date())} · App Sostenibilidad Páramos`, MARGEN, y);

  const blob = await new Promise((resolve) => canvas.toBlob(resolve, 'image/png'));
  if (!blob) throw new Error('No se pudo crear la imagen');
  const archivo = new File([blob], nombreArchivo(productor), { type: 'image/png' });

  // En el celular, "compartir" deja mandarla por WhatsApp o guardarla en la
  // galería; en el computador (o si no se puede compartir), se descarga.
  if (navigator.canShare?.({ files: [archivo] })) {
    try {
      await navigator.share({ files: [archivo], title: `Radar de sostenibilidad — ${productor?.nombre_completo || ''}` });
      return 'compartida';
    } catch (e) {
      if (e?.name === 'AbortError') return 'compartida'; // el técnico cerró el menú
    }
  }
  const url = URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url;
  a.download = archivo.name;
  document.body.appendChild(a);
  a.click();
  a.remove();
  setTimeout(() => URL.revokeObjectURL(url), 10000);
  return 'descargada';
}
