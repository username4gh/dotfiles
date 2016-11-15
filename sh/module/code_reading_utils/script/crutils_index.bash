#! /usr/bin/env bash

if [[ -f './cscope.files' ]];then
    echo "cscope indexing ..."
    cscope -bckq -i './cscope.files'

    echo "ctags indexing ..."
    ctags -L ./cscope.files --tag-relative=yes './tags'

    echo "gnu global indexing ..."
    gtags -f ./cscope.files --skip-unreadable
else
    echo "Plz generate file list first!"
fi
