#!/usr/bin/env bash

filepath="/tmp/youtube-mode"

if [[ $(cat "$filepath") == *"1"* ]]; then
  yabai -m space --padding abs:10:10:10:10
  yabai -m space --gap abs:10
  osascript -e 'tell application "System Events" to set autohide menu bar of dock preferences to false'
  echo "0" > "$filepath"
else
  yabai -m space --padding abs:0:0:0:0
  yabai -m space --gap abs:0
  osascript -e 'tell application "System Events" to set autohide menu bar of dock preferences to true'
  echo "1" > "$filepath"
fi
