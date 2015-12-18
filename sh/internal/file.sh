#! /usr/bin/env bash

_file_path() {
    FILE=$1
    FILEPATH=${FILE%/*};
    echo $FILEPATH
}

_file_name() {
    FILE=$1
    FILENAME=${FILE##*/};
    echo $FILENAME
}

_file_name_noext() {
    FILE=$1
    NOEXT=${FILENAME%\.*};
    echo $NOEXT
}

_file_ext(){
    FILE=$1
    EXT=${FILE##*.}
    echo $EXT
}
