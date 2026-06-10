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

// Aviso flotante cuando no hay conexión (solo se ven las teselas descargadas)
function OfflineNotice() {
  const [offline, setOffline] = useState(false);
  useEffect(() => {
    const update = () => setOffline(!navigator.onLine);
    update();
    window.addEventListener('online', update);
    window.addEventListener('offline', update);
    return () => {
      window.removeEventListener('online', update);
      window.removeEventListener('offline', update);
    };
  }, []);
  if (!offline) return null;
  return (
    <div className="absolute top-3 left-1/2 -translate-x-1/2 z-[1000] bg-black/75 text-white text-[10px] font-bold px-3 py-1.5 rounded-full shadow-lg whitespace-nowrap">
      📡 Sin conexión — mostrando mapa descargado
    </div>
  );
}

export default function MultiMap({ producers }) {
  const router = useRouter();
  const [boundary, setBoundary] = useState(null);
  const [selectedVeredas, setSelectedVeredas] = useState([]);

  useEffect(() => {
    fetch('/purace-boundary.json')
      .then(res => res.json())
      .then(data => setBoundary(data))
      .catch(err => console.error('Error cargando perímetro:', err));
  }, []);

  // Filtrar productores con coordenadas válidas + aplicar filtro de veredas
  const validProducers = useMemo(() => {
    let filtered = producers.filter(p => p.ubicacion_lat && p.ubicacion_lng).map(p => ({
      ...p,
      lat: parseFloat(p.ubicacion_lat),
      lng: parseFloat(p.ubicacion_lng)
    }));
    if (selectedVeredas.length > 0) {
      filtered = filtered.filter(p => selectedVeredas.includes(p.vereda || 'Sin registrar'));
    }
    return filtered;
  }, [producers, selectedVeredas]);

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
      <OfflineNotice />
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
              url="https://tile.openstreetmap.org/{z}/{x}/{y}.png"
              crossOrigin=""
            />
          </LayersControl.BaseLayer>
          <LayersControl.BaseLayer name="Satélite">
            <TileLayer
              attribution='&copy; Esri World Imagery'
              url="https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}"
              crossOrigin=""
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
      <div className="absolute bottom-6 left-6 z-[1000] bg-white/95 backdrop-blur-sm rounded-2xl shadow-2xl border border-gray-100 max-h-[350px] overflow-hidden flex flex-col min-w-[160px]">
        <div className="sticky top-0 bg-white/95 p-3 border-b pb-1">
          <h4 className="text-[10px] font-black uppercase text-gray-400 mb-2">Veredas</h4>
          {selectedVeredas.length > 0 && (
            <button onClick={() => setSelectedVeredas([])} className="text-[10px] font-bold text-[#03A64A] hover:underline text-left">
              ✕ Mostrar todas
            </button>
          )}
        </div>
        <div className="overflow-y-auto flex-1 p-3 flex flex-col gap-2">
          {Array.from(new Set(producers.map(p => p.vereda || 'Sin registrar'))).sort().map(vereda => {
            const prod = producers.find(p => (p.vereda || 'Sin registrar') === vereda);
            const count = producers.filter(p => (p.vereda || 'Sin registrar') === vereda && p.ubicacion_lat).length;
            const isSelected = selectedVeredas.includes(vereda);
            return (
              <button
                key={vereda}
                onClick={() => setSelectedVeredas(isSelected ? selectedVeredas.filter(v => v !== vereda) : [...selectedVeredas, vereda])}
                className={`flex items-center gap-2 p-1.5 rounded cursor-pointer transition-all ${isSelected ? 'bg-green-50 ring-1 ring-green-200' : 'hover:bg-gray-50'}`}
              >
                <span className={`w-3.5 h-3.5 rounded-full border shadow-sm transition-all ${isSelected ? 'ring-2 ring-offset-1 ring-green-500' : 'border-white'}`} style={{ backgroundColor: prod?.color || '#03A64A' }}></span>
                <span className="text-[11px] text-gray-700 font-bold leading-tight">{vereda} ({count})</span>
              </button>
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
