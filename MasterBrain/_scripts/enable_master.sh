#!/bin/bash
for n in briefing backup prune; do
  launchctl bootout gui/$(id -u)/com.brain.$n 2>/dev/null
  launchctl bootstrap gui/$(id -u) "/Users/apple/Library/LaunchAgents/com.brain.$n.plist" && echo "ON: $n"
done
echo "Briefing: daily 07:00 | Backup: hourly :45 | Skill prune: 1st of month 05:00"
