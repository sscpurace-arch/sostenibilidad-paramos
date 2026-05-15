import pandas as pd
import requests
import uuid

url = "https://vxtzvadknxmstdcwfwhb.supabase.co"
anon_key = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ4dHp2YWRrbnhtc3RkY3dmd2hiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzY4MTczOTgsImV4cCI6MjA5MjM5MzM5OH0.RqtYEisfvtFWlQ539WwTW39aJBRTVpvWhS9KiRDUXjU"

headers = {
    "apikey": anon_key,
    "Authorization": f"Bearer {anon_key}",
    "Content-Type": "application/json",
    "Prefer": "return=representation"
}

# 1. Insert Evaluador
evaluator_id = str(uuid.uuid4())
print(f"Creating evaluador user with ID {evaluator_id}")
requests.post(
    f"{url}/rest/v1/usuarios",
    headers=headers,
    json={"id": evaluator_id, "nombre": "Evaluador Principal", "email": "sscpurace@gmail.com", "rol": "evaluador"}
)

def clean_str(val):
    return "" if pd.isna(val) else str(val).strip()

def get_lat_lng(ubicacion):
    if pd.isna(ubicacion):
        return None, None
    parts = str(ubicacion).split(",")
    if len(parts) >= 2:
        try:
            return float(parts[0].strip()), float(parts[1].strip())
        except:
            pass
    return None, None

def parse_score(val):
    if pd.isna(val):
        return None
    try:
        score = int(float(val))
        if 1 <= score <= 5: return score
    except:
        pass
    return None

df = pd.read_excel(r"c:\Users\Maria Mercedez\Documents\Estrategia SSC - GEF Páramos\Plan de trabajo\Seguimiento a acuerdos\Herramienta calificacion indicadores\Matriz de sustentabilidad - Silvo Paletara.xlsx")
cols = df.columns.tolist()
cedula_col = [c for c in cols if 'dula' in c.lower()][0]
ubicacion_col = [c for c in cols if 'bicaci' in c.lower()][0]

ind_cols = {}
for c in cols:
    parts = str(c).split('.')
    if len(parts) > 1 and parts[0].isdigit():
        num = int(parts[0])
        if 1 <= num <= 29: ind_cols[num] = c

print("Processing records...")
count = 0
for index, row in df.iterrows():
    cedula = clean_str(row[cedula_col])
    if not cedula or cedula == 'nan': continue
    
    lat, lng = get_lat_lng(row[ubicacion_col])
    fecha = row['Fecha']
    fecha_str = fecha.isoformat() if not pd.isna(fecha) else None
    
    prod_data = {
        "cedula": cedula,
        "nombre_completo": clean_str(row['Nombre completo']),
        "nombre_predio": clean_str(row['Nombre de predio']),
        "vereda": clean_str(row['Vereda']),
        "municipio": clean_str(row['Municipio']),
        "ubicacion_lat": lat,
        "ubicacion_lng": lng,
        "created_by": evaluator_id
    }
    
    upsert_headers = headers.copy()
    upsert_headers["Prefer"] = "resolution=merge-duplicates,return=representation"
    prod_res = requests.post(f"{url}/rest/v1/productores", headers=upsert_headers, json=prod_data)
    if prod_res.status_code >= 400:
        print("Error productor:", prod_res.text)
        continue
    
    productor_id = prod_res.json()[0]["id"]
    
    cal_data = {
        "productor_id": productor_id,
        "usuario_id": evaluator_id,
        "estado": "completada"
    }
    if fecha_str:
        cal_data["fecha_inicio"] = fecha_str
        cal_data["fecha_fin"] = fecha_str
        
    cal_res = requests.post(f"{url}/rest/v1/calificaciones", headers=headers, json=cal_data)
    if cal_res.status_code >= 400:
        print("Error calificacion:", cal_res.text)
        continue
        
    cal_id = cal_res.json()[0]["id"]
    observaciones = clean_str(row.get('Observaciones', ''))
    
    detalles = []
    for ind_id, col in ind_cols.items():
        score = parse_score(row[col])
        if score is not None:
            detalles.append({
                "calificacion_id": cal_id,
                "indicador_id": ind_id,
                "puntaje": score,
                "observacion": observaciones
            })
            
    if detalles:
        det_res = requests.post(f"{url}/rest/v1/calificacion_detalle", headers=headers, json=detalles)
        if det_res.status_code >= 400:
            print("Error detalles:", det_res.text)
            
    count += 1
    if count % 20 == 0:
        print(f"Imported {count} records...")

print(f"Successfully imported {count} producers and their scores.")
