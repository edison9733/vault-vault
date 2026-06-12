---
title: "732 bytes of Python just borked every Linux machine on earth…"
channel: The Code Report (Fireship)
video_url: https://youtube.com/watch?v=lkifbWtxxlk
date: 2026-05-04
tags: [linux, security, cve, kernel, privilege-escalation, ai-security, fireship]
---

## Summary
- CVE-2026-31431 ("copy-fail") is a universal local [[Privilege Escalation]] flaw in the Linux [[Kernel]], rooted in commits from 2015–2017 and affecting every distro updated since.
- An AI agent from security firm Theory discovered the vulnerability, wrote a working exploit, and published a proof-of-concept in approximately one hour of scan time.
- The exploit is local-only (not remotely exploitable), but CrowdStrike confirmed active in-the-wild use and CISA has added it to the Known Exploited Vulnerabilities (KEV) list.

## Key Points
- **CVE-2026-31431 "copy-fail"**: a 100% reliable [[Privilege Escalation]] in the Linux [[Kernel]] introduced through normal-looking commits in 2015 and 2017; all distros (Debian, Arch, Red Hat, Ubuntu, SUSE, Amazon Linux) are affected if updated since 2017.
- **Exploit mechanism**: the `authencesn` (authentication encryption with extended sequence numbers) module lives behind Linux's **`AF_ALG`** socket interface, which exposes [[Kernel]] crypto algorithms to user space. Due to a bug in the `AF_ALG` **splice** function, the 4-byte scratch-data write inside `authencesn` can be redirected into the **[[Page Cache]]** of a read-only file instead of the intended crypto output buffer.
- **The target — `su`**: the exploit points that 4-byte write at the read-only `su` binary (present on every Linux distro), corrupting it in memory to grant **root access** to any unprivileged local user.
- **Not remotely exploitable**: an attacker must already have a local shell — either as a regular user or via an initial foothold (SSH, compromised app). Desktop Arch users are lower risk; unpatched Linux servers are the primary danger.
- **[[AI-Assisted Vulnerability Discovery]]**: Theory's AI agent was given a single hint prompt ("splice can deliver page cache references of read-only files to crypto TX scatter lists, go look") and found, wrote, and packaged the full exploit in ~1 hour — a task that would have sold for $10K–$7M on the gray market.
- ==**AI agents now find and weaponize kernel exploits in hours**: the discovery model has flipped — instead of human researchers taking months, a one-sentence hint lets an AI agent surface a multi-million-dollar vulnerability, compress the entire disclosure timeline, and publish the PoC for free.==
- **Status**: CrowdStrike confirmed active wild exploitation; CISA added to the KEV (Known Exploited Vulnerabilities) list. **Patch immediately** on any Linux server.

## Notable Quotes
- "A 732-byte Python script penetrated the back door and beat them all to death with a baseball bat." *(Fireship's sardonic setup for the CVE disclosure)*
- "These AI hackers are teaching us that now more than ever our AI coding agents need to be writing the best quality [code] possible."

## Concepts
- [[Kernel]]
- [[Privilege Escalation]]
- [[Page Cache]]
- [[AF_ALG]]
- [[System Call]]
- [[AI-Assisted Vulnerability Discovery]]
- [[Privilege Rings]]
