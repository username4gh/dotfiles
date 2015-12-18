#! /usr/bin/env bash

_util_string_contains() {
    string="$1"
    substring="$2"
    if test "${string#*$substring}" != "$string"
    then
        return 1    # $substring is in $string
    else
        return 0    # $substring is not in $string
    fi
}
