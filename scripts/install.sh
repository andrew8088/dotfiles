#!/usr/bin/env bash
#
# bootstrap installs things.

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

set -e

echo ''

info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

link_file () {
  local src=$1 dst=$2

  local overwrite= backup= skip=
  local action=

  if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
  then

    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
    then

      local currentSrc="$(readlink $dst)"

      if [ "$currentSrc" == "$src" ]
      then

        skip=true;

      else

        user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action  < /dev/tty

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac

      fi

    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]
    then
      rm -rf "$dst"
      success "removed $dst"
    fi

    if [ "$backup" == "true" ]
    then
      mv "$dst" "${dst}.backup"
      success "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ]
    then
      success "skipped $src"
    fi
  fi

  if [ "$skip" != "true" ]  # "false" or empty
  then
    ln -s "$1" "$2"
    success "linked $1 to $2"
  fi
}


prop () {
   PROP_KEY=$1
   PROP_FILE=$2
   PROP_VALUE=$(eval echo $(cat $PROP_FILE | grep "$PROP_KEY" | cut -d'=' -f2))
   echo $PROP_VALUE
}

install_dotfiles () {
  info 'installing dotfiles'

  local overwrite_all=false backup_all=false skip_all=false

  for linkfile in $(find -H "$DOTFILES_ROOT" -maxdepth 2 -name 'links.prop' -not -path '*.git*')
  do
    cat "$linkfile" | while read line
    do
        local src=$(eval echo "$line" | cut -d '=' -f 1)
        local dst=$(eval echo "$line" | cut -d '=' -f 2)
        local dir=$(dirname $dst)

        mkdir -p "$dir"
        link_file "$src" "$dst"
    done
  done
}

install_dotfiles

source ./scripts/setup.sh
source ./scripts/install-deps.sh

echo ''
echo '  All installed!'

