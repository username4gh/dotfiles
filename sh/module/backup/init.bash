#! /usr/bin/env bash

if _is_not_root;then
    export PATH="$MY_SH_MODULE/backup/script:$PATH"
    _load_sh_files $MY_SH_MODULE/backup src
fi
