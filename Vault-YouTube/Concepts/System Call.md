# System Call

**What it is** - The controlled mechanism by which a user-space program (Ring 3) requests a service from the kernel (Ring 0). The program puts arguments in specific CPU registers, executes a special instruction, and the CPU switches to Ring 0 to run kernel code, then returns.

**Why it matters** - System calls are the *only* entry point into the kernel from user space. This boundary is the main reason modern computers are secure — programs cannot directly touch hardware or other processes' memory. Linux has ~400 system calls.

**Example** - When C code calls `printf`, the C standard library internally makes a `write` system call. The developer never writes the system call manually — it is hidden inside library functions — but every I/O operation ultimately flows through one.

## Seen in
- [[2026-05-07 - Every operating system concept in one video… [MtxP2pyCvYA]]]
- [[2026-05-04 - 732 bytes of Python just borked every Linux machine on earth… [lkifbWtxxlk]]]
