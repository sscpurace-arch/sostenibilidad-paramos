import './globals.css';
import { Nunito_Sans } from 'next/font/google';

const nunito = Nunito_Sans({ 
  subsets: ['latin'], 
  variable: '--font-nunito',
  weight: ['300', '400', '600', '700', '800', '900'],
  display: 'swap',
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
  maximumScale: 1,
  userScalable: false,
};

export default function RootLayout({ children }) {
  return (
    <html lang="es">
      <body className={`${nunito.variable} font-sans`}>{children}</body>
    </html>
  );
}

