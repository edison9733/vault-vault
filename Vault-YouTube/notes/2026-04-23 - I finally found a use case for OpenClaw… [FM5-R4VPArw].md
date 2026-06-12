---
title: "I finally found a use case for OpenClaw…"
channel: The Code Report (Fireship)
video_url: https://youtube.com/watch?v=FM5-R4VPArw
date: 2026-04-23
tags: [fireship, openclaw, ai-assistant, voice-cloning, telegram, vps, automation]
---

## Summary
- [[OpenClaw]], the open-source personal AI assistant by Peter Steinberger, has accumulated 1,100+ security advisories (~650 resolved); its creator spoke at TED and AI Engineer Europe about its origin and security progress.
- Fireship deploys OpenClaw on a [[VPS]] connected to a Telegram bot and [[ElevenLabs]] voice clone to handle family tech-support requests autonomously, responding in his own voice.
- The full pipeline — inbound Telegram message → OpenClaw analysis → text reply → ElevenLabs TTS → FFmpeg conversion → .ogg voice memo — achieves hands-free, voice-identical automated responses.

## Key Points
- **OpenClaw** is an open-source personal AI assistant first covered on The Code Report in January 2026; its release triggered a nationwide Mac mini shortage as developers rushed to self-host it.
- Creator **Peter Steinberger** spoke about OpenClaw's origin at **TED** and addressed its security vulnerabilities at **AI Engineer Europe** (April 2026).
- Security posture: over **1,100 advisories** received; ~**650 resolved or closed**. Steinberger's AI-slop filter for fake reports: "anytime the report is too nice or someone apologizes, that is very likely AI."
- **Deployment**: run on a [[VPS]] for ~a few dollars/month (vs. buying a Mac mini); Hostinger offers one-click OpenClaw plans with private vault isolation to prevent personal-data leakage.
- **Configuration files**: `soul.md` defines the bot's personality; `tools.md` gives it context on available tools — both editable over SSH.
- **Voice pipeline**: OpenClaw drafts a reply → [[ElevenLabs]] API converts text to MP3 using the creator's personal voice clone → **FFmpeg** converts MP3 → `.ogg` → sent as a Telegram voice memo.
- ==The system allows a single configuration to autonomously respond to any inbound request in the owner's own cloned voice — recipients cannot distinguish the bot from the person, achieving full personal-presence automation without any manual effort.==

## Notable Quotes
- "The new status symbol is to flex on how many tokens it takes to automate any part of your life where you might be experiencing some mild form of inconvenience."
- "Every computer programmer has always dreamed of: emotional detachment from your family at scale."

## Concepts
- [[OpenClaw]]
- [[ElevenLabs]]
- [[Voice Cloning]]
- [[Agentic AI Era]]
