#! /usr/bin/env bash

if [[ $(whoami) != root ]];then
    export PATH="$MY_SH_MODULE/fpp/script:$PATH"
    _load_sh_files $MY_SH_MODULE/fpp src
fi
