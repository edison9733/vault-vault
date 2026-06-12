#!/bin/bash
for n in youtube youtube-consolidate; do
  launchctl bootout gui/$(id -u)/com.vault.$n 2>/dev/null
  launchctl bootstrap gui/$(id -u) "/Users/apple/Library/LaunchAgents/com.vault.$n.plist" && echo "ON: $n"
done
echo "YouTube: hourly at :05 | Consolidation: Sundays 04:00"
