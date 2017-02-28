#! /usr/bin/env bash

if [[ ! -d "$MY_DOTFILES_RESOURCES/PathPicker" ]];then
    git clone 'https://github.com/facebook/PathPicker' "$MY_DOTFILES_RESOURCES/PathPicker"
fi
