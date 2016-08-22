#! /usr/bin/env bash

if [[ $(whoami) != root ]];then
    _load_sh_files $MY_SH_MODULE/jadx src
    export PATH="$MY_SH_MODULE/jadx/script:$PATH"
fi
