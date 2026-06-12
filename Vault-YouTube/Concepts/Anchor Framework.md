# Anchor Framework

**What it is** - A development framework for building programs (smart contracts) on the [[Solana]] blockchain. Anchor handles low-level Solana boilerplate — account validation, data serialisation, error handling — so developers focus on business logic. The `anchor` CLI initialises workspaces, builds programs, and runs tests.

**Why it matters** - Solana's native programming model in Rust is complex and error-prone. Anchor raises the abstraction level, reducing common security mistakes and making it the de facto standard starting point for most Solana application development.

**Example** - A [[CRUD]] app on Solana uses Anchor to define accounts (data structures stored on-chain) and instruction handlers (the create/read/update/delete operations), then deploys with `anchor deploy`.

## Seen in
- [[2026-04-29 - Build a CRUD app with me in the linked tutorial [zGR6WvLLo1Q]]]
- [[2026-04-16 - Learn how to build an escrow program on a blockchain in the linked tutorial [x-OQJ2X5q30]]]
