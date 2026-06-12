# IPC

**What it is** - Interprocess Communication — mechanisms that let two separate [[Process]]es exchange data safely, without sharing memory. Common forms: pipes, sockets, and message queues.

**Why it matters** - Processes are deliberately isolated from each other (different address spaces). IPC provides safe, kernel-mediated channels so they can cooperate without breaking that isolation.

**Example** - A Unix *pipe* (invented 1973) lets you chain commands: `cat file.txt | grep "error"` creates two processes — the OS creates a pipe so the output of `cat` flows into `grep` as input, with no shared memory involved.

## Seen in
- [[2026-05-07 - Every operating system concept in one video… [MtxP2pyCvYA]]]
