import pandas as pd

# 1. Read Official Paletará List (140) from file
paletara_data = []
with open(r'c:\Users\Maria Mercedez\Documents\Estrategia SSC - GEF Páramos\sostenibilidad-paramos\scratch\paletara_list.txt', 'r', encoding='utf-8') as f:
    for line in f:
        parts = line.strip().split('\t')
        if len(parts) >= 4:
            paletara_data.append({
                'cedula': parts[0].strip(),
                'nombre': parts[1].strip(),
                'vereda': parts[2].strip(),
                'municipio': parts[3].strip()
            })

# 2. Official Sotará List (130 from Excel)
df_sotara = pd.read_excel(r'C:\Users\Maria Mercedez\Documents\Estrategia SSC - GEF Páramos\sostenibilidad-paramos\data_import\Calificacion indicadores sotará.xlsx')
sotara_cedulas = []
for col in df_sotara.columns[1:]:
    c_raw = str(df_sotara[col].iloc[1])
    c = c_raw.replace('.', '').strip()
    if c and c != 'nan':
        sotara_cedulas.append(c)

# Prepare SQL
lines = ["BEGIN;", "UPDATE productores SET proyecto = 'Sin Proyecto';"]

# Update Paletará
for p in paletara_data:
    name = p['nombre'].replace("'", "''")
    vereda = p['vereda'].replace("'", "''")
    muni = p['municipio'].replace("'", "''")
    lines.append(f"UPDATE productores SET proyecto = 'Proyecto Paletará', nombre_completo = '{name}', vereda = '{vereda}', municipio = '{muni}' WHERE REPLACE(cedula, '.', '') = '{p['cedula']}';")

# Update Sotará
for c in sotara_cedulas:
    lines.append(f"UPDATE productores SET proyecto = 'Proyecto Sotará' WHERE REPLACE(cedula, '.', '') = '{c}';")

lines.append("COMMIT;")

with open(r'c:\Users\Maria Mercedez\Documents\Estrategia SSC - GEF Páramos\sostenibilidad-paramos\scratch\fix_projects.sql', 'w', encoding='utf-8') as f:
    f.write('\n'.join(lines))

print(f"SQL script generated for {len(paletara_data)} Paletara and {len(sotara_cedulas)} Sotara.")
