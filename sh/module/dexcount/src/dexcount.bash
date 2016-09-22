#! /usr/bin/env bash

if [[ ! -d "$MY_DOTFILES/dex-method-counts" ]];then
    git clone https://github.com/mihaip/dex-method-counts "$MY_DOTFILES/dex-method-counts"
fi

export PATH="$MY_DOTFILES/dex-method-counts:$PATH"
