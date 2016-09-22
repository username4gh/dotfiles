#! /usr/bin/env bash

if [[ ! -d "$MY_DOTFILES/PathPicker" ]];then
    git clone 'https://github.com/facebook/PathPicker' "$MY_DOTFILES/PathPicker"
fi

export PATH="$MY_DOTFILES/PathPicker:$PATH"
