#! /usr/bin/env bash

_fdupes_init() {
    if [[ ! -d "$MY_DOTFILES_RESOURCES/fdupes" ]];then
        git clone --depth 1 https://github.com/adrianlopezroche/fdupes "$MY_DOTFILES_RESOURCES/fdupes"
    fi
}

export PATH="$PATH:$MY_DOTFILES_RESOURCES/fdupes"
