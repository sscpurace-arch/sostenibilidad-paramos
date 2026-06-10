import json
from graphify.build import build_from_json
from graphify.cluster import score_all
from graphify.analyze import god_nodes, surprising_connections, suggest_questions
from graphify.report import generate
from pathlib import Path

extraction = json.loads(Path('graphify-out/.graphify_extract.json').read_text(encoding='utf-8'))
detection  = json.loads(Path('graphify-out/.graphify_detect.json').read_text(encoding='utf-8'))
analysis   = json.loads(Path('graphify-out/.graphify_analysis.json').read_text(encoding='utf-8'))

G = build_from_json(extraction)
communities = {int(k): v for k, v in analysis['communities'].items()}
cohesion = {int(k): v for k, v in analysis['cohesion'].items()}

labels = {
    0:  "Dependencies & Config",
    1:  "Search & Evaluation Flow",
    2:  "Pages & Routing",
    3:  "Admin Dashboard",
    4:  "Base de Datos & Dashboard",
    5:  "App Shell & Auth",
    6:  "Supabase DB Schema",
    7:  "Root Layout & Metadata",
    8:  "Global Map View",
    9:  "Individual Farm Map",
    10: "AI Diagnostico (Gemini)",
    11: "Supabase Project Config",
    12: "Producer History & Info",
    13: "Radar Chart Visualization",
    14: "JS Path Config",
    15: "Auth Middleware",
    16: "Farm Detail Page",
    17: "Mapa Page Duplicate",
    18: "App Layout",
    19: "Base Datos Page",
    20: "New Producer Registration",
    21: "Offline DB (Dexie)",
    22: "Sync Engine Core",
    23: "Sostenibilidad Panel",
    24: "Indicator Card",
    25: "Validation Logic",
    26: "Navbar & Navigation",
    27: "Offline & Validation Banners",
    28: "Evaluation Header",
    29: "Evaluation Footer",
    30: "New Evaluation Form",
    31: "Topographic Background",
    32: "Offline Sync Hook",
    33: "Diagnostico Hook",
    34: "Watermark Component",
    35: "Tailwind Theme",
    36: "PostCSS Config",
    37: "ESLint Config",
    38: "Next.js Config",
}

questions = suggest_questions(G, communities, labels)
tokens = {'input': 0, 'output': 0}
report = generate(G, communities, cohesion, labels, analysis['gods'], analysis['surprises'], detection, tokens, '.', suggested_questions=questions)
Path('graphify-out/GRAPH_REPORT.md').write_text(report, encoding='utf-8')
Path('graphify-out/.graphify_labels.json').write_text(json.dumps({str(k): v for k, v in labels.items()}, ensure_ascii=False), encoding='utf-8')
print("Report updated with community labels")
