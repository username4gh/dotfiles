#! /usr/bin/env bash

_rmlint_init() {
    if [[ ! -d "$MY_DOTFILES_RESOURCES/rmlint" ]];then
        git clone https://github.com/sahib/rmlint "$MY_DOTFILES_RESOURCES/rmlint"
    fi
}

if ! _is_command_exist scons;then
    _sh_log "${BASH_SOURCE[0]}" "missing scons, check http://rmlint.readthedocs.io/en/latest/install.html" rmlint
else
    export PATH="$PATH:$MY_DOTFILES_RESOURCES/rmlint"
fi
