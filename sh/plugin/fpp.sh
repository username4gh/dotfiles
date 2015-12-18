#! /bin/bash

if [[ ! -d "$HOME/repo/PathPicker" ]];then
    pushd "$HOME/repo" \
        && git clone 'https://github.com/facebook/PathPicker' \
        && popd
fi

export PATH="$HOME/repo/PathPicker:$PATH"