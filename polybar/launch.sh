#!/bin/bash

# Terminate existing instances
killall -q polybar

# wait for existing instances to terminate
while pgrep -u $UID -x polybar >/dev/null; do
    sleep 1
done

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload example &
  done
else
  polybar --reload example &
fi

echo "polybar launched..."
