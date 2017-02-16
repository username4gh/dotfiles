#! /usr/bin/env bash

nls() {
    if [[ "$#" == 0 ]];then
        local DIRS=( $(find . -mindepth 1 -maxdepth 1 -type d) )

        size=${#DIRS[@]}

        for ((i = 0; i < size; i++));
        do
            echo "[$i]${DIRS[$i]}"
        done
    else
        echo "nls does not support any option"
    fi
}

ncd() {
    if [[ "$1" =~ [0-9]+ ]];then
        local DIRS=( $(find . -mindepth 1 -maxdepth 1 -type d) )

        cd ${DIRS[$1]}
    else
        echo "plz enter a valid number, use nls to list all valid number"
    fi
}
