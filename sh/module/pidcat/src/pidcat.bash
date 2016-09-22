#! /usr/bin/env bash

if [[ ! -d "$MY_DOTFILES/pidcat" ]];then
    git clone https://github.com/JakeWharton/pidcat "$MY_DOTFILES/pidcat"
fi

if [[ "$MY_CURRENT_SHELL" == 'bash' ]];then
    export PATH="$MY_DOTFILES/pidcat:$PATH"
fi
