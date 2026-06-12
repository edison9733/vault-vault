# WordPress Plugin Architecture

**What it is** - The system that lets third-party developers extend [[WordPress]] by writing PHP scripts (plugins) that integrate directly into the WordPress runtime. When a plugin is installed and activated, it runs with the same full server privileges as WordPress core — there is no sandboxing or isolation between plugins or between plugins and the server.

**Why it matters** - Full-privilege execution means any plugin can read the database, modify any file, or call external servers. A single compromised plugin is effectively a compromised site. This architectural decision accounts for 96% of reported WordPress vulnerabilities. Cloudflare's "m-" project proposes the fix: each plugin runs in a sandboxed worker and must declare required capabilities in a manifest before it can access anything.

**Example** - In the 2026 acquisition-based [[Supply Chain Attack]], an attacker who purchased 31 plugins inserted a backdoor that modified `wp-config.php` (database credentials, security keys). Because plugins have unrestricted access, one malicious update gave the attacker complete control over every affected site.

## Seen in
- [[2026-04-16 - Millions of WordPress sites just got hacked... again [piah4fV_o2Q]]]
