#! /usr/bin/env bash

if [[ ! -d "$MY_DOTFILES/jadx" ]];then
    git clone https://github.com/skylot/jadx "$MY_DOTFILES/jadx"
fi

export PATH="$MY_DOTFILES/jadx/build/jadx/bin:$PATH"
