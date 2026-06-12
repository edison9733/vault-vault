#!/bin/bash
for n in skills skills-consolidate; do
  launchctl bootout gui/$(id -u)/com.vault.$n 2>/dev/null
  launchctl bootstrap gui/$(id -u) "/Users/apple/Library/LaunchAgents/com.vault.$n.plist" && echo "ON: $n"
done
echo "Skills hunt: daily 08:00 | Consolidation: Sundays 04:40"
