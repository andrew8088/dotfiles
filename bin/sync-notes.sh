#! /bin/bash

# Usage via cron:
#
# */5 * * * * NOTES_DIR=/path/to/notes /path/to/sync-notes.sh >> /tmp/sync-notes.log 2>&1

set -ex

if [[ -z "$NOTES_DIR" ]]; then
    echo "NOTES_DIR is not set"
    exit 1
fi

cd "$NOTES_DIR"

git pull --ff-only
git add .
git commit -m "$(date '+%F %T')" | tee >(cat)
git push
