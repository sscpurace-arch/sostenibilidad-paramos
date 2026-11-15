// Genera el PDF del Diagnóstico Inteligente para entregar al productor.
// Import dinámico de jsPDF: solo se carga cuando el usuario pide el PDF.
import { crearCursor, encabezado, piePagina, fechaLegible, lineaElaboradoPor, lineaUbicacion, PNN_VERDE } from './pdf-utils';

// tecnico: perfil actual { nombre, cargo } — respaldo cuando la evaluación no
// trae snapshot (visitas anteriores a sep-2026).
// puntajeGlobal: el calculado en la app con promedioGlobal (misma regla que la
// pantalla). El score_global que guardó la IA solo se usa si no llega, porque
// los diagnósticos viejos lo calcularon con otra fórmula.
// radar: { dataUrl, ancho, alto, series: [{ nombre, fecha, color }], indicadores: [{ orden, nombre }] }
// — la gráfica tal como se ve en resultados (lib/radar-imagen.js → radarComoPng).
export async function descargarDiagnosticoPdf({ diagnostico, productor, evaluacion, tecnico = null, puntajeGlobal = null, radar = null }) {
  const { jsPDF } = await import('jspdf');
  const doc = new jsPDF();

  const yInicial = await encabezado(doc, 'Diagnóstico de Sostenibilidad', 'Estrategia SSC — PNN Puracé · Páramos para la Vida');
  const c = crearCursor(doc);
  c.y = yInicial;

  // Datos del productor
  c.titulo(productor?.nombre_completo || 'Productor', { tamano: 13, color: [30, 41, 59] });
  const ubicacion = lineaUbicacion(productor);
  if (ubicacion) c.parrafo(ubicacion, { tamano: 9, color: [107, 114, 128] });
  c.parrafo(`Fecha de la evaluación: ${fechaLegible(evaluacion?.fecha)}`, { tamano: 9, color: [107, 114, 128] });
  const elaborado = lineaElaboradoPor(evaluacion, tecnico);
  if (elaborado) c.parrafo(elaborado, { tamano: 9, color: [107, 114, 128] });
  if (evaluacion?.receptor_es_otro && evaluacion?.receptor_nombre) {
    c.parrafo(`Recibió la visita: ${evaluacion.receptor_nombre}${evaluacion.receptor_parentesco ? ` (${evaluacion.receptor_parentesco})` : ''}`, { tamano: 9, color: [107, 114, 128] });
  }
  c.avanzar(3);
  c.linea();

  // Score global
  const puntaje = typeof puntajeGlobal === 'number' ? puntajeGlobal : Number(diagnostico.score_global) || null;
  if (puntaje) {
    c.titulo(`Puntaje global: ${puntaje.toFixed(1)} / 5`, { tamano: 12 });
    c.avanzar(2);
  }

  // Radar de sostenibilidad con todas las mediciones que muestra la pantalla
  // (la visita anterior, si la hay, y la actual). Si la gráfica no se pudo
  // capturar, el PDF sale igual sin ella.
  if (radar?.dataUrl) dibujarRadar(doc, c, radar);

  // Diagnóstico
  c.titulo('Diagnóstico');
  c.parrafo(diagnostico.texto || '', { tamano: 10, interlineado: 5.5 });
  c.avanzar(3);

  // Fortalezas
  const fortalezas = diagnostico.recomendaciones?.fortalezas || [];
  if (fortalezas.length > 0) {
    c.titulo('Fortalezas', { color: PNN_VERDE });
    c.lista(fortalezas, { marcador: '+' });
    c.avanzar(3);
  }

  // Debilidades (si vienen separadas del texto de recomendaciones)
  const debilidades = diagnostico.recomendaciones?.debilidades || [];
  if (debilidades.length > 0) {
    c.titulo('Aspectos a mejorar', { color: [217, 119, 6] });
    c.lista(debilidades, { marcador: '!' });
    c.avanzar(3);
  }

  // Recomendaciones / acciones
  const acciones = diagnostico.recomendaciones?.acciones || [];
  if (acciones.length > 0) {
    c.titulo('Recomendaciones');
    c.lista(acciones, { marcador: '>' });
  }

  piePagina(doc);

  const nombreArchivo = `diagnostico-${(productor?.nombre_completo || 'productor').toLowerCase().replace(/[^a-z0-9]+/g, '-')}.pdf`;
  doc.save(nombreArchivo);
  // El mismo archivo que se le entregó al productor, para archivarlo
  // (lib/reporte-sync.js). El caller decide si lo guarda.
  return { blob: doc.output('blob'), nombreArchivo };
}

