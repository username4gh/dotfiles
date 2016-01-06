#! /usr/bin/env bash

_rvm_init_disable() {
    if [[ ! -d "$HOME/.rvm" ]];then
        curl -sSL https://get.rvm.io | bash -s stable --autolibs=enabled
    fi
}
