/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./components/**/*.{js,ts,jsx,tsx,mdx}",
    "./app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      colors: {
        background: "var(--background)",
        foreground: "var(--foreground)",
        // Paleta oficial PNN — Manual de Identidad Visual
        pnn: {
          verde: '#03A64A',         // Verde Institucional (primario)
          'verde-oscuro': '#028A3D',
          'verde-profundo': '#016B30',
          'verde-manzana': '#96BE52', // Verde Manzana (acentos éxito)
          azul: '#049DD9',          // Azul PNN (links, info, mapas)
          'azul-claro': '#05C7F2', // Azul Claro (hovers, acentos)
          gris: '#F2F2F2',         // Gris Fondo (legacy)
          negro: '#0D0D0D',        // Negro Texto
        },
        // Dark theme — Páramo Digital
        paramo: {
          deep: '#0A2E1C',         // Fondo principal oscuro
          dark: '#0D3B23',         // Gradiente start
          mid: '#133D28',          // Cards oscuras
          surface: '#1A4D33',      // Superficies elevadas
          glow: 'rgba(3, 166, 74, 0.15)', // Glow verde sutil
        },
        // Glassmorphism
        glass: {
          bg: 'rgba(255, 255, 255, 0.08)',
          border: 'rgba(255, 255, 255, 0.12)',
          'bg-light': 'rgba(255, 255, 255, 0.95)',
        },
        // Colores de acento (Bandera de Colombia)
        acento: {
          amarillo: '#FFC800',
          azul: '#003189',
          rojo: '#D80025',          // Alertas / danger
        },
        // Colores derivados del logo PNN Puracé
        purace: {
          venado: '#C9A630',        // Dorado del venado
          volcan: '#8FA4A0',        // Gris páramo
          cielo: '#3B7BBF',         // Azul cielo del logo
          nieve: '#F0F4F2',         // Blanco volcán
        },
      },
      fontFamily: {
        sans: ['var(--font-nunito)', 'Nunito Sans', 'sans-serif'],
      },
      boxShadow: {
        'glow-green': '0 0 20px rgba(3, 166, 74, 0.3)',
        'glow-blue': '0 0 20px rgba(4, 157, 217, 0.3)',
        'glow-teal': '0 0 20px rgba(5, 199, 242, 0.3)',
        'card-premium': '0 8px 32px rgba(0, 0, 0, 0.12)',
        'card-hover': '0 12px 40px rgba(3, 166, 74, 0.15)',
      },
      backgroundImage: {
        'gradient-pnn': 'linear-gradient(135deg, #028A3D 0%, #049DD9 100%)',
        'gradient-hero': 'linear-gradient(160deg, #0D3B23 0%, #028A3D 50%, #049DD9 100%)',
        'gradient-dark': 'linear-gradient(180deg, #0D3B23 0%, #0A2E1C 40%, #091F14 100%)',
      },
      animation: {
        'float-slow': 'float 20s ease-in-out infinite',
        'fade-in-up': 'fadeInUp 0.6s ease-out forwards',
        'fade-in-up-delay-1': 'fadeInUp 0.6s ease-out 0.1s forwards',
        'fade-in-up-delay-2': 'fadeInUp 0.6s ease-out 0.2s forwards',
        'fade-in-up-delay-3': 'fadeInUp 0.6s ease-out 0.3s forwards',
        'pulse-glow': 'pulseGlow 3s ease-in-out infinite',
        'breathe': 'breathe 4s ease-in-out infinite',
      },
      keyframes: {
        float: {
          '0%, 100%': { transform: 'translateY(0px)' },
          '50%': { transform: 'translateY(-8px)' },
        },
        fadeInUp: {
          '0%': { opacity: '0', transform: 'translateY(20px)' },
          '100%': { opacity: '1', transform: 'translateY(0)' },
        },
        pulseGlow: {
          '0%, 100%': { boxShadow: '0 0 15px rgba(3, 166, 74, 0.2)' },
          '50%': { boxShadow: '0 0 25px rgba(3, 166, 74, 0.4)' },
        },
        breathe: {
          '0%, 100%': { transform: 'scale(1)' },
          '50%': { transform: 'scale(1.02)' },
        },
      },
    },
  },
  plugins: [],
};
