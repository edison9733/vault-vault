# LEARNED RULES (machine-maintained - review or reset this file freely)
<!-- Claude appends 1-3 dated rules per run. Hard cap: 100 lines. -->

- [2026-06-12] Archived repos: write the note for reference but NEVER distill or install skills from them.
- [2026-06-12] A skill description must start "Use this skill whenever..." and be broad, or it will under-trigger.
- [2026-06-12] Distinguish curators from installable skills: repos with "awesome-*" prefix or >50k stars are indexes/curators (use for discovery only; skip in STEP C). Actual SKILL.md repos are focused single-skill repos with "skill" in the name, typically <15k stars.
- [2026-06-12] When ~/.claude/skills/ is outside the session working directory, stage SKILL.md files in _staging/ and provide cp commands; do not block the run on permission errors.
