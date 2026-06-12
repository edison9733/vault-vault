# Merge Queue

**What it is** - A GitHub feature that serialises pull request merges: instead of merging PRs immediately, they enter a queue and are tested together in order before the winning batch is applied to the main branch. This prevents "merge races" where two PRs each pass tests alone but break the codebase when combined.

**Why it matters** - When the merge queue itself fails, the damage is amplified — it can silently revert already-approved PRs at scale across many repositories at once.

**Example** - On April 23 2026, GitHub's merge queue silently unmerged 2,092 pull requests across 658 repositories — the platform tasked with protecting code accidentally destroyed already-merged code in bulk.

## Seen in
- [[2026-04-30 - GitHub is having some major issues right now… [d53Zk28esmU]]]
