#! /usr/bin/env sh

_dir_basename() {
    if [[ "$#" == 1 ]];then
        if [[ -d "$1" ]];then
            echo "${1##*/}"
        fi
    else
        echo "_dir_basename error"
    fi
}

_dir_parentname() {
    if [[ "$#" == 1 ]];then
        if [[ -d "$1" ]];then
            echo "${1%/*}"
        fi
    else
        echo "_dir_parentname error"
    fi
}
