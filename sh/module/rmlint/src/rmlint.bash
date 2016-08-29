#! /usr/bin/env bash

if [[ ! -d "$MY_REPO/rmlint" ]];then
    git clone https://github.com/sahib/rmlint "$MY_REPO/rmlint"
fi

if [[ "$(_check_command scons)" == 0 ]];then
    echo "just check http://rmlint.readthedocs.io/en/latest/install.html"
else
    export PATH="$PATH:$HOME/repo/rmlint"
fi