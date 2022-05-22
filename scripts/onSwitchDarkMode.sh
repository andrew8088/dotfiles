#! /bin/bash

if [ $DARKMODE == 1 ]; then
  echo "$(date): going dark"
   /usr/local/bin/m wallpaper /System/Library/Desktop\ Pictures/Solid\ Colors/Black.png
else
  echo "$(date): going light"
   /usr/local/bin/m wallpaper /System/Library/Desktop\ Pictures/Solid\ Colors/Silver.png
fi
