// Genera el PDF del Plan de Acción SMART para entregar/imprimir con el productor.
// Estructura: 1) página horizontal con un CUADRO resumen (vistazo rápido para el
// productor), y 2) páginas verticales con el detalle narrado de cada meta.
import { crearCursor, encabezado, piePagina, PNN_VERDE, GRIS_CLARO } from './pdf-utils';

const CAMPOS = [
  { key: 'especifico', label: 'Específico' },
  { key: 'medible', label: 'Medible' },
  { key: 'alcanzable', label: 'Alcanzable' },
  { key: 'relevante', label: 'Relevante' },
];

function fechaLegible(valor) {
  if (!valor) return null;
  const d = valor instanceof Date ? valor : new Date(`${valor}T12:00:00`);
  if (isNaN(d.getTime())) return null;
  return d.toLocaleDateString('es-CO', { year: 'numeric', month: 'long', day: 'numeric' });
}

// ─── Cuadro resumen en página horizontal (columnas en lenguaje llano) ───
function dibujarCuadroResumen(doc, { conPlan, planes, detalles, productor, evaluacion }) {
  const W = doc.internal.pageSize.getWidth();  // ~297 (A4 horizontal)
  const H = doc.internal.pageSize.getHeight(); // ~210
  const M = 15;

  // Encabezado verde a todo el ancho
  doc.setFillColor(...PNN_VERDE);
  doc.rect(0, 0, W, 26, 'F');
  doc.setFont('helvetica', 'bold');
  doc.setFontSize(15);
  doc.setTextColor(255, 255, 255);
  doc.text('Plan de Acción — Cuadro resumen', M, 13);
  doc.setFont('helvetica', 'normal');
  doc.setFontSize(9);
  doc.text('Estrategia SSC — PNN Puracé · Páramos para la Vida', M, 20);

  // Datos del productor
  let y = 34;
  doc.setFont('helvetica', 'bold');
  doc.setFontSize(12);
  doc.setTextColor(30, 41, 59);
  doc.text(productor?.nombre_completo || 'Productor', M, y);
  y += 5;
  const ubic = [productor?.nombre_predio, productor?.vereda, productor?.municipio].filter(Boolean).join(' · ');
  doc.setFont('helvetica', 'normal');
  doc.setFontSize(9);
  doc.setTextColor(107, 114, 128);
  if (ubic) { doc.text(ubic, M, y); y += 4.5; }
  const fEval = fechaLegible(evaluacion?.fecha ? new Date(evaluacion.fecha) : new Date());
  doc.text(`Fecha de la evaluación: ${fEval}`, M, y);
  y += 7;

  // Definición de columnas (suma de anchos = 267 = ancho útil en horizontal)
  const cols = [
    { t: 'N°', w: 12 },
    { t: 'Lo que vamos a mejorar', w: 56 },
    { t: 'Qué haremos', w: 80 },
    { t: 'Cómo sabremos que se logró', w: 74 },
    { t: 'Para cuándo', w: 45 },
  ];
  const xs = [];
  let acc = M;
  cols.forEach((c) => { xs.push(acc); acc += c.w; });
  const derecha = M + cols.reduce((s, c) => s + c.w, 0);
  const headH = 9;
  const pad = 2.5;
  const lh = 4.2;
  const fs = 8.5;

  const dibujarCabeceraTabla = () => {
    doc.setFillColor(...PNN_VERDE);
    doc.rect(M, y, derecha - M, headH, 'F');
    doc.setFont('helvetica', 'bold');
    doc.setFontSize(8.5);
    doc.setTextColor(255, 255, 255);
    cols.forEach((c, i) => doc.text(doc.splitTextToSize(c.t, c.w - pad * 2), xs[i] + pad, y + 5.8));
    y += headH;
  };
  dibujarCabeceraTabla();

  conPlan.forEach((ind, idx) => {
    const p = planes[ind.id];
    const score = detalles[ind.id]?.valor ?? 0;
    const plazo = fechaLegible(p.plazo) || '—';
    const celdas = [
      String(idx + 1),
      `${ind.nombre}\n(${ind.dimension} · ${score}/5)`,
      p.especifico || '—',
      p.medible || '—',
      plazo,
    ];

    doc.setFont('helvetica', 'normal');
    doc.setFontSize(fs);
    const envuelto = celdas.map((txt, i) => doc.splitTextToSize(String(txt), cols[i].w - pad * 2));
    const filaH = Math.max(...envuelto.map((w) => w.length)) * lh + pad * 2;

    // Salto de página (horizontal) si la fila no cabe
    if (y + filaH > H - 14) {
      doc.addPage('a4', 'landscape');
      y = 18;
      dibujarCabeceraTabla();
    }

    // Fondo alterno para leer más fácil
    if (idx % 2 === 1) {
      doc.setFillColor(243, 244, 246);
      doc.rect(M, y, derecha - M, filaH, 'F');
    }

    // Texto de cada celda
    doc.setFont('helvetica', 'normal');
    doc.setFontSize(fs);
    doc.setTextColor(55, 65, 81);
    envuelto.forEach((w, i) => doc.text(w, xs[i] + pad, y + pad + 3));

    // Líneas de la cuadrícula (horizontal inferior + verticales)
    doc.setDrawColor(...GRIS_CLARO);
    doc.line(M, y + filaH, derecha, y + filaH);
    [...xs, derecha].forEach((x) => doc.line(x, y, x, y + filaH));

    y += filaH;
  });
}

