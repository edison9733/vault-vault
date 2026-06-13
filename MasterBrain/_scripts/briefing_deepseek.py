#!/opt/homebrew/bin/python3
"""Generate MasterBrain morning briefing using DeepSeek API (stdlib only)."""
import os
import sys
import json
from datetime import datetime, timedelta
from pathlib import Path
import urllib.request
import urllib.error

HOME = Path.home()
MB = HOME / "MasterBrain"
VAULTS = {
    "Twitter": HOME / "Vault-Twitter",
    "Skills": HOME / "Vault-Skills",
    "YouTube": HOME / "Vault-YouTube",
}


def recent_files(directory, days=2, pattern="*.md"):
    cutoff = datetime.now() - timedelta(days=days)
    result = []
    d = Path(directory)
    if not d.exists():
        return result
    for p in d.glob(pattern):
        try:
            if datetime.fromtimestamp(p.stat().st_mtime) >= cutoff:
                result.append(p)
        except OSError:
            pass
    return sorted(result, key=lambda p: p.stat().st_mtime, reverse=True)


def read_capped(path, max_chars=5000):
    try:
        t = Path(path).read_text(encoding="utf-8", errors="ignore")
        if len(t) > max_chars:
            return t[:max_chars] + "\n...[truncated]"
        return t
    except OSError:
        return ""


def vault_context():
    parts = []

    # Twitter: daily digest files
    twitter_dir = VAULTS["Twitter"] / "digests"
    files = recent_files(twitter_dir, days=2)
    if files:
        parts.append("=== TWITTER DIGESTS (last 2 days) ===")
        for f in files[:2]:
            parts.append(f"\n--- {f.name} ---\n{read_capped(f, 7000)}")
    else:
        parts.append("=== TWITTER DIGESTS ===\n(no new digests in last 2 days)")

    # YouTube: notes modified recently
    yt_dir = VAULTS["YouTube"] / "notes"
    files = recent_files(yt_dir, days=2)
    if files:
        parts.append("\n=== YOUTUBE NOTES (last 2 days) ===")
        for f in files[:4]:
            parts.append(f"\n--- {f.name} ---\n{read_capped(f, 3000)}")
    else:
        parts.append("\n=== YOUTUBE NOTES ===\n(no new notes in last 2 days)")

    # Skills: Skills-Index + recently modified notes
    skills_dir = VAULTS["Skills"]
    idx = skills_dir / "Skills-Index.md"
    if idx.exists():
        parts.append(f"\n=== SKILLS INDEX ===\n{read_capped(idx, 3000)}")
    notes_files = recent_files(skills_dir / "notes", days=2)
    if notes_files:
        parts.append("\n=== SKILLS NOTES (last 2 days) ===")
        for f in notes_files[:4]:
            parts.append(f"\n--- {f.name} ---\n{read_capped(f, 2000)}")

    return "\n".join(parts)


def call_deepseek(prompt, api_key, base_url, model):
    url = base_url.rstrip("/") + "/v1/chat/completions"
    payload = json.dumps({
        "model": model,
        "messages": [{"role": "user", "content": prompt}],
        "max_tokens": 1500,
        "temperature": 0.3,
    }).encode("utf-8")
    req = urllib.request.Request(url, data=payload, headers={
        "Content-Type": "application/json",
        "Authorization": f"Bearer {api_key}",
    })
    try:
        with urllib.request.urlopen(req, timeout=90) as r:
            data = json.loads(r.read().decode("utf-8"))
        return data["choices"][0]["message"]["content"]
    except urllib.error.HTTPError as e:
        body = e.read().decode("utf-8", errors="replace")
        raise RuntimeError(f"HTTP {e.code}: {body}")
    except urllib.error.URLError as e:
        raise RuntimeError(f"Network error: {e.reason}")


def main():
    date_str = datetime.now().strftime("%Y-%m-%d")
    bfile = MB / "briefings" / f"{date_str}.md"

    if bfile.exists():
        print(f"Briefing already exists, skipping.", file=sys.stderr)
        return

    api_key = os.environ.get("DEEPSEEK_API_KEY", "")
    if not api_key:
        print("FATAL: DEEPSEEK_API_KEY not set", file=sys.stderr)
        sys.exit(1)

    model = os.environ.get("DEEPSEEK_MODEL", "deepseek-chat")
    base_url = os.environ.get("DEEPSEEK_BASE_URL", "https://api.deepseek.com")

    context = vault_context()

    prompt = f"""You are writing the Morning Briefing for {date_str} for MasterBrain.

## FORMAT (follow exactly, keep total under 40 lines):
# Morning Briefing - {date_str}
## Top story
==highlighted key claim in one sentence==
3-4 simple sentences: what happened, why it matters to the user.
## From your videos
- up to 3 newest YouTube notes, 1-2 lines each + [[wikilink to note title]]
## From Twitter
- up to 4 items from the digest, 1-2 lines each + [[wikilink]]
## New skills & repos
- anything new in Skills-Index or notes, 1 line each
## Connections
- 1-2 cross-vault connections you noticed (video topic also in tweets, etc.)
  Omit this section entirely if none — never invent connections.

## RULES:
- Output ONLY the briefing markdown, starting with "# Morning Briefing"
- Under 40 lines total, B2 English, short sentences
- If a section has nothing new, write "- nothing new" and continue
- Use ==double equals== for the Top story highlight

## VAULT CONTENT (last 2 days):
{context}

Write the briefing now:"""

    try:
        result = call_deepseek(prompt, api_key, base_url, model)
    except RuntimeError as e:
        print(f"DeepSeek API error: {e}", file=sys.stderr)
        sys.exit(1)

    bfile.parent.mkdir(parents=True, exist_ok=True)
    bfile.write_text(result.strip() + "\n", encoding="utf-8")
    print(f"Briefing written: {bfile}")


if __name__ == "__main__":
    main()
