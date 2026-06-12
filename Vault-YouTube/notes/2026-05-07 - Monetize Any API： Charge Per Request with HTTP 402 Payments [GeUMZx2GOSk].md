---
title: "Monetize Any API: Charge Per Request with HTTP 402 Payments"
channel: Bree (Solana Developer)
video_url: https://youtube.com/watch?v=GeUMZx2GOSk
date: 2026-05-07
tags: [solana, http402, api-monetization, pay-server, web3]
---

## Summary
- Pay (pay.sh) is a tool that lets API providers monetize endpoints per-request using HTTP 402 without building a billing system.
- Providers define routes, prices, and routing rules in a YAML config; Pay handles the payment challenge, verification, and retry flow.
- Key features: proxy mode (forwards verified requests to upstream API), split payments (distribute revenue to multiple recipients), filtered OpenAPI docs, and Pay skills registry for AI agent discovery.

## Key Points
- **The 402 problem**: Traditional API monetization requires authentication, accounts, billing, metering, and usage enforcement. Pay replaces all of this with a single YAML config.
- **How it works**: API returns 402 → Pay CLI reads challenge → creates payment proof → retries request → gateway verifies → delivers response.
- **Provider-side setup**: `pay server scaffold` generates config; `pay server start --config config.yaml` runs the gateway.
- **Free vs paid endpoints**: Endpoints without a `metering` block in config are free; those with a price block require payment.
- **404 as allowlist**: Any endpoint not listed in config returns 404—the config acts as security allowlist.
- **Proxy mode**: Instead of `respond` routing, use `proxy` to forward verified requests to upstream API. Gateway injects upstream credentials so client never sees your API key.
- **Split payments**: One API call can distribute revenue across operator, partners, affiliates, and processors simultaneously.
- **OpenAPI integration**: Pass an OpenAPI/Google Discovery document; Pay serves a filtered version exposing only listed endpoints.
- **Skills registry**: Publish to Pay skills registry so Claude/Codex agents can discover your API without guessing URLs.
- **Sandbox flag**: Use `--sandbox` for testing with devnet SOL; no mainnet funds required.

## Notable Quotes
> "For API providers, this is the way to start monetizing endpoints directly without having to build a traditional billing stack first."

## Concepts
- [[HTTP 402]]
- [[Pay.sh]]
- [[API Monetization]]
- [[Solana]]
- [[Stablecoins]]
- [[AI Agents]]

==Pay turns HTTP 402 into a payment gateway: define your routes and prices in a YAML config, run the server, and any AI agent or CLI automatically handles the payment handshake—no billing system needed.==
