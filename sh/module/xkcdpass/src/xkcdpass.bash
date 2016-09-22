#! /usr/bin/env bash

if [[ ! -d "$MY_DOTFILES/xkcdpass" ]];then
    git clone https://github.com/danielmcgraw/xkcdpass "$MY_DOTFILES/xkcdpass"
fi

export PATH="$MY_DOTFILES/xkcdpass:$PATH"
