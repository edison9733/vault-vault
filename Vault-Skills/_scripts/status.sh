#!/bin/bash
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
V="$HOME/Vault-Skills"
NOTES=$(ls -1 "$V"/notes/*.md 2>/dev/null | wc -l | tr -d ' ')
SKILLS=$(ls -1d "$HOME"/.claude/skills/*/ 2>/dev/null | wc -l | tr -d ' ')
PEND=$(jq -r '.[].fullName // empty' "$V"/raw/examples/*.json 2>/dev/null | awk '!s[$0]++' | while read -r f; do [ -f "$V/notes/$(echo "$f"|sed 's#/#--#').md" ] || echo x; done | wc -l | tr -d ' ')
echo "=== Vault-Skills status ==="
echo "Repo notes written  : $NOTES (pending in raw: $PEND)"
echo "Skills installed    : $SKILLS  (ls ~/.claude/skills/)"
if [ -d "$V/_scripts/.run.lock" ]; then echo "Pipeline            : RUNNING now"; else echo "Pipeline            : idle"; fi
launchctl print "gui/$(id -u)/com.vault.skills" >/dev/null 2>&1 && echo "Daily automation    : ON" || echo "Daily automation    : OFF"
launchctl print "gui/$(id -u)/com.vault.skills-consolidate" >/dev/null 2>&1 && echo "Weekly consolidation: ON" || echo "Weekly consolidation: OFF"
echo "--- last 3 runs ---"; tail -3 "$V/_memory/STATS.md" 2>/dev/null || echo "(none yet)"
echo "--- newest skill decisions ---"; tail -5 "$V/Skills-Index.md" 2>/dev/null || echo "(none yet)"
