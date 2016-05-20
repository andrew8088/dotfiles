export PATH="/Users/andrew/bin:$PATH"
export DOTFILES=$HOME/bin/dotfiles

# FOR PURE PROMPT (https://github.com/sindresorhus/pure) ----------------------
fpath=( "$DOTFILES/zsh/zfunctions" $fpath )

autoload -U promptinit && promptinit
prompt pure

autoload -U colors && colors

BASE16_SHELL="$DOTFILES/zsh/base16-shell/base16-chalk.light.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# VIM MODE (http://dougblack.io/words/zsh-vi-mode.html) -----------------------
bindkey -v

bindkey '^?' backward-delete-char

function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg[yellow]%}[% NORMAL]% %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1

#if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# ALIASES ---------------------------------------------------------------------
alias hcat='highlight -O ansi'

alias u="npm run-script unit"
alias i="npm run-script integration"

alias vim='vim -w ~/.vimlog "$@"'
alias mvim='mvim -w ~/.vimlog "$@"'

alias ta='tmux attach -t'

alias l='ls -la'
alias sl=ls

alias gst='git status'
alias gc='git commit'
alias gco='git checkout'
alias ga='git add'

alias gl="git log --all --graph --format=format:'%C(bold blue)%h%C(reset) - %C(black)%s%C(reset) %C(bold magenta)%d%C(reset)'"
# FUNCTIONS -------------------------------------------------------------------
function take {
    mkdir $1
    cd $1
}

function unmount_all {
    diskutil list |
    grep external |
    cut -d ' ' -f 1 |
    while read file
    do
        diskutil unmountDisk "$file"
    done
}

alias unmount_all_and_exit='unmount_all && exit'

export WORKON_HOME="$HOME/.virtualenvs"
source /usr/local/bin/virtualenvwrapper.sh
