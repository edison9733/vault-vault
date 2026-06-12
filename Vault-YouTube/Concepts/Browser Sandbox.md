# Browser Sandbox

**What it is** - A security isolation layer inside web browsers that keeps JavaScript (and other web content) locked inside a restricted environment. Code running on a webpage cannot directly read your files, access other websites' data, or control your operating system — the sandbox enforces these boundaries.

**Why it matters** - The browser sandbox is one of the most important security layers protecting users, because browsers run untrusted code from any website. A "sandbox escape" vulnerability breaks that isolation: an attacker's webpage can then steal data, access other sites, or even control the underlying operating system.

**Example** - [[Claude Mythos]] found JavaScript engine bugs in every major browser that allowed a malicious webpage to escape the sandbox — one case enabled cross-site data theft, another allowed writing directly to the OS [[Kernel]] for full device control.

## Seen in
- [[2026-04-10 - Claude Mythos is too dangerous for public consumption... [d3Qq-rkp_to]]]
