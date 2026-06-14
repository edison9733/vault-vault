---
name: iOfficeAI/AionUi
url: https://github.com/iOfficeAI/AionUi
stars: 28197
forks: 2759
language: TypeScript
category: ai-agent
date: 2026-06-14
tags:
  - cowork
  - multi-agent
  - desktop-app
  - MCP
  - team-mode
  - office-automation
---

# iOfficeAI/AionUi

## What it does

**AionUi** is a free, open-source **Cowork desktop app** with a built-in AI agent engine, multi-agent team mode, and 21 built-in professional assistants (PPT, Word, Excel, and more). It auto-detects 15+ installed CLI agents (Claude Code, Codex, Hermes Agent, OpenClaw, etc.) and lets you run them all from one unified interface. It features **Team Mode** where a Leader agent delegates subtasks to parallel Teammate agents.

==The key insight: it's not just a chat client — it's a full "cowork" platform where multiple AI agents work alongside you on your computer simultaneously.==

## Why it's a top example

28.2k ★, very active (5,500+ commits). AionUi solves the practical problem of **managing multiple AI coding agents from one place** with a polished desktop UI. Its Team Mode (Leader + parallel Teammates) is an innovative multi-agent orchestration pattern. Built-in Office CLI for generating real PPTX, DOCX, and XLSX files adds genuine productivity value beyond coding.

## Architecture patterns

- **[[multi-agent-orchestration]]** — Team Mode: Leader agent breaks tasks into subtasks, delegates to parallel Teammates via ACP (Agent Communication Protocol)
- **[[multi-CLI]] integration** — auto-detects 15+ installed coding agents and provides unified interface, session management, and cross-agent context
- **[[MCP]] unified management** — configure MCP tools once, sync to all agents automatically
- **[[skill-loading]] runtime** — three-tier skill system: built-in, custom (user-defined), and extension (third-party) skills
- **[[desktop-agent-host]]** — Electron-style desktop app that hosts agent processes with file access, web search, image generation, and automation
- **[[cron-automation]]** — 24/7 scheduled task execution with unattended operation
- **[[remote-access]]** — WebUI + Telegram/Lark/DingTalk/WeChat for mobile access to desktop agents

## Reusable techniques

1. **Multi-agent Team Mode** — Leader/Teammate pattern with shared workspace, async mailbox, and task board; applicable to any collaborative AI system
2. **Auto-detection of CLI tools** — scan PATH for installed agents and integrate without manual configuration; portable UX pattern
3. **Three-tier skill system** — builtin / custom / extension skills with per-conversation enable/disable; architecture for any extensible agent platform
4. **Unified MCP configuration** — configure once, sync to all agents; solves the "configure every agent separately" pain point
5. **YOLO/Full-Auto mode** — one-click bypass of permission prompts for unattended execution; useful pattern but needs careful security consideration

## When I'd use this

- As the **reference for building a desktop cowork app** that hosts multiple AI agents
- When designing **multi-agent team orchestration** (Leader/Teammate pattern)
- Studying **CLI agent auto-detection and unified management**
- As a **comparison point** for agent workspace UIs vs pure terminal tools
- For understanding **how to build cross-agent MCP sharing** and skill ecosystems
