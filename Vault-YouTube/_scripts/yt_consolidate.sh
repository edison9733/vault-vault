#!/bin/bash
# yt_consolidate.sh - weekly memory compaction + session archival.
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
set -uo pipefail
VAULT="$HOME/Vault-YouTube"
MEM="$VAULT/_memory"
mkdir -p "$MEM/archive" "$VAULT/_logs"
cd "$VAULT" || exit 1
command -v claude >/dev/null 2>&1 || { echo "FATAL: claude not on PATH" >&2; exit 1; }

# Lock against the hourly pipeline (same lock dir)
LOCK="$VAULT/_scripts/.run.lock"
if ! mkdir "$LOCK" 2>/dev/null; then
  echo "$(date) consolidate: pipeline busy, skipping this week." >> "$VAULT/_logs/pipeline.log"
  exit 0
fi
trap 'rmdir "$LOCK"' EXIT

# 1) Archive session files older than 14 days
find "$MEM/sessions" -type f \( -name '*.md' -o -name '*.jsonl' \) -mtime +14 \
  -exec mv {} "$MEM/archive/" \; 2>/dev/null || true

# 2) Compact the memory files
python3 "$HOME/MasterBrain/_scripts/ds_agent.py" \
  --cwd "$VAULT" --max-turns 20 \
  --tools "Read,Write,Edit,Glob,Grep" \
  --output-json "$MEM/sessions/.consolidate_$(date +%Y-%m-%d).json" \
  --prompt 'Consolidation pass. (1) _memory/LEARNINGS.md: merge duplicate or near-duplicate rules, resolve contradictions by keeping the most recent/specific rule, keep the [YYYY-MM-DD] prefixes, keep the file under 100 lines, remove any "> NEEDS CONSOLIDATION" marker. (2) _memory/INSIGHTS.md: merge duplicate concepts, sum counts, tidy cross-links, keep under 150 lines. Touch ONLY files inside _memory/. Report what you merged or removed.' \
  2>> "$VAULT/_logs/consolidate.log"
echo "$(date) consolidation done" >> "$VAULT/_logs/consolidate.log"
