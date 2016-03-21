#! /usr/bin/env bash

if [[ ! -d "$MY_REPO/compleat" ]];then
    git clone 'https://github.com/mbrubeck/compleat' "$MY_REPO/compleat"
fi

if [[ "$(_check_command 'ghc')" == 0 ]];then
    echo "compleat depends on ghc, more details plz check out https://github.com/mbrubeck/compleat"
    return
fi

export PATH="$HOME/repo/compleat/dist/build/compleat:$PATH"

if [[ "$MY_CURRENT_SHELL" == 'zsh' ]];then
    autoload -Uz compinit bashcompinit
    bashcompinit
fi

source "$HOME/repo/compleat/compleat_setup"

_compleat_init() {
    (cd "$MY_REPO/compleat"
    ./Setup.lhs configure
    ./Setup.lhs build)
}
