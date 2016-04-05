#! /usr/bin/env sh

_bootstrap_module() {
    if [[ "$#" == 1 ]];then
        local item

        local method

        while IFS= read -r item;
        do
            method="_$(_file_name_noext $item)"

            if [[ "$(_check_command $method)" == 1 ]];then
                $method
            fi
        done < <(find "$MY_SH_MODULE/$1" -mindepth 1 -maxdepth 1 -type f -name "$1\_init.sh")
    else
        echo "Usage: _bootstrap_module name"
    fi
}

_bootstrap_modules() {
    if [[ "$#" == 0 ]];then
        local item

        while IFS= read -r item;
        do
            _bootstrap_module $(_dir_basename $item)
        done < <(find "$MY_SH/module" -mindepth 1 -maxdepth 1 -type d)
    else
        echo "Usage: _bootstrap_modules"
    fi
}

my_bootstrap() {
    local useage='Usage:my_bootstrap option \n help:show this help message \n init:do actual init process \n'
    if [[ "$#" == 0 ]];then
        if  [[ "$1" == 'init' ]];then
            _bootstrap_modules
        fi
        if [[ "$1" == 'help' ]];then
            printf "$useage"
        fi
    else
        printf "$useage"
    fi
}
