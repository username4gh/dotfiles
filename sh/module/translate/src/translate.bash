#! /usr/bin/env bash

if [[ ! -d "$MY_DOTFILES/translate-shell" ]];then
    git clone https://github.com/soimort/translate-shell "$MY_DOTFILES/translate-shell"
fi

_translate() {
    (export PATH="$PATH:$MY_DOTFILES/translate-shell"; translate "$@";)
}

alias trans='_translate'
