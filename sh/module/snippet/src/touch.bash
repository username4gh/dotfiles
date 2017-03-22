#! /usr/bin/env bash

_touch() {
    if [[ "$#" == 1 ]];then
        local name=$(_file_name_noext $1)
        local ext=$(_file_ext $1)
        if [[ -f "$MY_SH_MODULE/snippet/snippets/snippet.$ext" ]];then
            cp "$MY_SH_MODULE/snippet/snippets/snippet.$ext" "./$1"
        else
            command touch "./$1"
        fi
        if [[ "$ext" == 'java' ]];then
            gsed -i "s/public\ class\ Main/public\ class $name/g" ./$1
        fi
        unset name
        unset ext
    else
        echo "Usage: touch full_filename"
    fi
}

alias touch="_touch"
