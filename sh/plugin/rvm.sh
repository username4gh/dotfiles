#! /usr/bin/env bash

if [[ ! -d "$HOME/.rvm" ]];then
    curl -sSL https://get.rvm.io | bash -s stable --autolibs=enabled
fi
