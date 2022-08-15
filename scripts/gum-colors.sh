#!/bin/bash

for i in {0..17}
do
  gum style --foreground "$i" "color $(printf %02d $i) $(gum style --background "$i" "        ")"
done
