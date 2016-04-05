#! /usr/bin/env sh

#Description current-dir file count

cfc() {
    echo "The hidden dir is ignored by default!"

    find . -maxdepth 1 -type d -not -path "./.*" |
    while read -r dir; 
    do
        count=$(find "$dir" -type f -not -path "./.*" | wc -l)
        echo "$dir:$count"
    done
}
