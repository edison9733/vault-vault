# Device Drivers

**What it is** - Kernel-mode code that translates generic kernel requests ("write this data") into the specific command sequences a particular piece of hardware understands. Every external device — GPU, Wi-Fi card, keyboard, webcam — gets its own driver.

**Why it matters** - Because drivers run in Ring 0, a single buggy driver can crash the entire operating system. This is the source of most Windows Blue Screens of Death and was the root cause of the 2024 Crowdstrike global outage.

**Example** - When the kernel wants to send data over Wi-Fi, it calls a generic network function. The Wi-Fi driver translates that into the exact register writes and DMA commands the specific Wi-Fi chip needs.

## Seen in
- [[2026-05-07 - Every operating system concept in one video… [MtxP2pyCvYA]]]
