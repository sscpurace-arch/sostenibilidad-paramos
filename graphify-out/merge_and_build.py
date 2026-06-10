import json, glob
from pathlib import Path

# B3: Merge chunks
chunks = sorted(glob.glob('graphify-out/.graphify_chunk_*.json'))
all_nodes, all_edges, all_hyperedges = [], [], []
for c in chunks:
    d = json.loads(Path(c).read_text(encoding='utf-8'))
    all_nodes += d.get('nodes', [])
    all_edges += d.get('edges', [])
    all_hyperedges += d.get('hyperedges', [])

Path('graphify-out/.graphify_semantic_new.json').write_text(json.dumps({
    'nodes': all_nodes, 'edges': all_edges, 'hyperedges': all_hyperedges,
    'input_tokens': 0, 'output_tokens': 0,
}, indent=2, ensure_ascii=False), encoding='utf-8')
print("Chunks merged: " + str(len(all_nodes)) + " nodes, " + str(len(all_edges)) + " edges")

# Dedup and create semantic.json (no cache to merge)
seen = set()
deduped = []
for n in all_nodes:
    if n['id'] not in seen:
        seen.add(n['id'])
        deduped.append(n)

Path('graphify-out/.graphify_semantic.json').write_text(json.dumps({
    'nodes': deduped, 'edges': all_edges, 'hyperedges': all_hyperedges,
    'input_tokens': 0, 'output_tokens': 0,
}, indent=2, ensure_ascii=False), encoding='utf-8')
print("Semantic: " + str(len(deduped)) + " unique nodes")

# Part C: Merge AST + semantic
ast = json.loads(Path('graphify-out/.graphify_ast.json').read_text(encoding='utf-8'))
sem = json.loads(Path('graphify-out/.graphify_semantic.json').read_text(encoding='utf-8'))

seen = {n['id'] for n in ast['nodes']}
merged_nodes = list(ast['nodes'])
for n in sem['nodes']:
    if n['id'] not in seen:
        merged_nodes.append(n)
        seen.add(n['id'])

merged = {
    'nodes': merged_nodes,
    'edges': ast['edges'] + sem['edges'],
    'hyperedges': sem.get('hyperedges', []),
    'input_tokens': 0,
    'output_tokens': 0,
}
Path('graphify-out/.graphify_extract.json').write_text(json.dumps(merged, indent=2, ensure_ascii=False), encoding='utf-8')
print("Final extract: " + str(len(merged_nodes)) + " nodes, " + str(len(merged['edges'])) + " edges (" +
      str(len(ast['nodes'])) + " AST + " + str(len(sem['nodes'])) + " semantic)")
