---
name: playwright-skill
description: Use this skill whenever you need browser automation, UI testing, end-to-end testing, or web scraping with Playwright. Triggers for: "test this UI", "automate the browser", "write a Playwright test", "check if the login flow works", "screenshot this page", "check for broken links".
---

# Playwright Browser Automation Skill

Complete browser automation with Playwright. Auto-detects dev servers, writes clean test scripts to /tmp, executes via the skill runner.

## Critical Workflow

1. **Auto-detect dev servers** — run server detection first for localhost testing
2. **Write scripts to /tmp** — create test files in `/tmp`, never in the project directory
3. **Execute via the skill runner** — use `node run.js` wrapper for proper module resolution

```bash
cd $SKILL_DIR && node run.js /tmp/playwright-test-*.js
```

## Key Patterns

**Responsive design testing** — test across viewports: mobile (375x667), tablet (768x1024), desktop (1280x800)

**Login flow automation** — fill credentials, submit, assert success state; parameterise credentials via env vars

**Form filling** — locate fields by label/placeholder, fill, submit, assert redirect or confirmation

**Broken link detection** — crawl all href links, check HTTP status, report 4xx/5xx

**Screenshot capture** — `await page.screenshot({ path: '/tmp/screenshot.png', fullPage: true })`

**Custom HTTP headers** — `'X-Automated': 'playwright'` to identify automated traffic in server logs

## Important Defaults

- **Always use `headless: false`** unless the user specifically requests headless — keeps browser visible for debugging
- Use `slowMo: 50` to make actions observable when debugging
- Parameterise URLs via environment variables so scripts work across environments
- Add `await page.waitForLoadState('networkidle')` after navigation for dynamic SPAs

## Setup

```bash
# Run once from the skill directory
npm run setup
```

Source: lackeyjb/playwright-skill (2,755 stars). Reviewed 2026-06-12: browser automation for testing/QA only; no destructive ops, no exfiltration. Safe.
