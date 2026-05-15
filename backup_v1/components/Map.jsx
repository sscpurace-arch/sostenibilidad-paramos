'use client';
import 'leaflet/dist/leaflet.css';
import { MapContainer, TileLayer, Marker, Popup, useMap, LayersControl } from 'react-leaflet';
import L from 'leaflet';
import { useEffect, useState } from 'react';

// Corregir el problema de los iconos de Leaflet en Next.js
const farmIcon = new L.Icon({
  iconUrl: 'https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon.png',
  iconRetinaUrl: 'https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon-2x.png',
  shadowUrl: 'https://unpkg.com/leaflet@1.9.4/dist/images/marker-shadow.png',
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

export default function Map({ farmCoords, farmName }) {
  const [userCoords, setUserCoords] = useState(null);

  useEffect(() => {
    if ('geolocation' in navigator) {
      const watchId = navigator.geolocation.watchPosition(
        (position) => {
          setUserCoords([position.coords.latitude, position.coords.longitude]);
        },
        (error) => console.error('Error getting location:', error),
        { enableHighAccuracy: true }
      );
      return () => navigator.geolocation.clearWatch(watchId);
    }
  }, []);

  const center = farmCoords || userCoords || [2.342, -76.385]; // Default Puracé area

  return (
    <div style={{ width: '100%', height: '100%', minHeight: '400px' }}>
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

        <RecenterMap position={farmCoords} />
      </MapContainer>
    </div>
  );
}
