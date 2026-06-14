---
name: siyuan-note/siyuan
url: https://github.com/siyuan-note/siyuan
stars: 44434
forks: 2840
language: TypeScript
category: ai-agent
date: 2026-06-14
tags:
  - knowledge-management
  - personal-knowledge-management
  - block-editor
  - self-hosted
  - privacy-first
---

# siyuan-note/siyuan

## What it does

**SiYuan** is a **privacy-first**, self-hosted personal knowledge management system with fine-grained block-level reference and **Markdown WYSIWYG** editing. It handles everything from note-taking and wikis to databases, spaced repetition flashcards, and AI writing via OpenAI API. It runs as a desktop app, mobile app (Android/iOS/HarmonyOS), or Docker server.

==The key insight: block-level references let you link any paragraph, heading, or list item independently — not just whole pages.==

## Why it's a top example

44.4k ★, highly active (22k+ commits). It offers a **complete, self-contained PKM ecosystem** with sync, publishing, plugin API, web clipper, and community marketplace. Its AGPL-3.0 license and self-hosted architecture make it a strong alternative to Notion, Obsidian, or Roam Research for privacy-conscious users.

## Architecture patterns

- **[[block-oriented-editor]]** — every content element is an addressable block with unique ID, enabling fine-grained backlinks and transclusion
- **[[plugin-system]]** — marketplace-driven extensibility via `petal` (plugin API), letting community build custom functionality
- **[[self-hosted-infrastructure]]** — Docker deployment with workspace persistence, auth codes, and PUID/PGID mapping for secure multi-user setups
- **[[database-view]]** — table-like structured data within notes, blurring the line between documents and databases
- **[[spaced-repetition]]** — built-in flashcard system using the RIFT algorithm
- **[[WYSIWYG-Markdown]]** — real-time rendering of Markdown as you type, without toggle between edit/preview modes

## Reusable techniques

1. **Block-level addressing scheme** — assign UUIDs to every content block for granular linking; applicable to any document system
2. **Community marketplace pattern** — a plugin/bazaar ecosystem keeps the core lean while enabling extensibility
3. **Self-hosted Docker with auth** — `--accessAuthCode` + environment variable fallback pattern is portable to any self-hosted app
4. **Multi-platform packaging** — single codebase targeting desktop (Electron), mobile (native apps), and Docker with consistent data format

## When I'd use this

- As the **reference example for building a block-based editor** with Markdown WYSIWYG
- When designing a **self-hosted knowledge management system** with plugin extensibility
- Studying **privacy-first architecture** patterns (local-first, encryption, no vendor lock-in)
- As a **comparison point** for other PKM tools (Obsidian, Logseq, Notion)
