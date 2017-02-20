#! /usr/bin/env bash

if [[ ! -d "$MY_DEPENDENCIES/dex-method-counts" ]];then
    git clone https://github.com/mihaip/dex-method-counts "$MY_DEPENDENCIES/dex-method-counts"
fi

export PATH="$MY_DEPENDENCIES/dex-method-counts:$PATH"
