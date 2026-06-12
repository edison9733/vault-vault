# Remote Code Execution

**What it is** - A class of security vulnerability where an attacker can run arbitrary code on a target machine without physical access or a login. The attacker sends specially crafted input; the server processes it and executes the attacker's instructions. Often abbreviated RCE.

**Why it matters** - RCE is among the most severe vulnerability classes (commonly rated CVSS 9–10 out of 10). On a code-hosting platform like [[GitHub]], RCE means an attacker's malicious `git push` could run code inside GitHub's own infrastructure, potentially affecting all 100M+ users.

**Example** - On April 28 2026, GitHub disclosed that a crafted `git push` could trigger arbitrary code execution on GitHub servers — disclosed the same morning their CTO posted a reliability apology, compounding the crisis.

## Seen in
- [[2026-04-30 - GitHub is having some major issues right now… [d53Zk28esmU]]]
