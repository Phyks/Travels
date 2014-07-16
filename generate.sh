#!/bin/bash

function generate_html {
    echo "Converting $0"
    output=`echo "$0" | sed -e "s/md/html/g"`
    pandoc -s -S --toc "$0" -o "$output"
    echo "Done"
}

function append_index {
    echo "<a href=\"$0\">$0</a>" >> index_head.html
}

export -f generate_html
export -f append_index

rm index_head.html
touch index_head.html
find . -type d -not -path '*/\.*' -not -path '.' | sort | xargs -L 1 sh -c '
    append_index "$0"
'

find . -name \*.md  -exec sh -c '
    generate_html "$0"
' {} ';'

pandoc -s -S -B index_head.html index.md -o index.html
