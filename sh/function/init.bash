#! /usr/bin/env bash

export MY_SH_FUNCTION="$MY_SH/function"

_my_load_sh_files $MY_SH_FUNCTION 'general'

if [[ "$(_check_os)" == "Darwin" ]];then
    _my_load_sh_files $MY_SH_FUNCTION 'mac'
else
    _my_load_sh_files $MY_SH_FUNCTION 'linux'
fi