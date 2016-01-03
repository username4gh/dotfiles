#! /usr/bin/env bash

if [[ "$(_check_os)" == "Darwin" ]]; then
    if [[ ! -d "$HOME/repo/macports-tools" ]];then
        git clone https://github.com/vasi/macports-tools "$HOME/repo/macports-tools"
    fi

    export PATH="$HOME/repo/macports-tools:$PATH"
fi
