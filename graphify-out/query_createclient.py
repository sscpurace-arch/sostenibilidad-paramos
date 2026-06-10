import json
import networkx as nx
from pathlib import Path
from collections import deque

data = json.loads(Path('graphify-out/graph.json').read_text(encoding='utf-8'))

G = nx.Graph()
node_meta = {}

for n in data.get('nodes', []):
    G.add_node(n['id'])
    node_meta[n['id']] = n

for e in data.get('links', []):
    G.add_edge(e['source'], e['target'],
               relation=e.get('relation', ''),
               confidence=e.get('confidence', ''),
               confidence_score=e.get('confidence_score', 0))

def label(nid):
    return node_meta.get(nid, {}).get('label', nid)

def comm(nid):
    return node_meta.get(nid, {}).get('community', '?')

# Find createClient
candidates = [(n, G.degree(n)) for n in G.nodes() if 'createclient' in n.lower()]
candidates.sort(key=lambda x: -x[1])
print("createClient candidates:")
for n, d in candidates:
    print(f"  {label(n)} (degree={d}, community={comm(n)}, id={n})")

print()
main = candidates[0][0] if candidates else None
if not main:
    print("No createClient node found!")
    raise SystemExit(1)

print(f"=== Tracing: {label(main)} (community {comm(main)}, degree {G.degree(main)}) ===\n")

print("Direct connections:")
for nb in sorted(G.neighbors(main), key=lambda n: -G.degree(n)):
    e = G[main][nb]
    print(f"  --{e.get('relation','?')}--> [{comm(nb)}] {label(nb)}  ({e.get('confidence','?')} {e.get('confidence_score','')})")

print()

# 2-hop BFS
visited = {main}
queue = deque([(main, 0, [])])
hop1 = []
hop2 = []
while queue:
    node, depth, path = queue.popleft()
    for nb in G.neighbors(node):
        if nb not in visited:
            visited.add(nb)
            e = G[node][nb]
            entry = (nb, e.get('relation','?'), e.get('confidence','?'), comm(nb))
            if depth == 0:
                hop1.append(entry)
                queue.append((nb, 1, path + [nb]))
            elif depth == 1:
                hop2.append(entry)

print(f"2-hop reach: {len(visited)-1} nodes")
touched_communities = set(comm(n) for n in visited if n != main)
print(f"Communities bridged: {sorted(str(c) for c in touched_communities)}\n")

# Show which community labels are bridged
comm_labels = {}
for n in visited:
    c = comm(n)
    if c not in comm_labels:
        comm_labels[c] = []
    comm_labels[c].append(label(n))

print("By community:")
for c in sorted(str(x) for x in comm_labels.keys()):
    nodes_in_comm = comm_labels[int(c) if c.isdigit() else c]
    print(f"  Community {c}: {', '.join(nodes_in_comm[:4])}{' ...' if len(nodes_in_comm) > 4 else ''}")

print()
print("=== Impact analysis: what breaks if createClient() changes? ===")
print(f"  • {len(hop1)} direct callers — every one of these needs updating")
for n, rel, conf, c in sorted(hop1, key=lambda x: -G.degree(x[0])):
    print(f"    [{c}] {label(n)} (degree={G.degree(n)})")
print(f"  • {len(hop2)} indirect dependents (2 hops away)")
print(f"  • Touches {len(touched_communities)} of 39 communities")
