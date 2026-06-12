#!/bin/bash
# status.sh - one-shot health + progress report for the YouTube vault.
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
V="$HOME/Vault-YouTube"
SRT=$(ls -1 "$V"/raw/*.srt 2>/dev/null | wc -l | tr -d ' ')
NOTES=$(ls -1 "$V"/notes/*.md 2>/dev/null | wc -l | tr -d ' ')
SEEN=$(wc -l < "$V/_scripts/yt_seen.txt" 2>/dev/null | tr -d ' ')
echo "=== Vault-YouTube status ==="
echo "Transcripts fetched : $SRT"
echo "Notes written       : $NOTES"
echo "Backlog remaining   : $((SRT - NOTES)) transcripts"
echo "Videos marked seen  : ${SEEN:-0}"
if [ -d "$V/_scripts/.run.lock" ]; then echo "Pipeline            : RUNNING now"; else echo "Pipeline            : idle"; fi
launchctl print "gui/$(id -u)/com.vault.youtube" >/dev/null 2>&1 && echo "Hourly automation   : ON" || echo "Hourly automation   : OFF"
launchctl print "gui/$(id -u)/com.vault.youtube-consolidate" >/dev/null 2>&1 && echo "Weekly consolidation: ON" || echo "Weekly consolidation: OFF"
if [ "$SRT" -gt "$NOTES" ]; then
  RUNS=$(( (SRT - NOTES + 3) / 4 ))
  echo "ETA at 4 notes/hour : ~$RUNS more hourly runs (~$((RUNS/24)) day(s) $((RUNS%24))h)"
fi
echo "--- last 3 runs (turns/cost) ---"
tail -3 "$V/_memory/STATS.md" 2>/dev/null || echo "(no runs logged yet)"
echo "--- last log lines ---"
tail -3 "$V/_logs/analyze.log" 2>/dev/null || echo "(no analyze log yet)"
