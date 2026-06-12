---
title: "Google just casually disrupted the open-source AI narrative…"
channel: The Code Report (Fireship)
video_url: https://youtube.com/watch?v=-01ZCTt-CJw
date: 2026-04-08
tags: [ai, google, open-source, llm, quantization, fireship]
---

## Summary
- Google released **Gemma 4** under the Apache 2.0 license — the first truly free and unrestricted open-source large language model from a major US tech company.
- Gemma 4's 31B parameter version matches frontier-class benchmark scores (e.g., Kimmi K 2.5 thinking) while running on a single consumer GPU, achieved via two novel techniques: **TurboQuant** and **per-layer embeddings**.
- The video argues that the real bottleneck for running LLMs locally is not compute power but **memory bandwidth (VRAM)**, and Gemma 4 is the first model to seriously attack that constraint.

## Key Points
- **[[Gemma 4]]** released under [[Apache 2.0 License]], meaning full commercial freedom — no special leverage clauses, no "research only" restrictions. Genuine open source.
- Open-source LLM landscape context:
  - **Meta Llama**: quasi-open under a special license that gives Meta leverage over any developer who starts generating revenue.
  - **OpenAI GPT-OSS**: also Apache 2.0, but larger and weaker than Gemma 4 on benchmarks.
  - **Mistral, Qwen, GLM, Kimmi, DeepSeek**: fill the gap but are Chinese-origin or European.
  - Gemma 4 is notable for being **American-made, Apache 2.0, intelligent, and tiny**.
- **Benchmark**: Gemma 4 31B scores in the same ballpark as Kimmi K 2.5 thinking. Kimmi is likely still stronger overall, but requires 600+ GB download, 256 GB RAM, and multiple H100s; Gemma 4 runs on a **single RTX 4090** with a 20 GB download at ~10 tokens/second.
- ==The real LLM bottleneck is **memory bandwidth**, not compute — every generated token forces a full read of model weights through [[VRAM]]; Gemma 4 attacks this directly through aggressive compression without sacrificing intelligence.==
- **[[TurboQuant]]**: Google's new [[Quantization]] technique in two steps:
  1. Converts model weight vectors from Cartesian (XYZ) to **polar coordinates** (radius + angle). Because angles follow predictable patterns, the model can skip standard normalization, storing information more efficiently.
  2. Applies the **Johnson-Lindenstrauss transform** to compress high-dimensional data to single sign bits (+1 or −1) while preserving the *distances* between data points — compressing data without destroying the relationships the model depends on.
- **[[Per-layer Embeddings]]** (the "E" in model names like E2B, E4B): in a standard transformer, each token gets one embedding at the start and that single representation is carried through every layer. Per-layer embeddings give **each layer its own small custom version of the token**, so the model injects information exactly when it is useful — drastically reducing the information that must be carried unnecessarily through early layers.
- Practical impressions: solid all-around model; good candidate for fine-tuning with tools like Unsloth; not yet competitive with frontier coding tools.

## Notable Quotes
> "That means free as in total freedom, not openish, not research only, not please don't make money or we'll sue you."

> "That shouldn't be possible."

## Concepts
- [[Gemma 4]]
- [[Apache 2.0 License]]
- [[Quantization]]
- [[TurboQuant]]
- [[Per-layer Embeddings]]
- [[VRAM]]
- [[AI-Assisted Vulnerability Discovery]]
