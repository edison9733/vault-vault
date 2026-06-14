# INSIGHTS - pattern map, skill coverage, source quality
<!-- Knowledge that compounds across runs. Cap ~150 lines; weekly job dedupes. -->

## Recurring architecture patterns (with counts)

| Pattern | Count | Top examples |
|---------|-------|-------------|
| [[agent-harness]] (invariant loop + tool dispatch) | 5 | hermes-agent (192k), nanobot (44k), openclaude (29k), learn-claude-code (66k), CowAgent (45k) |
| [[multi-model]] provider abstraction | 6 | hermes-agent (192k), nanobot (44k), openclaude (29k), learn-claude-code (66k), CowAgent (45k), cherry-studio (47k) |
| [[skill-loading]] runtime extensibility | 5 | hermes-agent (192k), nanobot (44k), CopilotKit (35k), AionUi (28k), CowAgent (45k), career-ops (53k) |
| [[MCP]] integration | 4 | nanobot (44k), openclaude (29k), AionUi (28k), CopilotKit (35k) |
| [[multi-channel]] gateway abstraction | 4 | hermes-agent (192k), nanobot (44k), DSA (42k), CowAgent (45k) |
| [[memory]] three-tier (context → daily → core) | 3 | hermes-agent (192k), nanobot (44k), CowAgent (45k) |
| [[human-in-the-loop]] approval gates | 3 | career-ops (53k), nanobot (44k), CopilotKit (35k) |
| [[cron-automation]] scheduled AI workflows | 2 | DSA (42k), AionUi (28k) |
| [[multi-agent-orchestration]] team mode | 1 | AionUi (28k) — Leader/Teammate with ACP protocol |
| [[generative-ui]] agent-rendered UI | 1 | CopilotKit (35k) — AG-UI Protocol |
| [[multi-cli]] portability (parallel skill dirs) | 1 | career-ops (53k) |
| [[rules-as-content]] structured corpus | 1 | Front-End-Checklist (73k) |
| [[block-oriented-editor]] fine-grained content | 1 | siyuan (44k) |

## Skill coverage map

| Pattern | Skill | Status |
|---------|-------|--------|
| [[agent-harness]] | build-agent-harness | STAGED → needs install |
| [[prompt-engineering]] | prompt-master | STAGED → needs install |
| [[browser-automation]] / [[testing]] | playwright-skill | STAGED → needs install |
| [[multi-model]] provider abstraction | multi-model-provider | STAGED (this run) |
| [[scientific-research]] / [[literature-review]] | literature-review | STAGED (this run, from K-Dense) |
| [[bioinformatics]] | bioinformatics | STAGED (this run, from K-Dense) |
| [[content-creation]] / [[infographic]] | baoyu-infographic | STAGED (this run) |
| [[memory]] / [[rag]] | GAP | — |
| [[multi-channel]] gateway | GAP | — |
| [[MCP]] integration patterns | GAP | — |
| [[generative-ui]] | GAP | — |
| [[rules-as-content]] checklist | GAP | — |

## Source quality notes

- **top_ai-agent_2026-06-14.json** — richest source yet; all 6 assigned repos are genuine high-star systems with strong patterns. Nanobot (44k) is the best reference for lightweight agent harness design. DSA (42k) best for cron-driven AI automation.
- **topic_claude-skills_2026-06-14.json** — improving quality. K-Dense/scientific-agent-skills (28k★), JimLiu/baoyu-skills (21k★), and alirezarezvani/claude-skills (18k★) all have proper SKILL.md files with real content. The earlier pattern (<10k stars for real skills) is shifting as the ecosystem matures.
- **kw_claude-skills_2026-06-14.json** — Saw several offensive-security repos (Claude-Red, Claude-OSINT, iothackbot). These are intentional skill repos but are destructive by design. Flag them early.
- **kw_awesome-claude_2026-06-14.json** — VoltAgent/awesome-claude-design (2.7k★) and VoltAgent/awesome-claude-code-subagents (22k★) are new curator types. Design prompts in SKILL.md format is an emerging pattern.
- **Heuristic update**: Repos with "claude-red", "osint", "hack", "pentest", "exploit" in name/description are offensive security skills. Skip automatically unless explicitly authorized.
