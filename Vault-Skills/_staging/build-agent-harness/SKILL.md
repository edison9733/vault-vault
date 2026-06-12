---
name: build-agent-harness
description: Use this skill whenever you need to build an AI agent harness from scratch — a loop that wraps an LLM with tool dispatch, context management, memory, and skill loading. Triggers for prompts like "build me an agent", "create an AI assistant", "make a bot that uses tools", "agent loop", or "agentic system".
---

# Build Agent Harness

An agent harness is the operational layer around an LLM: it feeds messages in, routes tool calls out, manages context, and persists memory. The model supplies intelligence; the harness gives that intelligence a place to act.

**Core principle** (from learn-claude-code, 66k stars): the loop never changes — only the mechanisms layered around it change.

## The invariant loop

```python
messages = [{"role": "user", "content": user_input}]

while True:
    response = llm.call(messages)

    if response.stop_reason != "tool_use":
        return response.text          # done

    tool_results = []
    for tool_call in response.tool_calls:
        result = dispatch(tool_call.name, tool_call.input)
        tool_results.append({"tool_use_id": tool_call.id, "content": result})

    messages.append({"role": "assistant", "content": response.content})
    messages.append({"role": "user", "content": tool_results})
    # loop
```

This loop is the whole agent. Everything else is harness.

## Step-by-step build order

**Step 1 — Core loop + tool dispatch**
- Implement the loop above.
- Define a tool registry: `{name: fn}`. `dispatch()` is just `registry[name](**args)`.
- Start with 2-3 tools (read_file, run_shell, web_search). Keep tools atomic.

**Step 2 — Permission boundaries**
- Before any destructive tool, log the action and require approval.
- Store a per-session allowlist for approved action patterns.
- Implement this *before* adding dangerous tools.

**Step 3 — Context compaction**
1. **snipCompact**: drop oldest non-system turns when approaching token limit.
2. **microCompact**: LLM-summarise oldest N turns into one summary message.
3. **autoCompact**: background LLM sweep compressing history every K turns.

**Step 4 — Memory**
1. **Context memory** (in-session): the messages array itself.
2. **Daily memory** (cross-session): JSONL file of session summaries; load on startup.
3. **Core memory** (long-term): nightly LLM pass over daily memory → distilled facts in Markdown. Hybrid keyword + vector retrieval.

**Step 5 — Subagent isolation**
- For side tasks, spawn a fresh messages array with only what the subagent needs.
- Never pass the parent's full context to a subagent (prevents noise leakage).
- Collect result, inject as a single tool result into the parent loop.

**Step 6 — Skill loading**
- Skills are Markdown instructions in `~/.claude/skills/<name>/SKILL.md`.
- On startup, scan skills directory and prepend relevant content as system message.
- Skills self-improve: after complex tasks, ask the model to review and update the skill file.

**Step 7 — Multi-channel gateway** (optional)
- Abstract input/output behind `BaseChannel.send()` / `BaseChannel.receive()`.
- Implement one channel (CLI), then add others (Telegram, Slack, Discord) as adapters.

**Step 8 — Multi-model support** (optional)
- Define a `LLMProvider` interface with `call(messages, tools) → response`.
- Implement per-provider adapters. Runtime switching requires zero agent code changes.

## Pitfalls

- **Modifying the loop for features**: never. Add mechanisms around the loop.
- **Skipping permission gates**: add them in Step 2 before dangerous tools.
- **One giant context**: implement snipCompact first; build microCompact before you need it.
- **Passing parent context to subagents**: creates noise and token waste.
- **No trajectory logging**: save real deployment sequences from day 1 as training data.

## Reference repos

| Repo | Stars | What to study |
|------|-------|--------------|
| NousResearch/hermes-agent | 191k | Closed skill-improvement loop; serverless hibernation |
| shareAI-lab/learn-claude-code | 66k | 20-lesson build order; three-layer compaction |
| zhayujie/CowAgent | 45k | Three-tier memory; channel abstraction; Skill Hub |
