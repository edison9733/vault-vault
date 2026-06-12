#!/bin/bash
for n in twitter twitter-consolidate; do
  launchctl bootout gui/$(id -u)/com.vault.$n 2>/dev/null
  launchctl bootstrap gui/$(id -u) "/Users/apple/Library/LaunchAgents/com.vault.$n.plist" && echo "ON: $n"
done
echo "Twitter: hourly at :25 | Consolidation: Sundays 04:20"
