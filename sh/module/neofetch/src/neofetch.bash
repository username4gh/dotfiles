#! /usr/bin/env bash

if [[ ! -d "$MY_DEPENDENCIES/neofetch" ]];then
    git clone https://github.com/dylanaraps/neofetch "$MY_DEPENDENCIES/neofetch"
fi

export PATH="$MY_DEPENDENCIES/neofetch:$PATH"
