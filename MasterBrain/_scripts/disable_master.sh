#!/bin/bash
for n in briefing backup prune; do
  launchctl bootout gui/$(id -u)/com.brain.$n 2>/dev/null && echo "OFF: $n"
done
