# Privilege Escalation

**What it is** - A type of security attack where a user or program gains more permissions than they are supposed to have. "Local privilege escalation" means a regular (unprivileged) user on a machine finds a way to become an administrator (root/SYSTEM). "Remote privilege escalation" means doing this over a network without any prior access.

**Why it matters** - Most initial attacks (malware, phishing, stolen passwords) give an attacker limited access. Privilege escalation is how they turn a foothold into full control of the machine — reading all files, installing software, or pivoting to other systems.

**Example** - CVE-2026-31431 ("copy-fail") allowed any unprivileged Linux user to write 4 bytes into the in-memory copy of the `su` binary via a [[Kernel]] crypto bug ([[AF_ALG]] splice + [[Page Cache]] misdirection), instantly gaining root. A 732-byte Python script was the entire proof of concept.

## Seen in
- [[2026-05-04 - 732 bytes of Python just borked every Linux machine on earth… [lkifbWtxxlk]]]
