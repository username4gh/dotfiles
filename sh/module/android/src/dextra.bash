#! /usr/bin/env bash

# http://newandroidbook.com/tools/dextra.html

_dextra_init() {
    if [[ ! -d "$MY_DOTFILES_RESOURCES/dextra" ]];then
        mkdir -p "$MY_DOTFILES_RESOURCES/dextra"
    fi

    if [[ ! -f "$MY_DOTFILES_RESOURCES/dextra/dextra" ]];then
        (cd "$MY_DOTFILES_RESOURCES/dextra/" && dl http://newandroidbook.com/tools/dextra.tar && tar xf dextra.tar)
    fi
}

export PATH="$MY_DOTFILES_RESOURCES/dextra:$PATH"
