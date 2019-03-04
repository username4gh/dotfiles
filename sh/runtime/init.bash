#! /usr/bin/env bash

if _is_not_root;then
    export PATH="$MY_SH/runtime/script:$PATH"
    _load_sh_files $MY_SH/runtime src
fi
