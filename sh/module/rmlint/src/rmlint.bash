#! /usr/bin/env bash

if [[ ! -d "$MY_DEPENDENCIES/rmlint" ]];then
    git clone https://github.com/sahib/rmlint "$MY_DEPENDENCIES/rmlint"
fi

if [[ "$(_check_command scons)" == 0 ]];then
    _sh_log "${BASH_SOURCE[0]}" "check http://rmlint.readthedocs.io/en/latest/install.html"
else
    export PATH="$PATH:$MY_DEPENDENCIES/rmlint"
fi
