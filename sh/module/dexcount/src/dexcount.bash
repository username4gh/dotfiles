#! /usr/bin/env bash

if [[ ! -d "$MY_DOTFILES_RESOURCES/dex-method-counts" ]];then
    git clone https://github.com/mihaip/dex-method-counts "$MY_DOTFILES_RESOURCES/dex-method-counts"
fi

export PATH="$MY_DOTFILES_RESOURCES/dex-method-counts:$PATH"
