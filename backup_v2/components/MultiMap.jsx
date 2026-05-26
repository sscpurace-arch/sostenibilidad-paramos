'use client';
import 'leaflet/dist/leaflet.css';
import { MapContainer, TileLayer, Marker, Popup, useMap, LayersControl, GeoJSON } from 'react-leaflet';
import L from 'leaflet';
import { useEffect, useState, useMemo } from 'react';
import { useRouter } from 'next/navigation';

// Componente para ajustar los límites del mapa para mostrar todos los puntos
function SetBounds({ points }) {
  const map = useMap();
  
  useEffect(() => {
    if (points && points.length > 0) {
      const bounds = L.latLngBounds(points.map(p => [p.lat, p.lng]));
      map.fitBounds(bounds, { padding: [50, 50], maxZoom: 16 });
    }
  }, [points, map]);
  
  return null;
}

// Forzar la actualización del tamaño del contenedor del mapa
function FixSize() {
  const map = useMap();
  useEffect(() => {
    const timer = setTimeout(() => {
      map.invalidateSize();
    }, 200);
    return () => clearTimeout(timer);
  }, [map]);
  return null;
}

export default function MultiMap({ producers }) {
  const router = useRouter();
  const [boundary, setBoundary] = useState(null);

  useEffect(() => {
    fetch('/purace-boundary.json')
      .then(res => res.json())
      .then(data => setBoundary(data))
      .catch(err => console.error('Error cargando perímetro:', err));
  }, []);

  // Filtrar productores con coordenadas válidas
  const validProducers = useMemo(() => {
    return producers.filter(p => p.ubicacion_lat && p.ubicacion_lng).map(p => ({
      ...p,
      lat: parseFloat(p.ubicacion_lat),
      lng: parseFloat(p.ubicacion_lng)
    }));
  }, [producers]);

  // Generar iconos basados en el color de la vereda
  const getMarkerIcon = (color) => {
    return new L.DivIcon({
      className: 'custom-div-icon',
      html: `<div style="background-color: ${color}; width: 26px; height: 26px; border-radius: 50% 50% 50% 0; transform: rotate(-45deg); border: 2.5px solid white; box-shadow: 0 3px 6px rgba(0,0,0,0.4); display: flex; align-items: center; justify-content: center;">
               <div style="width: 8px; height: 8px; background-color: white; border-radius: 50%; transform: rotate(45deg);"></div>
             </div>`,
      iconSize: [26, 26],
      iconAnchor: [13, 26],
      popupAnchor: [0, -26]
    });
  };

  return (
    <div style={{ width: '100%', height: '100%', minHeight: '500px' }} className="relative">
      <MapContainer 
        center={[2.342, -76.385]} // Default Puracé area
        zoom={13} 
        scrollWheelZoom={true} 
        style={{ width: '100%', height: '100%' }}
      >
        <FixSize />
        <SetBounds points={validProducers} />
        
        <LayersControl position="topright">
          <LayersControl.BaseLayer checked name="Mapa de Calles">
            <TileLayer
              attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
              url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
            />
          </LayersControl.BaseLayer>
          <LayersControl.BaseLayer name="Satélite">
            <TileLayer
              attribution='&copy; Esri World Imagery'
              url="https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}"
            />
          </LayersControl.BaseLayer>
        </LayersControl>

        {boundary && (
          <>
            {/* Capa de sombra/borde para contraste universal (Halo) */}
            <GeoJSON 
              data={boundary} 
              style={{
                color: '#000000',
                weight: 6,
                opacity: 0.5,
                fill: false,
              }}
            />
            {/* Capa principal naranja vibrante */}
            <GeoJSON 
              data={boundary} 
              style={{
                color: '#FF5722', 
                weight: 3,
                opacity: 1,
                fillColor: '#FF5722',
                fillOpacity: 0.05,
              }}
            />
          </>
        )}

        {validProducers.map((p) => (
          <Marker 
            key={p.id} 
            position={[p.lat, p.lng]} 
            icon={getMarkerIcon(p.color || '#03A64A')}
          >
            <Popup className="custom-popup">
              <div className="p-1 min-w-[150px]">
                <h3 className="font-bold text-gray-800 text-sm mb-1">{p.nombre_completo}</h3>
                <div className="flex flex-col gap-1 mb-3">
                   <div className="flex items-center gap-1 text-[10px] text-gray-500 font-medium">
                     <span className="w-2 h-2 rounded-full" style={{ backgroundColor: p.color }}></span>
                     <span>Vereda: {p.vereda || 'Sin registrar'}</span>
                   </div>
                   <div className="text-[10px] text-gray-400">Predio: {p.nombre_predio || '-'}</div>
                </div>
                <button 
                  onClick={() => router.push(`/calificacion/nueva/${p.id}`)}
                  className="w-full bg-[#03A64A] text-white py-2 rounded-lg text-xs font-bold shadow-sm active:scale-95 transition-all"
                >
                  Ver Perfil
                </button>
              </div>
            </Popup>
          </Marker>
        ))}
      </MapContainer>

      {/* Leyenda de Veredas */}
      <div className="absolute bottom-6 left-6 z-[1000] bg-white/95 backdrop-blur-sm p-3 rounded-2xl shadow-2xl border border-gray-100 max-h-[180px] overflow-y-auto min-w-[140px]">
        <h4 className="text-[10px] font-black uppercase text-gray-400 mb-2 border-b pb-1">Veredas</h4>
        <div className="flex flex-col gap-2">
          {Array.from(new Set(validProducers.map(p => p.vereda))).sort().map(vereda => {
            const prod = validProducers.find(p => p.vereda === vereda);
            return (
              <div key={vereda || 'none'} className="flex items-center gap-2">
                <span className="w-3.5 h-3.5 rounded-full border border-white shadow-sm" style={{ backgroundColor: prod?.color || '#03A64A' }}></span>
                <span className="text-[11px] text-gray-700 font-bold leading-tight">{vereda || 'Sin registrar'}</span>
              </div>
            );
          })}
          <div className="flex items-center gap-2 pt-1 border-t mt-1">
            <span className="w-3.5 h-1 border-t-2 border-dashed border-[#03A64A]"></span>
            <span className="text-[10px] text-gray-400 font-black uppercase">Límite PNN</span>
          </div>
        </div>
      </div>
    </div>
  );
}
