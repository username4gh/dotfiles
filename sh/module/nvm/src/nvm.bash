#! /usr/bin/env bash

if [[ ! -d  "$HOME/.nvm" ]];then
    git clone https://github.com/creationix/nvm.git ~/.nvm && git -C ~/.nvm checkout `git describe --abbrev=0 --tags`
fi

export NVM_DIR="$HOME/.nvm";
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
