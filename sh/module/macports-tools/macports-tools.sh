#! /usr/bin/env sh

if [[ "$(_check_os)" == "Darwin" ]]; then
    if [[ ! -d "$MY_REPO/macports-tools" ]];then
        git clone https://github.com/vasi/macports-tools "$MY_REPO/macports-tools"
    fi

    export PATH="$MY_REPO/macports-tools:$PATH"
fi
