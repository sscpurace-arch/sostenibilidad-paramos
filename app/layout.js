import './globals.css';
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
};

export default function RootLayout({ children }) {
  return (
    <html lang="es">
      <body className={`${nunito.variable} font-sans`}>{children}</body>
    </html>
  );
}

