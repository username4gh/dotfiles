#! /usr/bin/env bash

nlc() {
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

nlu() {
    if [[ ! "$#" -gt 0 ]];then
        local DIRS=()
        local CURRENT_FOLDER="$(pwd)"
        local MATCHING=true

        while [ "$MATCHING" = true ]; do
            if [[ "$CURRENT_FOLDER" =~ ^/$ ]]; then
                DIRS+=( / )
                MATCHING=false
            else
                DIRS+=( $CURRENT_FOLDER )
                CURRENT_FOLDER=$(dirname "$CURRENT_FOLDER")
            fi
        done

        local size=${#DIRS[@]}

        for ((i = 0; i < size; i++));
        do
            echo "[$i]${DIRS[$i]}"
        done 
    else
        echo "nlu does not support any option"
    fi
}

nud() {
    if [[ "$1" =~ [0-9]+ ]];then
        local DIRS=()
        local CURRENT_FOLDER="$(pwd)"
        local MATCHING=true

        while [ "$MATCHING" = true ]; do
            if [[ "$CURRENT_FOLDER" =~ ^/$ ]]; then
                DIRS+=( / )
                MATCHING=false
            else
                DIRS+=( $CURRENT_FOLDER )
                CURRENT_FOLDER=$(dirname "$CURRENT_FOLDER")
            fi
        done

        cd ${DIRS[$1]}
    else
        echo "plz enter a valid number, use nlu to list all valid number"
    fi
}
