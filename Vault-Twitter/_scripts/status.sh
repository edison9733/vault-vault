#!/bin/bash
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
V="$HOME/Vault-Twitter"
RAW=$(ls -1 "$V"/raw/*.md 2>/dev/null | wc -l | tr -d ' ')
UNP=$(grep -l "processed: false" "$V"/raw/*.md 2>/dev/null | wc -l | tr -d ' ')
DIG=$(ls -1 "$V"/digests/*.md 2>/dev/null | wc -l | tr -d ' ')
echo "=== Vault-Twitter status ==="
echo "Tweets captured     : $RAW (unprocessed: $UNP)"
echo "Digest days         : $DIG"
if [ -d "$V/_scripts/.run.lock" ]; then echo "Pipeline            : RUNNING now"; else echo "Pipeline            : idle"; fi
launchctl print "gui/$(id -u)/com.vault.twitter" >/dev/null 2>&1 && echo "Hourly automation   : ON" || echo "Hourly automation   : OFF"
launchctl print "gui/$(id -u)/com.vault.twitter-consolidate" >/dev/null 2>&1 && echo "Weekly consolidation: ON" || echo "Weekly consolidation: OFF"
curl -s -o /dev/null -m 5 -w "RSSHub (localhost)  : HTTP %{http_code}\n" "http://localhost:1200/" 2>/dev/null || echo "RSSHub (localhost)  : NOT RUNNING (start Docker + rsshub_start.sh)"
echo "--- last 3 runs ---"; tail -3 "$V/_memory/STATS.md" 2>/dev/null || echo "(none yet)"
echo "--- last log lines ---"; tail -3 "$V/_logs/analyze.log" 2>/dev/null || echo "(none yet)"
