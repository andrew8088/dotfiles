#!/usr/bin/env sh

sketchybar --add   item           calendar.time right          \
           --set   calendar.time  update_freq=15               \
                                  icon=􀐫 \
                                  label="start" \
                                  script="$PLUGIN_DIR/time.sh"
