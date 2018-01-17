#! /usr/bin/env bash

_module_generate_init_bash() {
    if [[ ! -f "$MY_SH_MODULE/$1/init.bash" ]];then
        cp "$MY_SH/mechanism/module.snippet" "$MY_SH_MODULE/$1/init.bash"
        sed -i -e "s/module_name/$1/g" "$MY_SH_MODULE/$1/init.bash"
    fi
}

module_init() {
    if [[ "$#" == 2 ]];then
        local current_dir=$(pwd)
        if [[ "$current_dir" == "$MY_SH_MODULE" ]];then
            mkdir -p "$MY_SH_MODULE/$1"
            mkdir -p "$MY_SH_MODULE/$1/script"
            mkdir -p "$MY_SH_MODULE/$1/src"

            _module_generate_init_bash $1 $2
        else
            echo "Usage: _package_init can only be used while current_dir is $MY_SH_MODULE"
        fi
    else
        echo "Usage: module_init package_name (y|n)"
        echo "(y|n) for whether this package work under root or not"
    fi
}
