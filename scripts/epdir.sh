#!/bin/sh

if [ ${EPISODES_DIR+x} ];
then
  true
else
  gum style --foreground 1 "EPISODES_DIR env var is not set"
  exit 1
fi

cd $EPISODES_DIR || exit 1

last_index=$(ls | grep "^\d\d\d\d" | sort -n | tail -1 | awk -F '-' '{print $1}' | sed 's/^0*//')
next_index=$(printf %04d $(($last_index + 1 )) )

next_date=$(date +%Y-%m-%d)

next_slug=$(gum input --placeholder "video slug")

next_title="$next_index-$next_date-$next_slug"

mkdir "$next_title"
cd "$next_title" || exit 1
pwd
