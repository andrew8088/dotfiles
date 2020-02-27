export PATH="/Users/andrewburgess/bin:$PATH"
export DOTFILES=$HOME/bin/dotfiles

# FOR PURE PROMPT (https://github.com/sindresorhus/pure) ----------------------
fpath=( "$DOTFILES/zsh/zfunctions" $fpath )

autoload -U promptinit && promptinit
prompt pure
autoload -U colors && colors

BASE16_SHELL="$DOTFILES/zsh/base16-shell/base16-chalk.light.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

precmd() {
    source ~/bin/dotfiles/aliases
}

# VIM MODE (http://dougblack.io/words/zsh-vi-mode.html) -----------------------
#bindkey -v
bindkey '^?' backward-delete-char

function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg[yellow]%}[% NORMAL]% %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1
# END VIM MODE ----------------------------------------------------------------

eval "$(lua ~/bin/z.lua --init zsh)"
source ~/bin/dotfiles/aliases
