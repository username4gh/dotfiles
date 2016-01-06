#! /usr/bin/env bash

_dir_basename() {
    if [[ "$#" == 1 ]];then
        if [[ -d "$1" ]];then
            echo "${1##*/}"
        fi
    else
        echo "_dir_basename error"
    fi
}
