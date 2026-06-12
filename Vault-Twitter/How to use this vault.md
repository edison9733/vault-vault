---
title: How to use this vault
date: 2026-06-12
tags: [guide, manual]
---

# How to use this Twitter vault (complete edition)

Hourly, the vault pulls tweets from your handles, scores each 0-10, throws away the noise (below 6), and builds a daily news digest. It learns your noise patterns over time. You mostly just read the digest.

## Daily use (the only 3 things you actually do)

**1. Read today's digest.** Obsidian → `digests/2026-06-12.md`. The ==most important story== is highlighted at the top, items grouped by theme, every item has the source @handle + link + why it matters.

**2. Ask questions.** In Terminal:
```
cd ~/Vault-Twitter && claude
```
Answers teach from fundamentals in simple English. Examples:
- "Explain today's biggest crypto story like I know nothing about crypto"
- "What did @AnthropicAI announce this month, with a timeline chart"
- "Compare how different handles covered the Fed decision"

**3. Check health with one command:**
```
~/Vault-Twitter/_scripts/status.sh
```
Shows tweets captured, unprocessed count, digest days, RSSHub alive or dead, automation state, costs.

## Charts

Questions comparing numbers/events get a self-contained HTML chart in `charts/` (works offline). Open with `open ~/Vault-Twitter/charts/<file>.html`. Add "with a chart" to any question.

## The memory (why filtering gets smarter)

| File | What it is |
|---|---|
| `_memory/LEARNINGS.md` | Scoring rules Claude learned (e.g. "giveaway tweets = 0-2"). Delete any rule — always safe |
| `_memory/INSIGHTS.md` | Recurring topics, people, and per-handle reliability notes |
| `_memory/STATS.md` | Cost per run ledger |
| `_memory/sessions/` | Full output + transcript of every curation run |

Sundays 04:20: duplicates merged, contradictions fixed, memory kept small, old sessions archived, raw tweets older than 30 days moved to `raw/archive/` (digests keep the curated history forever).

## The fragile part: the cookie (only real maintenance)

Twitter scraping needs your throwaway account's cookie, and cookies die every few weeks. Symptoms: `status.sh` shows RSSHub errors, or no new tweets for 2+ days. Fix (~2 minutes):
1. Log into x.com with the **throwaway** account → DevTools (Cmd+Opt+I) → Application → Cookies → x.com → copy `auth_token` and `ct0`
2. Paste into `_scripts/rsshub_start.sh`, then run `bash ~/Vault-Twitter/_scripts/rsshub_start.sh`
3. `HTTP 200` = fixed

Account banned? Make a new throwaway, same steps. NEVER use your real account.

## Adding / removing handles

Edit `_scripts/tw_handles.txt` — one handle per line, no @. Or in the vault chat: "add handle X to my list".

## Quota limits

Runs that hit your Claude limit stop early and resume next hour. Max 30 tweets scored per run; nothing is ever lost. Force a run now: `~/Vault-Twitter/_scripts/tw_pipeline.sh`

## Switches

```
~/Vault-Twitter/_scripts/enable_automation.sh    # ON  (hourly + Sunday cleanup)
~/Vault-Twitter/_scripts/disable_automation.sh   # OFF
```

## If something looks broken

1. `status.sh` — RSSHub dead? Start Docker Desktop, then `bash _scripts/rsshub_start.sh`
2. RSSHub up but feeds empty/403 → cookie expired (see cookie section)
3. Pipeline stuck "RUNNING" for hours → `rmdir ~/Vault-Twitter/_scripts/.run.lock`
4. Still broken after cookie refresh → `docker pull diygod/rsshub:chromium-bundled` then rerun rsshub_start.sh

## Rules of thumb

- Never hand-edit `raw/` tweet text or `_scripts/` (except `tw_handles.txt` and the cookie in `rsshub_start.sh`)
- `digests/`, `charts/`, `_memory/` are yours — edit freely
- Docker Desktop must be running for fetching to work
