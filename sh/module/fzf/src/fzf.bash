#! /usr/bin/env bash

#Description wrapper for fzf
if [[ ! -d "$HOME/.fzf" ]];then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
fi
