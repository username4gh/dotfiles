#! /usr/bin/env bash

if [[ ! -d "$MY_DEPENDENCIES/PathPicker" ]];then
    git clone 'https://github.com/facebook/PathPicker' "$MY_DEPENDENCIES/PathPicker"
fi
