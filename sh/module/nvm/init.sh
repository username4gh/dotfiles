#! /usr/bin/env sh

if [[ "$(whoami)" != 'root' ]];then
    _my_load_sh_files $MY_SH_MODULE/nvm src
fi
