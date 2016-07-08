#! /usr/bin/env bash
# sn stands for special name

# exec module's function with special name
_function_on_module_level() {
    method="_$(_file_name_noext $2)_$1"

    if [[ "$(_check_command $method)" == 1 ]];then
        echo "  $1 calling $method"
        if [[ "$3" == 'execute' ]];then
            $method
        fi
    fi
}

_function_on_modules_level() {
    while IFS= read -r item;
    do
        echo "$1 calling $(_dir_basename $item)"
        if [[ "$2" == 'execute' ]];then
            _function_on_module_level $1 "$(_dir_basename $item)" execute
        else
            _function_on_module_level $1 "$(_dir_basename $item)"
        fi
    done < <(find "$MY_SH/module" -mindepth 1 -maxdepth 1 -type d)
}

my_init() {
    local useage='Usage:my_init option \n init:do actual init process \n list:show all modules'
    if [[ "$#" == 1 ]];then
        if  [[ "$1" == 'init' ]];then
            _function_on_modules_level my_init execute
        fi
        if [[ "$1" == 'list' ]];then
            _function_on_modules_level my_init
        fi
    else
        printf "$useage"
    fi
}

my_backup() {
    local useage='Usage:my_backup option \n init:do actual init process \n list:show all modules'
    if [[ "$#" == 1 ]];then
        if  [[ "$1" == 'init' ]];then
            _function_on_modules_level backup execute
        fi
        if [[ "$1" == 'list' ]];then
            _function_on_modules_level backup
        fi
    else
        printf "$useage"
    fi
}

my_cleanup() {
    local useage='Usage:my_cleanup option \n init:do actual init process \n list:show all modules'
    if [[ "$#" == 1 ]];then
        if  [[ "$1" == 'init' ]];then
            _function_on_modules_level cleanup execute
        fi
        if [[ "$1" == 'list' ]];then
            _function_on_modules_level cleanup
        fi
    else
        printf "$useage"
    fi
}
