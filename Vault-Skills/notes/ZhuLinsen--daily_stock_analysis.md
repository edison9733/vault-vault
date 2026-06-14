---
name: ZhuLinsen/daily_stock_analysis
url: https://github.com/ZhuLinsen/daily_stock_analysis
stars: 42411
forks: 40195
language: Python
category: ai-agent
date: 2026-06-14
tags:
  - stock-analysis
  - LLM
  - quantitative-finance
  - automation
  - multi-channel
---

# ZhuLinsen/daily_stock_analysis

## What it does

**Daily Stock Analysis (DSA)** is an **LLM-powered stock analysis system** for A/H/US markets. It aggregates multi-source market data (TickFlow, AkShare, Tushare, YFinance, etc.), runs AI analysis with configurable models (Gemini, Claude, OpenAI, DeepSeek, Ollama), and pushes a "decision dashboard" to 7+ notification channels (WeChat Work, Feishu, Telegram, Discord, Slack, Email). It runs on zero-cost GitHub Actions or local Docker.

==The key insight: it combines 15+ investment strategies with LLM reasoning in a fully automated, cron-driven pipeline that costs nothing to run.==

## Why it's a top example

42.4k ★ with 40k forks — one of the most-starred stock analysis tools on GitHub. It demonstrates **practical LLM integration with quantitative finance**, combining real-time market data, AI reasoning, agent-style multi-turn Q&A, and multi-channel push notifications. Its `AGENTS.md` and `SKILL.md` files show agent-native design patterns.

## Architecture patterns

- **[[LLM-reasoning-pipeline]]** — structured chain: data collection → AI analysis → report generation → push notification
- **[[multi-data-source]] aggregation** — abstract layer over 10+ market data providers with fallback/priority rules
- **[[multi-channel]] notification** — push to 7 platforms with consistent formatting
- **[[agent-strategy]] system** — 15 built-in investment strategies (MA crossover, Elliot Wave, trend, event-driven, growth, etc.) as modular skill files
- **[[cron-automation]]** — GitHub Actions scheduled workflow with zero-cost serverless execution
- **[[web-dashboard]]** — WebUI with config management, task monitoring, backtesting, portfolio tracking

## Reusable techniques

1. **GitHub Actions as free cron infrastructure** — the entire system runs on GitHub's free tier with scheduled workflows; portable template for any daily-report system
2. **Multi-model LLM routing** — supports any OpenAI-compatible API with fallback chain; configurable via environment secrets
3. **Decision dashboard format** — structured Markdown report with scoring, sentiment, risk alerts, and action signals; reusable template for any AI decision-reporting system
4. **Agent strategy pattern** — each strategy is an independent skill file with clear input/output contracts; allows hot-swappable analysis approaches
5. **CLAUDE.md + AGENTS.md + SKILL.md** — the repo ships these files, showing how to onboard AI agents to a codebase

## When I'd use this

- As the **reference architecture for building an LLM-powered daily analysis system** (stocks, news, reports)
- When designing a **multi-source data aggregation pipeline with AI reasoning**
- Studying **GitHub Actions for zero-cost automation** of scheduled AI workflows
- As a **template for multi-channel notification systems** with consistent formatting
- For understanding **agent-onboarding patterns** (CLAUDE.md / AGENTS.md / SKILL.md) in a real project
