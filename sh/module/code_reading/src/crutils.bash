#! /usr/bin/env bash

crutils_search() {
    if [[ "$1" == '--help' ]] || [[ "$#" -lt 2 ]];then
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
        cscope -dL -f ./cscope.out -$1$2
    fi
}


