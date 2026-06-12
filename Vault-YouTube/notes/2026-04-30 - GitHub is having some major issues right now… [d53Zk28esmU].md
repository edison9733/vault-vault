---
title: "GitHub is having some major issues right now…"
channel: The Code Report (Fireship)
video_url: https://youtube.com/watch?v=d53Zk28esmU
date: 2026-04-30
tags: [github, infrastructure, reliability, security, enshittification]
---

## Summary
- GitHub suffered three major incidents in one week (April 23–28 2026): merge queue silently reverting 2,092 pull requests, a botnet attack knocking out search, and a critical RCE vulnerability disclosed the same morning the CTO posted a reliability apology.
- Mitchell Hashimoto — GitHub's user #1,299 since 2008 and creator of Vagrant, Terraform, and HashiCorp — announced he is migrating his 50,000-star Ghosty terminal emulator off the platform after 18 consecutive years.
- GitHub's own CTO admitted the root cause: AI agentic workflows have been hammering the platform at a scale it was never designed for.

## Key Points
- **[[GitHub]] history**: Founded 2008 on [[Git]] (Linus Torvalds, 2005) with a Ruby on Rails web UI; acquired by Microsoft for **$7.5 billion** in 2018; now serves 100M+ developers and 420M+ repositories — "if it isn't on GitHub, it might as well not exist."
- **[[Uptime]] crisis**: Third-party monitoring measured 2025 uptime below **90%** and April 2026 at ~**86%** — compared to AWS S3's eleven-nines SLA. GitHub's own status page still claimed >99%.
- **April 23 — [[Merge Queue]] failure**: The queue silently **unmerged 2,092 pull requests across 658 repos**; the platform whose entire job is to protect code lost code.
- **April 27 — [[Botnet]] attack**: A botnet hit GitHub's Elasticsearch subsystem, taking **search offline for hours**.
- **April 28 — Double crisis**: GitHub CTO published a reliability apology *and* disclosed a critical **[[Remote Code Execution]]** bug: a `git push` could execute arbitrary code on GitHub's servers.
- **[[Enshittification]] arc**: Post-2018 Microsoft ownership initially improved GitHub (Actions, Codespaces); the AI coding era reversed the trajectory.
- ==**AI agents as root cause**: GitHub CTO admitted "agentic development workflows have accelerated sharply since 2025" — [[Agentic AI Era]] load from AI agents is now the primary infrastructure strain, not human developers. "GitHub isn't just a host for developers anymore, it's a host for their replacements."==
- **Mitchell Hashimoto exodus**: User #1,299 since 2008; kept a daily journal for a month marking every day a GitHub outage blocked work — "almost every day got an X." Moving 50,000-star Ghosty project off the platform.
- **Alternatives named**: GitLab ("reliable but boring"), Codeberg (German nonprofit), SourceHut (minimal, zero AI features). Zig had already migrated before this incident.

## Notable Quotes
- "I want to ship software and it doesn't want me to ship software." — Mitchell Hashimoto
- "GitHub isn't just a host for developers anymore, it's a host for their replacements." — Fireship

## Concepts
- [[GitHub]]
- [[Git]]
- [[Merge Queue]]
- [[Remote Code Execution]]
- [[Enshittification]]
- [[Uptime]]
- [[Botnet]]
- [[GitHub Actions]]
- [[Agentic AI Era]]
