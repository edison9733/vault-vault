#!/bin/bash
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
MB="$HOME/MasterBrain"
echo "=== MasterBrain status ==="
for V in YouTube Twitter Skills; do
  [ -e "$MB/$V" ] && echo "link $V: OK -> $(readlink "$MB/$V")" || echo "link $V: MISSING"
done
B=$(ls -1 "$MB"/briefings/*.md 2>/dev/null | wc -l | tr -d ' ')
echo "Briefings written  : $B (latest: $(ls -1t "$MB"/briefings/*.md 2>/dev/null | head -1 | xargs basename 2>/dev/null))"
echo "ntfy topic         : $(cat "$MB/_scripts/ntfy_topic.txt" 2>/dev/null || echo none)"
if [ -d "$HOME/.brain-backup/.git" ]; then
  cd "$HOME/.brain-backup"
  echo "Backup last commit : $(git log -1 --format='%cd %s' --date=format:'%Y-%m-%d %H:%M' 2>/dev/null || echo none yet)"
else
  echo "Backup             : NOT SET UP"
fi
for n in briefing backup prune; do
  launchctl print "gui/$(id -u)/com.brain.$n" >/dev/null 2>&1 && echo "job $n: ON" || echo "job $n: OFF"
done
echo "--- last log lines ---"
tail -2 "$MB/_logs/briefing.log" 2>/dev/null; tail -2 "$MB/_logs/backup.log" 2>/dev/null
