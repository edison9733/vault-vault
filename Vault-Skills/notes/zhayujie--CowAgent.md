---
title: zhayujie/CowAgent
date: 2026-06-12
source: https://github.com/zhayujie/CowAgent
tags: [agent-harness, multi-channel, memory, skills, multi-model, self-evolving, python]
stars: 45235
forks: 10194
language: Python
category: ai-agent
---

## What it does

CowAgent (formerly chatgpt-on-wechat) is an open-source AI agent harness. It connects to 10+ messaging channels (WeChat, Telegram, Slack, Discord, Feishu, DingTalk, web), routes to any LLM (Claude, GPT, Gemini, DeepSeek, Qwen), manages a three-tier memory system, maintains a self-curating knowledge base, and runs a Skill Hub for community extensions. The agent "proactively plans tasks, controls your computer and external services, creates and runs skills, and self-evolves with memory and knowledge."

## Why it's a top example

==The three-tier memory architecture (context → daily → core) with automatic "Deep Dream" distillation into a hybrid keyword + vector index is the most complete open-source agent memory system in this dataset.== At 45 k stars it has the largest community of any Python agent harness built for consumer messaging platforms.

## Architecture patterns

- **[[agent-harness]]** — decoupled layers: channels → agent core → models → tools/skills. Each layer is independently extensible.
- **[[multi-channel]]** — 10+ messaging platforms as input channels; single agent core handles all.
- **[[multi-model]]** — runtime model switching through web console; no code changes.
- **[[memory]]** — three-tier: context (short), daily (medium), core (long-term); Deep Dream distillation + hybrid retrieval.
- **[[knowledge-graph]]** — auto-curates information into structured Markdown with visual graph browsing.
- **[[skill-loading]]** — external Skill Hub; skills installable at runtime.
- **[[self-evolving]]** — reviews conversations to improve skills and consolidate learning.

## Reusable techniques

1. **Three-tier memory**: context (raw turns) → daily (summarised sessions) → core (distilled facts). Implement in that order as scale grows.
2. **Deep Dream distillation**: nightly LLM pass over daily memory → core knowledge; prevents memory bloat.
3. **Channel abstraction**: define `BaseChannel` with `send`/`receive`; add new messaging platforms without touching agent logic.
4. **Skill Hub decoupling**: decouple skill releases from core releases via an external registry URL.
5. **Web console as single control plane**: one URL for chat, config, channel management, and skill install.

## When I'd use this

When building an agent that must serve users across multiple consumer messaging platforms simultaneously, maintain long-term per-user memory, and install new capabilities at runtime without redeployment.
