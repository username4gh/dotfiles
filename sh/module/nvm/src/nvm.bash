#! /usr/bin/env bash

if [[ ! -d  "$HOME/.nvm" ]];then
    git clone https://github.com/creationix/nvm.git ~/.nvm && git -C ~/.nvm checkout `git describe --abbrev=0 --tags`
fi

v_nvm() {
    # https://www.topbug.net/blog/2013/10/23/use-both-homebrew-and-macports-on-your-os-x/
    if [[ "$#" -le 0 ]];then
        echo "Usage: v_nvm command [arg1, arg2, ...]" >&2;
        return;
    fi

    (export NVM_DIR="$HOME/.nvm";
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

    command=$1;

    shift

    # exec cannot invake a function
    $command $*)
}

_completion_register_write v_nvm commitizen_init
_completion_register_write v_nvm git-cz
_completion_register_write v_nvm npm

_completion_setup v_nvm
