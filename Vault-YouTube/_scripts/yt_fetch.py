#!/usr/bin/env python3
"""
yt_fetch.py (v3) - Fetch new videos from YouTube channel RSS feeds and save
English AND Chinese subtitles as .srt into ~/Vault-YouTube/raw.

v3 changes (cost control):
- NEWEST FIRST: all new videos across all channels are sorted by publish date
  (newest first) before downloading, so the most recent content always wins.
- PER_CHANNEL_CAP (default 2): at most N new videos per channel per run.
- GLOBAL_CAP (default 8): at most N new videos total per run. Anything beyond
  the caps is left for the next hourly run (NOT marked seen), so nothing is
  lost - it just trickles in instead of exploding.
Stdlib only. Dedup via _scripts/yt_seen.txt; one download attempt per video.
"""
import os
import re
import sys
import glob
import shutil
import subprocess
import urllib.request
import xml.etree.ElementTree as ET

os.environ["PATH"] = "/opt/homebrew/bin:/usr/local/bin:" + os.environ.get("PATH", "")

VAULT = os.path.expanduser("~/Vault-YouTube")
RAW = os.path.join(VAULT, "raw")
FEEDS_FILE = os.path.join(VAULT, "_scripts", "yt_feeds.txt")
SEEN_FILE = os.path.join(VAULT, "_scripts", "yt_seen.txt")

# --- Cost-control caps (override via env if you ever want) ---
PER_CHANNEL_CAP = int(os.environ.get("YT_PER_CHANNEL_CAP", "2"))
GLOBAL_CAP = int(os.environ.get("YT_GLOBAL_CAP", "8"))

NS = {"a": "http://www.w3.org/2005/Atom",
      "yt": "http://www.youtube.com/xml/schemas/2015"}


def load_seen():
    if not os.path.exists(SEEN_FILE):
        return set()
    with open(SEEN_FILE) as f:
        return {line.strip() for line in f if line.strip()}


def mark_seen(video_id):
    with open(SEEN_FILE, "a") as f:
        f.write(video_id + "\n")


def fetch_feed(url):
    req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0"})
    with urllib.request.urlopen(req, timeout=30) as r:
        return ET.fromstring(r.read())


def srt_exists(video_id):
    return bool(glob.glob(os.path.join(RAW, f"*[[]{video_id}[]]*.srt")))


def download_subs(video_id):
    ytdlp = shutil.which("yt-dlp")
    if not ytdlp:
        print("FATAL: yt-dlp not found. Run: brew install yt-dlp", file=sys.stderr)
        sys.exit(1)
    cmd = [
        ytdlp, "--skip-download",
        "--write-subs", "--write-auto-subs",
        "--sub-langs", "en.*,zh.*",
        "--convert-subs", "srt",
        "--sleep-requests", "3", "--sleep-subtitles", "5", "--retries", "5",
        "--no-warnings",
        "-o", os.path.join(RAW, "%(upload_date>%Y-%m-%d)s - %(title).80s [%(id)s].%(ext)s"),
        f"https://www.youtube.com/watch?v={video_id}",
    ]
    subprocess.run(cmd, stdin=subprocess.DEVNULL, timeout=900)
    return srt_exists(video_id)


def fallback_transcript_api(video_id, title, date):
    cli = shutil.which("youtube_transcript_api")
    if not cli:
        return False
    try:
        out = subprocess.run(
            [cli, video_id, "--languages", "en", "zh-Hant", "zh-Hans",
             "zh-TW", "zh", "--format", "srt"],
            stdin=subprocess.DEVNULL, capture_output=True, text=True, timeout=120)
        if out.returncode == 0 and out.stdout.strip():
            safe_title = re.sub(r'[/\\:*?"<>|]', "_", title)[:80]
            path = os.path.join(RAW, f"{date} - {safe_title} [{video_id}].srt")
            with open(path, "w") as f:
                f.write(out.stdout)
            return True
    except Exception as e:
        print(f"  fallback failed for {video_id}: {e}", file=sys.stderr)
    return False


def main():
    os.makedirs(RAW, exist_ok=True)
    if not os.path.exists(FEEDS_FILE):
        print(f"FATAL: {FEEDS_FILE} not found. Add one feed URL per line.",
              file=sys.stderr)
        sys.exit(1)

    seen = load_seen()
    with open(FEEDS_FILE) as f:
        feeds = [l.strip() for l in f
                 if l.strip() and not l.strip().startswith("#")]

    # ---- Pass 1: collect ALL unseen videos across all channels ----
    candidates = []  # (published_iso, channel_idx, video_id, title, date)
    for ch_idx, feed_url in enumerate(feeds):
        try:
            root = fetch_feed(feed_url)
        except Exception as e:
            print(f"WARN: feed failed {feed_url}: {e}", file=sys.stderr)
            continue
        for entry in root.findall("a:entry", NS):
            vid_el = entry.find("yt:videoId", NS)
            if vid_el is None:
                continue
            vid = vid_el.text.strip()
            if vid in seen:
                continue
            title_el = entry.find("a:title", NS)
            pub_el = entry.find("a:published", NS)
            title = title_el.text if title_el is not None else vid
            published = pub_el.text if pub_el is not None else "0000-00-00T00:00:00"
            candidates.append((published, ch_idx, vid, title, published[:10]))

    # ---- Pass 2: newest first, apply per-channel + global caps ----
    candidates.sort(key=lambda c: c[0], reverse=True)  # ISO dates sort correctly
    per_channel = {}
    picked = []
    for published, ch_idx, vid, title, date in candidates:
        if len(picked) >= GLOBAL_CAP:
            break
        if per_channel.get(ch_idx, 0) >= PER_CHANNEL_CAP:
            continue
        per_channel[ch_idx] = per_channel.get(ch_idx, 0) + 1
        picked.append((vid, title, date))

    deferred = len(candidates) - len(picked)
    print(f"Found {len(candidates)} new video(s); fetching {len(picked)} "
          f"(newest first, caps: {PER_CHANNEL_CAP}/channel, {GLOBAL_CAP}/run); "
          f"{deferred} deferred to later runs.")

    # ---- Pass 3: download picked videos ----
    for vid, title, date in picked:
        print(f"NEW: {vid} | {date} | {title[:60]}")
        ok = False
        try:
            ok = download_subs(vid)
        except Exception as e:
            print(f"  yt-dlp error for {vid}: {e}", file=sys.stderr)
        if not ok:
            ok = fallback_transcript_api(vid, title, date)
        print(f"  -> {'OK' if ok else 'NOSUBS (marked seen, will not retry)'}")
        mark_seen(vid)
        seen.add(vid)

    print(f"Done. {len(picked)} fetched, {deferred} waiting for next run.")


if __name__ == "__main__":
    main()
