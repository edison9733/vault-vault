# MMU

**What it is** - The Memory Management Unit — a piece of hardware inside the CPU that translates virtual addresses (used by programs) into physical addresses (actual RAM locations) on every single memory access. It uses a data structure called a page table to do this translation.

**Why it matters** - The MMU is what makes [[Virtual Memory]] possible in hardware. Without it, every address translation would have to be done in software, which would be impossibly slow.

**Example** - The MMU also caches recent translations in a tiny structure called the TLB (Translation Lookaside Buffer) so it doesn't have to walk the full page table on every memory access.

## Seen in
- [[2026-05-07 - Every operating system concept in one video… [MtxP2pyCvYA]]]
