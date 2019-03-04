#!/usr/bin/env bash

# If not running interactively, don't do anything
# this line has to be placed at this front-pos,
# otherwise the rsync will not work
case $- in
    *i*) ;;
    *) return;; # exit also causing the scp command malfunction
esac

# http://mivok.net/2009/09/20/bashfunctionoverrist.html
_overrideFunction() {
    local -r functionBody=$(declare -f $1)
    local -r newDefinition="${1}_super ${functionBody#$1}"
    eval "$newDefinition"
}

# https://stackoverflow.com/questions/5431909/bash-functions-return-boolean-to-be-used-in-if
_is_env_exist() {
    [[ "$#" -eq 1 ]] && [[ ! -z "$1" ]]
}

_is_dir_exist() {
    [[ "$#" -eq 1 ]] && [[ -d "$1" ]]
}

_is_file_exist() {
    [[ "$#" -eq 1 ]] && [[ -f "$1" ]]
}

_is_darwin() {
    [[ "$#" -eq 0 ]] && [[ "$(uname -s)" == "Darwin" ]]
}

_is_linux() {
    [[ "$#" -eq 0 ]] && [[ "$(uname -s)" == "Linux" ]]
}

_is_mingw32_nt() {
    [[ "$#" -eq 0 ]] && [[ "$(uname -s)" == "MINGW32_NT" ]]
}

_is_command_exist() {
    [[ "$#" -eq 1 ]] && command -v "$1" > /dev/null
}

_is_root() {
    [[ "$#" -eq 0 ]] && [[ "$(i -iu)" -ne 0 ]]
}

_is_termux() {
    _is_linux && [[ "$HOME" =~ "com.termux/files/home" ]]
}

if _is_command_exist 'python';then

    export MY_CURRENT_SHELL='bash'

    if [[ "$(uname -s)" == "Darwin" ]];then
        if [[ -f '/opt/local/bin/port' ]];then
            export MY_CURRENT_PACKAGE_MANAGER='macports'
        elif [[ -f '/usr/local/bin/brew' ]];then
            export MY_CURRENT_PACKAGE_MANAGER='homebrew'
        else
            unset MY_CURRENT_PACKAGE_MANAGER
        fi
    else
        unset MY_CURRENT_PACKAGE_MANAGER
    fi

    if [[ -f "$HOME/.dotfiles/sh/init.bash" ]];then
        source "$HOME/.dotfiles/sh/init.bash"
    fi
fi
