import json, os
from graphify.detect import detect
from pathlib import Path

cwd = Path(os.getcwd())
source_dirs = ['components', 'app', 'lib', 'hooks', 'scripts', 'types', 'utils', 'context', 'services', 'supabase']

all_files = {'code': [], 'document': [], 'image': [], 'video': [], 'paper': []}
total_words = 0

for d in source_dirs:
    p = cwd / d
    if p.exists():
        r = detect(p)
        for ftype, flist in r.get('files', {}).items():
            all_files.setdefault(ftype, []).extend(flist)
        total_words += r.get('total_words', 0)
        print(d + ": " + str(r.get('total_files', 0)) + " files")

# Root-level files
r_root = detect(cwd)
for ftype, flist in r_root.get('files', {}).items():
    root_only = [f for f in flist if Path(f).parent == cwd]
    all_files.setdefault(ftype, []).extend(root_only)

merged = {
    'files': {k: list(set(v)) for k, v in all_files.items()},
    'total_files': sum(len(list(set(v))) for v in all_files.values()),
    'total_words': total_words,
    'scan_root': str(cwd),
    'skipped_sensitive': []
}
Path('graphify-out/.graphify_detect.json').write_text(json.dumps(merged, ensure_ascii=False), encoding='utf-8')
print("Total: " + str(merged['total_files']) + " files, ~" + str(total_words) + " words")
for ftype, flist in merged['files'].items():
    if flist:
        print("  " + ftype + ": " + str(len(flist)) + " files")
