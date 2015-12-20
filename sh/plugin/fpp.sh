#! /bin/bash

if [[ ! -d "$HOME/repo/PathPicker" ]];then
    git clone 'https://github.com/facebook/PathPicker' "$HOME/repo/PathPicker"
fi

export PATH="$HOME/repo/PathPicker:$PATH"
