#!/bin/bash
for n in skills skills-consolidate; do
  launchctl bootout gui/$(id -u)/com.vault.$n 2>/dev/null && echo "OFF: $n"
done
