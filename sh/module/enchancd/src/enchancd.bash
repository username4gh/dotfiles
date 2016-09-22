#! /usr/bin/env bash

if [[ ! -d "$MY_DOTFILES/enhancd" ]];then
    git clone https://github.com/b4b4r07/enhancd "$MY_DOTFILES/enhancd"
fi

export ENHANCD_COMMAND=ecd
export ENHANCD_FILTER="$HOME/.fzf/fzf"

if [[ -f "$MY_DOTFILES/enhancd/enhancd.sh" ]];then
    source "$MY_DOTFILES/enhancd/enhancd.sh"
fi
