#! /usr/bin/env bash

_rfc_init() {
    if [[ ! -d "$MY_DOTFILES_RESOURCES/rfc" ]];then
        git clone --depth 1 https://github.com/bfontaine/rfc "$MY_DOTFILES_RESOURCES/rfc"
    fi
}

export PATH="$MY_DOTFILES_RESOURCES/rfc:$PATH"
