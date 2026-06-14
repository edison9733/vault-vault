---
name: multi-model-provider
description: Use this skill whenever you need to configure, switch, or abstract across multiple LLM model providers (OpenAI, Anthropic, Gemini, DeepSeek, Ollama, OpenRouter, etc.) in a single application. Covers unified API facades, fallback chains, provider profiles, per-agent routing, and cost optimization.
---

# Multi-Model Provider Abstraction

Build systems that work with any LLM provider behind a single interface — swappable at runtime without code changes.

## When to use this

- Your app needs to support **multiple LLM backends** (cloud APIs + local models)
- You want **automatic fallback** when one provider is down or rate-limited
- You need to **route different tasks to different models** (cheap model for exploration, powerful model for planning)
- You're building an **agent harness, chatbot, or CLI** that should work with any API key a user provides
- You want to avoid **vendor lock-in** to a single LLM provider

## Architecture pattern

```
┌─────────────────────────────┐
│     Unified Interface       │  ← same API for all providers
│  (chat_completion, stream)  │
└──────────┬──────────────────┘
           │
    ┌──────┼──────┬──────────┐
    ▼      ▼      ▼          ▼
┌──────┐ ┌──────┐ ┌──────┐ ┌────────┐
│OpenAI│ │Anthr │ │Gemini│ │ Ollama │ ...
│      │ │opic  │ │      │ │ (local)│
└──────┘ └──────┘ └──────┘ └────────┘
```

## Step-by-step build

### 1. Define a provider interface

```python
from abc import ABC, abstractmethod
from dataclasses import dataclass
from typing import Optional

@dataclass
class ModelResponse:
    content: str
    model: str
    provider: str
    usage: Optional[dict] = None

class LLMProvider(ABC):
    @abstractmethod
    def chat(self, messages: list, **kwargs) -> ModelResponse:
        """Send a chat completion and return the response."""
        pass
    
    @abstractmethod
    def stream(self, messages: list, **kwargs):
        """Stream a chat completion token by token."""
        pass
```

### 2. Implement per-provider adapters

Each provider gets its own adapter class. Keep adapters thin — they translate between your interface and the provider SDK.

```python
class OpenAIProvider(LLMProvider):
    def __init__(self, api_key: str, model: str = "gpt-4o"):
        from openai import OpenAI
        self.client = OpenAI(api_key=api_key)
        self.model = model
    
    def chat(self, messages, **kwargs):
        resp = self.client.chat.completions.create(
            model=self.model, messages=messages, **kwargs
        )
        return ModelResponse(
            content=resp.choices[0].message.content,
            model=self.model,
            provider="openai",
            usage=dict(resp.usage) if resp.usage else None,
        )

class AnthropicProvider(LLMProvider):
    def __init__(self, api_key: str, model: str = "claude-sonnet-4-20250514"):
        import anthropic
        self.client = anthropic.Anthropic(api_key=api_key)
        self.model = model
    
    def chat(self, messages, **kwargs):
        # Convert your message format to Anthropic's expected format
        resp = self.client.messages.create(
            model=self.model, messages=convert_messages(messages), **kwargs
        )
        return ModelResponse(
            content=resp.content[0].text,
            model=self.model,
            provider="anthropic",
            usage={"input_tokens": resp.usage.input_tokens, 
                   "output_tokens": resp.usage.output_tokens},
        )

class OllamaProvider(LLMProvider):
    """Local model provider — no API key needed."""
    def __init__(self, model: str = "qwen2.5-coder:7b", base_url: str = "http://localhost:11434/v1"):
        from openai import OpenAI
        self.client = OpenAI(base_url=base_url, api_key="ollama")
        self.model = model
```

### 3. Build a provider registry with fallback

```python
class ProviderRegistry:
    def __init__(self):
        self.providers: dict[str, LLMProvider] = {}
        self.fallback_chain: list[str] = []
    
    def register(self, name: str, provider: LLMProvider, primary: bool = False):
        self.providers[name] = provider
        if primary:
            self.fallback_chain.insert(0, name)
        else:
            self.fallback_chain.append(name)
    
    def chat_with_fallback(self, messages: list, **kwargs) -> ModelResponse:
        last_error = None
        for name in self.fallback_chain:
            try:
                return self.providers[name].chat(messages, **kwargs)
            except Exception as e:
                last_error = e
                continue
        raise RuntimeError(f"All providers failed. Last error: {last_error}")
```

### 4. Add per-agent routing (for multi-agent systems)

```python
# Route different agent roles to different models
agent_routes = {
    "explore": "deepseek-v4-flash",    # cheap, fast
    "plan": "gpt-4o",                  # strong reasoning
    "code": "claude-sonnet-4",         # best at coding
    "default": "gpt-4o",
}

def get_provider_for_agent(agent_role: str, registry: ProviderRegistry) -> LLMProvider:
    provider_name = agent_routes.get(agent_role, agent_routes["default"])
    return registry.providers[provider_name]
```

### 5. Configuration via environment or profiles

Store provider configs in JSON/YAML for runtime switching:

```json
{
  "providers": {
    "primary": {
      "type": "anthropic",
      "api_key_env": "ANTHROPIC_API_KEY",
      "model": "claude-sonnet-4-20250514"
    },
    "fallback": {
      "type": "openai",
      "api_key_env": "OPENAI_API_KEY", 
      "model": "gpt-4o"
    },
    "local": {
      "type": "ollama",
      "model": "qwen2.5-coder:7b",
      "base_url": "http://localhost:11434/v1"
    }
  },
  "routing": {
    "explore": "local",
    "plan": "primary",
    "code": "primary",
    "default": "fallback"
  }
}
```

## Pitfalls

1. **Message format differences** — Each provider expects different message schemas (Anthropic uses `content` as list of blocks; OpenAI uses `content` as string; Gemini uses `parts`). Build a `convert_messages()` function per provider.
2. **Tool calling varies** — Anthropic tools use `tool_use` blocks; OpenAI uses `tool_calls`; Gemini uses `functionCall`. Abstract tool handling behind a `parse_tool_calls(response)` interface.
3. **Streaming is inconsistent** — Some providers stream tokens, others stream content blocks. Normalize to a standard `TokenStream` iterable.
4. **Rate limits differ** — Track per-provider rate limits and add adaptive backoff.
5. **Model availability** — Not all models are available on all providers. Add a capability check before routing.
6. **Cost tracking** — Token pricing varies 10x+ between providers. Add usage tracking per-request for cost attribution.

## Reference repos

| Repo | Stars | Why |
|------|-------|-----|
| NousResearch/hermes-agent | 192k★ | Native multi-provider SDKs, clean provider abstraction |
| shareAI-lab/learn-claude-code | 66k★ | Minimal agent harness with provider-agnostic design |
| CherryHQ/cherry-studio | 47k★ | Unified access to frontier LLMs with 300+ assistants |
| HKUDS/nanobot | 44k★ | 20+ providers, native SDK replacement of litellm |
| Gitlawb/openclaude | 29k★ | Per-agent model routing for cost optimization |
