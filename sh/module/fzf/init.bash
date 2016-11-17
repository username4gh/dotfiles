#! /usr/bin/env bash

if [[ $(whoami) != root ]];then
    export PATH="$MY_SH_MODULE/fzf/script:$PATH"
    _load_sh_files $MY_SH_MODULE/fzf src
fi
