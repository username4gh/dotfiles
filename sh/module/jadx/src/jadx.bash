#! /usr/bin/env bash

if [[ ! -d "$MY_DOTFILES_RESOURCES/jadx" ]];then
    git clone https://github.com/skylot/jadx "$MY_DOTFILES_RESOURCES/jadx"
fi

export PATH="$MY_DOTFILES_RESOURCES/jadx/build/jadx/bin:$PATH"
