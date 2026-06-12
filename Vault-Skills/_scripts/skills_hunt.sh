#!/bin/bash
# skills_hunt.sh - Two hunts, dumped as JSON for Claude to analyze:
#   A) Top-starred example repos for your TOPICS  -> raw/examples/
#   B) Existing Claude Skills collections on GitHub -> raw/skills-sources/
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
set -uo pipefail

VAULT="$HOME/Vault-Skills"
EX="$VAULT/raw/examples"
SK="$VAULT/raw/skills-sources"
mkdir -p "$EX" "$SK"
TODAY=$(date +%F)
FIELDS="fullName,description,stargazersCount,forksCount,url,language,updatedAt"

if ! command -v gh >/dev/null 2>&1; then
  echo "FATAL: gh not installed. Run: brew install gh" >&2; exit 1
fi
if ! gh auth status >/dev/null 2>&1; then
  echo "FATAL: gh not authenticated. Run: gh auth login" >&2; exit 1
fi

search () { # $1=outfile  $2...=gh search repos args
  local f="$1"; shift
  if gh search repos "$@" --sort stars --order desc --json "$FIELDS" > "$f" 2>/dev/null && [ -s "$f" ]; then
    echo "OK: $f"
  else
    gh search repos "$@" --sort stars --order desc > "${f%.json}.txt" 2>/dev/null \
      && echo "OK (text fallback): ${f%.json}.txt" || echo "WARN: search failed: $*" >&2
    rm -f "$f"
  fi
}

# ---- A) Best example repos. EDIT THIS LIST. ----
TOPICS=("website-builder" "automation" "ai-system" "full-stack" "ai-agent")
for t in "${TOPICS[@]}"; do
  search "$EX/top_${t}_${TODAY}.json" --topic "$t" --limit 20
done

# ---- B) Existing Claude Skills out in the wild ----
search "$SK/topic_claude-skills_${TODAY}.json" --topic "claude-skills" --limit 30
search "$SK/kw_claude-skills_${TODAY}.json"    "claude skills" --limit 30
search "$SK/kw_awesome-claude_${TODAY}.json"   "awesome claude" --limit 20
# Known anchor: Anthropic's official skills repo
gh repo view anthropics/skills --json "name,description,stargazerCount,forkCount,url" \
  > "$SK/anchor_anthropics-skills_${TODAY}.json" 2>/dev/null \
  || echo "WARN: could not fetch anthropics/skills" >&2

echo "Done."
