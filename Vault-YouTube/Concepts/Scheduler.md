# Scheduler

**What it is** - The kernel component that decides which process (or thread) runs on which CPU core at any given moment. It rapidly switches between processes, giving each a short time slice, creating the illusion that hundreds of programs run simultaneously.

**Why it matters** - With far more processes than CPU cores, fair and efficient scheduling is what keeps every program responsive. A bad scheduler causes laggy UIs, starvation of background tasks, or wasted CPU cycles.

**Example** - Modern Linux uses EEVDF (Earliest Eligible Virtual Deadline First), which tracks how much CPU time each process has received and prioritises those that are furthest behind their fair share.

## Seen in
- [[2026-05-07 - Every operating system concept in one video… [MtxP2pyCvYA]]]
