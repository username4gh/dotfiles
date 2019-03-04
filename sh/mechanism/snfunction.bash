#! /usr/bin/env bash

# sn -- special-named

_init() {
    local useage='Usage:my_init option \n init:do actual init process \n list:show all modules\n'
    if [[ "$#" == 1 ]];then
        if  [[ "$1" == 'init' ]];then
            _snfunction_on_modules_level _init execute
        fi
        if [[ "$1" == 'list' ]];then
            _snfunction_on_modules_level _init
        fi
    else
        printf "$useage"
    fi
}

_backup() {
    local useage='Usage:my_backup option \n init:do actual init process \n list:show all modules'
    if [[ "$#" == 1 ]];then
        if  [[ "$1" == 'init' ]];then
            _snfunction_on_modules_level backup execute
        fi
        if [[ "$1" == 'list' ]];then
            _snfunction_on_modules_level backup
        fi
    else
        printf "$useage"
    fi
}

_cleanup() {
    local useage='Usage:my_cleanup option \n init:do actual init process \n list:show all modules'
    if [[ "$#" == 1 ]];then
        if  [[ "$1" == 'init' ]];then
            _snfunction_on_modules_level cleanup execute
        fi
        if [[ "$1" == 'list' ]];then
            _snfunction_on_modules_level cleanup
        fi
    else
        printf "$useage"
    fi
}

if _is_bash;then
    complete -F _snfunction_complete _init
    complete -F _snfunction_complete _backup
    complete -F _snfunction_complete _cleanup
fi
