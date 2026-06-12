#!/bin/bash
# tw_pipeline.sh - fetch + analyze with a lock so runs never overlap.
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
LOCK="$HOME/Vault-Twitter/_scripts/.run.lock"
if ! mkdir "$LOCK" 2>/dev/null; then
  echo "$(date) previous run still active, skipping." >> "$HOME/Vault-Twitter/_logs/pipeline.log"
  exit 0
fi
trap 'rmdir "$LOCK"' EXIT
"$HOME/Vault-Twitter/_scripts/tw_fetch.py" && "$HOME/Vault-Twitter/_scripts/tw_analyze.sh"
