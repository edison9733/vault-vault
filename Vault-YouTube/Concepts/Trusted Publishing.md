# Trusted Publishing

**What it is** - A passwordless mechanism for publishing packages to registries like NPM or PyPI. Instead of storing a long-lived secret token, the CI server (e.g. GitHub Actions) requests a short-lived token at publish time. GitHub signs an OIDC statement proving which workflow, repo, and branch is running; the registry verifies it and issues a token valid for only a few minutes.

**Why it matters** - It eliminates long-lived secrets that can be stolen. But the 2026 TanStack attack showed it can still be bypassed — not by stealing the token, but by poisoning the CI cache that the token flows through after it is issued.

**Example** - NPM's Trusted Publishing was the recommended setup for 2 years before the TanStack attack exploited a flaw upstream of the token issuance itself.

## Seen in
- [[2026-05-14 - A single PR just hijacked the NPM registry... [gwTQLZSIlsU]]]
