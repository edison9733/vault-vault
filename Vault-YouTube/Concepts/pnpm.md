# pnpm

**What it is** - An alternative JavaScript package manager to npm and Yarn. It uses a content-addressable store and hard links to save disk space and speed up installs. Version 11 (2025+) introduced three security features enabled by default.

**Why it matters** - pnpm 11's security defaults directly address supply chain attacks: (1) *minimum release age* — refuses packages published less than 24 hours ago; (2) *block exotic subdependencies* — rejects deps that point to arbitrary Git repos or S3 URLs instead of a proper registry; (3) *approved builds* — blocks all install scripts by default, requiring explicit whitelist.

**Example** - The 2026 TanStack worm would have been stopped for most users by pnpm 11's minimum release age feature, since malicious packages are typically detected and pulled within hours of publication.

## Seen in
- [[2026-05-14 - A single PR just hijacked the NPM registry... [gwTQLZSIlsU]]]
