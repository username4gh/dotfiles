#! /usr/bin/env bash

_fileutil_list_unexist_dir() {
    if [[ "$#" == 1 ]];then
        while IFS= read -r item
        do
            if [[ ! -d "$item" ]];then
                echo $item
            fi
        done < <(cat $1)
    else
        echo "Usage: command file-list-file"
    fi
}

_fileutil_make_dir_from_file() {
    if [[ "$#" == 1 ]];then
        while IFS= read -r item
        do
            if [[ ! -d "$item" ]];then
                mkdir "$item"
            fi
        done < <(cat $1)
    else
        echo "Usage: command file-list-file"
    fi
}

_fileutil_gen_dir_list() {
    if [[ "$#" == 1 ]];then
        find . -maxdepth 1 -mindepth 1 -type d > $1
    else
        echo "Usage: command file-list-file"
    fi
}
