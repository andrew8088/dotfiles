#!/bin/bash

set -e

cd $DOTFILES

DARK_COUNT="$(ag --files-with-matches --ignore-dir=./bin --nobreak "catppuccin.*mocha"  | wc -l | xargs)"
LIGHT_COUNT="$(ag --files-with-matches --ignore-dir=./bin --nobreak "catppuccin.*latte" | wc -l | xargs)"

if [ $DARK_COUNT -eq 4 ]; then
  # go light
  ag --files-with-matches --ignore-dir=./bin --nobreak "catppuccin.*mocha" | while read file; do
    gsed -i 's/mocha/latte/' "$file"
  done
  tmux source-file ~/.tmux.conf
elif [ $LIGHT_COUNT -eq 4 ]; then
  # go dark
  ag --files-with-matches --ignore-dir=./bin --nobreak "catppuccin.*latte" | while read file; do
    gsed -i 's/latte/mocha/' "$file"
  done
  tmux source-file ~/.tmux.conf
else
  echo "expected 3 dark or 3 light lines, but found $DARK_COUNT dark and $LIGHT_COUNT light lines"
  exit 1
fi
