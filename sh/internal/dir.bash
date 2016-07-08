#! /usr/bin/env bash

_dir_basename() {
    if [[ "$#" == 1 ]];then
        if [[ -d "$1" ]];then
            echo "${1##*/}"
        fi
    fi
}

_dir_parentname() {
    if [[ "$#" == 1 ]];then
        if [[ -d "$1" ]];then
            echo "${1%/*}"
        fi
    fi
}
