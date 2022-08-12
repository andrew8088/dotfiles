ITEM_DIR="$HOME/.config/sketchybar/items" # Directory where the items are configured
PLUGIN_DIR="$HOME/.config/sketchybar/plugins" # Directory where all the plugin scripts are stored

sketchybar \
--bar \
height=50 \
y_offset=5 \
margin=5 \
blur_radius=0 \
position=top \
color=0x00000000              \
padding_left=0 \
padding_right=0 \
                              \
--default                     \
updates=when_shown            \
drawing=on                    \
label.font="SF Pro:Bold:18.0" \
label.color=0xffffffff \
label.padding_left=4 \
label.padding_right=4 \
icon.padding_left=4 \
icon.padding_right=4 \
background.drawing=off \
icon.background.drawing=off \
\
--add item current_app left \
--set current_app \
icon=􀣺 \
drawing=on \
background.drawing=on \
background.color=0xff24283b \
icon.padding_left=10 \
label.padding_right=10 \
label="macOS" \
script="$PLUGIN_DIR/current_app.sh" \
--subscribe current_app front_app_switched


source "$ITEM_DIR/time.sh"

sketchybar --update
echo "reloaded sketchybar"
