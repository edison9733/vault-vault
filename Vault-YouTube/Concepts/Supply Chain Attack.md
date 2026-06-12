# Supply Chain Attack

**What it is** - An attack that doesn't target the victim directly. Instead, it compromises a piece of software (a library, a build tool, a plugin) that the victim trusts and uses. When the victim installs or runs that software, the malware arrives automatically.

**Why it matters** - Modern software depends on thousands of open-source packages. Attacking one widely-used package can infect millions of downstream users simultaneously — no phishing or password theft required.

**Example** - In 2026, an attacker poisoned 84 TanStack NPM packages by exploiting a misconfigured GitHub Actions trigger. Any developer who ran `npm install` on those packages had their machine scanned for credentials.

## Seen in
- [[2026-05-14 - A single PR just hijacked the NPM registry... [gwTQLZSIlsU]]]
