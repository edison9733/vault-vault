#!/bin/bash
# morning_briefing.sh - daily 07:00: DeepSeek writes briefings/YYYY-MM-DD.md
# from all three vaults, then pushes a summary to your phone via ntfy.sh.
# Flags: --test-push  (skip briefing, just test the phone notification)
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
set -uo pipefail
MB="$HOME/MasterBrain"
LOGS="$MB/_logs"; mkdir -p "$LOGS" "$MB/briefings"
cd "$MB" || exit 1
TOPIC="$(cat "$MB/_scripts/ntfy_topic.txt" 2>/dev/null || true)"
DATE="$(date +%Y-%m-%d)"
SCRIPT_DIR="$MB/_scripts"

push () { # $1=title $2=body
  [ -z "$TOPIC" ] && return 0
  curl -s -m 15 -H "Title: $1" -d "$2" "https://ntfy.sh/$TOPIC" >/dev/null 2>&1 || \
    echo "$(date) ntfy push failed (offline?)" >> "$LOGS/briefing.log"
}

if [ "${1:-}" = "--test-push" ]; then
  push "MasterBrain test" "If you can read this on your phone, ntfy works. Topic: $TOPIC"
  echo "Test push sent to ntfy.sh/$TOPIC - check your phone."
  exit 0
fi

command -v python3 >/dev/null 2>&1 || { echo "FATAL: python3 not on PATH" >&2; exit 1; }
BFILE="briefings/$DATE.md"
[ -f "$BFILE" ] && { echo "$(date) briefing already exists, skipping." >> "$LOGS/briefing.log"; exit 0; }

python3 "$SCRIPT_DIR/briefing_deepseek.py" \
  >> "$LOGS/briefing.out.log" 2>> "$LOGS/briefing.log"
RC=$?

if [ -f "$BFILE" ]; then
  # Phone gets the Top story section, trimmed
  TOP="$(awk '/^## Top story/{f=1;next}/^## /{f=0}f' "$BFILE" | head -6 | tr '\n' ' ' | cut -c1-450)"
  [ -z "$TOP" ] && TOP="Briefing ready - open MasterBrain/briefings/$DATE.md"
  push "Morning Briefing $DATE" "$TOP"
  echo "$(date) briefing written + pushed." >> "$LOGS/briefing.log"
else
  echo "$(date) briefing FAILED (rc=$RC) - see briefing.log" >> "$LOGS/briefing.log"
  push "Briefing failed" "DeepSeek run failed this morning (rc=$RC). Check MasterBrain/_logs/briefing.log"
fi
exit "$RC"
