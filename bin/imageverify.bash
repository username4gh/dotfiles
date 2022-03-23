#! /usr/bin/env bash

while IFS= read -r item;
do
    if identify $item &> /dev/null;then
        echo $item
    fi
done < <(gfind . -type f)
