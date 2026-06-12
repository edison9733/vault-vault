# GitHub Actions

**What it is** - GitHub's built-in CI/CD system. You define workflows in YAML files; when certain events happen (a PR is opened, a branch is merged), GitHub runs those workflows on its servers automatically.

**Why it matters** - Workflows often hold powerful secrets (API keys, publishing tokens). Misconfiguring *which events* trigger a workflow can let untrusted code run with trusted permissions — the root cause of the 2026 TanStack attack.

**Example** - TanStack used the `pull_request_target` trigger, which runs fork PRs in the context of the *main repository*, including its secrets. An attacker opened and immediately closed a PR from a fork; this alone was enough to trigger the publishing workflow and access its credentials.

## Seen in
- [[2026-05-14 - A single PR just hijacked the NPM registry... [gwTQLZSIlsU]]]
- [[2026-04-30 - GitHub is having some major issues right now… [d53Zk28esmU]]]
