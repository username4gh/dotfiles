#! /usr/bin/env bash

if [[ ! -d "$MY_REPO/dex-method-counts" ]];then
    git clone https://github.com/mihaip/dex-method-counts "$MY_REPO/dex-method-counts"
fi

export PATH="$MY_REPO/dex-method-counts:$PATH"
