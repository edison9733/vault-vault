# Process

**What it is** - A running program. The kernel represents each process as an entry in the *process table*, with a unique PID (process ID), its own virtual address space ([[Page Table]]), open file descriptors, and CPU register state.

**Why it matters** - Processes are the unit of isolation in an OS. Each one lives in its own address space and must use [[System Call]]s to access shared resources. If a process crashes, only it is affected — not other processes.

**Example** - When Linux boots, the kernel creates the first user-space process, PID1 (usually systemd). Every other process on the machine is a descendant of PID1, created via the `fork` + `exec` system calls.

## Seen in
- [[2026-05-07 - Every operating system concept in one video… [MtxP2pyCvYA]]]
