#! /usr/bin/env bash

if [[ ! -d "$MY_DOTFILES/hstr" ]];then
    git clone https://github.com/dvorka/hstr "$MY_DOTFILES/hstr"
fi

_hstr_init() {
    (pushd "$MY_DOTFILES/hstr/dist" && ./1-dist.sh && pushd .. && ./configure && make)
}

export HH_CONFIG=hicolor
export PATH="$MY_DOTFILES/hstr/src:$PATH"
