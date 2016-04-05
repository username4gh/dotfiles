#! /usr/bin/env sh

if [[ ! -d "$MY_REPO/neofetch" ]];then
    git clone https://github.com/dylanaraps/neofetch "$MY_REPO/neofetch"
fi

export PATH="$MY_REPO/neofetch:$PATH"
