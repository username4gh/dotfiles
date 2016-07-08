#! /usr/bin/env bash

if [[ "$(_check_os)" == 'Darwin' ]];then
    if [[ ! -d "$MY_REPO/zap" ]];then
        git clone https://github.com/keith/zap "$MY_REPO/zap"
    fi

    export PATH="$MY_REPO/zap:$PATH"
fi
