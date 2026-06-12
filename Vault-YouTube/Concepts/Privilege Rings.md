# Privilege Rings

**What it is** - Hardware-enforced protection levels built into the CPU. On x86, there are four rings (0–3), but only two are widely used: Ring 0 (kernel mode — can do anything) and Ring 3 (user mode — must request permission for hardware access).

**Why it matters** - Without this separation, any buggy or malicious program could read any other program's memory or crash the entire system. With rings, a buggy user-space program can usually only crash itself.

**Example** - When you type `printf` in C, your code runs in Ring 3. The function eventually makes a `write` system call, which switches the CPU to Ring 0 so the kernel can write to the screen, then switches back to Ring 3 when done.

## Seen in
- [[2026-05-07 - Every operating system concept in one video… [MtxP2pyCvYA]]]
- [[2026-05-04 - 732 bytes of Python just borked every Linux machine on earth… [lkifbWtxxlk]]]
