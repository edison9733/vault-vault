---
name: CopilotKit/CopilotKit
url: https://github.com/CopilotKit/CopilotKit
stars: 35004
forks: 4362
language: TypeScript
category: ai-agent
date: 2026-06-14
tags:
  - generative-ui
  - agent-framework
  - react
  - angular
  - AG-UI
  - frontend
---

# CopilotKit/CopilotKit

## What it does

**CopilotKit** is an SDK for building **agent-native applications** with Generative UI, shared state, and human-in-the-loop workflows. It works across React, Angular, Vue, React Native, Slack, and Microsoft Teams. It created the **AG-UI Protocol** (Agent-User Interaction Protocol) — adopted by Google, LangChain, AWS, Microsoft, Mastra, and PydanticAI.

==The key insight: agents can render live UI components dynamically, not just text — turning AI responses into interactive app surfaces.==

## Why it's a top example

35k ★ with 1,373 releases and a massive ecosystem. CopilotKit solves a hard, unsolved problem: **making agent outputs interactive rather than just text**. Its AG-UI protocol is becoming an industry standard. It ships its own agent skills (npx copilotkit@latest skills install) that teach coding agents how to set up, build, and debug CopilotKit projects.

## Architecture patterns

- **[[generative-ui]]** — agents dynamically render React/Vue/Angular components at runtime based on user intent and agent state
- **[[AG-UI-protocol]]** — standard wire protocol for agent↔UI communication; adopted by Google, LangChain, AWS, Microsoft
- **[[human-in-the-loop]]** — agents pause execution to request user input, confirmation, or edits before continuing
- **[[shared-state]]** — synchronized state layer that both agents and UI components read/write in real time
- **[[self-learning]]** — Continuous Learning from Human Feedback (CLHF) via in-context reinforcement learning
- **[[multi-platform]]** — same agent backend powers web (React/Angular/Vue), mobile (React Native), and chat (Slack/Teams)
- **[[skill-loading]]** — `npx copilotkit@latest skills install` injects agent onboarding skills into any project directory

## Reusable techniques

1. **AG-UI Protocol design** — a lightweight wire protocol for agent↔UI interaction that multiple major frameworks adopted; blueprint for building interoperable agent interfaces
2. **Backend tool rendering** — agents call backend tools that return UI components rendered directly in the client; separates agent logic from presentation
3. **useAgent hook** — programmatic control over agent connection, letting developers read/write agent state and trigger actions
4. **Cross-platform agent deployment** — one agent backend, multiple frontends (web, mobile, Slack, Teams) via the same protocol
5. **Self-learning loop** — CLHF reinforcement learning from user feedback without model fine-tuning

## When I'd use this

- As the **primary reference for building generative UI into any agent application**
- When designing an **agent-native app** where users interact with AI through dynamic interfaces, not just chat
- Studying **cross-platform agent deployment** (web + Slack + mobile from one backend)
- As a **comparison point** for agent-UX patterns vs traditional chat-only interfaces
- For understanding **how to build an industry protocol** (AG-UI) that gets adopted by major players
