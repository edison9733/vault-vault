# Page Table

**What it is** - A data structure maintained by the kernel that maps each virtual memory page (typically 4 KB chunk) to its corresponding physical RAM location. Each process has its own page table, giving every process a completely separate address space.

**Why it matters** - The page table is how process isolation is implemented. Because each process has its own table, one process cannot access another's memory — the kernel controls the mapping entirely.

**Example** - When the OS creates a new process, the kernel allocates a fresh page table for it. When the process exits, the kernel frees all entries. The MMU uses the currently active page table to translate every memory access at hardware speed.

## Seen in
- [[2026-05-07 - Every operating system concept in one video… [MtxP2pyCvYA]]]
