#!/bin/sh

set -e

if [[ -z "$NOTES_DIR" ]]; then
    echo "NOTES_DIR is not set"
    exit 1
fi

if [[ -z "$JOURNAL_DIR" ]]; then
    echo "JOURNAL_DIR is not set"
    exit 1
fi

cd "$NOTES_DIR"

html="$JOURNAL_DIR/index.html"

echo """<head>
<title>Journal</title>
<meta charset="UTF-8" />
<link rel="stylesheet" href="style.css" />
</head>
<body>
<section>""" > "$html"
ag --files-with-matches "#journal" | sort | while read line
do
    echo "<article>" >> "$html"
    echo "<h1>$(date -jf "%Y%m%d%H%M.md" "$line" +"%A %B %d, %Y")</h1>" >> "$html"
    echo "<h2>$(date -jf "%Y%m%d%H%M.md" "$line" +"%H:%M")</h2>" >> "$html"
    cat "$line" | grep -v "#journal" | markdown >> "$html"
    echo "</article>" >> "$html"
done
echo """</section>
</body>""" >> "$html"
