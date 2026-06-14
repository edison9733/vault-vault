---
name: HKUDS/nanobot
url: https://github.com/HKUDS/nanobot
stars: 44160
forks: 7808
language: Python
category: ai-agent
date: 2026-06-14
tags:
  - ai-agent
  - agent-harness
  - multi-channel
  - MCP
  - lightweight
---

# HKUDS/nanobot

## What it does

**Nanobot** is an "ultra-lightweight" open-source personal AI agent you can own. It keeps the agent core small and readable while providing practical pieces for real long-running work: WebUI, chat channels (Telegram, Discord, WeChat, Slack, Email, Feishu, Matrix, Signal, WhatsApp, DingTalk), tools, memory, **MCP** support, model routing, image generation, automation, and one-command deployment.

==The key insight: it's a batteries-included agent harness that's small enough to read and extend, yet production-ready for daily use.==

## Why it's a top example

44.2k ★ with rapid iteration (2,900+ commits, daily releases v0.1.4 → v0.2.1 in 2 months). It replaces the heavy `litellm` dependency with native SDKs (OpenAI + Anthropic) and offers genuine **multi-model provider abstraction** (OpenAI, Anthropic, Gemini, DeepSeek, Ollama, Bedrock, and 20+ more). Its `/goal` command for sustained objectives across turns is a notable UX innovation.

## Architecture patterns

- **[[agent-harness]]** — small core with tool dispatch loop, memory, MCP, and skill system
- **[[multi-model]] provider abstraction** — native SDK facade over 20+ LLM providers with fallback models
- **[[multi-channel]] gateway** — 12+ chat platforms via unified session abstraction
- **[[MCP]] integration** — Model Context Protocol support for tool ecosystem
- **[[memory]] system** — "Dream" two-stage memory (context → long-term) with auto-compaction
- **[[skill-loading]] runtime** — extensible skill system with `disabled_skills` config, MCP presets, and slash actions
- **[[human-in-the-loop]]** — `ask_user` choices, approval gates for tool execution
- **[[event-driven]]** — cron scheduler, reminders, webhook-based triggers

## Reusable techniques

1. **Native SDK replacement of heavy wrappers** — dropping `litellm` for direct `openai` + `anthropic` SDKs improved reliability and reduced dependencies; a lesson for any agent framework
2. **/goal persistent objective pattern** — cross-turn sustained goals with visible multi-step progress is a superior UX pattern for long-running agent tasks
3. **Interactive setup wizard** — `/provider` guided setup with model autocomplete; reduces onboarding friction to near-zero
4. **Channel-agnostic session management** — unified cross-channel session with thread-aware routing; applicable to any multi-platform bot
5. **Langfuse observability** — built-in tracing via Langfuse for debugging agent behavior in production

## When I'd use this

- As the **primary reference for building a lightweight, production-ready agent harness** in Python
- When designing a **multi-channel chatbot system** that needs to support 10+ platforms from one codebase
- Studying **MCP integration patterns** for tool ecosystem extensibility
- As a **comparison point** against heavier agent frameworks (LangChain, CrewAI)
- For understanding **how to structure a rapidly-iterating open-source AI project** with daily releases
