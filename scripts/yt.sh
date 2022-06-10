#!/usr/bin/env sh

if [ "$YOUTUBE_MODE" = 1 ]; then
  yabai -m space code --padding abs:10:10:10:10
  yabai -m space code --gap abs:10
  defaults write NSGlobalDomain _HIHideMenuBar -bool false
  export YOUTUBE_MODE=0
else
  yabai -m space code --padding abs:0:0:0:0
  yabai -m space code --gap abs:0
  defaults write NSGlobalDomain _HIHideMenuBar -bool true
  export YOUTUBE_MODE=1
fi
