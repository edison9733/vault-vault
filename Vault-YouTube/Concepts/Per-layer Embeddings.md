# Per-layer Embeddings

**What it is** - A transformer architecture technique where each layer of the neural network gets its own small, custom version of each input token's embedding, instead of sharing one single embedding carried through all layers. In a standard transformer, a token is given one embedding at the start and the model must carry that same representation — with all its information — through every layer, even when most of it is not needed at a given depth.

**Why it matters** - Per-layer embeddings let information be injected exactly when it is useful at each layer, reducing the amount of information that must be unnecessarily propagated through early layers. This makes the model more computationally efficient and allows smaller models to reason more effectively, contributing to [[Gemma 4]]'s small size.

**Example** - Gemma 4's "E" model variants (E2B = 2B effective parameters, E4B = 4B effective parameters) use per-layer embeddings, letting them punch above their parameter count in benchmark performance.

## Seen in
- [[2026-04-08 - Google just casually disrupted the open-source AI narrative… [-01ZCTt-CJw]]]
