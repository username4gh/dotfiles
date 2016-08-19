#! /usr/bin/env bash

if [[ "$#" == 1 ]];then
    find . -maxdepth 1 -mindepth 1 -type d > $1
else
    echo "Usage: command file-list-file"
fi
