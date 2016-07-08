#! /usr/bin/env bash

_jadx_init() {
    if [[ ! -d "$MY_REPO/jadx" ]];then
        git clone https://github.com/skylot/jadx "$MY_REPO/jadx"
    fi
}

export PATH="$MY_REPO/jadx/build/jadx/bin:$PATH"

_jadx_build() {
    (cd $MY_REPO/jadx; ./gradlew dist)
}
