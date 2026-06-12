# ElevenLabs

**What it is** — A commercial AI voice synthesis and cloning service. Users upload voice samples to create a personal voice profile; the API then converts any text to audio in that voice (MP3 output). One of the leading [[Voice Cloning]] platforms as of 2026.

**Why it matters** — Enables autonomous agents to respond in a specific person's voice without any per-response recording session. Plugging ElevenLabs into an AI pipeline makes the agent's text outputs audibly indistinguishable from the person it represents — raising both productivity and deepfake concerns.

**Example** — Fireship created his own voice profile in ElevenLabs and wired it into [[OpenClaw]]: the bot drafts a text reply, ElevenLabs synthesizes it as an MP3 in Fireship's voice, FFmpeg converts it to `.ogg`, and it is sent as a Telegram voice memo.

## Seen in
- [[2026-04-23 - I finally found a use case for OpenClaw… [FM5-R4VPArw]]]
