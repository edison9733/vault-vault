#!/bin/bash
# prune_skills.sh - monthly: Claude audits ~/.claude/skills, flags weak or
# overlapping ones, moves rejects to a quarantine folder (never deletes).
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
set -uo pipefail
VAULT="$HOME/Vault-Skills"
[ -d "$VAULT" ] || exit 0
Q="$HOME/.claude/skills-quarantine"; mkdir -p "$Q" "$VAULT/_logs"
cd "$VAULT" || exit 1
command -v claude >/dev/null 2>&1 || exit 1

python3 "$HOME/MasterBrain/_scripts/ds_agent.py" \
  --cwd "$HOME" --max-turns 30 \
  --tools "Read,Write,Edit,Glob,Grep,Move" \
  --output-json "$VAULT/_memory/sessions/.prune_$(date +%Y-%m).json" \
  --prompt "Monthly skill audit. Read every SKILL.md under ~/.claude/skills/. For each, judge: (a) is the description broad and trigger-friendly, (b) is the body actionable and under ~2000 words, (c) does it duplicate another skill. For weak/duplicate skills: use the Move tool to move the whole skill folder to ~/.claude/skills-quarantine/ (never delete), merge anything salvageable into the stronger sibling, and record every decision with reasons in Vault-Skills/Skills-Index.md under a '## Monthly audit $(date +%Y-%m)' header. Improve descriptions in place where that alone fixes a skill. Touch nothing else." \
  2>> "$VAULT/_logs/prune.log"
echo "$(date) monthly prune done" >> "$VAULT/_logs/prune.log"
