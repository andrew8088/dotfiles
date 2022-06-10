ctrl + shift + alt - y : launchctl kickstart -k "gui/${UID}/homebrew.mxcl.yabai"
ctrl + shift + alt - u : brew services restart skhd

# move windows
ctrl + shift + alt - k : yabai -m window --swap north
ctrl + shift + alt - l : yabai -m window --swap east || yabai -m window --display next && yabai -m display --focus next
ctrl + shift + alt - j : yabai -m window --swap south
ctrl + shift + alt - h : yabai -m window --swap west || yabai -m window --display prev && yabai -m display --focus prev

ctrl + alt - c : ~/.local/bin/cycle_counterclockwise.sh

# focus window
alt - k : yabai -m window --focus north
alt - l : yabai -m window --focus east
alt - j : yabai -m window --focus south
alt - h : yabai -m window --focus west

# Focus window up/down in stack
# ctrl + shift + alt - n : yabai -m window --focus stack.next
# ctrl + shift + alt - p : yabai -m window --focus stack.prev
rcmd - up: yabai -m window --focus stack.prev || yabai -m window --focus stack.last
rcmd - down: yabai -m window --focus stack.next || yabai -m window --focus stack.first

# Add the active window to the window or stack to the {direction}
# Note that this only works when the active window does *not* already belong to a stack
ctrl + shift + alt - left  : yabai -m window west --stack $(yabai -m query --windows --window | jq -r '.id')
ctrl + shift + alt - down  : yabai -m window south --stack $(yabai -m query --windows --window | jq -r '.id')
ctrl + shift + alt - up    : yabai -m window north --stack $(yabai -m query --windows --window | jq -r '.id')
ctrl + shift + alt - right : yabai -m window east --stack $(yabai -m query --windows --window | jq -r '.id')

# create desktop, move window and follow focus - uses jq for parsing json (brew install jq)
ctrl + shift + alt - d : yabai -m space --create && \
                  index="$(yabai -m query --spaces --display | jq 'map(select(."native-fullscreen" == 0))[-1].index')" && \
                  yabai -m window --space "${index}" && \
                  yabai -m space --focus "${index}"

# fast focus desktop
# ctrl + shift + alt - left : yabai -m space --focus prev
# ctrl + shift + alt - right : yabai -m space --focus next

# increase window size
ctrl + alt - a : yabai -m window --resize left:50:0
ctrl + alt - w : yabai -m window --resize top:0:50
ctrl + alt - d : yabai -m window --resize right:50:0
ctrl + alt - s : yabai -m window --resize bottom:0:50

# decrease window size
shift + alt - a : yabai -m window --resize left:-50:0
shift + alt - w : yabai -m window --resize top:0:-50
shift + alt - d : yabai -m window --resize right:-50:0
shift + alt - s : yabai -m window --resize bottom:0:-50

# toggle window zoom
alt - d : yabai -m window --toggle zoom-parent
alt - f : yabai -m window --toggle zoom-fullscreen

# toggle window split type
alt - e : yabai -m window --toggle split

lshift + lcmd + lctrl + lalt - y: "$DOTFILES/scripts/yt.sh"
lshift + lcmd + lctrl + lalt - s: osascript "$DOTFILES/scripts/slack-all-unread.applescript"

# ################################################################ #
# THE FOLLOWING IS AN EXPLANATION OF THE GRAMMAR THAT SKHD PARSES. #
# FOR SIMPLE EXAMPLE MAPPINGS LOOK FURTHER DOWN THIS FILE..        #
# ################################################################ #

# A list of all built-in modifier and literal keywords can
# be found at https://github.com/koekeishiya/skhd/issues/1
#
# A hotkey is written according to the following rules:
#
#   hotkey       = <mode> '<' <action> | <action>
#
#   mode         = 'name of mode' | <mode> ',' <mode>
#
#   action       = <keysym> '[' <proc_map_lst> ']' | <keysym> '->' '[' <proc_map_lst> ']'
#                  <keysym> ':' <command>          | <keysym> '->' ':' <command>
#                  <keysym> ';' <mode>             | <keysym> '->' ';' <mode>
#
#   keysym       = <mod> '-' <key> | <key>
#
#   mod          = 'modifier keyword' | <mod> '+' <mod>
#
#   key          = <literal> | <keycode>
#
#   literal      = 'single letter or built-in keyword'
#
#   keycode      = 'apple keyboard kVK_<Key> values (0x3C)'
#
#   proc_map_lst = * <proc_map>
#
#   proc_map     = <string> ':' <command> | <string>     '~' |
#                  '*'      ':' <command> | '*'          '~'
#
#   string       = '"' 'sequence of characters' '"'
#
#   command      = command is executed through '$SHELL -c' and
#                  follows valid shell syntax. if the $SHELL environment
#                  variable is not set, it will default to '/bin/bash'.
#                  when bash is used, the ';' delimeter can be specified
#                  to chain commands.
#
#                  to allow a command to extend into multiple lines,
#                  prepend '\' at the end of the previous line.
#
#                  an EOL character signifies the end of the bind.
#
#   ->           = keypress is not consumed by skhd
#
#   *            = matches every application not specified in <proc_map_lst>
#
#   ~            = application is unbound and keypress is forwarded per usual, when specified in a <proc_map>
#
# A mode is declared according to the following rules:
#
#   mode_decl = '::' <name> '@' ':' <command> | '::' <name> ':' <command> |
#               '::' <name> '@'               | '::' <name>
#
#   name      = desired name for this mode,
#
#   @         = capture keypresses regardless of being bound to an action
#
#   command   = command is executed through '$SHELL -c' and
#               follows valid shell syntax. if the $SHELL environment
#               variable is not set, it will default to '/bin/bash'.
#               when bash is used, the ';' delimeter can be specified
#               to chain commands.
#
#               to allow a command to extend into multiple lines,
#               prepend '\' at the end of the previous line.
#
#               an EOL character signifies the end of the bind.
