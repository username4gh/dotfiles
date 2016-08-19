#! /usr/bin/env bash

if [[ ! -d "$MY_REPO/pidcat" ]];then
    git clone https://github.com/JakeWharton/pidcat "$MY_REPO/pidcat"
fi

if [[ "$MY_CURRENT_SHELL" == 'bash' ]];then
    export PATH="$MY_REPO/pidcat:$PATH"
fi
