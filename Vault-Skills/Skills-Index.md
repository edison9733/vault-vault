# Skills Index

Records every community skill evaluated (STEP C) and every skill distilled (STEP B).
Format: skill name | source repo (stars) | status | reason | date | related notes

---

## STEP B — Distilled Skills

| Skill | Distilled from | Status | Reason | Date |
|-------|---------------|--------|--------|------|
| build-agent-harness | hermes-agent (191k), learn-claude-code (66k), CowAgent (45k) | STAGED `_staging/` | 3 repos share invariant-loop + tool-dispatch + memory pattern; no skill existed | 2026-06-12 |
| multi-model-provider | hermes-agent (192k), learn-claude-code (66k), CowAgent (45k), cherry-studio (47k), nanobot (44k), openclaude (29k) | STAGED `_staging/` | 6 repos share multi-model provider abstraction pattern; was GAP in INSIGHTS.md | 2026-06-14 |

---

## STEP C — Community Skills Evaluated

| Skill | Source repo (stars) | Status | Reason | Date |
|-------|--------------------|---------|----|------|
| prompt-master | nidhinjs/prompt-master (9,122★) | STAGED `_staging/` | Clean, focused prompt-engineering skill; no destructive commands; safe [[prompt-engineering]] | 2026-06-12 |
| playwright-skill | lackeyjb/playwright-skill (2,755★) | STAGED `_staging/` | Browser automation for QA; writes to /tmp only; no destructive ops; [[testing]] [[automation]] | 2026-06-12 |
| planning-with-files | OthmanAdi/planning-with-files (23,056★) | SKIP — 404 | SKILL.md not reachable via raw.githubusercontent.com; multiple paths tried | 2026-06-12 |
| claude-mem | thedotmack/claude-mem (81,863★) | SKIP — no SKILL.md | Repo uses `.claude/commands/` layout; no top-level SKILL.md found | 2026-06-12 |
| awesome-claude-skills | ComposioHQ/awesome-claude-skills (64,225★) | SKIP — curator | Curated list, not a skill file; nothing to install | 2026-06-12 |
| oh-my-openagent | code-yeongyu/oh-my-openagent (61,951★) | SKIP — not reviewed | Below cut; already installing 2 skills this run | 2026-06-12 |
| awesome-claude-code | hesreallyhim/awesome-claude-code (46,223★) | SKIP — curator | Curated list, not a skill file | 2026-06-12 |
| anthropics/skills (pdf) | anthropics/skills (149,588★) | SKIP — too generic | SKILL.md is a Python library reference doc; not a Claude behavior skill | 2026-06-12 |
| scientific-agent-skills | K-Dense-AI/scientific-agent-skills (28,135★) | STAGED `_staging/` | 147 scientific skills with proper SKILL.md files; safe; no destructive commands; [[scientific-research]] [[bioinformatics]] | 2026-06-14 |
| baoyu-infographic | JimLiu/baoyu-skills (21,428★) | STAGED `_staging/` | Professional infographic generator with 21 layouts × 22 styles; clean SKILL.md; no destructive ops; [[content-creation]] | 2026-06-14 |
| nanoclaw | nanocoai/nanoclaw (29,842★) | SKIP — no SKILL.md | Lightweight OpenClaw alternative; agent harness, not a skill repo | 2026-06-14 |
| VoltAgent/awesome-agent-skills | VoltAgent/awesome-agent-skills (25,245★) | SKIP — curator | "awesome-*" prefix indicates curated list; not installable skill files | 2026-06-14 |
| travisvn/awesome-claude-skills | travisvn/awesome-claude-skills (13,434★) | SKIP — curator | Curated list with "awesome-*" prefix | 2026-06-14 |
| alirezarezvani/claude-skills | alirezarezvani/claude-skills (17,993★) | SKIP — not reviewed | 345 skills, high quality; hit quota limit this run; evaluate next run | 2026-06-14 |
| Claude-Red | SnailSploit/Claude-Red (2,279★) | SKIP — security | Offensive security skills (SQLi, EDR evasion, shellcode); destructive by design | 2026-06-14 |
| Claude-OSINT | elementalsouls/Claude-OSINT (1,672★) | SKIP — security | Recon/red-team tradecraft; not appropriate for general skill installation | 2026-06-14 |
| iothackbot | BrownFineSecurity/iothackbot (778★) | SKIP — security | IoT pentesting skills; destructive by design | 2026-06-14 |

---

## Installation note

Skill files in `_staging/` must be manually moved to `~/.claude/skills/`:

```bash
cp -r ~/Vault-Skills/_staging/build-agent-harness ~/.claude/skills/
cp -r ~/Vault-Skills/_staging/prompt-master ~/.claude/skills/
cp -r ~/Vault-Skills/_staging/playwright-skill ~/.claude/skills/
cp -r ~/Vault-Skills/_staging/multi-model-provider ~/.claude/skills/
cp -r ~/Vault-Skills/_staging/scientific-agent-skills ~/.claude/skills/
cp -r ~/Vault-Skills/_staging/baoyu-infographic ~/.claude/skills/
```
