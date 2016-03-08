#! /usr/bin/env bash

if [[ "$(whoami)" != 'root' ]];then
    _myload_sh_files $MY_SH_MODULE/android src
fi
