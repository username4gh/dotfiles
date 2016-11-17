#! /usr/bin/env bash

if [[ $(whoami) != root ]];then
    export PATH="$MY_SH_MODULE/repos/script:$PATH"
    _load_sh_files $MY_SH_MODULE/repos src
fi
