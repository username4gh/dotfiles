#! /usr/bin/env bash

_enchancd_init() {
    if [[ ! -d "$MY_REPO/enhancd" ]];then
        git clone https://github.com/b4b4r07/enhancd "$MY_REPO/enhancd"
    fi
}

export ENHANCD_COMMAND=ecd
export ENHANCD_FILTER="peco"

if [[ -f "$MY_REPO/enhancd/enhancd.sh" ]];then
    source "$MY_REPO/enhancd/enhancd.sh"
fi
