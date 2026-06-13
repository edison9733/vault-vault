#!/bin/bash
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
set -uo pipefail
VAULT="$HOME/Vault-Skills"; MEM="$VAULT/_memory"
mkdir -p "$MEM/archive" "$VAULT/_logs"; cd "$VAULT" || exit 1
command -v claude >/dev/null 2>&1 || exit 1
LOCK="$VAULT/_scripts/.run.lock"
if ! mkdir "$LOCK" 2>/dev/null; then
  echo "$(date) consolidate: pipeline busy, skipping." >> "$VAULT/_logs/pipeline.log"; exit 0
fi
trap 'rmdir "$LOCK"' EXIT
find "$MEM/sessions" -type f \( -name '*.md' -o -name '*.jsonl' \) -mtime +14 -exec mv {} "$MEM/archive/" \; 2>/dev/null || true
# keep only the 2 newest dated JSONs per search to stop raw/ growing forever
for d in raw/examples raw/skills-sources; do
  ls -1t "$d"/*.json 2>/dev/null | awk -F'_[0-9]{4}-' '{print}' | tail -n +30 | xargs rm -f 2>/dev/null || true
done
python3 "$HOME/MasterBrain/_scripts/ds_agent.py" \
  --cwd "$VAULT" --max-turns 20 \
  --tools "Read,Write,Edit,Glob,Grep" \
  --output-json "$MEM/sessions/.consolidate_$(date +%Y-%m-%d).json" \
  --prompt 'Consolidation pass. (1) _memory/LEARNINGS.md: merge duplicates, resolve contradictions (most recent/specific wins), keep [YYYY-MM-DD] prefixes, under 100 lines, remove any "> NEEDS CONSOLIDATION" marker. (2) _memory/INSIGHTS.md: merge duplicate patterns, tidy, under 150 lines. (3) Skills-Index.md: dedupe rows, keep newest verdicts. Touch ONLY _memory/ and Skills-Index.md. Report changes.' \
  2>> "$VAULT/_logs/consolidate.log"
echo "$(date) consolidation done" >> "$VAULT/_logs/consolidate.log"
