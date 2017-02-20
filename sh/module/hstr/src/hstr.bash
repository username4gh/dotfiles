#! /usr/bin/env bash

if [[ ! -d "$MY_DEPENDENCIES/hstr" ]];then
    git clone https://github.com/dvorka/hstr "$MY_DEPENDENCIES/hstr"
fi

_hstr_init() {
    (pushd "$MY_DEPENDENCIES/hstr/dist" && ./1-dist.sh && pushd .. && ./configure && make)
}

export HH_CONFIG=hicolor
export PATH="$MY_DEPENDENCIES/hstr/src:$PATH"
