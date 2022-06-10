#!/usr/bin/env bash

filepath="/tmp/youtube-mode"

if [[ $(cat "$filepath") == *"1"* ]]; then
  yabai -m space code --padding abs:10:10:10:10
  yabai -m space code --gap abs:10
  defaults write NSGlobalDomain _HIHideMenuBar -bool false
  echo "0" > "$filepath"
else
  yabai -m space code --padding abs:0:0:0:0
  yabai -m space code --gap abs:0
  defaults write NSGlobalDomain _HIHideMenuBar -bool true
  echo "1" > "$filepath"
fi
