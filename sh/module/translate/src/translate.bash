#! /usr/bin/env bash
if [[ ! -d "$MY_DOTFILES/translate-shell" ]];then
    git clone https://github.com/soimort/translate-shell "$MY_DOTFILES/translate-shell"
fi

_translate() {
    (cd $MY_DOTFILES/translate-shell; ./translate "$1";)
}

alias trans='_translate'
