#! /usr/bin/env bash

if [[ -f "/opt/local/bin/port" ]];then
    if [[ "$(port installed | s 'py27-readline')" == '' ]];then
        echo "port install py27-readline"
    fi

    if [[ "$(port installed | s 'py35-readline')" == '' ]];then
        echo "port install py35-readline"
    fi
fi
