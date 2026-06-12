# INSIGHTS - recurring concepts, channel themes, cross-links
<!-- Knowledge that compounds across runs. Cap ~150 lines; weekly job dedupes. -->

## Recurring concepts (with running counts)
<!-- format: - [[Concept]] - count N - short gloss -->
- [[OpenAI]] - count 2 - appears in both Google IO and Musk trial videos; central node for AI industry coverage
- [[Anthropic]] - count 2 - Google's named rival; rapid product expansion: Claude Code → Opus 4.7 → Claude Design (April 2026), disrupting Figma directly
- [[Gemini]] - count 1 - Google's AI family; flagship of the agentic era strategy
- [[Agentic AI Era]] - count 3 - Google's 2026 paradigm; root cause of GitHub failures; also the demand driving personal AI assistants like OpenClaw
- [[Multimodal AI]] - count 1 - Gemini Omni as flagship natively multimodal model
- [[AI Coding IDE]] - count 1 - category shifting from code-writing to agent orchestration (Anti-gravity, Cursor, Codex)
- [[xAI]] - count 1 - Musk's AI company; Grok admitted to using OpenAI model outputs
- [[Musk vs Altman Trial]] - count 1 - defining AI governance case of 2026
- [[TPU]] - count 1 - Google's custom AI chip, now split into training and inference variants
- [[Supply Chain Attack]] - count 2 - core attack class: two variants seen: (1) malicious package injection (npm/PyPI), (2) legitimate marketplace acquisition (Flippa) — both exploit trusted update channels
- [[NPM Registry]] - count 1 - JS package distribution hub; primary surface for supply chain attacks on web developers
- [[GitHub Actions]] - count 2 - CI/CD system; root cause of TanStack worm AND a feature of GitHub whose reliability degraded in the AI coding era
- [[Trusted Publishing]] - count 1 - OIDC-based short-lived token issuance; bypassed by CI cache poisoning, not token theft
- [[pnpm]] - count 1 - npm alternative; v11 default security features (release age, exotic subdeps, approved builds)
- [[Dead Man's Switch]] - count 1 - malware tactic: nukes machine if stolen token is revoked/expires
- [[Kernel]] - count 2 - core OS layer; target of CVE-2026-31431 (AF_ALG splice bug → page cache misdirection)
- [[Privilege Rings]] - count 2 - CPU-enforced separation: Ring 0 (kernel) vs Ring 3 (user space)
- [[Virtual Memory]] - count 1 - OS abstraction giving each process a private fake address space via MMU
- [[File System]] - count 1 - maps raw disk blocks to named files/folders; uses inodes + journaling
- [[Process]] - count 1 - a running program with isolated address space and PID
- [[System Call]] - count 2 - the only Ring 3→Ring 0 gateway; Linux ~400 calls; foundation of OS security
- [[Threads]] - count 1 - lightweight execution within a process; share memory; risk race conditions
- [[Scheduler]] - count 1 - decides which process/thread runs on which CPU core (EEVDF on Linux)
- [[IPC]] - count 1 - interprocess communication: pipes, sockets, message queues
- [[AI-Assisted Vulnerability Discovery]] - count 1 - AI agents (Theory) found copy-fail kernel CVE in ~1 hr; $7M gray-market value
- [[Privilege Escalation]] - count 1 - unprivileged user→root via kernel bug; copy-fail (CVE-2026-31431) canonical 2026 example
- [[Page Cache]] - count 1 - kernel RAM cache for file data; copy-fail redirected writes here to corrupt su binary
- [[AF_ALG]] - count 1 - Linux kernel crypto socket interface; splice bug was root cause of copy-fail exploit
- [[Solana]] - count 3 - high-throughput blockchain; $1T volume 2025; primary platform for DeFi and on-chain app development via Anchor; escrow is the canonical intermediate dev exercise
- [[DeFi]] - count 1 - on-chain permissionless finance; Yakovenko predicts DeFi/TradFi convergence within 10 years
- [[GitHub]] - count 1 - central code hosting platform; triple crisis week of April 23–28 2026: merge queue failure, botnet DDoS, RCE disclosure
- [[Git]] - count 1 - distributed VCS; foundation of GitHub; 2026 RCE allowed git push to execute arbitrary code on GitHub servers
- [[Remote Code Execution]] - count 1 - critical vuln class (CVSS 9–10); GitHub disclosed RCE same day CTO posted reliability apology
- [[Merge Queue]] - count 1 - GitHub feature; silently unmerged 2,092 PRs across 658 repos on April 23 2026
- [[Botnet]] - count 1 - DDoS tool; took down GitHub Elasticsearch search via botnet attack, April 27 2026
- [[Enshittification]] - count 1 - platform decay pattern; GitHub improved post-2018 then declined; Mitchell Hashimoto exodus as signal
- [[Uptime]] - count 1 - GitHub ~86% in April 2026 per third-party monitoring; own status page claimed >99%
- [[Anchor Framework]] - count 2 - standard Solana smart contract dev toolkit; Anchor CLI sets up workspace, handles boilerplate; tested with LiteSVM for fast iteration
- [[CRUD]] - count 1 - create/read/update/delete; canonical on-chain data management pattern in Solana development
- [[Smart Contract]] - count 2 - blockchain program executing autonomously; called "programs" on Solana; also used for attacker-controlled C&C domain resolution (Ethereum) in WordPress attack
- [[OpenClaw]] - count 1 - open-source personal AI assistant by Peter Steinberger; self-hosted, voice-clonable, Telegram-integrated
- [[Claude Design]] - count 1 - Anthropic's AI UI/UX tool; generates interactive prototypes from Figma files; caused Figma stock to drop 7%
- [[Opus 4.7]] - count 1 - Anthropic flagship model (April 2026); 3.75 MP vision, 87.6% SWE-bench; powers Claude Design
- [[Voice Cloning]] - count 1 - AI voice synthesis from samples; enables autonomous agents to respond in the owner's voice
- [[ElevenLabs]] - count 1 - leading voice cloning API; used in OpenClaw pipeline to produce voice memos
- [[Google Stitch]] - count 1 - Google's AI UI design tool; faster than Claude Design but weaker on interactivity and animations
- [[Figma]] - count 1 - dominant UI design tool; stock dropped 7% on Claude Design announcement
- [[WordPress]] - count 1 - world's most popular CMS (~43% of all websites); 96% of vulnerabilities from plugin architecture; targeted by acquisition-based supply chain attack 2026
- [[WordPress Plugin Architecture]] - count 1 - PHP plugins run with full server privileges and zero isolation; root cause of 96% of WordPress CVEs; Cloudflare "m-" project proposes capability-binding model as fix
- [[Command and Control]] - count 1 - malware C&C infrastructure; 2026 WordPress attack used Ethereum smart contract for resilient C&C domain resolution, defeating standard domain-seizure takedowns
- [[Escrow Program]] - count 1 - fundamental blockchain primitive: holds assets in trust until condition met, then auto-releases; core logic for DEXs, NFT markets, freelance platforms
- [[DEX]] - count 1 - decentralized exchange running as smart contracts; uses escrow logic for atomic trustless token swaps
- [[LiteSVM]] - count 1 - lightweight in-process Solana VM for testing Anchor programs; replaces slow local validator with near-instant test loop

## Channel themes
<!-- format: - <channel>: <theme summary> -->
- The Code Report (Fireship): Sardonic developer-news commentary covering AI industry, security, and CS fundamentals. Two registers: (1) genuine factual reporting on real events/products, (2) humorous framing and nicknames ("mini shai hulud" for npm worm, "trust me bro benchmarks") that signal skepticism without invalidating the underlying data. Videos range 5-11 minutes; audience is developers. Eight videos reviewed to date.

## Cross-links discovered
<!-- format: - [[A]] relates to [[B]] - why -->
- [[OpenAI]] ↔ [[Anthropic]] — both named as rivals Google must beat to own the "ambient intelligence" layer; Google's agentic strategy explicitly framed as racing against them
- [[OpenAI]] ↔ [[xAI]] — Musk founded xAI after leaving OpenAI; Grok admitted to using OpenAI outputs; competitive grievance underlies the lawsuit
- [[Musk vs Altman Trial]] ↔ [[Nonprofit-to-For-Profit Conversion]] — the conversion is the entire legal dispute; these concepts should always co-appear
- [[Gemini]] ↔ [[Agentic AI Era]] — Gemini is the vehicle; the "agentic era" is the strategic frame Google wrapped around it at I/O 2026
- [[AI Coding IDE]] ↔ [[Agentic AI Era]] — Anti-gravity IDE's pivot from code-writing to agent management is a direct product expression of the agentic era trend
- [[World Model]] ↔ [[Gemini Omni]] — Demis Hassabis explicitly frames Omni as a world model; these concepts are tightly coupled in Google's 2026 narrative
- [[Supply Chain Attack]] ↔ [[NPM Registry]] — npm's scale makes it the primary JS supply chain attack surface; registry is both delivery mechanism and target
- [[GitHub Actions]] ↔ [[Supply Chain Attack]] — pull_request_target misconfiguration is a canonical CI/CD attack vector; directly enabled the TanStack worm
- [[Trusted Publishing]] ↔ [[GitHub Actions]] — Trusted Publishing relies on GitHub OIDC; the 2026 attack bypassed it not by stealing tokens but by poisoning the Actions cache tokens flow through after issuance
- [[Virtual Memory]] ↔ [[Privilege Rings]] ↔ [[Process]] — the three pillars of OS isolation: rings separate kernel/user, virtual memory isolates address spaces, processes are the unit of containment
- [[Kernel]] ↔ [[System Call]] — system calls are the sole controlled bridge from user-space to kernel; their existence is the main reason modern computers are secure
- [[Threads]] ↔ [[Scheduler]] — threads are what the scheduler actually multiplexes; thread proliferation directly increases scheduling complexity
- [[File System]] ↔ [[Inode]] — inodes are the core data structure of the file system; understanding inodes explains hard links, rename-without-copy, and directory structure
- [[AI-Assisted Vulnerability Discovery]] ↔ [[Kernel]] — AI agents now surface kernel CVEs worth millions in ~1 hour; the discovery/weaponization timeline has collapsed from months to hours
- [[Privilege Escalation]] ↔ [[AF_ALG]] ↔ [[Page Cache]] — the copy-fail (CVE-2026-31431) exploit chain: AF_ALG splice bug misdirects a 4-byte write into the page cache of the read-only su binary → instant root
- [[Solana]] ↔ [[DeFi]] — Solana is the primary execution layer for DeFi; Yakovenko's thesis: on-chain latency wins pull all finance onto the chain within 10 years
- [[AI-Assisted Vulnerability Discovery]] ↔ [[Agentic AI Era]] — automated kernel exploit discovery is the offensive mirror of the agentic era; same AI agent capabilities enabling productivity tools also enable zero-day research
- [[Agentic AI Era]] ↔ [[GitHub]] — AI agent traffic is the direct, CTO-admitted cause of GitHub's 2026 reliability failures; agentic era is hammering legacy infrastructure at unprecedented scale
- [[Remote Code Execution]] ↔ [[GitHub]] ↔ [[Git]] — April 28 2026: crafted git push triggered arbitrary code execution on GitHub servers; disclosed simultaneously with reliability apology
- [[Enshittification]] ↔ [[GitHub]] ↔ [[Agentic AI Era]] — GitHub improved post-2018 then declined sharply; agentic AI load accelerated the trajectory; Mitchell Hashimoto exodus is the canonical human-cost signal
- [[Anchor Framework]] ↔ [[Solana]] ↔ [[CRUD]] — Anchor is the standard Solana dev toolkit; CRUD app is the canonical entry exercise for on-chain development
- [[Smart Contract]] ↔ [[DeFi]] ↔ [[Solana]] — DeFi protocols are composed of smart contracts; Solana's throughput advantage applies equally to financial and CRUD-style on-chain programs
- [[Claude Design]] ↔ [[Opus 4.7]] — Claude Design is built exclusively on Opus 4.7; these always co-appear; high-res vision is what makes the design tool viable
- [[Claude Design]] ↔ [[Figma]] — Claude Design accepts Figma file imports and substitutes for Figma in the design workflow; 7% Figma stock drop signals market's read of the threat
- [[Claude Design]] ↔ [[Google Stitch]] — direct competitors in AI UI generation; Claude wins on interactivity/animations, Stitch wins on speed
- [[OpenClaw]] ↔ [[Voice Cloning]] ↔ [[ElevenLabs]] — OpenClaw pipeline: agent drafts text → ElevenLabs synthesizes in owner's cloned voice → Telegram voice memo; voice cloning closes the human-impersonation loop
- [[OpenClaw]] ↔ [[Agentic AI Era]] — OpenClaw is the consumer-tier materialization of the agentic era: a personal AI agent that acts autonomously on the owner's behalf in their own voice
- [[WordPress Plugin Architecture]] ↔ [[Supply Chain Attack]] — full-privilege plugin execution makes each third-party plugin a potential total-compromise vector; acquisition of trusted plugins bypasses all code-review defenses
- [[Command and Control]] ↔ [[Smart Contract]] — Ethereum smart contract used for C&C domain resolution in 2026 WordPress attack; immutable blockchain record defeats domain-seizure takedowns by allowing attacker to redirect C&C at will
- [[Escrow Program]] ↔ [[DEX]] ↔ [[DeFi]] — escrow is the foundational primitive for atomic trustless swaps; DEX token-swap logic IS an escrow contract; learning escrow unlocks the core of most DeFi protocols simultaneously
- [[LiteSVM]] ↔ [[Anchor Framework]] — LiteSVM is the preferred fast-iteration testing runtime for Anchor; replaces local validator with in-process Solana VM, collapsing test cycle from seconds to milliseconds
