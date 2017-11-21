#! /usr/bin/env bash

_fdupes_init() {
    if [[ ! -d "$MY_DOTFILES_RESOURCES/fdupes" ]];then
        git clone https://github.com/adrianlopezroche/fdupes "$MY_DOTFILES_RESOURCES/fdupes"
    fi
}

export PATH="$PATH:$MY_DOTFILES_RESOURCES/fdupes"
