#! /usr/bin/env bash

#Description wrapper for fzf
if [[ ! -d "$HOME/.fzf" ]];then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
fi

gdgsaf() {
    git diff $(git status -s | s 'M' | awk '{print $2}' | fzf)
}
