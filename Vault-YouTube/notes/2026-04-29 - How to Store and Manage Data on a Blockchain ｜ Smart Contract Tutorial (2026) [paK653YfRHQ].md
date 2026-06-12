---
title: "How to Store and Manage Data on a Blockchain | Smart Contract Tutorial (2026)"
channel: Bree (Solana Developer)
video_url: https://youtube.com/watch?v=paK653YfRHQ
date: 2026-04-29
tags: [solana, anchor, smart-contracts, crud, rust, blockchain-dev]
---

## Summary
- Full walkthrough of building a CRUD (create/read/update/delete) app on Solana using the Anchor framework.
- Key architectural concept: Solana smart contracts are stateless—all data lives in separate accounts, not in the contract itself.
- Demonstrates a journal entry app with owner (public key), title (max 50 chars), and message (max 200 chars) stored as on-chain accounts.

## Key Points
- **Solana statelessness**: Unlike Ethereum or Cosmos, Solana programs store no state internally. All state lives in **accounts** that programs can create and modify.
- **Anchor framework**: Handles entry points, serialization/deserialization, and account validation macros. You focus on logic.
- **Data structure first**: Always define the account data structure before writing instructions.
- **`#[account]` macro**: Turns a Rust struct into an on-chain account definition. Automatically handles serialization.
- **`derive(InitSpace)` macro**: Automatically calculates the space (in bytes) an account needs on-chain—no manual byte counting required.
- **Max length for strings**: Strings in Anchor must have `#[max_len(N)]` attribute because the chain needs to pre-allocate storage.
- **Rent**: Creating an account requires paying "rent"—a SOL deposit proportional to how much space you're using on-chain.
- **`init` constraint**: In `#[derive(Accounts)]`, adding `init` to an account field tells Anchor to create it fresh; `payer` specifies who pays the rent.
- **Context struct**: First parameter of every Anchor instruction is `Context<T>` where T is a struct containing all required accounts and their constraints.
- **Lifetime specifiers**: `<'info>` ensures account references stay valid for the instruction's entire execution.
- **Journal example schema**: `owner: Pubkey`, `title: String` (max 50), `message: String` (max 200).

## Concepts
- [[Solana]]
- [[Anchor Framework]]
- [[Smart Contracts]]
- [[Account Model]]
- [[Rust]]
- [[Program Derived Addresses]]

==Solana smart contracts are stateless—all data lives in accounts, not the contract itself—which requires a fundamentally different architecture than Ethereum's storage model.==
