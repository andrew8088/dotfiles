#! /bin/sh

if [[ -z "$NOTES_DIR" ]]; then
    echo "NOTES_DIR is not set"
    exit 1
fi

cd "$NOTES_DIR"

git pull --ff-only

git add .obsidian*
git commit -m 'obsidian config'

git add .
git commit -m "$(date '+%F %T')"

git push
