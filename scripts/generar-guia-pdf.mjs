// Genera public/docs/guia-calificacion-matriz.pdf a partir del contenido ya
// corregido del Anexo A (scripts/anexo-a-indicadores.json) y la paleta
// institucional (misma línea visual de lib/pdf-utils.js, pero autocontenida
// porque este script corre en Node —build time—, no en el navegador).
//
// Uso: node scripts/generar-guia-pdf.mjs
// Se debe volver a correr cada vez que cambie el contenido del Anexo A.

import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { jsPDF } from 'jspdf';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, '..');

// ─── Paleta institucional (igual a lib/pdf-utils.js) ───
const VERDE = [27, 94, 32];
const VERDE_SEC = [46, 125, 50];
const OCRE = [196, 154, 58];
const TERRACOTA = [160, 82, 45];
const GRIS_TEXTO = [55, 65, 81];
const GRIS_CLARO = [156, 163, 175];
const CREMA = [245, 241, 232];

const NIVEL_FONDO = {
  '5': [214, 235, 214],
  '4': [232, 242, 224],
  '3': [250, 244, 225],
  '2': [250, 232, 217],
  '1': [248, 219, 209],
};
const NIVEL_BORDE = {
  '5': VERDE_SEC,
  '4': [123, 168, 87],
  '3': OCRE,
  '2': [200, 141, 92],
  '1': TERRACOTA,
};

const MARGEN = 15;
const A4_W = 210;
const A4_H = 297;
const ANCHO_UTIL = A4_W - MARGEN * 2;

function leerImagenBase64(rel) {
  const buf = fs.readFileSync(path.join(ROOT, rel));
  return 'data:image/png;base64,' + buf.toString('base64');
}

const LOGO_PATRIMONIO = leerImagenBase64('public/images/pdf/logo-patrimonio-small.png');
const LOGO_PNN = leerImagenBase64('public/images/pdf/logo-pnn-small.png');
const RATIO_PATRIMONIO = 320 / 119;
const RATIO_PNN = 480 / 187;

const ALTO_ENCABEZADO = 30;
const ALTO_FRANJA = 2.5;
const ALTO_LOGO = 11;

function encabezado(doc, titulo, subtitulo) {
  const ancho = doc.internal.pageSize.getWidth();
  doc.setFillColor(...VERDE);
  doc.rect(0, 0, ancho, ALTO_FRANJA, 'F');
  doc.setFillColor(255, 255, 255);
  doc.rect(0, ALTO_FRANJA, ancho, ALTO_ENCABEZADO - ALTO_FRANJA, 'F');

  const yLogo = ALTO_FRANJA + (ALTO_ENCABEZADO - ALTO_FRANJA - ALTO_LOGO) / 2;
  const wPat = ALTO_LOGO * RATIO_PATRIMONIO;
  const wPnn = ALTO_LOGO * RATIO_PNN;
  doc.addImage(LOGO_PATRIMONIO, 'PNG', MARGEN, yLogo, wPat, ALTO_LOGO);
  doc.addImage(LOGO_PNN, 'PNG', ancho - MARGEN - wPnn, yLogo, wPnn, ALTO_LOGO);

  const xIzq = MARGEN + wPat + 6;
  const xDer = ancho - MARGEN - wPnn - 6;
  const centroX = (xIzq + xDer) / 2;
  doc.setFont('helvetica', 'bold');
  doc.setFontSize(12.5);
  doc.setTextColor(...VERDE);
  doc.text(titulo, centroX, ALTO_FRANJA + (ALTO_ENCABEZADO - ALTO_FRANJA) / 2 - 1, { align: 'center' });
  doc.setFont('helvetica', 'normal');
  doc.setFontSize(8);
  doc.setTextColor(...GRIS_TEXTO);
  doc.text(subtitulo, centroX, ALTO_FRANJA + (ALTO_ENCABEZADO - ALTO_FRANJA) / 2 + 4, { align: 'center' });

  doc.setDrawColor(...OCRE);
  doc.setLineWidth(0.6);
  doc.line(0, ALTO_ENCABEZADO, ancho, ALTO_ENCABEZADO);
  doc.setLineWidth(0.2);
  return ALTO_ENCABEZADO + 7;
}

