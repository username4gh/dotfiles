#! /usr/bin/env bash

if [[ ! -d "$MY_DEPENDENCIES/fdupes" ]];then
    git clone https://github.com/adrianlopezroche/fdupes "$MY_DEPENDENCIES/fdupes"
else
    export PATH="$PATH:$MY_DEPENDENCIES/fdupes"
fi
