# Kernel

**What it is** - The core of the operating system. It runs in Ring 0 (full hardware privileges) and is responsible for managing memory, creating processes, handling interrupts, loading device drivers, and providing system calls to user-space programs.

**Why it matters** - The kernel is the bridge between software and hardware. Every application that wants to read a file, send a network packet, or allocate memory must ask the kernel for permission via a system call.

**Example** - When the bootloader hands control to the Linux kernel, it has no files, processes, or windows yet — it must build all of those abstractions from scratch in a few seconds before spawning the first user-space process (PID1 / systemd).

## Seen in
- [[2026-05-07 - Every operating system concept in one video… [MtxP2pyCvYA]]]
- [[2026-05-04 - 732 bytes of Python just borked every Linux machine on earth… [lkifbWtxxlk]]]
