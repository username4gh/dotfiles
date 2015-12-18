#! /usr/bin/env bash

if [[ ! -d "$HOME/repo/xkcdpass" ]];then
    pushd "$HOME" \
        && git clone https://github.com/danielmcgraw/xkcdpass "$HOME/repo/xkcdpass" \
        || popd
fi

export PATH="$HOME/repo/xkcdpass:$PATH"