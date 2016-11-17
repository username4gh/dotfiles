#! /usr/bin/env bash

if [[ $(whoami) != root ]];then
    export PATH="$PATH:$MY_SH_MODULE/code_reading_utils/script"
    _load_sh_files $MY_SH_MODULE/code_reading_utils src
fi
