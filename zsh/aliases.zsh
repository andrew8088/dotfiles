# ALIASES ---------------------------------------------------------------------
alias unmount_all_and_exit='unmount_all && exit'
alias d=docker
alias dc=docker-compose
alias hcat='highlight -O ansi'

alias vim='nvim -w ~/.vimlog "$@"'
alias mvim='mvim -w ~/.vimlog "$@"'

alias ta='tmux attach -t'

alias l='exa -lah'
alias ls=exa
alias sl=exa
alias c='clear'
alias s='source ~/.zshrc'
alias h=heroku
alias jj='pbpaste | jsonpp | pbcopy'
alias rm=trash
alias trim="awk '{\$1=\$1;print}'"

alias gst='test -d .git && git status || l'
alias gc='git commit'
alias gco='git checkout'
alias ga='git add'
alias gd='git diff -w'
alias gds='git diff -w --staged'
alias gpr='git remote prune origin'
alias ff='gpr && git pull --ff-only'
alias gba='git branch --all'
alias gb='git branch'
alias gbb='git-switchbranch'
alias gbf='git branch | head -1 | xargs' # top branch
alias gbd='git branch -D'
alias gcp='git cherry-pick'
alias gl="git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(white)%s%C(reset) %C(bold magenta)%d%C(reset)'"
alias gla="git log --all --graph --format=format:'%C(bold blue)%h%C(reset) - %C(white)%s%C(reset) %C(bold magenta)%d%C(reset)'"
alias git-current-branch="git branch | grep \* | cut -d ' ' -f2"
alias grd='mff && git rebase master'
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias gec='git status | grep "both modified:" | cut -d ":" -f 2 | trim | xargs nvim -'
alias gam='gc --amend -C HEAD'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias git-current-branch="git branch | grep \* | cut -d ' ' -f2"
alias grs='git restore --staged'
alias gbdd='git-branch-utils -d'
alias gbuu='git-branch-utils -u'
alias gbrr='git-branch-utils -r -b develop'
# FUNCTIONS -------------------------------------------------------------------
function gcl {
    gc -m "$(gl | head -1 | grep -o "A20-\d\d\d\d") $1"
}

function gg {
    git branch | grep "$1" | head -1 | xargs git checkout
}

function take {
    mkdir -p $1
    cd $1
}

note() {
    echo "date: $(date)" >> $HOME/drafts.txt
    echo "$@" >> $HOME/drafts.txt
    echo "" >> $HOME/drafts.txt
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

mff ()
{
    local curr_branch=`git-current-branch`
    gco master
    ff
    gco $curr_branch
}


JOBFILE="$DOTFILES/job-specific"
if [ -f "$JOBFILE" ]; then
    source "$JOBFILE"
fi

dclear () {
    docker ps -a -q | xargs docker kill -f
    docker ps -a -q | xargs docker rm -f
    docker images | grep "api\|none" | awk '{print $3}' | xargs docker rmi -f
    docker volume prune -f
}

alias docker-clear=dclear

dreset () {
    dclear
    docker images -q | xargs docker rmi -f
    docker volume rm $(docker volume ls |awk '{print $2}')
    rm -rf ~/Library/Containers/com.docker.docker/Data/*
    docker system prune -a
}
