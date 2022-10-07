#!/bin/bash

set -e

SOURCE_PATH="$EPISODES_DIR"
DESTINATION_PATH="$EPISODES_BACKUP_DIR"

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

delete_cache_files() {
  info "looking for FCP cache files"

  local cacheDeleted=0

  find "$SOURCE_PATH" -iname "*Cache.fcpcache" | while read file
  do
    info "moving to trash: $file" 
    /opt/homebrew/bin/trash "$file"
    cacheDeleted=1
  done

  if [ $cacheDeleted = 1 ]
  then
    success "removed all FCP cache files"
  else
    success "no FCP cache files found"
  fi
}

perform_backup() {
  info "rsync: starting"
  rsync -avPh "$SOURCE_PATH/" "$DESTINATION_PATH"
  success "rsync: complete"
}

# CHECK VARIABLES

if [ ${SOURCE_PATH+x} ];
then
  true
else
  fail "SOURCE_PATH not set: $SOURCE_PATH"
  exit 1
fi

if [ ${DESTINATION_PATH+x} ];
then
  true
else
  fail "DESTINATION_PATH not set: $DESTINATION_PATH"
  exit 1
fi

# CHECK PATHS

if [[ -d "$SOURCE_PATH" ]]
then
  true
else 
    fail "SOURCE_PATH not found: $SOURCE_PATH"
    exit 1
fi

if [[ -d "$DESTINATION_PATH" ]]
then
  true
else 
    fail "DESTINATION_PATH  found: $DESTINATION_PATH"
    exit 1
fi

# DO BACKUP

info "backup beginning"
delete_cache_files
perform_backup
success "backup complete"
