# AF_ALG

**What it is** - A Linux socket interface (`AF_ALG`, address family for algorithms) that exposes [[Kernel]]-level cryptographic operations — encryption, hashing, authentication — to user-space programs. Instead of shipping crypto code in each application, programs can ask the kernel to do the crypto work via this interface.

**Why it matters** - Because AF_ALG runs in kernel space, bugs in it can have system-wide consequences. Any logic flaw that causes a write to go to the wrong memory address can corrupt kernel data structures or, as in CVE-2026-31431, overwrite the [[Page Cache]] of protected files.

**Example** - The `authencesn` (authenticated encryption with extended sequence numbers) module behind AF_ALG writes 4 scratch bytes to what it believes is a crypto output buffer. A bug in the splice path meant that buffer pointer could resolve to the page cache of a read-only file, enabling full [[Privilege Escalation]] (CVE-2026-31431).

## Seen in
- [[2026-05-04 - 732 bytes of Python just borked every Linux machine on earth… [lkifbWtxxlk]]]
