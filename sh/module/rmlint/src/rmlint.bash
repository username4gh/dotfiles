#! /usr/bin/env bash

if [[ ! -d "$MY_DOTFILES/rmlint" ]];then
    git clone https://github.com/sahib/rmlint "$MY_DOTFILES/rmlint"
fi

if [[ "$(_check_command scons)" == 0 ]];then
    echo "check http://rmlint.readthedocs.io/en/latest/install.html"
else
    export PATH="$PATH:$MY_DOTFILES/rmlint"
fi
