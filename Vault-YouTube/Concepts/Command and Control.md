# Command and Control

**What it is** - A server (or network of servers) that malware "phones home" to after infecting a victim system. Abbreviated C&C or C2. Through this channel the attacker sends instructions to the malware and receives stolen data in return.

**Why it matters** - The C&C channel is what turns a static piece of malware into a dynamic, remotely-operable weapon. Defenders and law enforcement typically try to seize or sinkhole the C&C domain to neutralize an active campaign. Attackers therefore invest in making the C&C infrastructure resilient and hard to take down.

**Example** - In the 2026 WordPress plugin supply chain attack, the backdoor's C&C domain was resolved via an Ethereum [[Smart Contract]]. When investigators identified the domain, the attacker simply updated the smart contract to point to a new domain — a blockchain-based evasion that defeats the standard "seize the domain" takedown tactic.

## Seen in
- [[2026-04-16 - Millions of WordPress sites just got hacked... again [piah4fV_o2Q]]]
