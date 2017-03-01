#! /usr/bin/env bash

if [[ ! -d "$MY_DOTFILES_RESOURCES/the_silver_searcher" ]];then
    git clone https://github.com/ggreer/the_silver_searcher "$MY_DOTFILES_RESOURCES/the_silver_searcher"
fi

export PATH="$MY_DOTFILES_RESOURCES/the_silver_searcher:$PATH"
