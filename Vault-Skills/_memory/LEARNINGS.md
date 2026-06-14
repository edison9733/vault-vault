# LEARNED RULES (machine-maintained - review or reset this file freely)
<!-- Claude appends 1-3 dated rules per run. Hard cap: 100 lines. -->

- [2026-06-12] Archived repos: write the note for reference but NEVER distill or install skills from them.
- [2026-06-12] A skill description must start "Use this skill whenever..." and be broad, or it will under-trigger.
- [2026-06-12] Distinguish curators from installable skills: repos with "awesome-*" prefix or >50k stars are indexes/curators (use for discovery only; skip in STEP C). Actual SKILL.md repos are focused single-skill repos with "skill" in the name, typically <15k stars.
- [2026-06-12] When ~/.claude/skills/ is outside the session working directory, stage SKILL.md files in _staging/ and provide cp commands; do not block the run on permission errors.
- [2026-06-14] Detect offensive-security skill repos early by scanning name/description for keywords: "red", "osint", "hack", "pentest", "exploit", "recon". Skip automatically and record the rejection reason in Skills-Index.md.
- [2026-06-14] The <15k-star heuristic for installable SKILL.md files is weakening — K-Dense/scientific-agent-skills (28k★) and JimLiu/baoyu-skills (21k★) are large collections with real SKILL.md files. Update heuristic: check directory structure for actual `SKILL.md` files instead of relying on star count alone.
- [2026-06-14] For multi-repo skill collections (like scientific-agent-skills with 147 skills), install representative skills you've actually read rather than the entire collection. Document the source repo in each SKILL.md frontmatter.
