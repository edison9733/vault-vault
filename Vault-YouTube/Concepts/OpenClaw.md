# OpenClaw

**What it is** — Open-source personal AI assistant released in early 2026, created by Peter Steinberger. Runs on a local machine or VPS, configurable via plain-text files: `soul.md` (personality/persona) and `tools.md` (tool context). Gained rapid adoption in January 2026, triggering a Mac mini shortage as developers rushed to self-host it. Over 1,100 security advisories filed by April 2026, ~650 resolved.

**Why it matters** — Gives individuals a self-hosted AI agent that handles inbound messages or tasks autonomously in their own configured persona, without depending on a third-party cloud service. Integrates with messaging platforms (e.g., Telegram) and external APIs (e.g., [[ElevenLabs]] for voice) to close the loop from input to response entirely.

**Example** — Fireship configured OpenClaw on a VPS with a Telegram bot and ElevenLabs voice cloning: inbound family tech-support messages are analyzed, a reply is drafted, synthesized into a voice memo using the owner's cloned voice, and returned — zero manual intervention.

## Seen in
- [[2026-04-23 - I finally found a use case for OpenClaw… [FM5-R4VPArw]]]
