---
title: santifer/career-ops
date: 2026-06-12
source: https://github.com/santifer/career-ops
tags: [claude-skills, job-search, automation, pdf-generation, multi-agent, batch-processing, tui]
stars: 52866
forks: 10588
language: JavaScript
category: ai-agent
---

## What it does

Career-Ops is an AI-powered job-search pipeline built on Claude Code skills. It evaluates job listings with a structured A–F scoring rubric, generates ATS-optimised PDF resumes, tracks applications in a Markdown database, and runs a Go terminal dashboard. The creator used it to evaluate 740+ listings, generate 100+ tailored CVs, and land a Head of Applied AI role.

## Why it's a top example

==Multi-CLI portability through parallel skill directories (`.agents/`, `.claude/`, `.qwen/`) means the same pipeline runs under Claude Code, Gemini CLI, OpenCode, and Codex — a reusable pattern for any CLI-agnostic skill system.== At 53 k stars it is the highest-starred Claude-skills–based application.

## Architecture patterns

- **[[skill-based-cli]]** — 14 skill modes exposed through Claude Code skills; each mode is a discrete `.claude/` skill file.
- **[[multi-agent]]** batch processing — parallel sub-agent evaluation of job listings.
- **[[human-in-the-loop]]** — AI recommends; no auto-submit. Approval gates on cover letters and applications.
- **[[markdown-native-data]]** — CVs, profiles, tracking data stored as Markdown/YAML for version control and human readability.
- **[[tui-dashboard]]** — Go + Bubble Tea terminal UI for browsing the pipeline.
- **[[pdf-generation]]** — Playwright renders HTML/Markdown CVs to ATS-optimised PDF.
- **[[multi-cli]]** — same skills work under Gemini CLI, OpenCode, Qwen, Codex via standardised directories.

## Reusable techniques

1. **Archetype-driven scoring**: classify the role type first, then apply role-specific rubrics — more accurate than keyword matching.
2. **Parallel skill directories**: ship `.claude/`, `.agents/`, `.qwen/` with identical skills so users pick their preferred CLI.
3. **Markdown-native pipeline**: store every artifact (CV, cover letter, tracker row) as a file — enables git history and human review.
4. **Portal scanner with async-first discovery**: check APIs before launching Playwright; reduces cost 10×.
5. **Bounded evaluation (4.0/5 gate)**: hard threshold prevents wasted effort on poor-fit roles.

## When I'd use this

When building a domain-specific automation pipeline on top of Claude Code skills, especially one that needs PDF output, parallel batch processing, a terminal dashboard, and portability across multiple agent CLIs.