export async function descargarPlanAccionPdf({ planes, indicadores, detalles, productor, evaluacion }) {
  const { jsPDF } = await import('jspdf');

  const conPlan = indicadores
    .filter((ind) => planes[ind.id]?.especifico?.trim())
    .sort((a, b) => (detalles[a.id]?.valor || 0) - (detalles[b.id]?.valor || 0));

  // Si hay metas, arrancamos en horizontal para el cuadro; el detalle va en
  // páginas verticales. Sin metas, todo vertical (solo el mensaje de aviso).
  const doc = conPlan.length > 0 ? new jsPDF('landscape') : new jsPDF();

  if (conPlan.length > 0) {
    dibujarCuadroResumen(doc, { conPlan, planes, detalles, productor, evaluacion });
    doc.addPage('a4', 'portrait');
  }

  const yInicial = encabezado(doc, 'Plan de Acción SMART', 'Estrategia SSC — PNN Puracé · Páramos para la Vida');
  const c = crearCursor(doc); // se crea ya sobre la página vertical → alto correcto
  c.y = yInicial;

  c.titulo(productor?.nombre_completo || 'Productor', { tamano: 13, color: [30, 41, 59] });
  const ubicacion = [productor?.nombre_predio, productor?.vereda, productor?.municipio].filter(Boolean).join(' · ');
  if (ubicacion) c.parrafo(ubicacion, { tamano: 9, color: [107, 114, 128] });
  const fecha = evaluacion?.fecha ? new Date(evaluacion.fecha) : new Date();
  c.parrafo(`Fecha de la evaluación: ${fecha.toLocaleDateString('es-CO', { year: 'numeric', month: 'long', day: 'numeric' })}`, { tamano: 9, color: [107, 114, 128] });
  if (evaluacion?.receptor_es_otro && evaluacion?.receptor_nombre) {
    c.parrafo(`Recibió la visita: ${evaluacion.receptor_nombre}${evaluacion.receptor_parentesco ? ` (${evaluacion.receptor_parentesco})` : ''}`, { tamano: 9, color: [107, 114, 128] });
  }
  if (conPlan.length > 0) {
    c.parrafo('Detalle de cada meta (el cuadro resumen está en la primera página)', { tamano: 9, color: PNN_VERDE, negrita: true });
  }
  c.avanzar(3);
  c.linea();

  if (conPlan.length === 0) {
    c.parrafo('No hay metas SMART definidas todavía para esta evaluación.', { tamano: 10 });
  }

  conPlan.forEach((ind, idx) => {
    const p = planes[ind.id];
    const score = detalles[ind.id]?.valor || 0;

    c.titulo(`${idx + 1}. ${ind.nombre}`, { tamano: 11.5 });
    c.parrafo(`${ind.dimension} · Puntaje actual: ${score}/5`, { tamano: 8.5, color: [107, 114, 128] });
    c.avanzar(1);

    CAMPOS.forEach((campo) => {
      if (!p[campo.key]?.trim()) return;
      c.parrafo(campo.label.toUpperCase(), { tamano: 8, color: PNN_VERDE, negrita: true, interlineado: 4 });
      c.parrafo(p[campo.key], { tamano: 9.5, interlineado: 4.8 });
    });

    if (p.plazo) {
      const fechaPlazo = new Date(p.plazo + 'T12:00:00').toLocaleDateString('es-CO', { year: 'numeric', month: 'long', day: 'numeric' });
      c.parrafo(`Plazo objetivo: ${fechaPlazo}`, { tamano: 9, negrita: true, interlineado: 4.8 });
    }
    if (p.notas?.trim()) {
      c.parrafo(`Notas: ${p.notas}`, { tamano: 8.5, color: [107, 114, 128], interlineado: 4.5 });
    }

    c.avanzar(2);
    c.linea();
  });

  // Firmas — si ya se capturaron en la app, se incrustan; si no, queda el
  // espacio en blanco para firmar a mano sobre el PDF impreso.
  c.saltoSiNecesario(35);
  c.avanzar(8);
  const anchoFirma = 75;
  const altoFirma = 20;
  const yImg = c.y;
  if (evaluacion?.firma_tecnico) {
    try { doc.addImage(evaluacion.firma_tecnico, 'PNG', 15, yImg - altoFirma, anchoFirma, altoFirma); } catch { /* imagen inválida: queda el espacio en blanco */ }
  }
  if (evaluacion?.firma_productor) {
    try { doc.addImage(evaluacion.firma_productor, 'PNG', 210 - 15 - anchoFirma, yImg - altoFirma, anchoFirma, altoFirma); } catch { /* imagen inválida */ }
  }
  const yLineas = c.y;
  doc.setDrawColor(156, 163, 175);
  doc.line(15, yLineas, 15 + anchoFirma, yLineas);
  doc.line(210 - 15 - anchoFirma, yLineas, 210 - 15, yLineas);
  doc.setFont('helvetica', 'normal');
  doc.setFontSize(8.5);
  doc.setTextColor(107, 114, 128);
  doc.text('Firma del técnico', 15, yLineas + 5);
  doc.text('Firma del productor / receptor de la visita', 210 - 15 - anchoFirma, yLineas + 5);
  c.avanzar(12);

  piePagina(doc);

  const nombreArchivo = `plan-accion-${(productor?.nombre_completo || 'productor').toLowerCase().replace(/[^a-z0-9]+/g, '-')}.pdf`;
  doc.save(nombreArchivo);
}
