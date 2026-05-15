import zipfile
import os
import xml.etree.ElementTree as ET
import json
import re

def kml_to_geojson(kmz_path, output_path):
    print(f"Abriendo {kmz_path}...")
    
    # 1. Extraer KML del KMZ
    with zipfile.ZipFile(kmz_path, 'r') as z:
        kml_files = [f for f in z.namelist() if f.endswith('.kml')]
        if not kml_files:
            print("No se encontró archivo KML dentro del KMZ")
            return
        
        kml_content = z.read(kml_files[0]).decode('utf-8')

    # 2. Parsear KML
    # Quitar namespaces para facilitar el parsing con regex o ET simple
    kml_content = re.sub(r'xmlns="[^"]+"', '', kml_content)
    root = ET.fromstring(kml_content)
    
    features = []
    
    # Buscar todos los Placemark
    for placemark in root.findall('.//Placemark'):
        name = placemark.find('name')
        name_text = name.text if name is not None else "Sin nombre"
        
        # Buscar Polygon o LineString
        polygon = placemark.find('.//Polygon')
        linestring = placemark.find('.//LineString')
        
        coords_text = ""
        geom_type = ""
        
        if polygon is not None:
            outer = polygon.find('.//outerBoundaryIs')
            if outer is not None:
                coords_node = outer.find('.//coordinates')
                if coords_node is not None:
                    coords_text = coords_node.text
                    geom_type = "Polygon"
        elif linestring is not None:
            coords_node = linestring.find('.//coordinates')
            if coords_node is not None:
                coords_text = coords_node.text
                geom_type = "LineString"
        
        if coords_text:
            # Limpiar coordenadas
            coords_list = []
            for pair in coords_text.strip().split():
                parts = pair.split(',')
                if len(parts) >= 2:
                    try:
                        lng = float(parts[0])
                        lat = float(parts[1])
                        coords_list.append([lng, lat])
                    except ValueError:
                        continue
            
            if geom_type == "Polygon":
                # GeoJSON Polygon necesita una lista de listas (anillos)
                geometry = {
                    "type": "Polygon",
                    "coordinates": [coords_list]
                }
            else:
                geometry = {
                    "type": "LineString",
                    "coordinates": coords_list
                }
                
            features.append({
                "type": "Feature",
                "properties": {"name": name_text},
                "geometry": geometry
            })

    geojson = {
        "type": "FeatureCollection",
        "features": features
    }

    # 3. Guardar GeoJSON
    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(geojson, f, indent=2)
    
    print(f"GeoJSON generado con {len(features)} geometrías en {output_path}")

if __name__ == "__main__":
    kmz = r"c:\Users\Maria Mercedez\Documents\Estrategia SSC - GEF Páramos\sostenibilidad-paramos\docs\Pura.kmz"
    output = r"c:\Users\Maria Mercedez\Documents\Estrategia SSC - GEF Páramos\sostenibilidad-paramos\public\purace-boundary.json"
    kml_to_geojson(kmz, output)
