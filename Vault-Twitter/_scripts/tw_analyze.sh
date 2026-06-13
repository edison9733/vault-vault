#!/bin/bash
# tw_analyze.sh (v2) - headless curation with session capture + PER-RUN CAP.
# Scores at most $TW_TWEETS_PER_RUN unprocessed tweets per run (default 30,
# newest first); saves output+transcript to _memory/; appends STATS row.
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
set -uo pipefail
VAULT="$HOME/Vault-Twitter"
MEM="$VAULT/_memory"; SESSIONS="$MEM/sessions"; LOGS="$VAULT/_logs"
TWEETS_PER_RUN="${TW_TWEETS_PER_RUN:-30}"
mkdir -p "$SESSIONS" "$LOGS" "$MEM"
cd "$VAULT" || exit 1
command -v claude >/dev/null 2>&1 || { echo "FATAL: claude not on PATH" >&2; exit 1; }
command -v jq     >/dev/null 2>&1 || { echo "FATAL: jq not on PATH (brew install jq)" >&2; exit 1; }

# Deterministic worklist (zero tokens): newest unprocessed tweet files, capped.
WORKLIST="$(grep -l "processed: false" raw/*.md 2>/dev/null | sort -r | head -n "$TWEETS_PER_RUN" | xargs -n1 basename 2>/dev/null || true)"
COUNT=$(printf "%s" "$WORKLIST" | grep -c . || true)
if [ "$COUNT" -eq 0 ]; then
  echo "$(date) nothing to curate." >> "$LOGS/analyze.log"; exit 0
fi
echo "$(date) curating $COUNT tweet(s)" >> "$LOGS/analyze.log"

STAMP="$(date +%Y-%m-%d_%H%M)"; DATE="$(date +%Y-%m-%d)"
PROMPT="Process ONLY these $COUNT tweet files in raw/ (newest first), following CLAUDE.md exactly (score, mark processed, build today's digest):
$WORKLIST
Do NOT touch any other raw files this run. After the last one, do the REFLECTION STEP from CLAUDE.md once."

JSON_OUT="$SESSIONS/.last_run.json"
python3 "$HOME/MasterBrain/_scripts/ds_agent.py" \
  --cwd "$VAULT" --prompt "$PROMPT" \
  --tools "Read,Write,Edit,Glob,Grep" --max-turns 40 \
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
  [ -z "$RAW_JSONL" ] && RAW_JSONL="$(find "$PROJ_DIR" -name "*.jsonl" -mmin -30 2>/dev/null | head -1)"
fi

SESS_MD="$SESSIONS/${STAMP}_curation.md"
{
  echo "---"; echo "date: $DATE"; echo "category: twitter-curation"
  echo "session_id: \"$SID\""; echo "cost_usd: $COST"; echo "num_turns: $TURNS"
  echo "duration_ms: $DUR"; echo "is_error: $ISERR"; echo "exit_code: $RC"
  echo "tweets_this_run: $COUNT"; echo "tags: [session-log]"; echo "---"; echo
  echo "# Curation run $STAMP ($COUNT tweets)"; echo
  if [ -n "$RESULT" ]; then echo "$RESULT"; else
    echo "_(empty result field - known claude-code -p bug; see .jsonl beside this file)_"; fi
} > "$SESS_MD"
[ -n "$RAW_JSONL" ] && [ -f "$RAW_JSONL" ] && cp "$RAW_JSONL" "$SESSIONS/${STAMP}_${SID:-session}.jsonl"
echo "| $DATE $(date +%H:%M) | $TURNS | \$$COST | $ISERR | $SID |" >> "$MEM/STATS.md"
exit "$RC"
