#! /usr/bin/env bash

_dexcount_init() {
    if [[ ! -d "$MY_DOTFILES_RESOURCES/dex-method-counts" ]];then
        git clone --depth 1 https://github.com/mihaip/dex-method-counts "$MY_DOTFILES_RESOURCES/dex-method-counts"
    fi
}

export PATH="$MY_DOTFILES_RESOURCES/dex-method-counts:$PATH"
