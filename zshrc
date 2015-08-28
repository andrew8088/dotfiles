export GOPATH="/Users/andrew/bin/gopath"
export PATH="/Users/andrew/bin:$GOPATH/bin:$PATH"
export DOTFILES=$HOME/bin/dotfiles
export ZSH=$DOTFILES/zsh
fpath=( "/usr/local/share/zsh/site-functions" $fpath )

autoload -U colors && colors
autoload -U promptinit && promptinit

prompt pure

alias l='ls -la'
alias sl=ls

function take {
    mkdir $1
    cd $1
}

function server() {
    if [ $1 ]
    then
        local port="$1"
    else
        local port="8088"
    fi
    open "http://localhost:$port/" && python -m SimpleHTTPServer "$port"
}

alias gst='git status'
alias gc='git commit'
alias gco='git checkout'
alias ga='git add'
alias gpdm='git push deploy master'
alias gpom='git push -u origin master'
alias gl="git log --all --graph --format=format:'%C(bold blue)%h%C(reset) - %C(white)%s%C(reset) %C(bold yellow)%d%C(reset)'"

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

alias hcat='highlight -O ansi'

alias u="npm run-script unit"
alias i="npm run-script integration"

alias vim='vim -w ~/.vimlog "$@"'
alias mvim='mvim -w ~/.vimlog "$@"'

for config ($ZSH/**/*.zsh) source $config

BASE16_SHELL="$ZSH/base16-shell/base16-tomorrow.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
