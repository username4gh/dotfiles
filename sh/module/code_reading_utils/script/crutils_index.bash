#! /usr/bin/env bash

if [[ "$#" == 1 ]];then
    echo "generating file list ..."
    while IFS= read -r item;do readlink -m "$item"; done < <(find "$1" -name '*.aidl' -o -name '*.cc' -o -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.py' | s -i -v 'test') | sort | uniq > './cscope.files'

    echo "cscope indexing ..."
    cscope -bckq -i './cscope.files'

    echo "ctags indexing ..."
    ctags -L ./cscope.files --tag-relative=yes './tags'

    echo "gnu global indexing ..."
    gtags -f ./cscope.files --skip-unreadable
fi
