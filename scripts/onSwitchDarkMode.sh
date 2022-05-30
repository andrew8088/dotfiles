#! /bin/bash

path=""

if [ $DARKMODE = 1 ]; then
   path="/System/Library/Desktop Pictures/Solid Colors/Black.png"
else
   path="/System/Library/Desktop Pictures/Solid Colors/Silver.png"
fi

echo "$(date): switching to $path"
osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"$path\" as POSIX file"
