#! /usr/bin/env bash

if [[ $(whoami) != root ]];then
    export PATH="$PATH:$MY_SH_MODULE/pick/script"
    _load_sh_files $MY_SH_MODULE/pick src
fi
