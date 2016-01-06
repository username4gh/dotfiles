#! /usr/bin/env bash

#Description touch with snippet support

mytouch(){
    local MY_SNIPPET_DIR="$MY_I3/snippet"
    if [[ "$1" = '--help' ]];then
        echo "Usage: mytouch [full file name]"
    else
        if [[ "$(_file_ext $1)" = 'bash' ]];then
            cp $MY_SNIPPET_DIR/snippet.bash ./$1
        else
            touch ./$1
        fi
    fi
}
