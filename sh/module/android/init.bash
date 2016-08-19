#! /usr/bin/env bash

if [[ $(whoami) != root ]];then
    _my_load_sh_files $MY_SH_MODULE/android src
    export PATH="$MY_SH_MODULE/android/script:$PATH"
fi
