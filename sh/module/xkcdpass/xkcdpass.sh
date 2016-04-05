#! /usr/bin/env sh

if [[ ! -d "$MY_REPO/xkcdpass" ]];then
    git clone https://github.com/danielmcgraw/xkcdpass "$MY_REPO/xkcdpass"
fi

export PATH="$MY_REPO/xkcdpass:$PATH"
