#! /usr/bin/env bash

if [[ $(whoami) != root ]];then
    _load_sh_files $MY_SH_MODULE/fzf src
    export PATH="$MY_SH_MODULE/fzf/script:$PATH"
fi
