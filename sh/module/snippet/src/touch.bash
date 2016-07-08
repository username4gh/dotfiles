#! /usr/bin/env bash

my_touch() {
    if [[ "$#" == 1 ]];then
        local name=$(_file_name_noext $1)
        local ext=$(_file_ext $1)
        cp $MY_SH_MODULE/snippet/snippets/snippet.$ext ./$1
        if [[ "$ext" == 'java' ]];then
            gsed -i "s/public\ class\ Main/public\ class $name/g" ./$1
        fi
    else
        echo "Usage: my_touch full_filename"
    fi
}
