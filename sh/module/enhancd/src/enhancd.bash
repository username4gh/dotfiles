#! /usr/bin/env bash

_enhancd_init() {
    if [[ ! -d "$MY_DOTFILES_RESOURCES/enhancd" ]];then
        git clone https://github.com/b4b4r07/enhancd "$MY_DOTFILES_RESOURCES/enhancd"
    fi
}

#if [[ ! -d "$MY_DOTFILES_RESOURCES/fzy" ]];then
#    git clone https://github.com/jhawthorn/fzy "$MY_DOTFILES_RESOURCES/fzy"
#fi

#export PATH="$MY_DOTFILES_RESOURCES/fzy:$PATH"

export ENHANCD_FILTER=percol
export ENHANCD_COMMAND='z'
export ENHANCD_USE_FUZZY_MATCH=0

if [[ -f "$MY_DOTFILES_RESOURCES/enhancd/init.sh" ]];then
    source "$MY_DOTFILES_RESOURCES/enhancd/init.sh"
fi
