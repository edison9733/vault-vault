---
title: "Millions of WordPress sites just got hacked... again"
channel: The Code Report (Fireship)
video_url: https://youtube.com/watch?v=piah4fV_o2Q
date: 2026-04-16
tags: [security, wordpress, supply-chain, web-development, cloudflare, php]
---

## Summary
- An attacker purchased 31 WordPress plugins on Flippa for a mid-six-figure sum, inserted a hidden backdoor, and waited 8 months before activating it — a [[Supply Chain Attack]] that arrived as a routine, trusted plugin update.
- The malware modified `wp-config.php` (database credentials, security keys) and used an Ethereum [[Smart Contract]] to dynamically reroute its [[Command and Control]] domain, making infrastructure takedowns ineffective.
- Cloudflare's "m-" project offers a sandboxed WordPress alternative built on Astro, where plugins only access capabilities they explicitly declare in a manifest — the architectural inverse of the [[WordPress Plugin Architecture]].

## Key Points

- **96% of WordPress vulnerabilities** originate in its **[[WordPress Plugin Architecture]]**: PHP scripts that execute with full server privileges and zero isolation — a plugin can access the database, files, and all sensitive site data without restriction.
- The attack began with a **legitimate marketplace acquisition**: the attacker purchased a portfolio of 31 [[WordPress]] plugins on **Flippa** (an online marketplace for websites and digital products) for an estimated mid-six-figure price, gaining ownership of the trusted update pipeline.
- ==The most dangerous aspect: the entire payload arrived through a **normal, trusted plugin update** from a recognized source — the attacker legally owned the plugins, making the attack invisible to standard code-review defenses.==
- This exploit is **remotely exploitable**: once the backdoor activated, the malware called out to a remote **[[Command and Control]]** (C&C) server, downloaded additional payloads, and compromised any site running the affected plugins without any further user interaction.
- The C&C domain was resolved via an **Ethereum [[Smart Contract]]**: when investigators identified the domain, the attacker could update the smart contract to redirect to a new domain instantly — a blockchain-based evasion technique that sidesteps the standard takedown-by-domain method.
- The **sleeper tactic**: the backdoor was inserted ~8 months before activation, remaining dormant to evade behavioral scanning tools that flag malicious activity at install time.
- Primary target: **`wp-config.php`**, which stores database connection credentials and security keys — full-site compromise in a single file modification.
- Cloudflare's **"m-" project** is a MIT-licensed, WordPress-API-compatible replacement (built on **Astro**, zero original WP code) where each plugin runs inside a **sandboxed dynamic worker**. Plugins must explicitly declare required capabilities in a manifest; the framework grants only those — the "capability binding" model directly addresses the full-privilege root cause.
- Governance context: WordPress founder **Matt Mullenweg** is simultaneously in litigation with **WP Engine** (Silver Lake private equity) over a trademark royalty dispute — an independent crisis weakening ecosystem trust.

## Notable Quotes
- "A WordPress plugin is basically just a PHP script that plugs straight into your site and starts running with full privileges. There's no sandbox or isolation."
- "Everything was delivered through a normal plugin update from a trusted source. So, it bypassed the usual suspicion of a normal phishing attack."

## Concepts
- [[WordPress]]
- [[WordPress Plugin Architecture]]
- [[Supply Chain Attack]]
- [[Command and Control]]
- [[Smart Contract]]
- [[PHP]]
- [[Cloudflare]]
- [[Astro]]
- [[Flippa]]
