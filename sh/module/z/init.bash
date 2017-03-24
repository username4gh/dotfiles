#! /usr/bin/env bash

if [[ ! $(id -u) -eq 0 ]];then
    _load_sh_files $MY_SH_MODULE/z src
fi
