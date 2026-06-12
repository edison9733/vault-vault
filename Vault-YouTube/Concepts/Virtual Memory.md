# Virtual Memory

**What it is** - The OS trick where every address a program uses is *fake*. The program thinks it has its own private block of memory starting at address 0. In reality, the CPU's MMU silently translates each fake (virtual) address to a real (physical) RAM address on every memory access.

**Why it matters** - Each process gets its own isolated address space, so your browser cannot read your password manager's memory. Programs can also use more memory than physically exists (some pages live on disk until needed). It is the foundation of process isolation and modern security.

**Example** - When a program touches a page that is not currently in RAM, the MMU raises a *page fault*; the kernel loads that page from disk and resumes the program as if nothing happened.

## Seen in
- [[2026-05-07 - Every operating system concept in one video… [MtxP2pyCvYA]]]
