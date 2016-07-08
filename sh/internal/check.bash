#! /usr/bin/env bash

# for all func below, '1' means exist

_check_variant() {
    if [[ "$#" == 1 ]];then
        if [[ -z "$1" ]]; then
            echo 0;
        else
            echo 1;
        fi
    else
        echo "_check_variant error"
    fi
}

_check_dir() {
    if [[ "$#" == 1 ]];then
        if [[ -n "$1" ]] && [[ ! -d "$1" ]]; then
            echo 0;
        else
            echo 1;
        fi
    else 
        echo "_check_dir error"
    fi
}

_check_file() {
    if [[ "$#" == 1 ]];then
        if [[ -n "$1" ]] && [[ ! -f "$1" ]]; then
            echo 0;
        else
            echo 1;
        fi
    else 
        echo "_check_file error"
    fi
}

_check_command() {
    if [[ "$#" == 1 ]];then
        if ! command -v "$1" > /dev/null; then
            echo 0;
        else
            echo 1;
        fi
    else 
        echo "_check_command error"
    fi
}

_check_os() {
    if [[ "$#" == 0 ]];then
        if [[ "$(uname -s)" == "Darwin" ]]; then
            echo "Darwin";
            return;
        elif [[ "$(uname -s)" == "Linux" ]]; then
            echo "Linux";
            return;
        elif [[ "$(uname -s)" == "MINGW32_NT" ]]; then
            echo "MINGW32_NT";
        fi
    else
        echo "_check_os error"
    fi
}

_check_root() {
    if [[ "$#" == 0 ]];then
        if [[ $(id -u) -ne 0 ]];then
            echo "0";
        else
            echo "1";
        fi 
    else 
        echo "_check_root error"
    fi
}
