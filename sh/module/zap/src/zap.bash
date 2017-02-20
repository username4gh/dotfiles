#! /usr/bin/env bash

if [[ "$(_check_os)" == 'Darwin' ]];then
    if [[ ! -d "$MY_DEPENDENCIES/zap" ]];then
        git clone https://github.com/keith/zap "$MY_DEPENDENCIES/zap"
    fi

    export PATH="$MY_DEPENDENCIES/zap:$PATH"
fi
