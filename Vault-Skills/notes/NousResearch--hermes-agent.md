---
title: NousResearch/hermes-agent
date: 2026-06-12
source: https://github.com/NousResearch/hermes-agent
tags: [ai-agent, multi-platform, memory, skills, multi-model, harness]
stars: 191145
forks: 33209
language: Python
category: ai-agent
---

## What it does

Hermes Agent is a self-improving AI agent harness. It wraps any of 200+ LLMs with a persistent [[agent-harness]] loop, a multi-channel gateway (Telegram, Discord, Slack, WhatsApp, Signal, email), and an autonomous skill-creation system that improves capabilities after each complex task. It describes itself as "the agent that grows with you."

## Why it's a top example

==The closed learning loop is the key differentiator: after completing a task the agent writes and refines skills itself, so the system becomes more capable over time without human intervention.== At 191 k stars it is the single most-starred AI agent harness on GitHub as of June 2026, proving the design resonates at scale.

## Architecture patterns

- **[[agent-harness]]** — a single loop: `messages[] → LLM → tool_use? → execute → loop`; all complexity is layered around the loop, not inside it.
- **[[multi-platform]]** gateway — one process fans conversations out to six messaging platforms, maintaining thread continuity across them.
- **Agent-curated [[memory]]** — full-text-search session retrieval + LLM summarization; user modelling via the Honcho dialectic system.
- **[[skill-loading]]** — skills self-improve during use; 40+ tools available; MCP server integration.
- **[[multi-model]]** — provider-agnostic via `hermes model` switch; supports OpenRouter, OpenAI, Anthropic, NVIDIA NIM, HuggingFace, custom endpoints.
- **[[distributed-execution]]** — spawns isolated subagents for parallel workstreams; Python RPC; Docker / SSH / Modal backends.

## Reusable techniques

1. **Closed skill-improvement loop**: after each task, review the trajectory and update the skill file. No human needed.
2. **Serverless hibernation**: use Modal / Daytona so agent environments cost near-zero when idle.
3. **Migration helpers**: automate import of personas, memories, and skills from other agents.
4. **Trajectory collection**: save real deployment sequences as training data for fine-tuning.
5. **Single `hermes model` switch**: decouple model selection from code so the same harness runs across providers.

## When I'd use this

When building a general-purpose personal agent that must run 24/7 across multiple channels, use tools, remember users across sessions, and improve its own capability over time — especially when model-provider flexibility is required.
