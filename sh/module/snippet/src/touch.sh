#! /usr/bin/env bash

my_touch() {
    if [[ "$#" == 1 ]];then
        local name=$(_file_name_noext $1)
        local ext=$(_file_ext $1)
        cp $MY_SH_MODULE/snippet/snippets/snippet.$ext ./$1
    else
        echo "Usage: my_touch full_filename"
    fi
}
