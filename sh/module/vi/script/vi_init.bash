#! /usr/bin/env bash

if [[ ! -h "$HOME/.vimrc" ]];then
    if [[ -f "$HOME/.vimrc" ]];then
        rm "$HOME/.vimrc"
    fi

    ln -s "$MY_I3/.vimrc" "$HOME/.vimrc"
fi
