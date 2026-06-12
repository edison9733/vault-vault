# Quantization

**What it is** - A model compression technique that reduces the precision of the numbers (weights) inside an AI model. Instead of storing each weight as a 32-bit or 16-bit floating-point number, quantization uses 8-bit integers or even 1-bit values — shrinking the model's size in memory significantly.

**Why it matters** - Smaller weights mean a model fits in less [[VRAM]], reducing memory bandwidth requirements and making it possible to run large models on consumer hardware. The classic trade-off is quality loss: lower precision = smaller model but weaker performance. Advanced techniques like [[TurboQuant]] aim to break this trade-off.

**Example** - A full-precision (FP16) model requires roughly 2 bytes per parameter; 4-bit quantization halves that to ~0.5 bytes, allowing a 31B model to fit in ~16 GB of VRAM instead of ~62 GB.

## Seen in
- [[2026-04-08 - Google just casually disrupted the open-source AI narrative… [-01ZCTt-CJw]]]
