# Dead Man's Switch

**What it is** - A mechanism that triggers a destructive or irreversible action automatically *unless* something keeps happening. In security malware, it means: "if my foothold is ever removed, I will destroy the evidence (and more)."

**Why it matters** - It turns remediation into a trap. A developer trying to clean up an infection triggers the very payload they were trying to prevent.

**Example** - The 2026 TanStack worm installed a background process that checked every 60 seconds whether the stolen GitHub token was still valid. The moment the token expired (e.g., the victim revoked it or cleaned up), the malware nuked the root directory.

## Seen in
- [[2026-05-14 - A single PR just hijacked the NPM registry... [gwTQLZSIlsU]]]
