#! /usr/bin/env bash

if [[ ! -d "$MY_DEPENDENCIES/rfc" ]];then
    git clone https://github.com/bfontaine/rfc "$MY_DEPENDENCIES/rfc"
fi

export PATH="$MY_DEPENDENCIES/rfc:$PATH"
