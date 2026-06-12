# TurboQuant

**What it is** - Google's new [[Quantization]] technique released alongside [[Gemma 4]] in April 2026. It improves on standard quantization in two steps: (1) converts model weight vectors from Cartesian (XYZ) coordinates to **polar coordinates** (radius + angle) — because the angles follow predictable patterns, normalization steps can be skipped, reducing memory overhead; (2) applies the **Johnson-Lindenstrauss transform** to compress the resulting high-dimensional data to single sign bits (+1 or −1) while mathematically preserving the distances between data points.

**Why it matters** - Standard quantization trades model quality for size. TurboQuant achieves extreme compression (down to 1-bit weights) while preserving the relational structure of the data — theoretically getting smaller models without as much performance loss.

**Example** - TurboQuant is one of the two techniques behind Gemma 4's ability to match frontier-class models at a fraction of the memory footprint, alongside [[Per-layer Embeddings]].

## Seen in
- [[2026-04-08 - Google just casually disrupted the open-source AI narrative… [-01ZCTt-CJw]]]
