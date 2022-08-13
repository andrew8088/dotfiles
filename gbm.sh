#! /bin/sh

# add check: is this git repo?

gum style \
  --border normal \
  --margin "1" \
  --padding "1 2" \
  --border-foreground "" "Hello, there! Welcome to $(gum style --foreground 212 'Gum')."

# command=$(gum choose rebase delete update)

# get_branches () {

#   if [ ${var+x} ]; then
#     gum choose --limit="$1" $(git branch --format="%(refname:short)")
#   else 
#     gum choose --no-limit $(git branch --format="%(refname:short)")
#   fi
# }

# get_branches | while read -r branch
# do
#   # git checkout "$branch"

#   case $command in
#     rebase)
#       # base_branch=$(get_branches 1)
#       # git fetch origin
#       # git rebase "origin/$base_branch"
#       echo "rebase is hard"
#       ;;
#     delete)
#       echo "deleting is easy"
#       ;;
#     update)
#       echo "updating is okay"
#       ;;
#   esac
# done


