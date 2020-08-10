# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="$HOME/bin:$HOME/usr/local/bin:/bin:$PATH"
export DOTFILES=$HOME/bin/dotfiles
export ICLOUD_PATH="$HOME/Library/Mobile Documents/com~apple~CloudDocs/"

if test -f "$HOME/.secrets"; then
    source $HOME/.secrets
fi

if test -f "$HOME/bin/z.sh"; then
    source $HOME/bin/z.sh
fi
source $DOTFILES/zsh/history.zsh

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

# FOR PURE PROMPT (https://github.com/sindresorhus/pure) ----------------------
fpath=( "$DOTFILES/zsh/zfunctions" $fpath )

autoload -U promptinit && promptinit
#prompt pure
autoload -U colors && colors
autoload -Uz compinit && compinit

source $HOME/powerlevel10k/powerlevel10k.zsh-theme

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

precmd() {
    source $HOME/bin/dotfiles/aliases
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

#eval "$(lua ~/bin/z.lua --init zsh)"
source $HOME/bin/dotfiles/aliases

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f "$DOTFILES/p10k.zsh" ]] || source "$DOTFILES/p10k.zsh"
