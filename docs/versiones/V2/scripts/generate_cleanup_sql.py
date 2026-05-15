import os

def get_cedulas(path):
    try:
        with open(path, 'r', encoding='utf-16') as f:
            lines = f.readlines()
            if not lines: raise ValueError
    except:
        with open(path, 'r', encoding='utf-8') as f:
            lines = f.readlines()
    return [l.strip() for l in lines if l.strip()]

sotara = get_cedulas('scratch/official_sotara_cedulas.txt')
paletara = get_cedulas('scratch/official_paletara_cedulas.txt')

valid_all = list(set(sotara + paletara))
sql_valid_all = ",".join(f"('{c}')" for c in valid_all)
sql_sotara = ",".join(f"('{c}')" for c in sotara)
sql_paletara = ",".join(f"('{c}')" for c in paletara)

sql = f"""
CREATE TEMP TABLE valid_cedulas (cedula_val text);
INSERT INTO valid_cedulas (cedula_val) VALUES {sql_valid_all};

BEGIN;
-- Delete unauthorized evaluation details
DELETE FROM calificacion_detalle 
WHERE calificacion_id IN (
    SELECT c.id FROM calificaciones c
    JOIN productores p ON c.productor_id = p.id
    WHERE NOT EXISTS (
        SELECT 1 FROM valid_cedulas v 
        WHERE v.cedula_val = REPLACE(p.cedula, '.', '')
    )
);

-- Delete unauthorized evaluations
DELETE FROM calificaciones 
WHERE productor_id IN (
    SELECT id FROM productores 
    WHERE NOT EXISTS (
        SELECT 1 FROM valid_cedulas v 
        WHERE v.cedula_val = REPLACE(cedula, '.', '')
    )
);

-- Delete unauthorized producers
DELETE FROM productores 
WHERE NOT EXISTS (
    SELECT 1 FROM valid_cedulas v 
    WHERE v.cedula_val = REPLACE(cedula, '.', '')
);

-- Reset projects
UPDATE productores SET proyecto = 'Sin Proyecto';

-- Assign Sotara
CREATE TEMP TABLE sotara_cedulas (cedula_val text);
INSERT INTO sotara_cedulas (cedula_val) VALUES {sql_sotara};
UPDATE productores SET proyecto = 'Proyecto Sotará' 
WHERE EXISTS (SELECT 1 FROM sotara_cedulas s WHERE s.cedula_val = REPLACE(productores.cedula, '.', ''));

-- Assign Paletara
CREATE TEMP TABLE paletara_cedulas (cedula_val text);
INSERT INTO paletara_cedulas (cedula_val) VALUES {sql_paletara};
UPDATE productores SET proyecto = 'Proyecto Paletará' 
WHERE EXISTS (SELECT 1 FROM paletara_cedulas p WHERE p.cedula_val = REPLACE(productores.cedula, '.', ''));

COMMIT;
"""

with open('scripts/cleanup_final.sql', 'w', encoding='utf-8') as f:
    f.write(sql)

print(f"Generated scripts/cleanup_final.sql with {len(sotara)} Sotara and {len(paletara)} Paletara producers.")
