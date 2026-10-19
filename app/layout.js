import './globals.css';
import HidratadoMarca from '@/components/HidratadoMarca';
import { Nunito_Sans } from 'next/font/google';
import fs from 'fs';
import path from 'path';

// Self-copy assets for offline capability and PWA
try {
  const imagesDir = path.join(process.cwd(), 'public', 'images');
  const publicDir = path.join(process.cwd(), 'public');
  
  // 1. Copy leaflet images from node_modules to public/images
  const leafletImagesDir = path.join(process.cwd(), 'node_modules', 'leaflet', 'dist', 'images');
  if (fs.existsSync(leafletImagesDir)) {
    if (!fs.existsSync(imagesDir)) {
      fs.mkdirSync(imagesDir, { recursive: true });
    }
    const files = ['marker-icon.png', 'marker-icon-2x.png', 'marker-shadow.png'];
    files.forEach(file => {
      const srcPath = path.join(leafletImagesDir, file);
      const destPath = path.join(imagesDir, file);
      if (fs.existsSync(srcPath) && !fs.existsSync(destPath)) {
        fs.copyFileSync(srcPath, destPath);
        console.log(`[setup] Copied ${file} to public/images/`);
      }
    });
  }

  // 2. Generate/copy PWA icons
  const logoPath = path.join(imagesDir, 'logo-purace.png');
  const pwaIcon192 = path.join(publicDir, 'icon-192x192.png');
  const pwaIcon512 = path.join(publicDir, 'icon-512x512.png');

  if (fs.existsSync(logoPath)) {
    if (!fs.existsSync(pwaIcon192)) {
      fs.copyFileSync(logoPath, pwaIcon192);
      console.log(`[setup] Generated icon-192x192.png from logo-purace.png`);
    }
    if (!fs.existsSync(pwaIcon512)) {
      fs.copyFileSync(logoPath, pwaIcon512);
      console.log(`[setup] Generated icon-512x512.png from logo-purace.png`);
    }
  } else {
    // Fallback to logo-pnn.png if logo-purace.png doesn't exist
    const fallbackLogoPath = path.join(imagesDir, 'logo-pnn.png');
    if (fs.existsSync(fallbackLogoPath)) {
      if (!fs.existsSync(pwaIcon192)) {
        fs.copyFileSync(fallbackLogoPath, pwaIcon192);
        console.log(`[setup] Generated icon-192x192.png from logo-pnn.png`);
      }
      if (!fs.existsSync(pwaIcon512)) {
        fs.copyFileSync(fallbackLogoPath, pwaIcon512);
        console.log(`[setup] Generated icon-512x512.png from logo-pnn.png`);
      }
    }
  }
} catch (err) {
  console.error('[setup] Error setting up local assets:', err);
}

const nunito = Nunito_Sans({ 
  subsets: ['latin'], 
  variable: '--font-nunito',
  weight: ['300', '400', '600', '700', '800', '900'],
  display: 'swap',
  adjustFontFallback: false,
});

export const metadata = {
  title: 'Sostenibilidad Páramos',
  description: 'PNN Puracé - Estrategia SSC',
  manifest: '/manifest.json',
};

export const viewport = {
  themeColor: '#03A64A',
  width: 'device-width',
  initialScale: 1,
  maximumScale: 5,
  userScalable: true,
  // Sin esto, env(safe-area-inset-*) devuelve 0 y la barra inferior queda
  // debajo del gesto de inicio del iPhone.
  viewportFit: 'cover',
};

// Vigilante de carga. Corre ANTES de los archivos de la app y no depende de
// ellos: si una pantalla no termina de arrancar (típico sin señal cuando falta
// algún archivo de código guardado), la página se queda en "Cargando…" sin
// decir nada. Pasados 12 s sin que la app avise que arrancó, muestra un aviso
// con los archivos que no cargaron, para que el técnico (y nosotros) sepan por
// qué en lugar de esperar a ciegas.
const VIGILANTE_CARGA = `
(function () {
  var fallos = [];
  window.__hidratado = false;
  window.addEventListener('error', function (e) {
    var t = e && e.target;
    if (t && t !== window && (t.src || t.href)) {
      fallos.push(String(t.src || t.href).split('/').slice(-2).join('/'));
    }
  }, true);
  setTimeout(function () {
    if (window.__hidratado || document.getElementById('aviso-carga-fallida')) return;
    var d = document.createElement('div');
    d.id = 'aviso-carga-fallida';
    d.style.cssText = 'position:fixed;left:0;right:0;bottom:0;z-index:99999;background:#7a1f1f;color:#fff;padding:12px 14px;font:13px/1.35 sans-serif';
    var txt = '<b>La pantalla no terminó de cargar.</b> ';
    if (!navigator.onLine) txt += 'Estás sin internet y faltan archivos guardados en el celular. ';
    if (fallos.length) txt += 'No cargaron: ' + fallos.slice(0, 4).join(', ') + '. ';
    txt += '<br>Con internet entra a /diagnostico y toca "Guardar pantallas ahora".' +
      ' <button onclick="location.reload()" style="margin-left:6px;padding:3px 10px;border-radius:6px;border:0">Reintentar</button>';
    d.innerHTML = txt;
    document.body.appendChild(d);
  }, 12000);
})();
`;

export default function RootLayout({ children }) {
  return (
    <html lang="es">
      <body className={`${nunito.variable} font-sans`}>
        <script dangerouslySetInnerHTML={{ __html: VIGILANTE_CARGA }} />
        <HidratadoMarca />
        {children}
      </body>
    </html>
  );
}

