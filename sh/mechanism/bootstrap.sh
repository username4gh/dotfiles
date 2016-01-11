#! /usr/bin/env bash

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
        echo "_bootstrap_module error"
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
        echo "_bootstrap_modules error"
    fi
}

_bootstrap() {
    _bootstrap_modules
}
