#! /usr/bin/env bash

if [[ $(whoami) != root ]];then
    _load_sh_files $MY_SH/runtime src
    export PATH="$MY_SH/runtime/script:$PATH"
fi
