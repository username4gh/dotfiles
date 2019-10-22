#! /usr/bin/env bash

_nvm_init(){
    if [[ ! -d  "$HOME/.nvm" ]];then
        git clone --depth 1 https://github.com/creationix/nvm.git ~/.nvm && git -C ~/.nvm checkout `git describe --abbrev=0 --tags`
    fi
}

export NVM_DIR="$HOME/.nvm";
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
