#!/usr/bin/env python3
"""
tw_fetch.py - Pull tweets from your self-hosted RSSHub (localhost:1200) for
each handle in _scripts/tw_handles.txt and save raw markdown into
~/Vault-Twitter/raw. Dedup via _scripts/tw_seen.txt. Stdlib only.
"""
import os
import re
import sys
import html
import hashlib
import urllib.request
import xml.etree.ElementTree as ET
from email.utils import parsedate_to_datetime

os.environ["PATH"] = "/opt/homebrew/bin:/usr/local/bin:" + os.environ.get("PATH", "")

VAULT = os.path.expanduser("~/Vault-Twitter")
RAW = os.path.join(VAULT, "raw")
HANDLES_FILE = os.path.join(VAULT, "_scripts", "tw_handles.txt")
SEEN_FILE = os.path.join(VAULT, "_scripts", "tw_seen.txt")
RSSHUB = os.environ.get("RSSHUB_URL", "http://localhost:1200")


def load_seen():
    if not os.path.exists(SEEN_FILE):
        return set()
    with open(SEEN_FILE) as f:
        return {line.strip() for line in f if line.strip()}


def mark_seen(item_id):
    with open(SEEN_FILE, "a") as f:
        f.write(item_id + "\n")


def strip_html(s):
    s = re.sub(r"<br\s*/?>", "\n", s, flags=re.I)
    s = re.sub(r"<[^>]+>", " ", s)
    s = html.unescape(s)
    return re.sub(r"[ \t]+", " ", s).strip()


def fetch_handle(handle):
    url = f"{RSSHUB}/twitter/user/{handle}"
    req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0"})
    with urllib.request.urlopen(req, timeout=60) as r:
        return ET.fromstring(r.read())


def main():
    os.makedirs(RAW, exist_ok=True)
    if not os.path.exists(HANDLES_FILE):
        print(f"FATAL: {HANDLES_FILE} not found. One handle per line, no @.",
              file=sys.stderr)
        sys.exit(1)

    seen = load_seen()
    with open(HANDLES_FILE) as f:
        handles = [l.strip().lstrip("@") for l in f
                   if l.strip() and not l.strip().startswith("#")]

    new_count = 0
    for handle in handles:
        try:
            root = fetch_handle(handle)
        except Exception as e:
            print(f"WARN: RSSHub failed for @{handle}: {e} "
                  "(is Docker/RSSHub running? cookie expired?)", file=sys.stderr)
            continue
        for item in root.findall("./channel/item"):
            link = (item.findtext("link") or "").strip()
            guid = (item.findtext("guid") or link).strip()
            if not guid:
                continue
            item_id = hashlib.sha1(guid.encode()).hexdigest()[:16]
            if item_id in seen:
                continue
            desc = strip_html(item.findtext("description") or "")
            pub_raw = item.findtext("pubDate") or ""
            try:
                date = parsedate_to_datetime(pub_raw).strftime("%Y-%m-%d")
            except Exception:
                date = "0000-00-00"
            path = os.path.join(RAW, f"{date}_{handle}_{item_id}.md")
            with open(path, "w") as f:
                f.write("---\n")
                f.write(f"handle: \"@{handle}\"\n")
                f.write(f"url: \"{link}\"\n")
                f.write(f"date: {date}\n")
                f.write("processed: false\n")
                f.write("---\n\n")
                f.write(desc + "\n")
            mark_seen(item_id)
            seen.add(item_id)
            new_count += 1
            print(f"NEW: @{handle} {date} {item_id}")
    print(f"Done. {new_count} new tweet(s) saved.")


if __name__ == "__main__":
    main()
