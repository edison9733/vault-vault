---
title: How to use the Master Brain
date: 2026-06-12
tags: [guide, manual]
---

# How to use the Master Brain

One vault that sees all three brains at once. Open `~/MasterBrain` in Obsidian: YouTube notes, Twitter digests, and Skills notes all appear in ONE graph through live links — nothing is copied, nothing gets out of sync.

## What runs automatically

| When | What |
|---|---|
| Daily 07:00 | Morning briefing written to `briefings/` + top story pushed to your phone (ntfy) |
| Hourly :45 | Everything backed up to your GitHub repo (vault contents + your installed skills) |
| 1st of month 05:00 | Skill audit: weak/duplicate skills moved to quarantine (never deleted), decisions logged in Skills-Index.md |

## Daily use

**1. Phone buzzes at 7AM** with the top story. Full briefing: `briefings/2026-06-12.md` in Obsidian — top story, your videos, Twitter items, new skills/repos, and cross-vault connections.

**2. Ask cross-vault questions:**
```
cd ~/MasterBrain && claude
```
- "What do my videos AND tweets say about Solana? With a chart"
- "Did any video this week contradict the Twitter news?"
- "I want to build X — combine what my Skills notes and videos know about it"

Answers teach from fundamentals (B2 English), cite exactly which vault said what, and put charts in `charts/`.

**3. One-shot health check:**
```
~/MasterBrain/_scripts/master_status.sh
```
Links OK? Last briefing? Last backup commit? Jobs on?

## The phone setup (one time, 2 minutes)

1. Install the free **ntfy** app (App Store / Play Store)
2. In the app: Subscribe to topic → the random topic name from `_scripts/ntfy_topic.txt` (the setup printed it)
3. Test: `~/MasterBrain/_scripts/morning_briefing.sh --test-push`

The topic name is random so strangers can't guess it. Anyone WITH the name could see your briefings — keep it to yourself (and note: it's in your public repo backup, so rename it in `ntfy_topic.txt` if that bothers you).

## GitHub backup

Goes to your repo hourly when anything changed. Restore on a new Mac:
```
git clone https://github.com/edison9733/vault-vault.git ~/restore
cp -R ~/restore/Vault-YouTube ~/   # same for the others + claude-skills -> ~/.claude/skills
```
What's excluded on purpose: logs, lock files, raw session transcripts (.jsonl), archived raw tweets.
**Reminder: the repo is PUBLIC** — your interests, watchlists, notes, and learned rules are visible to anyone. Flip to private anytime: repo Settings → Danger Zone → Change visibility.

## Manual Whisper (videos with no captions)

When a video you care about has no subtitles (the log says NOSUBS):
```
~/MasterBrain/_scripts/transcribe_video.sh https://youtube.com/watch?v=XXXX
```
Downloads the audio, transcribes on your M1 (a 30-min video ≈ 3-5 min, first run installs mlx-whisper), drops the .srt into the YouTube vault — the next hourly run writes its note. Chinese audio works too.

## Twitter keyword tracking (topics, not just handles)

One-time enable: `~/MasterBrain/_scripts/add_twitter_keywords.sh`
Then add topics in `~/Vault-Twitter/_scripts/tw_keywords.txt` (e.g. `solana etf`). Tweets matching the keyword flow into the same scoring + digest pipeline.

## Mac sleep and the 7AM briefing

launchd runs missed jobs on wake — so if your Mac sleeps through 7:00, the briefing fires when you open the lid. Want it ready BEFORE you wake up? Make the Mac wake itself at 6:58 (one-time, asks your password):
```
sudo pmset repeat wakeorpoweron MTWRFSU 06:58:00
```
Undo: `sudo pmset repeat cancel`

## Switches

```
~/MasterBrain/_scripts/enable_master.sh    # ON  (briefing + backup + prune)
~/MasterBrain/_scripts/disable_master.sh   # OFF
```

## If something looks broken

1. `master_status.sh` first
2. No phone push → re-check the topic in the ntfy app matches `_scripts/ntfy_topic.txt`; test with `--test-push`
3. Backup "PUSH FAILED" in `_logs/backup.log` → `gh auth login`, then rerun `backup_to_github.sh`
4. A vault link shows MISSING → that vault was moved/renamed; rerun `setup_master.sh`
