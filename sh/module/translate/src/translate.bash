#! /usr/bin/env bash

_translate_init() {
    if [[ ! -d "$MY_DOTFILES_RESOURCES/translate-shell" ]];then
        git clone --depth 1 https://github.com/soimort/translate-shell "$MY_DOTFILES_RESOURCES/translate-shell"
    fi
}

_translate() {
    (export PATH="$PATH:$MY_DOTFILES_RESOURCES/translate-shell"; translate "$@";)
}

alias trans='_translate'
