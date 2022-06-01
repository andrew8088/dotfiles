#!/usr/bin/env bash

echo "plugin called $NAME" >> /tmp/bar-time-plugin.log
sketchybar --set $NAME label="$(date '+%H:%M')"
