#! /usr/bin/env bash

if [[ ! -d "$MY_REPO/compleat" ]];then
    git clone 'https://github.com/mbrubeck/compleat' "$MY_REPO/compleat"
fi

export PATH="$HOME/repo/compleat/dist/build/compleat:$PATH"

if [[ "$MY_CURRENT_SHELL" == 'zsh' ]];then
    autoload -Uz compinit bashcompinit
    compinit
    bashcompinit
fi


source "$HOME/repo/compleat/compleat_setup"


_compleat_init() {
    ./Setup.lhs configure
    ./Setup.lhs build
}
