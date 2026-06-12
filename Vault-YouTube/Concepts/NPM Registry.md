# NPM Registry

**What it is** - The public database where JavaScript/Node.js packages are published and downloaded. When you run `npm install some-package`, npm fetches it from this registry. It hosts millions of packages downloaded billions of times each week.

**Why it matters** - Because so many developers and CI pipelines pull from it automatically, a single poisoned package can spread to millions of machines very quickly.

**Example** - In the 2026 TanStack attack, a compromised publish token was used to push malware-laced versions of 84 packages to the NPM registry — all passing NPM's own Trusted Publishing verification.

## Seen in
- [[2026-05-14 - A single PR just hijacked the NPM registry... [gwTQLZSIlsU]]]
