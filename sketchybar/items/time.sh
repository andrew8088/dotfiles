#!/usr/bin/env sh

sketchybar \
\
--add   item           calendar.time right          \
--set   calendar.time  update_freq=15               \
label="start" \
drawing=on \
background.drawing=on \
background.color=0xff24283c \
label.padding_right=15 \
label.padding_left=15 \
icon.padding_left=0 \
icon.padding_right=0 \
script="$PLUGIN_DIR/time.sh" \
\
--add   item           calendar.icon right          \
--set   calendar.icon  update_freq=15               \
icon=􀐫 \
drawing=on \
background.drawing=on \
icon.padding_left=14 \
icon.font="SF Pro:Bold:18.0" \
icon.padding_right=10 \
background.color=0xff9ece6a
