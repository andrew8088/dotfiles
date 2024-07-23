#!/bin/bash

set -e

DARK_THEME=mocha
LIGHT_THEME=latte

cd $DOTFILES

DARK_COUNT="$(ag --files-with-matches --ignore-dir=./bin --nobreak "catppuccin.*$DARK_THEME"  | wc -l | xargs)"
LIGHT_COUNT="$(ag --files-with-matches --ignore-dir=./bin --nobreak "catppuccin.*$LIGHT_THEME" | wc -l | xargs)"

if [ $DARK_COUNT -eq 4 ]; then
  # go light
  ag --files-with-matches --ignore-dir=./bin --nobreak "catppuccin.*$DARK_THEME" | while read file; do
    gsed -i "s/$DARK_THEME/$LIGHT_THEME/" "$file"
  done
  tmux source-file ~/.tmux.conf
elif [ $LIGHT_COUNT -eq 4 ]; then
  # go dark
  ag --files-with-matches --ignore-dir=./bin --nobreak "catppuccin.*$LIGHT_THEME" | while read file; do
    gsed -i "s/$LIGHT_THEME/$DARK_THEME/" "$file"
  done
  tmux source-file ~/.tmux.conf
else
  echo "expected 4 dark or 4 light lines, but found $DARK_COUNT dark and $LIGHT_COUNT light lines"
  exit 1
fi
