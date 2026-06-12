---
title: CherryHQ/cherry-studio
date: 2026-06-12
source: https://github.com/CherryHQ/cherry-studio
tags: [desktop-app, multi-model, electron, llm-gateway, assistants, mcp]
stars: 47228
forks: 4476
language: TypeScript
category: ai-system
---

## What it does

Cherry Studio is a cross-platform desktop AI productivity application (Windows, macOS, Linux). It provides a unified interface for 300+ pre-built AI assistants, multi-model simultaneous conversations, document processing (PDF, Office, images), Mermaid visualisation, and MCP server support. It abstracts provider-specific APIs so users can switch between OpenAI, Anthropic, Gemini, and others without reconfiguring.

## Why it's a top example

==The multi-provider abstraction layer — identical UX regardless of which LLM sits behind it — is the pattern other desktop AI apps replicate. Shipping 300+ pre-built assistants lowers the barrier for non-technical users.== At 47 k stars it is the most-starred Electron-based LLM desktop client.

## Architecture patterns

- **[[multi-model]]** abstraction — provider-agnostic API layer; runtime model switching.
- **[[electron]]** desktop shell — TypeScript + Vite + Electron; cross-platform packaging with electron-builder.
- **[[monorepo]]** — pnpm workspaces for distinct functional packages.
- **[[mcp-integration]]** — MCP server support for extensible tool ecosystems.
- **[[assistant-library]]** — 300+ pre-configured personas stored as structured config; community-extensible.

## Reusable techniques

1. **Provider abstraction interface**: define a single `ChatProvider` contract; each provider implements it. New models = new implementation, not new UX.
2. **Assistant-as-config**: store assistant personas as JSON/YAML files in a registry; ship community packs as separate packages.
3. **AGPL + commercial dual-license**: enables open-source community + paid enterprise tier without forking.
4. **Electron + Vite**: fast HMR in dev, deterministic builds in prod; proven combo for desktop AI clients.

## When I'd use this

When building a desktop AI chat client that must support multiple LLM providers and a large library of pre-built personas. Fork as a base rather than building from scratch — the provider abstraction and assistant registry patterns save weeks.
