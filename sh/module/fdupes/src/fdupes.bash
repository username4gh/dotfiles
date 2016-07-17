#! /usr/bin/env bash

if [[ ! -d "$MY_REPO/fdupes" ]];then
    git clone https://github.com/adrianlopezroche/fdupes "$MY_REPO/fdupes"
else
    export PATH="$PATH:$HOME/repo/fdupes"
fi
