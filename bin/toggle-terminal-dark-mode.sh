#!/bin/bash

set -e

DARK_THEME=mocha
LIGHT_THEME=latte

cd $DOTFILES

DARK_COUNT="$(ag --files-with-matches --ignore-dir=./bin --ignore-dir=tmux/plugins/catppuccin --nobreak "catppuccin.*$DARK_THEME"  | wc -l | xargs)"
LIGHT_COUNT="$(ag --files-with-matches --ignore-dir=./bin  --ignore-dir=tmux/plugins/catppuccin --nobreak "catppuccin.*$LIGHT_THEME" | wc -l | xargs)"

EXPECTED_COUNT=4

if [ $DARK_COUNT -gt 0 ]; then
  # go light
  ag --files-with-matches --ignore-dir=./bin --nobreak "catppuccin.*$DARK_THEME" | while read file; do
    gsed -i "s/$DARK_THEME/$LIGHT_THEME/" "$file"
  done
  tmux source-file ~/.tmux.conf
else
  # go dark
  ag --files-with-matches --ignore-dir=./bin --nobreak "catppuccin.*$LIGHT_THEME" | while read file; do
    gsed -i "s/$LIGHT_THEME/$DARK_THEME/" "$file"
  done
  tmux source-file ~/.tmux.conf
fi
