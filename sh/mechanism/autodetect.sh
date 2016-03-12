#! /usr/bin/env bash

_autodetect_bin() {
    if [[ "$#" == 2 ]];then
        local path
        path=$(ls -F $MY_BIN | s "$1" | tail -1)
        echo $MY_BIN/$path
    else
        echo "Usage: _autodetect_bin 'regex_str'"
    fi
}
