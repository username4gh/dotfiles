#! /usr/bin/env bash

if [[ ! -d "$MY_REPO/xkcdpass" ]];then
    git clone https://github.com/danielmcgraw/xkcdpass "$MY_REPO/xkcdpass"
fi

export PATH="$MY_REPO/xkcdpass:$PATH"
