#! /usr/bin/env bash

if [[ $(whoami) != root ]];then
    export PATH="$MY_SH_MODULE/the_silver_searcher/script:$PATH"
    _load_sh_files $MY_SH_MODULE/the_silver_searcher src
fi
