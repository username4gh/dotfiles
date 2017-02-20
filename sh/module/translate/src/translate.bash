#! /usr/bin/env bash

if [[ ! -d "$MY_DEPENDENCIES/translate-shell" ]];then
    git clone https://github.com/soimort/translate-shell "$MY_DEPENDENCIES/translate-shell"
fi

_translate() {
    (export PATH="$PATH:$MY_DEPENDENCIES/translate-shell"; translate "$@";)
}

alias trans='_translate'
