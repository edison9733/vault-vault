#!/bin/bash
# add_twitter_keywords.sh - one-time patch: lets Vault-Twitter track TOPICS
# (keywords) in addition to handles, via RSSHub's /twitter/keyword/ route.
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
set -uo pipefail
V="$HOME/Vault-Twitter"
[ -d "$V" ] || { echo "FATAL: Vault-Twitter not found" >&2; exit 1; }
[ -f "$V/_scripts/tw_keywords.txt" ] || cat > "$V/_scripts/tw_keywords.txt" <<'KW'
# One Twitter SEARCH KEYWORD per line (topics, not handles). # = comment.
# Examples:
# solana etf
# anthropic claude
KW
# Patch tw_fetch.py once: also iterate keywords via /twitter/keyword/<kw>
if grep -q "tw_keywords.txt" "$V/_scripts/tw_fetch.py"; then
  echo "already patched."
else
  cp "$V/_scripts/tw_fetch.py" "$V/_memory/tw_fetch.py.bak.kw.$(date +%s)"
  python3 - "$V/_scripts/tw_fetch.py" <<'PY'
import sys,re
p=sys.argv[1]; s=open(p).read()
s=s.replace('HANDLES_FILE = os.path.join(VAULT, "_scripts", "tw_handles.txt")',
 'HANDLES_FILE = os.path.join(VAULT, "_scripts", "tw_handles.txt")\nKEYWORDS_FILE = os.path.join(VAULT, "_scripts", "tw_keywords.txt")')
s=s.replace('def fetch_handle(handle):\n    url = f"{RSSHUB}/twitter/user/{handle}"',
 'def fetch_handle(handle, kind="user"):\n    import urllib.parse\n    route = "keyword" if kind == "keyword" else "user"\n    url = f"{RSSHUB}/twitter/{route}/{urllib.parse.quote(handle)}"')
s=s.replace("""    new_count = 0
    for handle in handles:
        try:
            root = fetch_handle(handle)""",
 """    targets = [(h, "user") for h in handles]
    if os.path.exists(KEYWORDS_FILE):
        with open(KEYWORDS_FILE) as f:
            targets += [(l.strip(), "keyword") for l in f
                        if l.strip() and not l.strip().startswith("#")]
    new_count = 0
    for handle, kind in targets:
        try:
            root = fetch_handle(handle, kind)""")
s=s.replace('path = os.path.join(RAW, f"{date}_{handle}_{item_id}.md")',
 'safe = re.sub(r"[^A-Za-z0-9_-]+", "-", handle)[:30]\n            path = os.path.join(RAW, f"{date}_{safe}_{item_id}.md")')
open(p,"w").write(s)
print("patched OK")
PY
  python3 -m py_compile "$V/_scripts/tw_fetch.py" && echo "patched file compiles OK"
fi
echo "Add topics in: $V/_scripts/tw_keywords.txt"
