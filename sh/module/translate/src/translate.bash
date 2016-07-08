#! /usr/bin/env bash
if [[ ! -d "$MY_REPO/translate-shell" ]];then
    git clone https://github.com/soimort/translate-shell "$MY_REPO/translate-shell"
fi

_translate() {
    (cd $MY_REPO/translate-shell; ./translate "$1";)
}

alias trans='_translate'
