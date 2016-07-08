#! /usr/bin/env bash

if [[ ! -d "$MY_REPO/PathPicker" ]];then
    git clone 'https://github.com/facebook/PathPicker' "$MY_REPO/PathPicker"
fi

export PATH="$MY_REPO/PathPicker:$PATH"
