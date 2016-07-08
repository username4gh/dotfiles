#! /usr/bin/env bash

if [[ ! -d  "$HOME/.nvm" ]];then
    git clone https://github.com/creationix/nvm.git ~/.nvm && cd ~/.nvm && git checkout `git describe --abbrev=0 --tags`
fi

virtual_nvm() {
    # https://www.topbug.net/blog/2013/10/23/use-both-homebrew-and-macports-on-your-os-x/
    if [[ "$#" -le 0 ]];then
        echo "Usage: virtual_nvm command [arg1, arg2, ...]" >&2;
        return;
    fi

    (export NVM_DIR="$HOME/.nvm";
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

    command=$1;

    shift

    # exec cannot invake a function
    $command $*)
}

_completion_setup virtual_nvm
_completion_write virtual_nvm commitizen_init
_completion_write virtual_nvm git-cz
_completion_write virtual_nvm npm
