# 🧠 Guía Completa: Graphify + Antigravity
### Convierte tu código en un Mapa de Conocimiento Interactivo

> **Autor**: Generado automáticamente por Antigravity  
> **Fecha**: Mayo 2026  
> **Video de referencia**: [Antigravity + Graphify: Free Tool Makes Google Antigravity 10x Smarter & Token-Efficient](https://youtu.be/YwGUT6z0lQI)

---

## 📋 ¿Qué es Graphify?

**Graphify** es una herramienta gratuita y open-source que analiza tu código fuente, documentación, PDFs, imágenes e incluso videos, y los convierte en un **grafo de conocimiento navegable**. 

### ¿Por qué lo necesitas?

Cuando usas Antigravity (o cualquier agente de IA para programar), el agente normalmente tiene que:
1. Leer cada archivo uno por uno para entender tu proyecto
2. Gastar muchos tokens (tiempo y memoria) explorando la estructura
3. Perder contexto entre conversaciones

**Con Graphify**, el agente arranca **ya sabiendo** cómo está organizado tu proyecto: qué archivos dependen de cuáles, dónde están las funciones principales, y cómo fluyen los datos. Es como darle un mapa del tesoro en vez de una brújula.

### ¿Qué produce?

Después de ejecutarlo, obtienes una carpeta `graphify-out/` con:

| Archivo | Descripción |
|---------|-------------|
| `GRAPH_REPORT.md` | Resumen de arquitectura que el agente lee automáticamente |
| `graph.json` | Grafo completo y consultable con relaciones entre archivos |
| `graph.html` | **Mapa visual interactivo** — ábrelo en el navegador para explorar tu código como una galaxia |
| `GRAPH_TREE.html` | Vista jerárquica tipo árbol de carpetas |

---

## 🛠️ Requisitos Previos

Antes de empezar, asegúrate de tener:

- [x] **Python 3.10+** instalado → verifica con: `python --version`
- [x] **pip** funcional → verifica con: `pip --version`
- [x] **Google Antigravity** instalado y funcionando
- [x] Tu proyecto de código en una carpeta local

---

## 📦 Paso 1: Instalar Graphify

Abre una terminal (PowerShell en Windows, Terminal en Mac/Linux) y ejecuta:

```bash
pip install graphifyy
```

> ⚠️ **MUY IMPORTANTE**: El paquete se llama `graphifyy` con **doble Y**. Si escribes `graphify` (una sola Y) instalarás un paquete diferente que no tiene nada que ver.

### Verificar la instalación:
```bash
graphify --help
```

Si ves la lista de comandos disponibles, ¡estás listo!

---

## 🔗 Paso 2: Integrar con Antigravity

Navega en la terminal hasta la carpeta raíz de tu proyecto y ejecuta:

```bash
cd C:\ruta\a\tu\proyecto
graphify antigravity install
```

### ¿Qué hace este comando?

Crea automáticamente 3 cosas:

1. **Skill global** en `~/.agent/skills/graphify/SKILL.md` — Las instrucciones que el agente sigue para construir grafos.
2. **Regla del proyecto** en `.agent/rules/graphify.md` — Le dice al agente: *"antes de responder, lee el mapa del proyecto"*.
3. **Workflow** en `.agent/workflows/graphify.md` — Permite usar el comando `/graphify` dentro de Antigravity.

> 💡 **Nota para usuarios con carpeta `.agents` (plural)**: Si tu proyecto ya usa `.agents/` (con S), mueve los archivos generados:
> ```bash
> # Windows PowerShell
> Move-Item -Path ".agent\rules\graphify.md" -Destination ".agents\rules\graphify.md" -Force
> Move-Item -Path ".agent\workflows\graphify.md" -Destination ".agents\workflows\graphify.md" -Force
> Remove-Item -Path ".agent" -Recurse -Force
> ```

---

## 🏗️ Paso 3: Construir el Grafo de tu Proyecto

### 3.1 — Crear el archivo `.graphifyignore`

Antes de escanear, crea un archivo `.graphifyignore` en la raíz de tu proyecto para excluir carpetas pesadas o irrelevantes. Funciona igual que `.gitignore`:

```
# Carpetas que NO necesitan ser analizadas
node_modules/
dist/
.venv/
.git/
build/
__pycache__/
```

### 3.2 — Ejecutar el escaneo

Dentro de Antigravity, simplemente escribe:

```
/graphify
```

O desde la terminal, sigue estos pasos manualmente:

#### A) Detectar archivos:
```bash
mkdir graphify-out
python -c "
import json
from graphify.detect import detect
from pathlib import Path
result = detect(Path('.'))
with open('graphify-out/.graphify_detect.json', 'w', encoding='utf-8') as f:
    json.dump(result, f)
print('Archivos detectados: {}'.format(result['total_files']))
print('Palabras totales: ~{:,}'.format(result['total_words']))
"
```

#### B) Extraer estructura del código (AST — gratis, sin API):
```bash
python -c "
import json
from graphify.extract import collect_files, extract
from pathlib import Path

with open('graphify-out/.graphify_detect.json', 'r', encoding='utf-8') as f:
    detect = json.load(f)

code_files = [Path(f) for f in detect.get('files', {}).get('code', []) if Path(f).exists()]

if code_files:
    result = extract(code_files, cache_root=Path('.'))
    with open('graphify-out/.graphify_ast.json', 'w', encoding='utf-8') as f:
        json.dump(result, f, indent=2)
    print('AST: {} nodos, {} aristas'.format(len(result['nodes']), len(result['edges'])))
"
```

#### C) Construir el grafo y generar el reporte:
```bash
python -c "
import json
from pathlib import Path
from graphify.build import build_from_json
from graphify.cluster import cluster, score_all
from graphify.analyze import god_nodes, surprising_connections, suggest_questions
from graphify.report import generate
from graphify.export import to_json

# Crear extracción mínima (solo AST si no tienes API key)
ast = json.loads(Path('graphify-out/.graphify_ast.json').read_text(encoding='utf-8'))
extraction = {
    'nodes': ast['nodes'], 'edges': ast['edges'],
    'hyperedges': [], 'input_tokens': 0, 'output_tokens': 0
}
Path('graphify-out/.graphify_extract.json').write_text(
    json.dumps(extraction, indent=2), encoding='utf-8')

detection = json.loads(Path('graphify-out/.graphify_detect.json').read_text(encoding='utf-8'))
G = build_from_json(extraction)
communities = cluster(G)
cohesion = score_all(G, communities)
gods = god_nodes(G)
surprises = surprising_connections(G, communities)
labels = {cid: 'Community ' + str(cid) for cid in communities}
questions = suggest_questions(G, communities, labels)
report = generate(G, communities, cohesion, labels, gods, surprises, detection,
                  {'input': 0, 'output': 0}, '.', suggested_questions=questions)
Path('graphify-out/GRAPH_REPORT.md').write_text(report, encoding='utf-8')
to_json(G, communities, 'graphify-out/graph.json')
print('Grafo generado exitosamente')
"
```

#### D) Generar las visualizaciones HTML:
```bash
graphify export html
graphify tree --label "Mi Proyecto"
```

---

## 🌐 Paso 4: Ver tu Mapa Interactivo

Abre estos archivos directamente en tu navegador (Chrome, Edge, Firefox):

- **Mapa de Galaxia**: `graphify-out/graph.html`
  - Arrastra nodos con el mouse
  - Zoom con la rueda del scroll
  - Clic en un nodo para ver sus conexiones
  
- **Mapa de Árbol**: `graphify-out/GRAPH_TREE.html`
  - Vista jerárquica colapsable
  - Ideal para entender la estructura de carpetas

---

## ⚡ Paso 5 (Opcional): Servidor MCP para Consultas Avanzadas

Si quieres que Antigravity pueda **consultar el grafo en tiempo real** (buscar caminos entre funciones, preguntar "¿qué depende de X?"), configura el servidor MCP.

### 5.1 — Editar la configuración MCP

Abre el archivo `~/.gemini/antigravity/mcp_config.json` y añade esta entrada dentro de `"mcpServers"`:

```json
"graphify": {
  "command": "python",
  "args": [
    "-m",
    "graphify.serve",
    "C:\\ruta\\a\\tu\\proyecto\\graphify-out\\graph.json"
  ]
}
```

> ⚠️ Reemplaza la ruta con la ubicación real de tu `graph.json`.

### 5.2 — Reiniciar Antigravity

Cierra y vuelve a abrir Antigravity para que detecte el nuevo servidor MCP.

---

## 🔄 Paso 6: Mantener el Grafo Actualizado

### Actualización manual (rápida, sin costo):
Cuando hagas cambios significativos en el código, ejecuta:
```bash
graphify update .
```

### Actualización automática con Git hooks:
```bash
graphify hook install
```
Esto reconstruye el grafo automáticamente cada vez que haces un commit.

### Desde Antigravity:
Simplemente di: **"actualiza el mapa"** o **"/graphify"** y el agente lo hace por ti.

---

## 🧪 Verificación Final

Para confirmar que todo funciona, abre una conversación nueva en Antigravity y pregúntale:

> "¿Cuáles son los God Nodes de mi proyecto?"

Si el agente te responde mencionando las funciones más conectadas de tu código **sin que tú le hayas dado contexto**, ¡Graphify está funcionando perfectamente! 🎉

---

## 📚 Recursos Adicionales

| Recurso | Enlace |
|---------|--------|
| Repositorio oficial | [github.com/safishamsi/graphify](https://github.com/safishamsi/graphify) |
| Documentación | [graphify.net](https://graphify.net) |
| Video tutorial | [YouTube](https://youtu.be/YwGUT6z0lQI) |
| PyPI | [pypi.org/project/graphifyy](https://pypi.org/project/graphifyy/) |

---

## 🆘 Solución de Problemas Comunes

### "graphify: command not found"
Tu PATH no incluye la carpeta de pip. Solución:
```bash
python -m pip install graphifyy
# Y usa python -m graphify en vez de graphify directamente
```

### "error: unknown command '.'"
El comando `graphify .` solo funciona desde dentro de Antigravity (vía `/graphify`). Desde la terminal, usa los scripts de Python del Paso 3.

### El grafo tiene demasiados archivos
Añade más exclusiones a tu `.graphifyignore`. Las carpetas más comunes a excluir:
```
node_modules/
dist/
build/
.venv/
__pycache__/
*.min.js
*.map
```

### El agente no lee el grafo automáticamente
Verifica que existe el archivo `.agents/rules/graphify.md` (o `.agent/rules/graphify.md`) en la raíz de tu proyecto. Si no existe, ejecuta `graphify antigravity install` de nuevo.

---

> **¿Te fue útil esta guía?** Si Graphify te ahorra tiempo, considera apoyar al creador: [github.com/sponsors/safishamsi](https://github.com/sponsors/safishamsi)
