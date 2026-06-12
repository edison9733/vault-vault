# Bootloader

**What it is** - A small program that runs immediately after firmware (UEFI or BIOS) and has one job: find the operating system kernel on disk and load it into RAM so the CPU can start running it.

**Why it matters** - It is the first step that turns raw hardware into a running computer. Without a bootloader, the CPU has no idea where the OS lives.

**Example** - On Linux the bootloader is GRUB (Grand Unified Bootloader); on macOS it is iBoot; on Windows it is Bootmgr. Once the bootloader hands control to the kernel, the CPU runs kernel code in Ring 0 with full hardware access.

## Seen in
- [[2026-05-07 - Every operating system concept in one video… [MtxP2pyCvYA]]]
