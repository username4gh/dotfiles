#! /usr/bin/env bash

if [[ ! -d "$MY_DOTFILES/rfc" ]];then
    git clone https://github.com/bfontaine/rfc "$MY_DOTFILES/rfc"
fi

export PATH="$MY_DOTFILES/rfc:$PATH"
