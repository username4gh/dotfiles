#! /usr/bin/env bash

# for all func below, '1' means exist

_check_variant() {
    if [[ -z "$1" ]]; then
        echo 0;
    else
        echo 1;
    fi
}

_check_dir() {
    if [[ -n "$1" ]] && [[ ! -d "$1" ]]; then
        echo 0;
    else
        echo 1;
    fi
}

_check_file() {
    if [[ -n "$1" ]] && [[ ! -f "$1" ]]; then
        echo 0;
    else
        echo 1;
    fi
}

_check_command() {
    if ! command -v "$1" > /dev/null; then 
        echo 0;
    else
        echo 1;
    fi
}

_check_os() {
    if [[ "$(uname -s)" == "Darwin" ]]; then
        echo "Darwin";
        return;
    elif [[ "$(uname -s)" == "Linux" ]]; then
        echo "Linux";
        return;
    elif [[ "$(uname -s)" == "MINGW32_NT" ]]; then
        echo "MINGW32_NT";
    fi
}

_check_root() {
    if [[ $(id -u) -ne 0 ]];then
        echo "0";
    else
        echo "1";
    fi
}
