---
title: "How to Build an On-Chain Voting Program | Smart Contract Tutorial on Solana"
channel: Bree (Solana Developer)
video_url: https://youtube.com/watch?v=bvk2s39OnYU
date: 2026-04-15
tags: [solana, anchor, smart-contracts, voting, blockchain-dev, pdas]
---

## Summary
- Walkthrough of building a complete on-chain voting system on Solana using Anchor, demonstrating PDAs, stateless accounts, and real-time vote tallying.
- Blockchain voting addresses the core problems of traditional elections: fraud prevention, transparency, instant results, and accessibility from anywhere.
- Uses Program Derived Addresses (PDAs) to create deterministic poll accounts and per-voter ballot accounts, preventing double voting by design.

## Key Points
- **Why blockchain for voting**: Immutable records, transparent but pseudonymous (wallet address = identity), instant tallying when voting closes, accessible globally.
- **PDAs for voting**: Each poll gets its own unique account derived from poll parameters. Each voter's ballot is derived from their wallet + poll ID. This prevents double voting architecturally.
- **Poll account structure**: `poll_name` (max 32), `poll_description` (max 280), `poll_voting_start: u64`, `poll_voting_end: u64`, `poll_option_index: u64`.
- **Time on-chain**: Uses Unix timestamps (u64) for voting windows. The contract enforces start/end times.
- **`derive(InitSpace)` + string `max_len`**: Required pattern for any string field because Solana must pre-allocate storage.
- **Option accounts**: Separate struct/account for each voting option with a `votes` counter that increments atomically on-chain.
- **Access controls**: Only authorized users can create polls; only eligible wallets can cast ballots.
- **Scalability**: Same code pattern works from Discord community polls to governance systems managing millions in treasury funds.
- **First Anchor program in series**: This voting app is the first full program written from scratch in the bootcamp.

## Concepts
- [[Solana]]
- [[Anchor Framework]]
- [[Program Derived Addresses]]
- [[On-Chain Governance]]
- [[Smart Contracts]]
- [[Blockchain Voting]]

==Blockchain voting's killer feature is immutable real-time tallying: results are available the moment the voting period closes, with every participant able to independently verify the count.==
