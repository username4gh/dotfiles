#! /usr/bin/env bash

_exiftool_init() {
    if ! _is_command_exist exiftool;then
        echo "Missing exiftool : go check out http://www.sno.phy.queensu.ca/~phil/exiftool/"
    fi
}
