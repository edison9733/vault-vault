---
title: "How AI Agents Can Pay for Things | Pay.sh tutorial and integrations"
channel: Bree (Solana Developer)
video_url: https://youtube.com/watch?v=HoTnSjbMFHk
date: 2026-05-07
tags: [solana, http402, ai-agents, pay-sh, claude-code]
---

## Summary
- Pay (pay.sh) is a payment layer for HTTP that lets CLIs and AI agents access paid APIs using stablecoin payments without managing API keys.
- When an API returns 402, Pay detects the protocol, prepares a stablecoin payment, requests local wallet approval, and automatically retries the request.
- Integration with Claude Code via `pay claude` allows AI agents to discover and pay for APIs (like Google Places API) in real-time during development sessions.

## Key Points
- **Consumer-side workflow**: `pay curl [url]` wraps any API call → if 402 → Pay reads challenge → builds payment proof → signs with local wallet → retries automatically.
- **Transparent to user**: From the user's perspective, it feels like a normal curl command; payment handshake is invisible.
- **Pay debugger UI**: Visual UI at `pay server demo` shows the full challenge → payment → response cycle in real-time; clickable "Continue Solana" button for manual approval.
- **Claude Code integration**: `pay claude` opens Claude Code with Pay enabled. Claude can now call payment-gated APIs (e.g., Google Places API at $0.001/search) during agentic tasks.
- **Touch ID approval**: Mainnet payments require Touch ID/keychain approval before execution—user stays in control.
- **Supported protocols**: MPP and X402; pays with stablecoins on Solana.
- **Security model**: Agent doesn't hold private keys or API secrets; user approves each payment from their local wallet.
- **Real use case shown**: Claude Code answering "best Italian restaurant in Philly" using a payment-gated Google Places API call.

## Notable Quotes
> "Pay is basically the missing payment layer for HTTP."
> "The API gets paid, the user stays in control, and the agent doesn't need to hold private keys or API secrets."

## Concepts
- [[HTTP 402]]
- [[Pay.sh]]
- [[AI Agents]]
- [[Solana]]
- [[Stablecoins]]
- [[Claude Code]]

==Pay is the missing payment layer for HTTP: instead of API keys, agents use a local wallet with Touch ID approval—the API gets paid, the user stays in control, and the agent holds no secrets.==