function piePagina(doc) {
  const total = doc.internal.getNumberOfPages();
  for (let i = 1; i <= total; i++) {
    doc.setPage(i);
    const alto = doc.internal.pageSize.getHeight();
    const ancho = doc.internal.pageSize.getWidth();
    if (i === 1) continue; // la portada no lleva pie
    doc.setDrawColor(...OCRE);
    doc.setLineWidth(0.3);
    doc.line(MARGEN, alto - 13, ancho - MARGEN, alto - 13);
    doc.setLineWidth(0.2);
    doc.setFont('helvetica', 'normal');
    doc.setFontSize(8);
    doc.setTextColor(...GRIS_CLARO);
    doc.text('Guía de Calificación — Matriz de Sostenibilidad · PNN Puracé', MARGEN, alto - 8);
    doc.text(`${i}/${total}`, ancho - MARGEN - 8, alto - 8);
  }
}

// ─── Cursor con paginación automática (misma lógica de lib/pdf-utils.js) ───
function crearCursor(doc, tituloContinuacion, subtituloContinuacion) {
  let y = 0;

  function saltoSiNecesario(espacio) {
    if (y + espacio > A4_H - MARGEN - 14) {
      doc.addPage();
      y = encabezado(doc, tituloContinuacion, subtituloContinuacion);
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
    lista(items, { tamano = 9.5, color = GRIS_TEXTO, marcador = '•' } = {}) {
      doc.setFont('helvetica', 'normal');
      doc.setFontSize(tamano);
      doc.setTextColor(...color);
      items.forEach((item) => {
        const lineas = doc.splitTextToSize(item, ANCHO_UTIL - 6);
        saltoSiNecesario(lineas.length * 4.6 + 1.5);
        doc.text(marcador, MARGEN, y);
        doc.text(lineas, MARGEN + 5, y);
        y += lineas.length * 4.6 + 1.5;
      });
    },
    linea(color = GRIS_CLARO) {
      saltoSiNecesario(6);
      doc.setDrawColor(...color);
      doc.line(MARGEN, y, A4_W - MARGEN, y);
      y += 6;
    },
  };
}

// ─── Datos ───
const indicadores = JSON.parse(fs.readFileSync(path.join(__dirname, 'anexo-a-indicadores.json'), 'utf-8'));
indicadores.sort((a, b) => a.numero - b.numero);

const DIMENSIONES = [
  { nombre: 'Socioambiental', rango: [1, 6] },
  { nombre: 'Ambiental', rango: [7, 12] },
  { nombre: 'Socioeconómica', rango: [13, 20] },
  { nombre: 'Productiva', rango: [21, 29] },
];

const TITULO_DOC = 'Guía de Calificación';
const SUBTITULO_DOC = 'Matriz de Sostenibilidad de 29 Indicadores — PNN Puracé';

// ─── Construcción del PDF ───
const doc = new jsPDF();

// Portada
encabezado(doc, TITULO_DOC, SUBTITULO_DOC);
doc.setFont('helvetica', 'bold');
doc.setFontSize(26);
doc.setTextColor(...VERDE);
doc.text('Guía de Calificación', A4_W / 2, 130, { align: 'center' });
doc.setFontSize(15);
doc.setTextColor(...GRIS_TEXTO);
doc.text('Matriz de Sostenibilidad de 29 Indicadores', A4_W / 2, 142, { align: 'center' });
doc.setFontSize(11);
doc.setTextColor(...TERRACOTA);
doc.text('Parque Nacional Natural Puracé · Estrategia SSC', A4_W / 2, 151, { align: 'center' });
doc.setDrawColor(...OCRE);
doc.setLineWidth(0.6);
doc.line(A4_W / 2 - 25, 158, A4_W / 2 + 25, 158);
doc.setLineWidth(0.2);
doc.setFont('helvetica', 'normal');
doc.setFontSize(9);
doc.setTextColor(...GRIS_CLARO);
const fechaHoy = new Date().toLocaleDateString('es-CO', { year: 'numeric', month: 'long', day: 'numeric' });
doc.text(`Versión actualizada — ${fechaHoy}`, A4_W / 2, 168, { align: 'center' });
doc.setFillColor(...VERDE);
doc.rect(0, A4_H - ALTO_FRANJA, A4_W, ALTO_FRANJA, 'F');

// Página "Cómo usar esta guía"
doc.addPage();
let y0 = encabezado(doc, TITULO_DOC, SUBTITULO_DOC);
const c0 = crearCursor(doc, TITULO_DOC, SUBTITULO_DOC);
c0.y = y0;
c0.parrafo('Cómo usar esta guía', { tamano: 15, color: VERDE, negrita: true, interlineado: 6 });
c0.avanzar(1);
c0.parrafo(
  'Cada uno de los 29 indicadores se califica en una escala ordinal de 1 a 5, donde 1 representa el nivel más bajo de sostenibilidad (situación crítica o práctica insostenible) y 5 representa el nivel más alto (práctica óptima o de referencia). La escala es la misma para todos los indicadores, lo que permite calcular el promedio por dimensión y el promedio global de sostenibilidad predial.',
  { tamano: 10, interlineado: 5.2 }
);
c0.avanzar(1);
c0.parrafo(
  'Para cada indicador, esta guía describe la situación correspondiente a cada nivel, las preguntas orientadoras que ayudan a indagar en campo, y recomendaciones prácticas para el evaluador. Si el dato de campo cae justo en el límite entre dos niveles, elija el nivel inferior.',
  { tamano: 10, interlineado: 5.2 }
);
c0.avanzar(4);
c0.parrafo('Niveles globales de sostenibilidad predial', { tamano: 12, color: VERDE, negrita: true });
c0.avanzar(1);

const nivelesGlobales = [
  ['Muy Alto', '3,5 o superior'],
  ['Alto', 'De 3,0 a menos de 3,5'],
  ['Medio', 'De 2,5 a menos de 3,0'],
  ['Bajo', 'Inferior a 2,5'],
];
{
  const colW = [40, ANCHO_UTIL - 40];
  doc.setFillColor(...VERDE);
  doc.rect(MARGEN, c0.y, ANCHO_UTIL, 7, 'F');
  doc.setFont('helvetica', 'bold');
  doc.setFontSize(9.5);
  doc.setTextColor(255, 255, 255);
  doc.text('Nivel', MARGEN + 3, c0.y + 5);
  doc.text('Promedio global', MARGEN + colW[0] + 3, c0.y + 5);
  c0.y += 7;
  nivelesGlobales.forEach(([nivel, rango], i) => {
    const h = 7;
    if (i % 2 === 1) { doc.setFillColor(...CREMA); doc.rect(MARGEN, c0.y, ANCHO_UTIL, h, 'F'); }
    doc.setFont('helvetica', 'normal');
    doc.setFontSize(9.5);
    doc.setTextColor(...GRIS_TEXTO);
    doc.text(nivel, MARGEN + 3, c0.y + 5);
    doc.text(rango, MARGEN + colW[0] + 3, c0.y + 5);
    c0.y += h;
  });
  doc.setDrawColor(...GRIS_CLARO);
  doc.rect(MARGEN, c0.y - 7 * (nivelesGlobales.length + 1), ANCHO_UTIL, 7 * (nivelesGlobales.length + 1));
}

// ─── Página: reglas de aplicación y formas de levantamiento ───
doc.addPage();
const cR = crearCursor(doc, TITULO_DOC, SUBTITULO_DOC);
cR.y = encabezado(doc, TITULO_DOC, SUBTITULO_DOC);

cR.parrafo('Reglas de aplicación', { tamano: 15, color: VERDE, negrita: true, interlineado: 6 });
cR.avanzar(1);
cR.parrafo(
  'Estas siete reglas aplican a los 29 indicadores por igual. La validez del instrumento depende de que dos evaluadores distintos califiquen igual el mismo predio, y la dispersión entre evaluadores viene sobre todo de no aplicar estas reglas de forma consistente.',
  { tamano: 10, interlineado: 5.2 }
);
cR.avanzar(2);
cR.lista([
  'Califique lo observado, no lo declarado. Si no lo puede verificar, regístrelo como discrepancia.',
  'Si duda entre dos niveles, elija el inferior.',
  'Tome fotografías: al menos una por cada indicador calificado en 2 o menos, y una panorámica del predio. La herramienta digital las exige y no permite cerrar la visita sin ellas.',
  'Entreviste solo lo no observable (registros, ingresos, créditos, historial sanitario). Lo físico se observa.',
  'Recorra el predio completo. No califique desde la casa. Es válido observar durante el recorrido y consignar al cierre, bajo techo, cuando las condiciones climáticas lo impidan.',
  'Registre "no aplica" con justificación. La herramienta digital todavía no dispone de esa casilla: califique 1 y escriba NO APLICA junto con el motivo en el campo de observación.',
  'Firme al cerrar: evaluador y productor.',
], { marcador: '>' });

cR.avanzar(4);
cR.parrafo('Tres formas de levantar la información', { tamano: 13, color: VERDE, negrita: true, interlineado: 5.5 });
cR.avanzar(1);
cR.parrafo(
  'No son 29 indicadores independientes: son tres formas de trabajar. Quien domina la forma, la aplica a todo el grupo. Cada ficha indica a qué familia pertenece el indicador.',
  { tamano: 10, interlineado: 5.2 }
);
cR.avanzar(2);
cR.lista([
  'Familia A — Estimación visual de proporción o densidad: indicadores 1, 5, 8, 9, 12 y 20. El ojo se entrena; por eso los talleres incluyen ejercicios de calibración.',
  'Familia B — Verificación de existencia y funcionamiento: indicadores 2, 3, 4, 6, 10, 11, 18, 19 y 21. El trabajo consiste en pedir que se lo muestren. Si no se lo pueden mostrar, no cuenta.',
  'Familia C — Entrevista y cálculo: indicadores 13 a 17 y 22 a 29. Los indicadores 22 a 28 dependen de que existan registros (indicador 29); sin registros se estima por entrevista y aplica con más fuerza la regla de elegir el nivel inferior.',
], { marcador: '•' });

cR.avanzar(4);
cR.parrafo('Cálculos que resuelve la herramienta digital', { tamano: 13, color: VERDE, negrita: true, interlineado: 5.5 });
cR.avanzar(1);
cR.parrafo(
  'Cinco indicadores traen calculadora en la aplicación: el evaluador entrega los datos fáciles de preguntar en campo y la herramienta aplica la fórmula y sugiere el puntaje según la banda oficial. La fórmula permanece visible, con el propósito de que el evaluador la interiorice y con el tiempo pueda prescindir de la guía impresa. La aplicación conserva además los datos de entrada, no solo el resultado, de modo que el dato sea auditable y pueda recalcularse si una fórmula cambia.',
  { tamano: 10, interlineado: 5.2 }
);
cR.avanzar(2);
cR.lista([
  'Indicador 8 — árboles establecidos y vivos por hectárea.',
  'Indicador 22 — litros de leche por hectárea al año.',
  'Indicador 25 — carga animal en UGG por hectárea.',
  'Indicador 27 — tasa de mortalidad anual.',
  'Indicador 28 — intervalo entre partos.',
], { marcador: '•' });

// Fichas de indicador, agrupadas por dimensión
doc.addPage();
let y = encabezado(doc, TITULO_DOC, SUBTITULO_DOC);
const c = crearCursor(doc, TITULO_DOC, SUBTITULO_DOC);
c.y = y;

DIMENSIONES.forEach((dim) => {
  c.saltoSiNecesario(16);
  doc.setFillColor(...VERDE);
  doc.rect(MARGEN, c.y, ANCHO_UTIL, 9, 'F');
  doc.setFont('helvetica', 'bold');
  doc.setFontSize(11);
  doc.setTextColor(255, 255, 255);
  doc.text(`DIMENSIÓN ${dim.nombre.toUpperCase()} — Indicadores ${dim.rango[0]} a ${dim.rango[1]}`, MARGEN + 4, c.y + 6.2);
  c.y += 14;

  const delDim = indicadores.filter((ind) => ind.numero >= dim.rango[0] && ind.numero <= dim.rango[1]);
  delDim.forEach((ind) => {
    c.saltoSiNecesario(30);
    c.parrafo(`Indicador ${ind.numero}. ${ind.nombre}`, { tamano: 12, color: VERDE, negrita: true, interlineado: 5.5 });
    c.parrafo(ind.descripcion, { tamano: 9.5, interlineado: 4.6 });
    if (ind.ajustes) {
      c.parrafo(`Ajustes contextuales: ${ind.ajustes}`, { tamano: 9, color: TERRACOTA, cursiva: true, interlineado: 4.4 });
    }
    if (ind.nota_metodo) {
      c.parrafo(`Cómo se levanta: ${ind.nota_metodo}`, { tamano: 9, color: VERDE_SEC, cursiva: true, interlineado: 4.4 });
    }
    c.avanzar(1.5);

    // Tabla de niveles (5 filas, color por nivel)
    const colNivel = 16;
    const colSit = ANCHO_UTIL - colNivel;
    const filas = ind.niveles.slice().sort((a, b) => Number(b.nivel) - Number(a.nivel));
    filas.forEach((fila) => {
      doc.setFont('helvetica', 'normal');
      doc.setFontSize(9);
      const lineas = doc.splitTextToSize(fila.situacion, colSit - 6);
      const h = Math.max(lineas.length * 4.3 + 3, 8);
      c.saltoSiNecesario(h);
      doc.setFillColor(...NIVEL_FONDO[fila.nivel]);
      doc.rect(MARGEN, c.y, ANCHO_UTIL, h, 'F');
      doc.setDrawColor(...NIVEL_BORDE[fila.nivel]);
      doc.setLineWidth(0.4);
      doc.line(MARGEN, c.y, MARGEN, c.y + h);
      doc.setLineWidth(0.2);
      doc.setFont('helvetica', 'bold');
      doc.setFontSize(10);
      doc.setTextColor(...NIVEL_BORDE[fila.nivel]);
      doc.text(fila.nivel, MARGEN + colNivel / 2, c.y + h / 2 + 1.2, { align: 'center' });
      doc.setFont('helvetica', 'normal');
      doc.setFontSize(9);
      doc.setTextColor(...GRIS_TEXTO);
      doc.text(lineas, MARGEN + colNivel + 3, c.y + 4.3);
      c.y += h;
    });
    c.avanzar(2.5);

    if (ind.preguntas?.length) {
      c.parrafo('Preguntas orientadoras', { tamano: 9.5, color: VERDE_SEC, negrita: true, interlineado: 4 });
      c.lista(ind.preguntas, { marcador: '•' });
      c.avanzar(1);
    }
    if (ind.recomendaciones?.length) {
      c.parrafo('Recomendaciones prácticas', { tamano: 9.5, color: TERRACOTA, negrita: true, interlineado: 4 });
      c.lista(ind.recomendaciones, { marcador: '>' });
    }
    c.avanzar(3);
    c.linea();
  });
});

piePagina(doc);

const outPath = path.join(ROOT, 'public', 'docs', 'guia-calificacion-matriz.pdf');
fs.writeFileSync(outPath, Buffer.from(doc.output('arraybuffer')));
console.log('PDF generado:', outPath, `(${doc.internal.getNumberOfPages()} páginas)`);
