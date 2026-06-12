# VRAM

**What it is** - Video Random Access Memory — the dedicated, high-speed memory on a graphics processing unit (GPU). When running an AI model, the model's weights must be loaded into VRAM so the GPU can access them quickly. Consumer GPUs typically have 8–24 GB of VRAM; data-center GPUs (H100) have 80 GB.

**Why it matters** - VRAM capacity and **memory bandwidth** (how fast data can move in and out of VRAM) are the primary bottlenecks for running large language models locally. Every token a model generates requires reading through all model weights in VRAM — a larger model requires more VRAM and more bandwidth, not just more compute. [[TurboQuant]] and [[Per-layer Embeddings]] both address this bottleneck directly.

**Example** - Running [[Gemma 4]] 31B requires ~20 GB VRAM (fits on an RTX 4090); running the comparable Kimmi K 2.5 thinking requires 600+ GB — necessitating multiple H100 GPUs.

## Seen in
- [[2026-04-08 - Google just casually disrupted the open-source AI narrative… [-01ZCTt-CJw]]]
