# Skills Index

Records every community skill evaluated (STEP C) and every skill distilled (STEP B).
Format: skill name | source repo (stars) | status | reason | date | related notes

---

## STEP B — Distilled Skills

| Skill | Distilled from | Status | Reason | Date |
|-------|---------------|--------|--------|------|
| build-agent-harness | hermes-agent (191k), learn-claude-code (66k), CowAgent (45k) | STAGED `_staging/` | 3 repos share invariant-loop + tool-dispatch + memory pattern; no skill existed | 2026-06-12 |

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

---

## Installation note

Skill files in `_staging/` must be manually moved to `~/.claude/skills/`:

```bash
cp -r ~/Vault-Skills/_staging/build-agent-harness ~/.claude/skills/
cp -r ~/Vault-Skills/_staging/prompt-master ~/.claude/skills/
cp -r ~/Vault-Skills/_staging/playwright-skill ~/.claude/skills/
```
