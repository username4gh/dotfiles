#! /usr/bin/env bash

if [[ ! -d "$MY_DOTFILES_RESOURCES/translate-shell" ]];then
    git clone https://github.com/soimort/translate-shell "$MY_DOTFILES_RESOURCES/translate-shell"
fi

_translate() {
    (export PATH="$PATH:$MY_DOTFILES_RESOURCES/translate-shell"; translate "$@";)
}

alias trans='_translate'
