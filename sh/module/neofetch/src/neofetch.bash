#! /usr/bin/env bash

if [[ ! -d "$MY_DOTFILES/neofetch" ]];then
    git clone https://github.com/dylanaraps/neofetch "$MY_DOTFILES/neofetch"
fi

export PATH="$MY_DOTFILES/neofetch:$PATH"
