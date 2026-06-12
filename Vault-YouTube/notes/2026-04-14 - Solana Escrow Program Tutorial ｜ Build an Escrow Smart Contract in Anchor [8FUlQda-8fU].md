---
title: "Solana Escrow Program Tutorial | Build an Escrow Smart Contract in Anchor"
channel: Bree (Solana Developer)
video_url: https://youtube.com/watch?v=8FUlQda-8fU
date: 2026-04-14
tags: [solana, anchor, smart-contracts, escrow, defi, pdas, rust]
---

## Summary
- Builds an escrow program on Solana with three instructions: make (create escrow + deposit tokens), take (counterparty accepts + swap happens), and refund (creator cancels).
- Escrows are the foundational DeFi primitive used in DEXs (token swaps), NFT marketplaces, and freelance platforms.
- Demonstrates PDAs as trustless third parties, the Anchor `derive(Accounts)` macro, and testing with Light SVM (fast local validator alternative).

## Key Points
- **Escrow as trustless third party**: Replaces banks/lawyers with code. Holds funds and releases to the correct party when conditions are met.
- **Three instructions**: `make` (initialize escrow, deposit token A, specify desired token B), `take` (counterparty sends token B, receives token A from vault), `refund` (creator cancels and reclaims deposit).
- **Escrow state account fields**: `seed: u64` (for unique PDAs per user), `maker: Pubkey`, `mint_a: Pubkey`, `mint_b: Pubkey`, `receive: u64`, `bump: u8`.
- **Always store the bump**: Best practice in Anchor programs; more efficient than recalculating.
- **`derive(InitSpace)` macro**: Automatically calculates space needed for the struct; uses discriminator of 8 bytes.
- **Custom 1-byte discriminator**: New Anchor feature overrides SHA-256 default with a compact 1-byte identifier—more efficient.
- **PDA as trustless lock**: PDAs fall off the ED25519 curve → no private key exists → only the program can sign via `signer_seeds`. Trust is entirely in code.
- **Make instruction accounts**: Needs maker (signer/payer), mint_a, mint_b, maker_ata_a, escrow (PDA with seeds: b"escrow" + maker.key + seed), vault (token account owned by escrow PDA), token_program, associated_token_program, system_program.
- **Testing with Light SVM**: Faster alternative to running a local validator; ideal for integration tests.

## Concepts
- [[Solana]]
- [[Anchor Framework]]
- [[Program Derived Addresses]]
- [[Escrow]]
- [[Decentralized Exchange]]
- [[Token Accounts]]
- [[Light SVM]]

==PDAs fall off the ED25519 curve so they have no private key—only the program can sign via signer_seeds, making code the sole trustless enforcement mechanism with no human intermediary possible.==
