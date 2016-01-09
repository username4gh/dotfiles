#! /usr/bin/env bash

if [[ ! -d  "$HOME/.nvm" ]];then
    git clone https://github.com/creationix/nvm $HOME/.nvm
fi

source "$HOME/.nvm/nvm.sh"