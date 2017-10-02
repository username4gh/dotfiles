#! /usr/bin/env bash

_file_path() {
    if [[ "$#" == 1 ]];then
        #local FILE=$1
        #local FILEPATH=${FILE%/*};
        #echo $FILEPATH
        echo "$(dirname $1)"
    fi
}

_file_name() {
    if [[ "$#" == 1 ]];then
        #local FILE=$1;
        #local FILENAME=${FILE##*/};
        #echo $FILENAME
        echo "$(basename $1)"
    fi
}

_file_name_noext() {
    if [[ "$#" == 1 ]];then
        local FILE_NO_PATH=${1##*/};
        local NOEXT=${FILE_NO_PATH%\.*};
        echo $NOEXT
    fi
}

_file_ext(){
    if [[ "$#" == 1 ]];then
        local FILE_NO_PATH=${1##*/};
        local EXT=${FILE_NO_PATH##*.}
        echo $EXT
    fi
}

_file_name_from_uri() {
    if [[ "$#" == 1 ]];then
        echo "${1##*/}"
    fi
}
