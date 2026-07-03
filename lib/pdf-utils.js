// Utilidades compartidas para generar PDFs en el cliente (jsPDF).
// Se cargan con import dinámico desde donde se necesiten, para no
// engordar el bundle principal (mismo patrón que leaflet/apexcharts).

export const PNN_VERDE = [3, 166, 74];
export const GRIS_TEXTO = [55, 65, 81];
export const GRIS_CLARO = [156, 163, 175];

const MARGEN = 15;
const ANCHO_UTIL = 210 - MARGEN * 2; // A4 vertical

export function crearCursor(doc) {
  let y = MARGEN;
  const alto = doc.internal.pageSize.getHeight();

  function saltoSiNecesario(espacioNecesario) {
    if (y + espacioNecesario > alto - MARGEN) {
      doc.addPage();
      y = MARGEN;
    }
  }

  return {
    get y() { return y; },
    set y(v) { y = v; },
    avanzar(px) { y += px; },
    saltoSiNecesario,
    parrafo(texto, { tamano = 10, color = GRIS_TEXTO, interlineado = 5, negrita = false } = {}) {
      doc.setFont('helvetica', negrita ? 'bold' : 'normal');
      doc.setFontSize(tamano);
      doc.setTextColor(...color);
      const lineas = doc.splitTextToSize(texto, ANCHO_UTIL);
      saltoSiNecesario(lineas.length * interlineado + 2);
      doc.text(lineas, MARGEN, y);
      y += lineas.length * interlineado + 2;
    },
    titulo(texto, { tamano = 12, color = PNN_VERDE } = {}) {
      saltoSiNecesario(10);
      doc.setFont('helvetica', 'bold');
      doc.setFontSize(tamano);
      doc.setTextColor(...color);
      doc.text(texto, MARGEN, y);
      y += tamano * 0.5 + 3;
    },
    lista(items, { tamano = 10, color = GRIS_TEXTO, marcador = '•' } = {}) {
      doc.setFont('helvetica', 'normal');
      doc.setFontSize(tamano);
      doc.setTextColor(...color);
      items.forEach(item => {
        const lineas = doc.splitTextToSize(item, ANCHO_UTIL - 6);
        saltoSiNecesario(lineas.length * 5 + 2);
        doc.text(marcador, MARGEN, y);
        doc.text(lineas, MARGEN + 5, y);
        y += lineas.length * 5 + 2;
      });
    },
    linea() {
      saltoSiNecesario(6);
      doc.setDrawColor(...GRIS_CLARO);
      doc.line(MARGEN, y, 210 - MARGEN, y);
      y += 6;
    },
  };
}

export function encabezado(doc, titulo, subtitulo) {
  const ancho = doc.internal.pageSize.getWidth(); // sensible a orientación (vertical u horizontal)
  doc.setFillColor(...PNN_VERDE);
  doc.rect(0, 0, ancho, 28, 'F');
  doc.setFont('helvetica', 'bold');
  doc.setFontSize(15);
  doc.setTextColor(255, 255, 255);
  doc.text(titulo, MARGEN, 14);
  doc.setFont('helvetica', 'normal');
  doc.setFontSize(9);
  doc.text(subtitulo, MARGEN, 21);
  return 36; // y donde puede empezar el contenido
}

export function piePagina(doc) {
  const totalPaginas = doc.internal.getNumberOfPages();
  for (let i = 1; i <= totalPaginas; i++) {
    doc.setPage(i);
    const alto = doc.internal.pageSize.getHeight();
    const ancho = doc.internal.pageSize.getWidth(); // cada página puede tener su propia orientación
    doc.setFont('helvetica', 'normal');
    doc.setFontSize(8);
    doc.setTextColor(...GRIS_CLARO);
    doc.text(
      `Generado el ${new Date().toLocaleDateString('es-CO', { year: 'numeric', month: 'long', day: 'numeric' })} — Estrategia SSC · PNN Puracé`,
      MARGEN, alto - 8
    );
    doc.text(`${i}/${totalPaginas}`, ancho - MARGEN - 8, alto - 8);
  }
}
