# Page Cache

**What it is** - A region of RAM that the Linux [[Kernel]] uses to store copies of file data read from disk. When a program reads a file, the kernel caches the contents in RAM so the next read is instant (no disk access needed). The kernel manages which cached pages stay in RAM and which get evicted when memory is needed.

**Why it matters** - The page cache is normally read-only for files the user cannot write to. If an attacker can trick the kernel into writing to a cached page of a protected file, they can silently modify the in-memory version of that file — bypassing filesystem permissions entirely.

**Example** - CVE-2026-31431 exploited a bug in the [[AF_ALG]] splice function that caused a 4-byte write to land inside the page cache of the read-only `su` binary. The file on disk was untouched, but the kernel's in-memory copy was corrupted, granting root to whoever ran the script.

## Seen in
- [[2026-05-04 - 732 bytes of Python just borked every Linux machine on earth… [lkifbWtxxlk]]]
