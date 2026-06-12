# PyPI

**What it is** - The Python Package Index — the official public repository for Python packages. When you run `pip install some-package`, pip fetches it from PyPI. Like NPM, it is a critical piece of the open-source supply chain.

**Why it matters** - PyPI is a second major attack surface beyond npm. Because many JavaScript packages (like AI SDKs) also publish Python counterparts, a worm that starts in npm can jump to PyPI through those shared SDKs.

**Example** - In the 2026 TanStack attack, the worm spread from NPM to PyPI via the Python SDKs of companies like Mistral AI and UiPath whose npm publishing tokens had been compromised.

## Seen in
- [[2026-05-14 - A single PR just hijacked the NPM registry... [gwTQLZSIlsU]]]
