ITEM_DIR="$HOME/.config/sketchybar/items" # Directory where the items are configured
PLUGIN_DIR="$HOME/.config/sketchybar/plugins" # Directory where all the plugin scripts are stored

sketchybar --bar height=40 \
                 y_offset=5 \
                 margin=5 \
                 blur_radius=0 \
                 position=top \
                 padding_left=5 \
                 padding_right=5 \
                 color=0xff24283b              \
                                               \
       --default updates=when_shown            \
                 drawing=on                    \
                 label.font="SF Pro:Bold:15.0" \
                 label.color=0xffffffff \
                 label.padding_left=4 \
                 label.padding_right=4 \
                 icon.padding_left=4 \
                 icon.padding_right=4 \
                 background.drawing=off \
                 icon.background.drawing=off

sketchybar --add item code left \
           --set code icon=􀪂 \
                      label=Alacritty

source "$ITEM_DIR/time.sh"
echo "reloaded sketchybar"
