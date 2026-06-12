# INSIGHTS - recurring concepts, channel themes, cross-links
<!-- Knowledge that compounds across runs. Cap ~150 lines; weekly job dedupes. -->

## Recurring concepts (with running counts)
<!-- format: - [[Concept]] - count N - short gloss -->
- [[OpenAI]] - count 2 - appears in both Google IO and Musk trial videos; central node for AI industry coverage
- [[Anthropic]] - count 1 - named as Google's key rival in the "interface to reality" race
- [[Gemini]] - count 1 - Google's AI family; flagship of the agentic era strategy
- [[Agentic AI Era]] - count 1 - Google's declared 2026 paradigm: AI agents embedded in every product surface
- [[Multimodal AI]] - count 1 - Gemini Omni as flagship natively multimodal model
- [[AI Coding IDE]] - count 1 - category shifting from code-writing to agent orchestration (Anti-gravity, Cursor, Codex)
- [[xAI]] - count 1 - Musk's AI company; Grok admitted to using OpenAI model outputs
- [[Musk vs Altman Trial]] - count 1 - defining AI governance case of 2026
- [[TPU]] - count 1 - Google's custom AI chip, now split into training and inference variants
- [[Supply Chain Attack]] - count 1 - core attack class: compromise a trusted dependency to reach millions of downstream users
- [[NPM Registry]] - count 1 - JS package distribution hub; primary surface for supply chain attacks on web developers
- [[GitHub Actions]] - count 1 - CI/CD system; misconfigured pull_request_target trigger was root cause of TanStack worm
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
- [[Solana]] - count 1 - high-throughput blockchain; $1T volume 2025; Yakovenko: will become infrastructure of all finance
- [[DeFi]] - count 1 - on-chain permissionless finance; Yakovenko predicts DeFi/TradFi convergence within 10 years

## Channel themes
<!-- format: - <channel>: <theme summary> -->
- The Code Report (Fireship): Sardonic developer-news commentary covering AI industry, security, and CS fundamentals. Two registers: (1) genuine factual reporting on real events/products, (2) humorous framing and nicknames ("mini shai hulud" for npm worm, "trust me bro benchmarks") that signal skepticism without invalidating the underlying data. Videos range 5-11 minutes; audience is developers. Five videos reviewed to date.

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
