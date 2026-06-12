#!/bin/bash
for n in youtube youtube-consolidate; do
  launchctl bootout gui/$(id -u)/com.vault.$n 2>/dev/null && echo "OFF: $n"
done
