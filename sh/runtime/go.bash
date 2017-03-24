#! /usr/bin/env bash

if [[ ! -d "$MY_BIN/go" ]]; then
    mkdir -p "$MY_BIN/go"
fi

if [[ ! -d "$HOME/go" ]];then
    mkdir -p "$HOME/go"
fi

if [[ -d "$MY_BIN/go" ]];then
    export GOROOT="$MY_BIN/go"
    export PATH="$GOROOT/bin:$PATH"
fi

if [[ -d "$HOME/go" ]];then
    export GOPATH="$HOME/go"
    export PATH="$GOPATH/bin:$PATH"
fi
