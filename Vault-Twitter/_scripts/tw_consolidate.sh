#!/bin/bash
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
set -uo pipefail
VAULT="$HOME/Vault-Twitter"; MEM="$VAULT/_memory"
mkdir -p "$MEM/archive" "$VAULT/_logs"; cd "$VAULT" || exit 1
command -v claude >/dev/null 2>&1 || exit 1
LOCK="$VAULT/_scripts/.run.lock"
if ! mkdir "$LOCK" 2>/dev/null; then
  echo "$(date) consolidate: pipeline busy, skipping." >> "$VAULT/_logs/pipeline.log"; exit 0
fi
trap 'rmdir "$LOCK"' EXIT
find "$MEM/sessions" -type f \( -name '*.md' -o -name '*.jsonl' \) -mtime +14 -exec mv {} "$MEM/archive/" \; 2>/dev/null || true
# archive raw tweets older than 30 days (digests keep the curated history)
mkdir -p "$VAULT/raw/archive"
find "$VAULT/raw" -maxdepth 1 -name '*.md' -mtime +30 -exec mv {} "$VAULT/raw/archive/" \; 2>/dev/null || true
python3 "$HOME/MasterBrain/_scripts/ds_agent.py" \
  --cwd "$VAULT" --max-turns 20 \
  --tools "Read,Write,Edit,Glob,Grep" \
  --output-json "$MEM/sessions/.consolidate_$(date +%Y-%m-%d).json" \
  --prompt 'Consolidation pass. (1) _memory/LEARNINGS.md: merge duplicate rules, resolve contradictions (most recent/specific wins), keep [YYYY-MM-DD] prefixes, under 100 lines, remove any "> NEEDS CONSOLIDATION" marker. (2) _memory/INSIGHTS.md: merge duplicate topics/people, tidy, under 150 lines. Touch ONLY files inside _memory/. Report changes.' \
  2>> "$VAULT/_logs/consolidate.log"
echo "$(date) consolidation done" >> "$VAULT/_logs/consolidate.log"
