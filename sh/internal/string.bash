#! /usr/bin/env bash

_string_contains() {
    if [[ "$#" == 2 ]];then
        string="$1"
        substring="$2"
        if test "${string#*$substring}" != "$string"
        then
            return 1    # $substring is in $string
        else
            return 0    # $substring is not in $string
        fi
    else
        echo "_string_contains error"
    fi
}

_string_trim() {
    echo "$(echo -e "${1}" | tr -d '[[:space:]]')"
}