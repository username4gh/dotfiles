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
