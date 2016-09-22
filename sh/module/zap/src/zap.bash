#! /usr/bin/env bash

if [[ "$(_check_os)" == 'Darwin' ]];then
    if [[ ! -d "$MY_DOTFILES/zap" ]];then
        git clone https://github.com/keith/zap "$MY_DOTFILES/zap"
    fi

    export PATH="$MY_DOTFILES/zap:$PATH"
fi
