#! /usr/bin/env bash

if [[ ! -d "$MY_DOTFILES_RESOURCES/the_silver_searcher" ]];then
    git clone https://github.com/ggreer/the_silver_searcher "$MY_DOTFILES_RESOURCES/the_silver_searcher"
fi

export PATH="$MY_DOTFILES_RESOURCES/the_silver_searcher:$PATH"

alias ag='ag -p "$MY_SH_MODULE/the_silver_searcher/script/.ignore"'

# completion
source "$MY_DOTFILES_RESOURCES/the_silver_searcher/ag.bashcomp.sh"
