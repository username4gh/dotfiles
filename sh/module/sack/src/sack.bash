#! /usr/bin/env bash

if [[ "$(_check_dir "$MY_REPO/sack")" == 0 ]];then
    git clone https://github.com/sampson-chen/sack "$MY_REPO/sack"

    ln -s "$MY_REPO/sack/.sackrc" "$HOME/"
fi

export PATH="$MY_REPO/sack:$PATH"
