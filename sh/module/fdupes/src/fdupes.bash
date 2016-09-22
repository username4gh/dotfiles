#! /usr/bin/env bash

if [[ ! -d "$MY_DOTFILES/fdupes" ]];then
    git clone https://github.com/adrianlopezroche/fdupes "$MY_DOTFILES/fdupes"
else
    export PATH="$PATH:$MY_DOTFILES/fdupes"
fi
