#! /usr/bin/env bash

if [[ $(whoami) != root ]];then
    _load_sh_files $MY_SH_MODULE/macports src
    export PATH="$PATH:$MY_SH_MODULE/macports/script"
fi
