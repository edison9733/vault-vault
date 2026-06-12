---
title: "A single PR just hijacked the NPM registry..."
channel: The Code Report (Fireship)
video_url: https://youtube.com/watch?v=gwTQLZSIlsU
date: 2026-05-14
tags: [security, npm, supply-chain, open-source, github-actions]
---

## Summary
- An attacker exploited TanStack's misconfigured `pull_request_target` GitHub Actions trigger to poison the CI cache and publish malware to 84 TanStack NPM packages — without stealing any credentials.
- The worm self-replicated by scanning infected machines for NPM tokens, spreading to 373 poisoned versions across 169 packages (including PyPI) and forging commits signed by the Claude Code GitHub app to evade detection.
- pnpm 11 offers three default features that would have blocked this attack: minimum release age (24 h delay), block exotic subdependencies, and approved builds.

## Key Points

- **The attack vector — `pull_request_target`**: TanStack configured their release workflow with this GitHub Actions trigger. Unlike `pull_request`, it runs in the context of the *main repo* with main-repo permissions — even for PRs from forks. The attacker only had to *open* (then close) a PR; no merge was required.
- **[[Trusted Publishing]] bypassed without stealing tokens**: NPM's Trusted Publishing uses GitHub OIDC — GitHub signs a statement declaring which workflow, repo, and branch is running; NPM verifies it before handing over a short-lived publish token. The mechanism is sound, but the attacker never needed to steal a token — they poisoned the **CI cache** that the token later flowed through.
- **Cache poisoning chain**: The attacker's code (running via the fork PR trigger) wrote a malicious file into the shared GitHub Actions cache. Hours later, a legitimate PR merge kicked off the publish workflow, loaded the poisoned cache file, grabbed the NPM publish token, and published malware to **84 TanStack packages**.
- **Self-replicating worm**: The malware scanned for NPM publishing tokens on infected developer machines and used them to push poisoned versions of more packages. First wave: Mistral AI, UiPath, Open Search, Guardrails AI, Squawk. It then jumped to **[[PyPI]]** via Python SDKs.
- **Scale**: By the next morning, security firm Akamai tracked **373 poisoned versions across 169 packages**.
- **Evasion**: The worm began forging commits signed by the **[[Claude Code]]** GitHub app so malicious activity blended with ordinary AI-generated commits.
- **Persistence**: It embedded into Claude Code in VS Code so it survived package uninstalls. A background process checked every 60 seconds whether the stolen GitHub token was still valid.
- ==**Dead man's switch**: The moment a stolen token expires, the malware "activates war crime mode" — nuking the infected machine's root directory. Attempting to clean up the infection triggers the destructive payload.==
- **pnpm 11 defenses**: (1) *Minimum release age* — refuses packages published < 24 hours ago; (2) *Block exotic subdependencies* — rejects deps not from a proper registry; (3) *Approved builds* — blocks install scripts by default, requiring explicit whitelist.

## Notable Quotes

> "The poisoned packages were signed, verified, and shipped through NPM's trusted publishing feature, which was built primarily to prevent these kinds of attacks."

> "The moment your token expires, it activates war crime mode and nukes your root directory."

## Concepts
- [[Supply Chain Attack]]
- [[NPM Registry]]
- [[GitHub Actions]]
- [[TanStack]]
- [[Trusted Publishing]]
- [[pnpm]]
- [[Dead Man's Switch]]
- [[PyPI]]
- [[Claude Code]]
