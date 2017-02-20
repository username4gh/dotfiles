#! /usr/bin/env bash

if [[ ! -d "$MY_DEPENDENCIES/jadx" ]];then
    git clone https://github.com/skylot/jadx "$MY_DEPENDENCIES/jadx"
fi

export PATH="$MY_DEPENDENCIES/jadx/build/jadx/bin:$PATH"
