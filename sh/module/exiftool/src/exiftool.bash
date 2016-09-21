#! /usr/bin/env bash

if [[ ! "$(_check_command exiftool)" -eq 1 ]];then
    echo "Missing exiftool : go check out http://www.sno.phy.queensu.ca/~phil/exiftool/"
fi
