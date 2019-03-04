#! /usr/bin/env bash

if _is_not_root;then
    export PATH="$PATH:$MY_SH_MODULE/binutils/script"
    _load_sh_files $MY_SH_MODULE/binutils src
fi
