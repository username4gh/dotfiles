#! /usr/bin/env bash

_rvm_init() {
    if [[ ! -d "$HOME/.rvm/bin" ]];then
        curl -sSL https://get.rvm.io | bash -s stable --autolibs=enabled
    fi
}

virtual_rvm() {
    # https://www.topbug.net/blog/2013/10/23/use-both-homebrew-and-macports-on-your-os-x/
    if [[ "$#" -le 0 ]];then
        echo "Usage: $0 command [arg1, arg2, ...]" >&2;
        return;
    fi

    ([[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm";

    command=$1;

    shift

    exec $command $*)
}


_completion_register_write virtual_rvm alfi
_completion_register_write virtual_rvm gem
_completion_register_write virtual_rvm rvm

_completion_setup virtual_rvm
