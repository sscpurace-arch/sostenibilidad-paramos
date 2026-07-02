// Genera el PDF del Plan de Acción SMART para entregar/imprimir con el productor.
import { crearCursor, encabezado, piePagina, PNN_VERDE } from './pdf-utils';

const CAMPOS = [
  { key: 'especifico', label: 'Específico' },
  { key: 'medible', label: 'Medible' },
  { key: 'alcanzable', label: 'Alcanzable' },
  { key: 'relevante', label: 'Relevante' },
];

export async function descargarPlanAccionPdf({ planes, indicadores, detalles, productor, evaluacion }) {
  const { jsPDF } = await import('jspdf');
  const doc = new jsPDF();

  const yInicial = encabezado(doc, 'Plan de Acción SMART', 'Estrategia SSC — PNN Puracé · Páramos para la Vida');
  const c = crearCursor(doc);
  c.y = yInicial;

  c.titulo(productor?.nombre_completo || 'Productor', { tamano: 13, color: [30, 41, 59] });
  const ubicacion = [productor?.nombre_predio, productor?.vereda, productor?.municipio].filter(Boolean).join(' · ');
  if (ubicacion) c.parrafo(ubicacion, { tamano: 9, color: [107, 114, 128] });
  const fecha = evaluacion?.fecha ? new Date(evaluacion.fecha) : new Date();
  c.parrafo(`Fecha de la evaluación: ${fecha.toLocaleDateString('es-CO', { year: 'numeric', month: 'long', day: 'numeric' })}`, { tamano: 9, color: [107, 114, 128] });
  if (evaluacion?.receptor_es_otro && evaluacion?.receptor_nombre) {
    c.parrafo(`Recibió la visita: ${evaluacion.receptor_nombre}${evaluacion.receptor_parentesco ? ` (${evaluacion.receptor_parentesco})` : ''}`, { tamano: 9, color: [107, 114, 128] });
  }
  c.avanzar(3);
  c.linea();

  const conPlan = indicadores
    .filter(ind => planes[ind.id]?.especifico?.trim())
    .sort((a, b) => (detalles[a.id]?.valor || 0) - (detalles[b.id]?.valor || 0));

  if (conPlan.length === 0) {
    c.parrafo('No hay metas SMART definidas todavía para esta evaluación.', { tamano: 10 });
  }

  conPlan.forEach((ind, idx) => {
    const p = planes[ind.id];
    const score = detalles[ind.id]?.valor || 0;

    c.titulo(`${idx + 1}. ${ind.nombre}`, { tamano: 11.5 });
    c.parrafo(`${ind.dimension} · Puntaje actual: ${score}/5`, { tamano: 8.5, color: [107, 114, 128] });
    c.avanzar(1);

    CAMPOS.forEach(campo => {
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
