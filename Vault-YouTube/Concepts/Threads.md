# Threads

**What it is** - A unit of execution within a [[Process]]. Threads in the same process share memory (heap, globals, file descriptors) but each has its own stack and program counter. Creating a thread is much cheaper than creating a full process.

**Why it matters** - Threads let a single program do multiple things at once (e.g. serve network requests while writing to disk). The danger: two threads writing to the same memory simultaneously produces *race conditions* — subtle, hard-to-reproduce bugs.

**Example** - Modern languages address race conditions differently: Go uses goroutines with channels ("don't share memory; communicate"), while Rust's borrow checker statically refuses to compile code that could cause a data race.

## Seen in
- [[2026-05-07 - Every operating system concept in one video… [MtxP2pyCvYA]]]
