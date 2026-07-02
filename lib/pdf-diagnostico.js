// Genera el PDF del Diagnóstico Inteligente para entregar al productor.
// Import dinámico de jsPDF: solo se carga cuando el usuario pide el PDF.
import { crearCursor, encabezado, piePagina, PNN_VERDE } from './pdf-utils';

export async function descargarDiagnosticoPdf({ diagnostico, productor, evaluacion }) {
  const { jsPDF } = await import('jspdf');
  const doc = new jsPDF();

  const yInicial = encabezado(doc, 'Diagnóstico de Sostenibilidad', 'Estrategia SSC — PNN Puracé · Páramos para la Vida');
  const c = crearCursor(doc);
  c.y = yInicial;

  // Datos del productor
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

  // Score global
  if (diagnostico.score_global) {
    c.titulo(`Puntaje global: ${Number(diagnostico.score_global).toFixed(1)} / 5`, { tamano: 12 });
    c.avanzar(2);
  }

  // Diagnóstico
  c.titulo('Diagnóstico');
  c.parrafo(diagnostico.texto || '', { tamano: 10, interlineado: 5.5 });
  c.avanzar(3);

  // Fortalezas
  const fortalezas = diagnostico.recomendaciones?.fortalezas || [];
  if (fortalezas.length > 0) {
    c.titulo('Fortalezas', { color: PNN_VERDE });
    c.lista(fortalezas, { marcador: '✓' });
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
    c.lista(acciones, { marcador: '→' });
  }

  piePagina(doc);

  const nombreArchivo = `diagnostico-${(productor?.nombre_completo || 'productor').toLowerCase().replace(/[^a-z0-9]+/g, '-')}.pdf`;
  doc.save(nombreArchivo);
}
