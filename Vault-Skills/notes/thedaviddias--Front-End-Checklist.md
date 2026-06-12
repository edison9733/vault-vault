---
title: thedaviddias/Front-End-Checklist
date: 2026-06-12
source: https://github.com/thedaviddias/Front-End-Checklist
tags: [frontend, checklist, quality, accessibility, seo, security, mcp, ai-agent]
stars: 72898
forks: 6651
language: MDX
category: website-builder
---

## What it does

Front-End Checklist is an open-source front-end quality system: 385 rules across 11 categories (HTML, CSS, JavaScript, Performance, Accessibility, SEO, Security, Images, Testing, Privacy, Internationalization). Rules carry Critical/High/Medium/Low priorities. The project ships a web app, an MCP server, and skill-based workflows so both humans and AI agents can run the same audits.

## Why it's a top example

==Rules-as-content is the architectural insight: treating best-practice rules as first-class structured data (not prose docs) lets you expose the same corpus through a website, a CLI, and an MCP server without duplication.== At 73 k stars it is the canonical front-end checklist reference.

## Architecture patterns

- **[[rules-as-content]]** — each rule has id, priority, category, explanation, and remediation guidance. Single source of truth, multiple renderers.
- **[[monorepo]]** — pnpm workspaces + Turbo; separate packages for web, MCP server, and skill modules.
- **[[mcp-integration]]** — MCP endpoints expose rules to AI agents for automated code review and auditing.
- **[[priority-triage]]** — Critical / High / Medium / Low labels let agents and humans focus on what matters most first.

## Reusable techniques

1. **Structured rule schema**: define rules with machine-readable fields (id, priority, category, check, fix) to enable filtering, scoring, and agent consumption.
2. **Multi-interface corpus**: one ruleset → web UI + MCP server + skill file. Write once, use everywhere.
3. **Focused checklists**: distill the full 385 into launch-specific, accessibility-specific, and security-specific sub-lists.
4. **95 accessibility rules** (25% of corpus) — model a high-coverage WCAG mapping for automated a11y review.

## When I'd use this

When building an automated front-end audit tool, a code-review agent, or any system that must evaluate web code against a structured quality corpus. The rule schema is directly reusable for any domain-specific checklist (backend, mobile, security).
