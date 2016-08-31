#! /usr/bin/env bash

if [[ ! -d "$MY_REPO/fdupes" ]];then
    git clone https://github.com/adrianlopezroche/fdupes "$MY_REPO/fdupes"
else
    export PATH="$PATH:$MY_REPO/fdupes"
fi
