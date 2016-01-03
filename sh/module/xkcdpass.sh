#! /usr/bin/env bash

if [[ ! -d "$HOME/repo/xkcdpass" ]];then
    git clone https://github.com/danielmcgraw/xkcdpass "$HOME/repo/xkcdpass"
fi

export PATH="$HOME/repo/xkcdpass:$PATH"
