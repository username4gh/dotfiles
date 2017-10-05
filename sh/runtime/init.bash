#! /usr/bin/env bash

if [[ $(whoami) != root ]];then
    export PATH="$MY_SH/runtime/script:$PATH"
    _load_sh_files $MY_SH/runtime src
fi
