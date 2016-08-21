#! /usr/bin/env bash

if [[ $(whoami) != root ]];then
    _load_sh_files $MY_SH_MODULE/code_reading_utils src
fi
