#! /usr/bin/env sh

# exec module's function with special name
_function_module() {
    method="_$(_file_name_noext $2)_$1"

    if [[ "$(_check_command $method)" == 1 ]];then
        echo "  _cleanup_module calling $method"
        if [[ "$3" == 'execute' ]];then
            $method
        fi
    fi
}

_function_modules() {
    while IFS= read -r item;
    do
        echo "_$1_modules calling $(_dir_basename $item)"
        if [[ "$2" == 'execute' ]];then
            _function_module $1 "$(_dir_basename $item)" execute
        else
            _function_module $1 "$(_dir_basename $item)"
        fi
    done < <(find "$MY_SH/module" -mindepth 1 -maxdepth 1 -type d)
}

my_init() {
    local useage='Usage:my_init option \n init:do actual init process \n list:show all modules'
    if [[ "$#" == 1 ]];then
        if  [[ "$1" == 'init' ]];then
            _function_modules init execute
        fi
        if [[ "$1" == 'list' ]];then
            _function_modules init
        fi
    else
        printf "$useage"
    fi
}

my_backup() {
    local useage='Usage:my_backup option \n init:do actual init process \n list:show all modules'
    if [[ "$#" == 1 ]];then
        if  [[ "$1" == 'init' ]];then
            _function_modules backup execute
        fi
        if [[ "$1" == 'list' ]];then
            _function_modules backup
        fi
    else
        printf "$useage"
    fi
}

my_cleanup() {
    local useage='Usage:my_cleanup option \n init:do actual init process \n list:show all modules'
    if [[ "$#" == 1 ]];then
        if  [[ "$1" == 'init' ]];then
            _function_modules cleanup execute
        fi
        if [[ "$1" == 'list' ]];then
            _function_modules cleanup
        fi
    else
        printf "$useage"
    fi
}
