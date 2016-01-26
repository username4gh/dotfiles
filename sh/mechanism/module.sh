#! /usr/bin/env bash

_module_init() {
    if [[ "$#" == 0 ]];then
        if [[ -f "$MY_SH_MODULE/init.sh" ]];then
            rm -v "$MY_SH_MODULE/init.sh"
        fi

        while IFS= read -r item; 
        do 
            echo '_myload_sh_files $MY_SH_MODULE '$(_dir_basename $item) >> "$MY_SH_MODULE/init.sh"; 
        done < <(find "$MY_SH_MODULE" -maxdepth 1 -mindepth 1 -type d)
    else
        echo "Usage: _module_init"
    fi
}
