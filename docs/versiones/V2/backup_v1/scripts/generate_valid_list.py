import re
def get_cedulas(path):
    # Try reading as UTF-16 first, then UTF-8
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

valid = list(set(sotara + paletara))
sql_list = ",".join(f"'{c}'" for c in valid)
with open('scratch/valid_cedulas_sql.txt', 'w') as f:
    f.write(sql_list)

print(f"Generated SQL list with {len(valid)} unique cedulas")
