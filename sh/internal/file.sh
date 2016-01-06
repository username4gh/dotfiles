#! /usr/bin/env bash

_file_path() {
    if [[ "$#" == 1 ]];then
        local FILE=$1
        local FILEPATH=${FILE%/*};
        echo $FILEPATH
    else
        echo "_file_path error"
    fi
}

_file_name() {
    if [[ "$#" == 1 ]];then
        local FILE=$1;
        local FILENAME=${FILE##*/};
        echo $FILENAME
    else 
        echo "_file_name error"
    fi
}

_file_name_noext() {
    if [[ "$#" == 1 ]];then
        local FILE_NO_PATH=${1##*/};
        local NOEXT=${FILE_NO_PATH%\.*};
        echo $NOEXT
    else
        echo "_file_name_noext error"
    fi
}

_file_ext(){
    if [[ "$#" == 1 ]];then
        local FILE_NO_PATH=${1##*/};
        local EXT=${FILE_NO_PATH##*.}
        echo $EXT
    else
        echo "_file_ext error"
    fi
}
