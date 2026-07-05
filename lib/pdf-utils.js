// Utilidades compartidas para generar PDFs en el cliente (jsPDF).
// Se cargan con import dinámico desde donde se necesiten, para no
// engordar el bundle principal (mismo patrón que leaflet/apexcharts).

// Paleta institucional (misma guía de estilo usada en la Matriz de
// Sostenibilidad impresa: verde PNN + acentos tierra del paisaje andino).
export const PNN_VERDE = [27, 94, 32]; // verde institucional primario (#1B5E20)
export const VERDE_SECUNDARIO = [46, 125, 50]; // #2E7D32
export const TIERRA_OCRE = [196, 154, 58]; // #C49A3A — acento tierra
export const TERRACOTA = [160, 82, 45]; // #A0522D
export const GRIS_TEXTO = [55, 65, 81];
export const GRIS_CLARO = [156, 163, 175];

// Logos institucionales, en versión liviana optimizada para incrustar en PDF
// (las originales en /images pesan cientos de KB — son para pantalla, no PDF).
const LOGO_PATRIMONIO_SRC = '/images/pdf/logo-patrimonio-small.png';
const LOGO_PNN_SRC = '/images/pdf/logo-pnn-small.png';

let _logosCache = null;

function blobADataUrl(blob) {
  return new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.onload = () => resolve(reader.result);
    reader.onerror = reject;
    reader.readAsDataURL(blob);
  });
}

// Carga y cachea los dos logos como dataURL. Si algo falla (sin red y sin
// caché del service worker todavía, navegador sin FileReader, etc.) devuelve
// null para ese logo en vez de lanzar — el encabezado se dibuja igual, solo
// sin esa imagen, para nunca romper la descarga del PDF por un logo.
async function cargarLogos() {
  if (_logosCache) return _logosCache;
  const cargarUno = async (src) => {
    try {
      const resp = await fetch(src);
      if (!resp.ok) return null;
      return await blobADataUrl(await resp.blob());
    } catch {
      return null;
    }
  };
  const [patrimonio, pnn] = await Promise.all([cargarUno(LOGO_PATRIMONIO_SRC), cargarUno(LOGO_PNN_SRC)]);
  _logosCache = { patrimonio, pnn };
  return _logosCache;
}

// Proporciones reales de los logos pequeños (ancho/alto), para dibujarlos
// sin deformar a partir de una altura fija.
const RATIO_PATRIMONIO = 320 / 119;
const RATIO_PNN = 480 / 187;

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
    parrafo(texto, { tamano = 10, color = GRIS_TEXTO, interlineado = 5, negrita = false, cursiva = false } = {}) {
      doc.setFont('helvetica', negrita ? 'bold' : (cursiva ? 'italic' : 'normal'));
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

// Lee ancho/alto de un PNG dataURL sin cargarlo como imagen (el IHDR guarda las
// dimensiones en big-endian justo tras la firma de 8 bytes + "IHDR"). Sirve para
// colocar firmas en el PDF preservando su proporción en vez de aplastarlas.
export function dimensionesPngDataUrl(dataUrl) {
  try {
    const base64 = dataUrl.split(',')[1];
    const bin = atob(base64.substring(0, 44)); // 33 bytes: suficiente para el IHDR
    const b = (i) => bin.charCodeAt(i);
    const w = (b(16) << 24) | (b(17) << 16) | (b(18) << 8) | b(19);
    const h = (b(20) << 24) | (b(21) << 16) | (b(22) << 8) | b(23);
    if (w > 0 && h > 0) return { w, h };
  } catch { /* dataURL inválido */ }
  return null;
}

const ALTO_ENCABEZADO = 34;
const ALTO_FRANJA = 2.5;
const ALTO_LOGO = 12;

// Encabezado institucional: franja verde superior + zona blanca con los dos
// logos oficiales (Patrimonio Natural / Parques Nacionales) flanqueando el
// título, y una línea ocre de cierre. Es async porque los logos se cargan
// (y cachean) por fetch la primera vez que se genera un PDF en la sesión.
export async function encabezado(doc, titulo, subtitulo) {
  const ancho = doc.internal.pageSize.getWidth(); // sensible a orientación (vertical u horizontal)
  const { patrimonio, pnn } = await cargarLogos();

  doc.setFillColor(...PNN_VERDE);
  doc.rect(0, 0, ancho, ALTO_FRANJA, 'F');
  doc.setFillColor(255, 255, 255);
  doc.rect(0, ALTO_FRANJA, ancho, ALTO_ENCABEZADO - ALTO_FRANJA, 'F');

  const yLogo = ALTO_FRANJA + (ALTO_ENCABEZADO - ALTO_FRANJA - ALTO_LOGO) / 2;
  let xTextoIzq = MARGEN;
  let xTextoDer = ancho - MARGEN;
  try {
    if (patrimonio) {
      const w = ALTO_LOGO * RATIO_PATRIMONIO;
      doc.addImage(patrimonio, 'PNG', MARGEN, yLogo, w, ALTO_LOGO);
      xTextoIzq = MARGEN + w + 6;
    }
    if (pnn) {
      const w = ALTO_LOGO * RATIO_PNN;
      doc.addImage(pnn, 'PNG', ancho - MARGEN - w, yLogo, w, ALTO_LOGO);
      xTextoDer = ancho - MARGEN - w - 6;
    }
  } catch { /* si una imagen no es un PNG válido, el título igual se dibuja */ }

  const centroX = (xTextoIzq + xTextoDer) / 2;
  doc.setFont('helvetica', 'bold');
  doc.setFontSize(14);
  doc.setTextColor(...PNN_VERDE);
  doc.text(titulo, centroX, ALTO_FRANJA + (ALTO_ENCABEZADO - ALTO_FRANJA) / 2 - 1, { align: 'center' });
  doc.setFont('helvetica', 'normal');
  doc.setFontSize(8.5);
  doc.setTextColor(...GRIS_TEXTO);
  doc.text(subtitulo, centroX, ALTO_FRANJA + (ALTO_ENCABEZADO - ALTO_FRANJA) / 2 + 4.5, { align: 'center' });

  doc.setDrawColor(...TIERRA_OCRE);
  doc.setLineWidth(0.6);
  doc.line(0, ALTO_ENCABEZADO, ancho, ALTO_ENCABEZADO);
  doc.setLineWidth(0.2);

  return ALTO_ENCABEZADO + 8; // y donde puede empezar el contenido
}

export function piePagina(doc) {
  const totalPaginas = doc.internal.getNumberOfPages();
  for (let i = 1; i <= totalPaginas; i++) {
    doc.setPage(i);
    const alto = doc.internal.pageSize.getHeight();
    const ancho = doc.internal.pageSize.getWidth(); // cada página puede tener su propia orientación
    doc.setDrawColor(...TIERRA_OCRE);
    doc.setLineWidth(0.3);
    doc.line(MARGEN, alto - 13, ancho - MARGEN, alto - 13);
    doc.setLineWidth(0.2);
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
