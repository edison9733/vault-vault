#!/bin/bash
# backup_to_github.sh - hourly: copy all vaults' REAL files (git can't follow
# the MasterBrain symlinks) into ~/.brain-backup, commit, push to GitHub.
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
set -uo pipefail
BK="$HOME/.brain-backup"
LOG="$HOME/MasterBrain/_logs/backup.log"; mkdir -p "$(dirname "$LOG")"
command -v git >/dev/null 2>&1 || { echo "FATAL: git missing" >&2; exit 1; }
command -v rsync >/dev/null 2>&1 || { echo "FATAL: rsync missing (macOS has it by default)" >&2; exit 1; }
[ -d "$BK/.git" ] || { echo "FATAL: run setup_master.sh first" >&2; exit 1; }

# Use gh's auth for https pushes (already logged in from Skills vault)
command -v gh >/dev/null 2>&1 && gh auth setup-git >/dev/null 2>&1 || true

cat > "$BK/.gitignore" <<'GI'
**/_logs/
**/.run.lock/
**/sessions/*.jsonl
**/.last_run.json
**/raw/archive/
.DS_Store
GI

for V in Vault-YouTube Vault-Twitter Vault-Skills MasterBrain; do
  [ -d "$HOME/$V" ] || continue
  rsync -a --delete --copy-links \
    --exclude '_logs' --exclude '.run.lock' --exclude 'raw/archive' \
    --exclude 'YouTube' --exclude 'Twitter' --exclude 'Skills' \
    --exclude '*.jsonl' --exclude '.last_run.json' \
    "$HOME/$V/" "$BK/$V/" 2>>"$LOG"
done
# sanity: refuse to commit if nothing actually synced
if ! find "$BK" -mindepth 2 -type f -not -path "*/.git/*" -print -quit | grep -q .; then
  echo "$(date) FATAL: sync produced no files - aborting, not committing." >> "$LOG"; exit 1
fi
# skills are valuable - back them up too
[ -d "$HOME/.claude/skills" ] && rsync -a --delete "$HOME/.claude/skills/" "$BK/claude-skills/" 2>>"$LOG"

cd "$BK"
git add -A
if git diff --cached --quiet; then
  echo "$(date) nothing changed, no commit." >> "$LOG"; exit 0
fi
git -c user.name="brain-backup" -c user.email="brain@localhost" \
  commit -q -m "backup $(date '+%Y-%m-%d %H:%M')"
if git push -q -u origin HEAD:main 2>>"$LOG"; then
  echo "$(date) pushed." >> "$LOG"
else
  echo "$(date) PUSH FAILED - run 'gh auth login' or check repo access." >> "$LOG"
  exit 1
fi