function hexARgb(hex) {
  const h = String(hex || '#64748b').replace('#', '');
  const n = parseInt(h.length === 3 ? h.split('').map(x => x + x).join('') : h, 16);
  return [(n >> 16) & 255, (n >> 8) & 255, n & 255];
}

// Gráfica + convención (color y fecha de cada medición) + lista de
// indicadores, que en el radar solo aparecen por número.
function dibujarRadar(doc, c, radar) {
  const MARGEN = 15;
  const anchoPagina = doc.internal.pageSize.getWidth();
  // Máximo 120 x 110 mm, conservando la proporción de la gráfica
  const proporcion = (radar.alto || 1) / (radar.ancho || 1);
  let anchoImg = 120;
  let altoImg = anchoImg * proporcion;
  if (altoImg > 110) { altoImg = 110; anchoImg = altoImg / proporcion; }
  const series = radar.series || [];
  const formato = String(radar.dataUrl).startsWith('data:image/jpeg') ? 'JPEG' : 'PNG';

  c.titulo(series.length > 1 ? 'Radar de sostenibilidad: comparación de mediciones' : 'Radar de sostenibilidad');
  c.saltoSiNecesario(altoImg + 4);
  try {
    doc.addImage(radar.dataUrl, formato, (anchoPagina - anchoImg) / 2, c.y, anchoImg, altoImg);
  } catch {
    return; // imagen dañada: se omite el radar, no el PDF
  }
  c.avanzar(altoImg + 3);

  doc.setFont('helvetica', 'normal');
  doc.setFontSize(9);
  series.forEach(s => {
    c.saltoSiNecesario(6);
    doc.setFillColor(...hexARgb(s.color));
    doc.circle(MARGEN + 2, c.y - 1.2, 1.8, 'F');
    doc.setTextColor(55, 65, 81);
    doc.text(`${s.nombre}: visita del ${fechaLegible(s.fecha)}`, MARGEN + 6, c.y);
    c.avanzar(5);
  });

  const indicadores = radar.indicadores || [];
  if (indicadores.length > 0) {
    c.avanzar(2);
    c.parrafo('Indicadores (número en la gráfica):', { tamano: 8, negrita: true, color: [107, 114, 128] });
    doc.setFont('helvetica', 'normal');
    doc.setFontSize(7);
    doc.setTextColor(107, 114, 128);
    const anchoCol = (anchoPagina - MARGEN * 2 - 6) / 2;
    const porCol = Math.ceil(indicadores.length / 2);
    const lineas = indicadores.map(i => doc.splitTextToSize(`${i.orden}. ${i.nombre}`, anchoCol));
    const alto = (desde) => lineas.slice(desde, desde + porCol).reduce((a, l) => a + l.length * 3.2 + 0.6, 0);
    const altoTotal = Math.max(alto(0), alto(porCol));
    c.saltoSiNecesario(altoTotal + 2);
    const y0 = c.y;
    [0, 1].forEach(col => {
      let y = y0;
      const x = MARGEN + col * (anchoCol + 6);
      lineas.slice(col * porCol, (col + 1) * porCol).forEach(l => {
        doc.text(l, x, y);
        y += l.length * 3.2 + 0.6;
      });
    });
    c.avanzar(altoTotal);
  }
  c.avanzar(4);
}
