#! /usr/bin/env bash

_cr_cs_search() {
    if [[ "$1" == '--help' ]];then
        echo 'Usage: _cscope_search Num Pattern
        Where num can be one of:
        0 ==> C symbol
        1 ==> function definition
        2 ==> functions called by this function
        3 ==> functions calling this function
        4 ==> text string
        5 ==> egrep pattern
        6 ==> files #including this file'
    else
        cscope -dL -f ./.git/cscope.out -$1$2
    fi
}

_cr_cs_generate() {
    if [[ -d './.git' ]];then
        echo "cscope -- generate cscope.files"
        find $PWD -name '*.aidl' -o -name '*.cc' -o -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.py' > './.git/cscope.files'
        echo "cscope -- generate cscope.out"
        cd $PWD/.git && cscope -bkq -i './cscope.files' && cd ..
        echo "ctags -- generate -- tags"
        ctags -R --links=no --tag-relative=yes --exclude=.svn --exclude=.git -f './.git/tags'
    fi
}
