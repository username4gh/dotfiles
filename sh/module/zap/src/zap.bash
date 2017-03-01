#! /usr/bin/env bash

if [[ "$(_check_os)" == 'Darwin' ]];then
    if [[ ! -d "$MY_DOTFILES_RESOURCES/zap" ]];then
        git clone https://github.com/keith/zap "$MY_DOTFILES_RESOURCES/zap"
    fi

    export PATH="$MY_DOTFILES_RESOURCES/zap:$PATH"
fi
