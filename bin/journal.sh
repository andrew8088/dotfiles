#!/bin/sh

set -e

cd "$NOTES_DIR"

echo "<body>"
ag --files-with-matches "#journal" | sort | while read line
do
    echo "<article>"
    echo "<h1>$(date -jf "%Y%m%d%H%M.md" "$line" +"%A %B %d, %Y")</h1>"
    echo "<h2>$(date -jf "%Y%m%d%H%M.md" "$line" +"%H:%M")</h2>"
    cat "$line" | grep -v "#journal" | markdown
    echo "</article>"
done
echo "</body>"
