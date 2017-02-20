#! /usr/bin/env bash

if [[ ! -d "$MY_DEPENDENCIES/enhancd" ]];then
    git clone https://github.com/b4b4r07/enhancd "$MY_DEPENDENCIES/enhancd"
fi

if [[ ! -d "$MY_DEPENDENCIES/fzy" ]];then
    git clone https://github.com/jhawthorn/fzy "$MY_DEPENDENCIES/fzy"
fi

export PATH="$MY_DEPENDENCIES/fzy:$PATH"

export ENHANCD_FILTER=fzy
export ENHANCD_COMMAND='ecd'

if [[ -f "$MY_DEPENDENCIES/enhancd/init.sh" ]];then
    source "$MY_DEPENDENCIES/enhancd/init.sh"
fi
