# INSIGHTS - pattern map, skill coverage, source quality
<!-- Knowledge that compounds across runs. Cap ~150 lines; weekly job dedupes. -->

## Recurring architecture patterns (with counts)

| Pattern | Count | Top examples |
|---------|-------|-------------|
| [[agent-harness]] (invariant loop + tool dispatch) | 3 | hermes-agent (191k), learn-claude-code (66k), CowAgent (45k) |
| [[multi-model]] provider abstraction | 3 | hermes-agent (191k), cherry-studio (47k), CowAgent (45k) |
| [[memory]] three-tier (context → daily → core) | 2 | hermes-agent (191k), CowAgent (45k) |
| [[multi-channel]] gateway abstraction | 2 | hermes-agent (191k), CowAgent (45k) |
| [[skill-loading]] runtime extensibility | 3 | hermes-agent (191k), CowAgent (45k), career-ops (53k) |
| [[multi-cli]] portability (parallel skill dirs) | 1 | career-ops (53k) — `.claude/`, `.agents/`, `.qwen/` |
| [[rules-as-content]] structured corpus | 1 | Front-End-Checklist (73k) |
| [[human-in-the-loop]] approval gates | 1 | career-ops (53k) |

## Skill coverage map

| Pattern | Skill | Status |
|---------|-------|--------|
| [[agent-harness]] | build-agent-harness | STAGED → needs install |
| [[prompt-engineering]] | prompt-master | STAGED → needs install |
| [[browser-automation]] / [[testing]] | playwright-skill | STAGED → needs install |
| [[multi-model]] provider abstraction | GAP | — |
| [[memory]] / [[rag]] | GAP | — |
| [[multi-channel]] gateway | GAP | — |
| [[rules-as-content]] checklist | GAP | — |

## Source quality notes

- **top_ai-agent_2026-06-12.json** — highest signal; all 6 assigned repos were genuine, high-star agents or tools with real patterns to study.
- **topic_claude-skills_2026-06-12.json** — mixed quality. Top 3 by stars (claude-mem 81k, oh-my-openagent 62k, Understand-Anything 58k) are agent harnesses/tools, not SKILL.md libraries. Actual skills start around rank 6 (planning-with-files 23k). Curators (awesome-*) are useful for discovery but have no installable content.
- **kw_claude-skills_2026-06-12.json** — duplicates with topic list; ComposioHQ/awesome-claude-skills (64k) is the main curator.
- **kw_awesome-claude_2026-06-12.json** — mostly curated lists; hesreallyhim/awesome-claude-code (46k) is best discovery resource.
- **anchor_anthropics-skills_2026-06-12.json** — official Anthropic skills repo (150k stars); SKILL.md files are reference docs for Python libraries, not Claude behavior skills. Useful for format reference, not direct install.
- **Best source for installable SKILL.md files**: single-purpose repos with "skill" in name/description and <10k stars tend to have actual SKILL.md files. Mega-curators (>50k stars) are indexes, not installable content.
