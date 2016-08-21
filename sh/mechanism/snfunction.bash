#! /usr/bin/env bash

# sn -- special named

my_init() {
    local useage='Usage:my_init option \n init:do actual init process \n list:show all modules'
    if [[ "$#" == 1 ]];then
        if  [[ "$1" == 'init' ]];then
            _snfunction_on_modules_level my_init execute
        fi
        if [[ "$1" == 'list' ]];then
            _snfunction_on_modules_level my_init
        fi
    else
        printf "$useage"
    fi
}

my_backup() {
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

my_cleanup() {
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

if [[ "$MY_CURRENT_SHELL" == 'bash' ]];then
    complete -F _snfunction_complete my_init
    complete -F _snfunction_complete my_backup
    complete -F _snfunction_complete my_cleanup
fi
