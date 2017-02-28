#! /usr/bin/env bash

if [[ ! -d "$MY_DOTFILES_RESOURCES/fdupes" ]];then
    git clone https://github.com/adrianlopezroche/fdupes "$MY_DOTFILES_RESOURCES/fdupes"
else
    export PATH="$PATH:$MY_DOTFILES_RESOURCES/fdupes"
fi
