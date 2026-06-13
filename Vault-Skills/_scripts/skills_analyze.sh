#!/bin/bash
# skills_analyze.sh (v2) - headless run with session capture + PER-RUN CAPS.
# Caps: $SK_NOTES_PER_RUN new repo notes (default 6) and instructs max 2-3
# skills per run. Worklist built with jq (zero tokens).
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
set -uo pipefail
VAULT="$HOME/Vault-Skills"
MEM="$VAULT/_memory"; SESSIONS="$MEM/sessions"; LOGS="$VAULT/_logs"
NOTES_PER_RUN="${SK_NOTES_PER_RUN:-6}"
mkdir -p "$SESSIONS" "$LOGS" "$MEM"
cd "$VAULT" || exit 1
command -v claude >/dev/null 2>&1 || { echo "FATAL: claude not on PATH" >&2; exit 1; }
command -v jq     >/dev/null 2>&1 || { echo "FATAL: jq not on PATH (brew install jq)" >&2; exit 1; }

# Worklist: repo fullNames from all example JSONs (stars desc) lacking a note.
WORKLIST=""
COUNT=0
while IFS= read -r full; do
  [ -z "$full" ] && continue
  notefile="notes/$(echo "$full" | sed 's#/#--#').md"
  if [ ! -f "$notefile" ]; then
    WORKLIST="$WORKLIST$full"$'\n'
    COUNT=$((COUNT+1))
    [ "$COUNT" -ge "$NOTES_PER_RUN" ] && break
  fi
done < <(jq -r '.[].fullName // empty' raw/examples/*.json 2>/dev/null | awk '!seen[$0]++')

CLIPS=$(ls -1 raw/clips/*.md 2>/dev/null | wc -l | tr -d ' ')
if [ "$COUNT" -eq 0 ] && [ "$CLIPS" -eq 0 ] && ! ls raw/skills-sources/*.json >/dev/null 2>&1; then
  echo "$(date) nothing to analyze." >> "$LOGS/analyze.log"; exit 0
fi
echo "$(date) analyzing $COUNT repo(s) + skills-sources" >> "$LOGS/analyze.log"

STAMP="$(date +%Y-%m-%d_%H%M)"; DATE="$(date +%Y-%m-%d)"
PROMPT="Follow CLAUDE.md exactly with these LIMITS this run:
STEP A: write notes ONLY for these $COUNT repos (skip all others):
$WORKLIST
STEP B: distill at most ONE new skill if 3+ notes share an unskilled pattern.
STEP C: evaluate raw/skills-sources/ candidates not yet in Skills-Index.md; install at most 2 community skills.
Also process any files in raw/clips/. Then do the REFLECTION STEP from CLAUDE.md once. If truly nothing new anywhere, reply 'nothing to do'."

JSON_OUT="$SESSIONS/.last_run.json"
python3 "$HOME/MasterBrain/_scripts/ds_agent.py" \
  --cwd "$VAULT" --prompt "$PROMPT" \
  --tools "Read,Write,Edit,Glob,Grep,WebFetch" --max-turns 60 \
  --output-json "$JSON_OUT" \
  2>> "$LOGS/analyze.log"
RC=$?

RESULT="$(jq -r '.result // ""' "$JSON_OUT" 2>/dev/null || echo "")"
SID="$(jq -r '.session_id // ""' "$JSON_OUT" 2>/dev/null || echo "")"
COST="$(jq -r '.total_cost_usd // 0' "$JSON_OUT" 2>/dev/null || echo 0)"
TURNS="$(jq -r '.num_turns // 0' "$JSON_OUT" 2>/dev/null || echo 0)"
ISERR="$(jq -r '.is_error // false' "$JSON_OUT" 2>/dev/null || echo true)"
DUR="$(jq -r '.duration_ms // 0' "$JSON_OUT" 2>/dev/null || echo 0)"

PROJ_DIR="$HOME/.claude/projects/$(echo "$VAULT" | sed 's#/#-#g')"
RAW_JSONL=""
if [ -d "$PROJ_DIR" ]; then
  [ -n "$SID" ] && RAW_JSONL="$(find "$PROJ_DIR" -name "${SID}.jsonl" 2>/dev/null | head -1)"
  [ -z "$RAW_JSONL" ] && RAW_JSONL="$(find "$PROJ_DIR" -name "*.jsonl" -mmin -40 2>/dev/null | head -1)"
fi

SESS_MD="$SESSIONS/${STAMP}_analysis.md"
{
  echo "---"; echo "date: $DATE"; echo "category: skills-analysis"
  echo "session_id: \"$SID\""; echo "cost_usd: $COST"; echo "num_turns: $TURNS"
  echo "duration_ms: $DUR"; echo "is_error: $ISERR"; echo "exit_code: $RC"
  echo "repos_this_run: $COUNT"; echo "tags: [session-log]"; echo "---"; echo
  echo "# Skills run $STAMP ($COUNT repos)"; echo
  if [ -n "$RESULT" ]; then echo "$RESULT"; else
    echo "_(empty result field - known claude-code -p bug; see .jsonl beside this file)_"; fi
} > "$SESS_MD"
[ -n "$RAW_JSONL" ] && [ -f "$RAW_JSONL" ] && cp "$RAW_JSONL" "$SESSIONS/${STAMP}_${SID:-session}.jsonl"
echo "| $DATE $(date +%H:%M) | $TURNS | \$$COST | $ISERR | $SID |" >> "$MEM/STATS.md"
exit "$RC"
