#! /usr/bin/env bash

if [[ ! -d "$MY_DOTFILES/hstr" ]];then
    git clone https://github.com/dvorka/hstr "$MY_DOTFILES/hstr"
fi

_hstr_init() {
    (cd "$MY_DOTFILES/hstr" && cd ./dist && ./1-dist.sh && cd .. && ./configure && make)
}

export HH_CONFIG=hicolor
export PATH="$MY_DOTFILES/hstr/src:$PATH"
