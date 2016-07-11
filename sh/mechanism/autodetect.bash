#! /usr/bin/env bash

_autodetect_bin() {
    if [[ "$#" == 1 ]];then
        # it seems like that zsh treat 'path' same as 'PATH', so here we use bin_path
        local bin_path
        bin_path=$(find $MY_BIN -maxdepth 1 -type d | s "$1" | tail -1)
        echo $bin_path
    else
        echo "Usage: _autodetect_bin 'regex_str'"
    fi
}