# ALIASES ---------------------------------------------------------------------
alias unmount_all_and_exit='unmount_all && exit'
alias d=docker
alias dc=docker-compose
alias dkill="pgrep \"Docker\" | xargs kill -9"
alias hcat='highlight -O ansi'

alias v='nvim -w ~/.vimlog "$@"'
alias vi='nvim -w ~/.vimlog "$@"'
alias vim='nvim -w ~/.vimlog "$@"'
alias mvim='mvim -w ~/.vimlog "$@"'

alias zn='vim $NOTES_DIR/$(date +"%Y%m%d%H%M.md")'

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

alias gst='git rev-parse --git-dir > /dev/null 2>&1 && git status || exa'
alias gc='git commit'
alias gco='git checkout'
alias ga='git add'
alias gd='git diff -w'
alias gu='git reset --soft HEAD~1'
alias gds='git diff -w --staged'
alias gpr='git remote prune origin'
alias ff='gpr && git pull --ff-only'
alias gba='git branch --all'
alias gb='git branch'
alias gbb='git-switchbranch'
alias gbf='git branch | head -1 | xargs' # top branch
alias gbd='git branch -D'
alias gcp='git cherry-pick'
alias gl=pretty_git_log
alias gla=pretty_git_log_all
#alias gl="git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(white)%s%C(reset) %C(green)%an %ar %C(reset) %C(bold magenta)%d%C(reset)'"
#alias gla="git log --all --graph --format=format:'%C(bold blue)%h%C(reset) - %C(white)%s%C(reset) %C(bold magenta)%d%C(reset)'"
alias git-current-branch="git branch | grep \* | cut -d ' ' -f2"
alias grd='git fetch origin && git rebase origin/master'
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias gec='git status | grep "both modified:" | cut -d ":" -f 2 | trim | xargs nvim -'
alias gam='gc --amend -C HEAD'

alias gp="git push -u 2>&1 | tee >(cat) | grep \"pull/new\" | awk '{print \$2}' | xargs open"
alias gpf='git push --force-with-lease'

alias git-current-branch="git branch | grep \* | cut -d ' ' -f2"
alias grs='git restore --staged'
alias gbdd='git-branch-utils -d'
alias gbuu='git-branch-utils -u'
alias gbrr='git-branch-utils -r -b develop'
alias gg='git branch | fzf | xargs git checkout'
# FUNCTIONS -------------------------------------------------------------------
# function gg {
#     git branch | grep "$1" | head -1 | xargs git checkout
# }

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


JOBFILE="$DOTFILES/job-specific.sh"
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


extract-audio-and-video () {
    ffmpeg -i "$1" -c:a copy obs-audio.aac
    ffmpeg -i "$1" -c:v copy obs-video.mp4
}

alias dp='displayplacer "id:83F2F7DC-590D-6294-B7FB-521754A2A693 res:3840x2160 hz:60 color_depth:8 scaling:off origin:(0,0) degree:0" "id:BD0804E4-6EAA-1C8D-1CFB-D6B734DE10A5 res:3840x2160 hz:60 color_depth:8 scaling:off origin:(3840,0) degree:0"'
