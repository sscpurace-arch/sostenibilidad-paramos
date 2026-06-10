'use client';
import 'leaflet/dist/leaflet.css';
import { MapContainer, TileLayer, Marker, Popup, useMap, LayersControl, GeoJSON } from 'react-leaflet';
import L from 'leaflet';
import { useEffect, useState } from 'react';

// Corregir el problema de los iconos de Leaflet en Next.js (cargados localmente para soporte offline)
const farmIcon = new L.Icon({
  iconUrl: '/images/marker-icon.png',
  iconRetinaUrl: '/images/marker-icon-2x.png',
  shadowUrl: '/images/marker-shadow.png',
  iconSize: [25, 41],
  iconAnchor: [12, 41],
  popupAnchor: [1, -34],
  shadowSize: [41, 41]
});

const userIcon = new L.DivIcon({
  className: 'user-location-marker',
  html: '<div style="width: 12px; height: 12px; background: #4285F4; border: 2px solid white; border-radius: 50%; box-shadow: 0 0 4px rgba(0,0,0,0.5);"></div>',
  iconSize: [16, 16],
  iconAnchor: [8, 8]
});

// Componente para centrar el mapa cuando cambien las coordenadas
function RecenterMap({ position }) {
  const map = useMap();
  useEffect(() => {
    if (position) {
      map.setView(position);
    }
  }, [position, map]);
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

export default function Map({ farmCoords, farmName }) {
  const [userCoords, setUserCoords] = useState(null);
  const [boundary, setBoundary] = useState(null);
  const [geoError, setGeoError] = useState(false);

  useEffect(() => {
    fetch('/purace-boundary.json')
      .then(res => res.json())
      .then(data => setBoundary(data))
      .catch(err => console.error('Error cargando perímetro:', err));
  }, []);

  useEffect(() => {
    if ('geolocation' in navigator) {
      const watchId = navigator.geolocation.watchPosition(
        (position) => {
          setGeoError(false);
          setUserCoords([position.coords.latitude, position.coords.longitude]);
        },
        (error) => {
          console.error('Error getting location:', error);
          setGeoError(true);
        },
        { enableHighAccuracy: true }
      );
      return () => navigator.geolocation.clearWatch(watchId);
    } else {
      setGeoError(true);
    }
  }, []);

  const center = farmCoords || userCoords || [2.342, -76.385]; // Default Puracé area

  return (
    <div style={{ width: '100%', height: '100%', minHeight: '400px' }} className="relative">
      <OfflineNotice />
      {/* Aviso cuando la geolocalización no está disponible o fue denegada */}
      {geoError && (
        <div className="absolute bottom-3 left-1/2 -translate-x-1/2 z-[1000] bg-black/75 text-white text-[10px] font-bold px-3 py-1.5 rounded-full shadow-lg whitespace-nowrap">
          📍 Ubicación no disponible
        </div>
      )}
      <MapContainer
        center={center} 
        zoom={15} 
        scrollWheelZoom={true} 
        style={{ width: '100%', height: '100%' }}
      >
        <FixSize />
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

        {farmCoords && (
          <Marker position={farmCoords} icon={farmIcon}>
            <Popup>
              <div className="font-bold">{farmName}</div>
              <div className="text-xs text-gray-500">Predio del Productor</div>
            </Popup>
          </Marker>
        )}

        {userCoords && (
          <Marker position={userCoords} icon={userIcon}>
            <Popup>Tu ubicación actual</Popup>
          </Marker>
        )}

        {boundary && (
          <>
            <GeoJSON 
              data={boundary} 
              style={{
                color: '#000000',
                weight: 6,
                opacity: 0.5,
                fill: false,
              }}
            />
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

        <RecenterMap position={farmCoords} />
      </MapContainer>
    </div>
  );
}
