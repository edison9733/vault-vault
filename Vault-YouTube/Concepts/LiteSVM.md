# LiteSVM

**What it is** - A lightweight, in-process Solana virtual machine designed for testing smart contracts (programs). Instead of launching a full local Solana validator node, LiteSVM runs a minimal Solana runtime inside the same process as the test suite, making test startup nearly instant.

**Why it matters** - Testing [[Anchor Framework]] programs against a real local validator is slow: the validator must start, produce blocks, and process transactions. LiteSVM collapses this to milliseconds, letting developers iterate rapidly on program logic without waiting for block confirmation.

**Example** - An Anchor escrow program test using LiteSVM can deploy the program, call the `make_offer` and `take_offer` instructions, and assert final token balances — all in-memory, completing in milliseconds rather than seconds.

## Seen in
- [[2026-04-16 - Learn how to build an escrow program on a blockchain in the linked tutorial [x-OQJ2X5q30]]]
