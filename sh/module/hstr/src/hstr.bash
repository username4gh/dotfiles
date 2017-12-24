#! /usr/bin/env bash

_hstr_init() {
    if ! _is_command_exist 'hh';then
        echo 'plz install hstr using homebrew or macports or anyother package manger software'
    fi
}    

if _is_command_exist 'hh';then
    export HH_CONFIG=hicolor
fi

