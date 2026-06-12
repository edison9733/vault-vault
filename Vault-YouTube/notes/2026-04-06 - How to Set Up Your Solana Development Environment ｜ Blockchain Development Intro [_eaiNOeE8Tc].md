---
title: "How to Set Up Your Solana Development Environment | Blockchain Development Intro"
channel: Bree (Solana Developer)
video_url: https://youtube.com/watch?v=_eaiNOeE8Tc
date: 2026-04-06
tags: [solana, development-environment, rust, anchor, blockchain-dev]
---

## Summary
- Complete guide to setting up a Solana development environment: Rust, Solana CLI, Anchor CLI, and Surf Pool—all installed via a single curl command.
- Also covers setting up a local wallet keypair, requesting devnet SOL from the faucet, and using the Solana block explorer.
- The four required tools: Rust (language), Solana CLI (network interaction), Anchor (framework), Surf Pool (fast local test validator).

## Key Points
- **One-command install**: `curl` command from solana.com/docs installs all four tools: Rust + Cargo, Solana CLI, Anchor CLI, Surf Pool, Node.js, and Yarn.
- **Four required tools**:
  1. **Rust**: Language for Solana programs + Cargo package manager.
  2. **Solana CLI**: Create wallets, deploy programs, check balances, airdrop devnet SOL.
  3. **Anchor**: Framework that handles entry points, serialization, and security boilerplate. Most production Solana programs use Anchor.
  4. **Surf Pool**: Fast local test validator—eliminates waiting for devnet; instant transaction feedback.
- **Local wallet setup**: `solana keygen new` creates a keypair. `solana address` shows your public key. Save the seed phrase.
- **Devnet SOL faucet**: faucet.solana.com — requires GitHub login; or use `solana airdrop 2` (rate-limited).
- **Block explorer**: explorer.solana.com — shows transactions, token accounts, wallet balances; switch between mainnet, devnet, localnet.
- **Verify installation**: `solana --version`, `anchor --version`, `cargo --version`, `surf pool --version`.
- **Clusters**: Mainnet (real), Testnet (network team), Devnet (developers), Localnet (your machine).

## Concepts
- [[Solana]]
- [[Rust]]
- [[Anchor Framework]]
- [[Solana CLI]]
- [[Development Environment]]
- [[Devnet]]

==Solana's single-command installation installs Rust, Solana CLI, Anchor, and Surf Pool in one step—reducing the barrier to blockchain development setup to under a minute.==
