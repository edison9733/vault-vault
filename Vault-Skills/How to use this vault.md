---
title: How to use this vault
date: 2026-06-12
tags: [guide, manual]
---

# How to use this Skills vault (complete edition)

Daily at 08:00, the vault hunts GitHub for the highest-starred example repos in your topics AND the best existing Claude Skills, writes analysis notes, and turns the best patterns into installed skills in `~/.claude/skills/`. Those skills then work in EVERY project, forever.

## Daily use (the only 3 things you actually do)

**1. Use your skills — the whole point.** In ANY project folder:
```
cd ~/my-new-project && claude
```
Just describe what you're building ("make me a web scraper", "build a RAG chatbot") — matching skills trigger automatically with proven patterns from top repos. List what you have: `ls ~/.claude/skills/`

**2. Ask before you build.** In Terminal:
```
cd ~/Vault-Skills && claude
```
Answers teach from fundamentals in simple English. Examples:
- "Explain what RAG is like I know nothing, then show me the best repo for it"
- "Compare the top 3 automation frameworks in my notes, with a chart"
- "What should I use to build X? Start from the basics"

**3. Check status with one command:**
```
~/Vault-Skills/_scripts/status.sh
```
Notes written, repos pending, skills installed, automation state, latest install/reject decisions.

## Charts

Comparison questions get a self-contained HTML chart/table in `charts/` (works offline). Open: `open ~/Vault-Skills/charts/<file>.html`. Add "with a chart" to any question.

## Skills-Index.md — your audit trail (review weekly)

Every skill decision is logged here: installed or rejected, source repo + stars, one-line reason, date. **Skim it weekly** — skills are instructions Claude executes, so you want to know what got installed. Don't like a skill? Delete its folder:
```
rm -rf ~/.claude/skills/<skill-name>
```

## Manual captures

Found a great repo/article yourself? Clip it with the **Obsidian Web Clipper** browser extension into `raw/clips/` — tomorrow's run analyzes it like everything else.

## Changing what gets hunted

Edit the `TOPICS=(...)` line in `_scripts/skills_hunt.sh`. Current style: "ai-agents" "automation" "self-hosted" "rag" "llm". Or in vault chat: "add topic X to my hunts".

## The memory (why curation gets smarter)

| File | What it is |
|---|---|
| `_memory/LEARNINGS.md` | Quality heuristics Claude learned (e.g. "archived repos → never skill"). Delete any rule — always safe |
| `_memory/INSIGHTS.md` | Pattern map across repos + skill coverage gaps |
| `_memory/STATS.md` | Cost per run ledger |
| `_memory/sessions/` | Full output + transcript of every run |

Sundays 04:40: memory deduped and capped, old sessions archived, old raw JSONs pruned.

## Cost caps

Per daily run: max 6 new repo notes, max 1 self-distilled skill, max 2 community skills installed. Nothing-new exits without calling Claude. Force a run: `~/Vault-Skills/_scripts/skills_pipeline.sh`. Tune: `SK_NOTES_PER_RUN` in `_scripts/skills_analyze.sh`.

## Switches

```
~/Vault-Skills/_scripts/enable_automation.sh    # ON  (daily 08:00 + Sunday cleanup)
~/Vault-Skills/_scripts/disable_automation.sh   # OFF
```

## If something looks broken

1. `status.sh` first
2. `gh auth status` — GitHub login expired? `gh auth login`
3. `tail -20 ~/Vault-Skills/_logs/analyze.log`
4. Pipeline stuck "RUNNING" → `rmdir ~/Vault-Skills/_scripts/.run.lock`

## Rules of thumb

- Never hand-edit `raw/` or `_scripts/` (except the TOPICS line in skills_hunt.sh)
- `notes/`, `charts/`, `_memory/`, `Skills-Index.md` are yours — edit freely
- Skills run code on your machine: trust comes from the review step + your weekly Skills-Index skim
