#! /usr/bin/env bash

# https://stackoverflow.com/questions/255414/why-doesnt-cd-work-in-a-shell-script
ncd () {
    if [[ "$1" =~ [0-9]+ ]];then
        cd "$(nlc $1)"
    else
        echo "plz enter a valid number, use nls to list all valid number"
    fi
}

