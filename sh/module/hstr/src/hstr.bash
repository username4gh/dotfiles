#! /usr/bin/env bash

if [[ ! -d "$MY_DOTFILES_RESOURCES/hstr" ]];then
    git clone https://github.com/dvorka/hstr "$MY_DOTFILES_RESOURCES/hstr"
fi

_hstr_init() {
    (pushd "$MY_DOTFILES_RESOURCES/hstr/dist" && ./1-dist.sh && pushd .. && ./configure && make)
}

export HH_CONFIG=hicolor
export PATH="$MY_DOTFILES_RESOURCES/hstr/src:$PATH"
