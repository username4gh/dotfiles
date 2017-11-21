#! /usr/bin/env bash

_neofetch_init() {
    if [[ ! -d "$MY_DOTFILES_RESOURCES/neofetch" ]];then
        git clone https://github.com/dylanaraps/neofetch "$MY_DOTFILES_RESOURCES/neofetch"
    fi
}

export PATH="$MY_DOTFILES_RESOURCES/neofetch:$PATH"
