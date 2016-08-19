#! /usr/bin/env bash

if [[ "$#" == 1 ]];then
    while IFS= read -r item
    do
        if [[ ! -d "$item" ]];then
            mkdir "$item"
        fi
    done < <(cat $1)
else
    echo "Usage: command file-list-file"
fi
