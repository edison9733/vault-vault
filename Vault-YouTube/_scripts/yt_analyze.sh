#!/bin/bash
# yt_analyze.sh (v3) - headless Claude run with session capture + PER-RUN CAP.
# Processes at most $YT_NOTES_PER_RUN transcripts per run (default 4, newest
# first) so a backlog drains gradually instead of blowing turn/token limits.
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
set -uo pipefail

VAULT="$HOME/Vault-YouTube"
MEM="$VAULT/_memory"
SESSIONS="$MEM/sessions"
LOGS="$VAULT/_logs"
NOTES_PER_RUN="${YT_NOTES_PER_RUN:-4}"
mkdir -p "$SESSIONS" "$LOGS" "$MEM"
cd "$VAULT" || exit 1

command -v claude >/dev/null 2>&1 || { echo "FATAL: claude not on PATH" >&2; exit 1; }
command -v jq     >/dev/null 2>&1 || { echo "FATAL: jq not on PATH (brew install jq)" >&2; exit 1; }

# ---- Build the worklist OURSELVES (deterministic, costs zero tokens):
# newest-first .srt files in raw/ whose [VIDEOID] has no note yet, capped.
WORKLIST=""
COUNT=0
while IFS= read -r srt; do
  [ -z "$srt" ] && continue
  base="$(basename "$srt")"
  vid="$(echo "$base" | sed -n 's/.*\[\(.*\)\].*/\1/p')"
  [ -z "$vid" ] && continue
  if ! ls notes/*"[$vid]"* >/dev/null 2>&1; then
    WORKLIST="$WORKLIST$base"$'\n'
    COUNT=$((COUNT+1))
    [ "$COUNT" -ge "$NOTES_PER_RUN" ] && break
  fi
done < <(ls -1 raw/*.srt 2>/dev/null | sort -r)

if [ "$COUNT" -eq 0 ]; then
  echo "$(date) nothing to analyze." >> "$LOGS/analyze.log"
  exit 0
fi

BACKLOG_TOTAL=$(ls -1 raw/*.srt 2>/dev/null | wc -l | tr -d ' ')
NOTES_TOTAL=$(ls -1 notes/*.md 2>/dev/null | wc -l | tr -d ' ')
echo "$(date) analyzing $COUNT transcript(s); notes so far: $NOTES_TOTAL / $BACKLOG_TOTAL srt" >> "$LOGS/analyze.log"

STAMP="$(date +%Y-%m-%d_%H%M)"
DATE="$(date +%Y-%m-%d)"

PROMPT="Process ONLY these $COUNT transcript files in raw/ (newest first), one note each, following CLAUDE.md exactly:
$WORKLIST
Do NOT process any other transcripts this run. After the last note, do the REFLECTION STEP from CLAUDE.md once."

JSON_OUT="$SESSIONS/.last_run.json"
python3 "$HOME/MasterBrain/_scripts/ds_agent.py" \
  --cwd "$VAULT" --prompt "$PROMPT" \
  --tools "Read,Write,Edit,Glob,Grep" --max-turns 40 \
  --output-json "$JSON_OUT" \
  2>> "$LOGS/analyze.log"
RC=$?

RESULT="$(jq -r '.result // ""'      "$JSON_OUT" 2>/dev/null || echo "")"
SID="$(jq -r '.session_id // ""'     "$JSON_OUT" 2>/dev/null || echo "")"
COST="$(jq -r '.total_cost_usd // 0' "$JSON_OUT" 2>/dev/null || echo 0)"
TURNS="$(jq -r '.num_turns // 0'     "$JSON_OUT" 2>/dev/null || echo 0)"
ISERR="$(jq -r '.is_error // false'  "$JSON_OUT" 2>/dev/null || echo true)"
DUR="$(jq -r '.duration_ms // 0'     "$JSON_OUT" 2>/dev/null || echo 0)"

PROJ_DIR="$HOME/.claude/projects/$(echo "$VAULT" | sed 's#/#-#g')"
RAW_JSONL=""
if [ -d "$PROJ_DIR" ]; then
  if [ -n "$SID" ]; then
    RAW_JSONL="$(find "$PROJ_DIR" -name "${SID}.jsonl" 2>/dev/null | head -1)"
  fi
  if [ -z "$RAW_JSONL" ]; then
    RAW_JSONL="$(find "$PROJ_DIR" -name "*.jsonl" -mmin -30 2>/dev/null | head -1)"
  fi
fi

SESS_MD="$SESSIONS/${STAMP}_analysis.md"
{
  echo "---"
  echo "date: $DATE"
  echo "category: youtube-analysis"
  echo "session_id: \"$SID\""
  echo "cost_usd: $COST"
  echo "num_turns: $TURNS"
  echo "duration_ms: $DUR"
  echo "is_error: $ISERR"
  echo "exit_code: $RC"
  echo "transcripts_this_run: $COUNT"
  echo "tags: [session-log]"
  echo "---"
  echo
  echo "# Analysis run $STAMP ($COUNT transcripts)"
  echo
  if [ -n "$RESULT" ]; then
    echo "$RESULT"
  else
    echo "_(empty result field - known claude-code -p bug; see the .jsonl transcript beside this file and _logs/analyze.log)_"
  fi
} > "$SESS_MD"

if [ -n "$RAW_JSONL" ] && [ -f "$RAW_JSONL" ]; then
  cp "$RAW_JSONL" "$SESSIONS/${STAMP}_${SID:-session}.jsonl"
fi

echo "| $DATE $(date +%H:%M) | $TURNS | \$$COST | $ISERR | $SID |" >> "$MEM/STATS.md"
exit "$RC"
