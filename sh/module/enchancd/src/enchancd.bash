#! /usr/bin/env bash

if [[ ! -d "$MY_DOTFILES/enhancd" ]];then
    git clone https://github.com/b4b4r07/enhancd "$MY_DOTFILES/enhancd"
fi

if [[ ! -d "$MY_DOTFILES/fzy" ]];then
    git clone https://github.com/jhawthorn/fzy "$MY_DOTFILES/fzy"
fi

export PATH="$MY_DOTFILES/fzy:$PATH"

export ENHANCD_FILTER=fzy
export ENHANCD_COMMAND='ec'

if [[ -f "$MY_DOTFILES/enhancd/init.sh" ]];then
    source "$MY_DOTFILES/enhancd/init.sh"
fi
