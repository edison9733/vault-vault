---
title: shareAI-lab/learn-claude-code
date: 2026-06-12
source: https://github.com/shareAI-lab/learn-claude-code
tags: [agent-harness, claude, education, tool-dispatch, context-management, subagent]
stars: 66146
forks: 10776
language: Python
category: ai-agent
---

## What it does

An educational repository that teaches [[agent-harness]] engineering from scratch in 20 progressive lessons. Its tagline: "Bash is all you need — a nano claude-code–like agent harness, built from 0 to 1." The philosophy: "Agency comes from the model. The harness gives agency a place to land." Each lesson adds one mechanism (hooks, planning, memory, scheduling, isolation) around a single unchanging agent loop.

## Why it's a top example

==The single invariant loop insight is the biggest takeaway: every lesson adds harness mechanisms around the loop without ever modifying the loop itself — proving that agent complexity lives in the scaffolding, not the core.== At 66 k stars it is the most-starred educational harness-engineering resource.

## Architecture patterns

- **[[agent-harness]]** — core loop: `messages[] → LLM → stop_reason=="tool_use"? → execute → append → loop`. Unchanged across all 20 lessons.
- **[[tool-dispatch]]** — code executes model decisions; the model decides when to use tools.
- **[[context-compaction]]** — three layers: snipCompact (trim old turns), microCompact (summarise), autoCompact (background LLM sweep).
- **[[subagent-isolation]]** — side tasks run in fresh message contexts to prevent noise leakage.
- **[[planning]]** — persistent task graphs survive crashes; deterministic completion gates.
- **[[memory]]** — session retrieval via JSONL mailbox protocol; cross-session recall.
- **[[scheduling]]** — background jobs with cron-like scheduling inside the harness.

## Reusable techniques

1. **20-lesson progression structure**: use as a curriculum template for teaching any agentic system.
2. **Three-layer context compaction**: snip → micro → auto; implement in that order as context pressure grows.
3. **Subagent isolation via fresh message contexts**: never share the main context with a side task.
4. **JSONL mailbox for inter-agent comms**: lightweight, crash-safe, human-readable.
5. **Permission boundaries early**: add approval workflows before giving the agent any destructive tool.

## When I'd use this

When building a new agent harness from scratch or teaching someone how agent scaffolding works. The 20 lessons are a reliable build order for any LLM agent system regardless of language or provider.
