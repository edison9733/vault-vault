# Interrupts

**What it is** - An electrical signal from hardware that immediately stops whatever the CPU is executing and jumps to a special kernel function called an interrupt handler. This is how hardware tells the OS "something just happened."

**Why it matters** - Without interrupts, the OS would have to poll every device in a loop ("did you press a key? did you press a key?"), wasting enormous CPU time. Interrupts let the CPU do real work and only respond to hardware when there is actually something to handle.

**Example** - When you wiggle your mouse, the mouse controller fires an interrupt. The CPU pauses whatever it was doing, the kernel's interrupt handler reads the movement data and updates the cursor position, then resumes the previous work — all in microseconds.

## Seen in
- [[2026-05-07 - Every operating system concept in one video… [MtxP2pyCvYA]]]
