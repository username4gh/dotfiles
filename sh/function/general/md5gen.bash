#! /usr/bin/env bash
md5gen() {
    if [[ "$#" -gt 0 ]];then
        echo -n $1 | md5sum
    else
        echo "Usage: md5gen [filename]"
    fi
}
