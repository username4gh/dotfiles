#! /usr/bin/env sh

# UTF-8-encode a string of Unicode symbols
escape() {
    printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u);
    # print a newline unless we’re piping the output to another program
    if [[ -t 1 ]];then
        echo "";
    fi
}