---
name: Gitlawb/openclaude
url: https://github.com/Gitlawb/openclaude
stars: 28674
forks: 8730
language: TypeScript
category: ai-agent
date: 2026-06-14
tags:
  - coding-agent
  - CLI
  - multi-provider
  - MCP
  - openclaude
---

# Gitlawb/openclaude

## What it does

**OpenClaude** is an open-source **coding-agent CLI** that works with any model provider — OpenAI-compatible APIs, Gemini, GitHub Models, Codex OAuth, Ollama, Atomic Chat, and more. It offers one terminal-first workflow with prompts, tools, agents, tasks, **MCP**, slash commands, and streaming output. It also ships a VS Code extension for launch integration.

==The key insight: you get Claude Code's workflow (tools, agents, MCP, slash commands) but can use ANY model provider — cloud or local.==

## Why it's a top example

28.7k ★, rapidly growing. OpenClaude demonstrates **provider-agnostic agent infrastructure** — the same CLI experience (bash, file tools, grep, glob, agents, MCP, web tools) regardless of whether you use Claude, GPT-4o, Gemini, DeepSeek, or a local Ollama model. Its agent routing feature lets different agents use different models simultaneously for cost optimization.

## Architecture patterns

- **[[agent-harness]]** — terminal-first agent loop with tool dispatch, streaming, and multi-step reasoning
- **[[multi-model]] provider abstraction** — unified interface over 15+ providers via OpenAI-compatible, native SDK, and OAuth adapters
- **[[agent-routing]]** — per-agent model overrides (`agentModels` + `agentRouting` in config) for cost optimization and workload splitting
- **[[MCP]] integration** — Model Context Protocol support for tool ecosystem
- **[[slash-command]] system** — `/provider`, `/model`, `/onboard-github` for runtime configuration
- **[[provider-profile]] storage** — saved provider profiles in user-level config with guided `/provider` setup
- **[[web-search]] fallback** — DuckDuckGo free search for non-Anthropic models, with Firecrawl as premium upgrade

## Reusable techniques

1. **Agent routing by model strength** — route "Explore" tasks to cheap/fast models, "Plan" to powerful reasoning models; configurable JSON schema applicable to any multi-agent system
2. **Provider-agnostic agent design** — same CLI workflow across 15+ backends; architecture template for any tool that needs multi-provider support
3. **Interactive provider onboarding** — `/provider` guided setup with auto-discovery of models; reduces configuration burden
4. **Free web search fallback** — DuckDuckGo scraping as default search for non-Claude models, with paid upgrade path; cost-effective pattern
5. **Gitlawb Opengateway** — smart proxy that routes to partner models; useful pattern for managing multi-provider access

## When I'd use this

- As the **reference for building a provider-agnostic coding agent CLI**
- When designing **per-agent model routing** for cost optimization
- Studying **MCP integration in a terminal-first agent** that works with local models
- As a **comparison point** for Claude Code alternatives (OpenClaw, Codex, Hermes Agent)
- For understanding **how to structure a CLI agent** with tools, streaming, and extensible provider system
