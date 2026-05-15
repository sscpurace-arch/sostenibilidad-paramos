'use client';
import Link from 'next/link';
import { usePathname } from 'next/navigation';

export default function NavBar() {
  const pathname = usePathname();

  const links = [
    { name: 'Inicio', href: '/', icon: '🏠' },
    { name: 'Buscar', href: '/buscar', icon: '🔍' },
    { name: 'Mapa', href: '/mapa', icon: '🗺️' },
    { name: 'En proceso', href: '/en-proceso', icon: '⏳' },
    { name: 'Nuevo', href: '/nuevo-productor', icon: '➕' },
  ];

  return (
    <nav className="fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200 flex justify-around items-center py-2 z-40">
      {links.map((link) => {
        const isActive = pathname === link.href;
        return (
          <Link
            key={link.href}
            href={link.href}
            className={`flex flex-col items-center ${
              isActive ? 'text-[#2E7D32]' : 'text-gray-500'
            }`}
          >
            <span className="text-xl">{link.icon}</span>
            <span className="text-xs mt-1">{link.name}</span>
          </Link>
        );
      })}
    </nav>
  );
}
