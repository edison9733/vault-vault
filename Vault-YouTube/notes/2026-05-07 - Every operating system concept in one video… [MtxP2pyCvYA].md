---
title: "Every operating system concept in one video…"
channel: The Code Report (Fireship)
video_url: https://youtube.com/watch?v=MtxP2pyCvYA
date: 2026-05-07
tags: [operating-systems, systems-programming, computer-science, fundamentals]
---

## Summary
- Fireship walks through all major OS concepts in ~11 minutes — from power-on to shutdown — covering bootloader, privilege rings, virtual memory, file system, device drivers, interrupts, processes, system calls, scheduler, threads, and IPC.
- Every "abstraction" an OS offers (files, processes, virtual addresses) is described as a deliberate lie the kernel tells programs to give them an isolated, manageable view of hardware.
- The full lifecycle from pressing the power button to hitting shutdown is used as a narrative spine to connect all concepts.

## Key Points

**Stage 1 — [[Bootloader]]**: Power on → CPU wakes at a hard-coded firmware address (UEFI on modern hardware, BIOS on old). Firmware's only job: find a disk, hand off to the bootloader (GRUB on Linux, iBoot on Mac, Bootmgr on Windows). Bootloader's only job: find the **[[Kernel]]** on disk, load it into RAM.

**Stage 2 — [[Privilege Rings]]**: x86 CPUs have 4 rings; only two matter. **Ring 0** = kernel, can do anything. **Ring 3** = user space, must ask permission for everything. Without this CPU-enforced boundary, any buggy program could read any other program's memory and crash the whole system.

**Stage 3 — [[Virtual Memory]]**: ==The OS's biggest lie. Every address a program uses is fake — a virtual address silently translated to a real physical address by the **[[MMU]]** (Memory Management Unit) using a **[[Page Table]]**. Each process gets its own page table, so processes live in completely isolated address spaces. The MMU caches recent translations in a **TLB** (translation lookaside buffer). A *page fault* fires when a program touches a page not in RAM; the kernel loads it from disk transparently.==

**Stage 4 — [[File System]]**: Disk is physically just numbered blocks. The file system lies about this and shows you files and folders. Files are stored as **[[Inode]]**s (index nodes) — metadata (size, permissions, timestamps) plus a pointer to actual data blocks. File *names* live in directories (which are themselves just files mapping names to inode numbers), not in the inode. Modern file systems (ext4, NTFS, APFS) use **journaling** — writing intent before data — to survive power loss without corruption.

**Stage 5 — [[Device Drivers]] & [[Interrupts]]**: Drivers are kernel-mode code translating generic kernel requests into chip-specific commands. One buggy driver can crash the whole OS (source: Crowdstrike 2024). **Interrupts** are electrical signals from hardware (keyboard, Wi-Fi, mouse) that yank the CPU out of whatever it's doing and jump to an interrupt handler. The entire machine is driven by these tiny electrical screams from hardware.

**Stage 6 — [[Process]] / PID1**: The kernel creates the first user-space process, **PID1** (systemd on Linux). A process = a running program with its own virtual address space, page table, and entry in the **process table**. PID1 is ancestor of all processes; if it dies, the kernel panics. Every new process is created via `fork` + `exec` system calls.

**Stage 7 — [[System Call]]s**: The *only* way for user-space to talk to the kernel. A process puts arguments in registers, triggers a special instruction, and the CPU switches from ring 3 back to ring 0. Linux has ~400 system calls. `printf` in C secretly makes a `write` syscall. The syscall boundary is the sole reason computers are secure.

**Stage 8 — [[Scheduler]]**: With hundreds of processes and only ~8 CPU cores, the scheduler decides who runs when. Modern Linux uses **Earliest Eligible Virtual Deadline First (EEVDF)**. Analogy: an air traffic controller deciding which airplane lands on which runway.

**Stage 9 — [[Threads]]**: A thread shares memory and file descriptors with its parent process but has its own stack and program counter — cheaper than a full process. Downside: shared memory → **race conditions**. Modern languages defend against this (Go goroutines, Rust borrow checker).

**Stage 10 — [[IPC]] (Interprocess Communication)**: Separate processes can't share memory, so they communicate via pipes (invented 1973, "still undefeated"), sockets, or message queues. A Unix pipe chains two processes so one's output becomes the other's input, with no shared memory.

**Shutdown**: PID1 sends `SIGTERM` to all processes (polite stop request). After timeout, sends `SIGKILL` (game over). File system flushes journals, drivers release hardware, kernel syncs memory to disk, interrupts disabled, CPU halts, firmware cuts power.

## Notable Quotes

> "The kernel tells the biggest lie in computing — virtual memory."

> "System calls might be the single most important API in computing that you've never actually written by hand."

> "The pipe was invented in 1973 and is still undefeated."

## Concepts
- [[Bootloader]]
- [[Kernel]]
- [[Privilege Rings]]
- [[Virtual Memory]]
- [[MMU]]
- [[Page Table]]
- [[File System]]
- [[Inode]]
- [[Device Drivers]]
- [[Interrupts]]
- [[Process]]
- [[System Call]]
- [[Scheduler]]
- [[Threads]]
- [[IPC]]
