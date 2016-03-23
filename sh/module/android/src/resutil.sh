#! /usr/bin/env bash

my_android_info() {
    if [[ "$#" == 0 ]];then
        echo 'ldpi 120dpi  0.75'
        echo 'mdpi 160dpi  1'
        echo 'hdpi 240dpi  1.5'
        echo 'xhdpi 320dpi  2'
        echo 'xxhdpi 480dpi 2.5'
        echo 'xxxhdpi 640dpi 3'
    fi
}

my_android_imgcopy(){
    if [[ "$#" == 2 ]];then
        local FILEPATH=${1%/*}
        local FILE_NO_PATH=${1##*/};
        local NOEXT=${FILE_NO_PATH%\.*};
        local EXT=${FILE_NO_PATH##*.}
        if [[ "$2/drawable-mdpi/$NOEXT.$EXT" || "$2/drawable-xhdpi/$NOEXT.$EXT" || "$2/drawable-xxhdpi/$NOEXT.$EXT" ]];then
            echo "$NOEXT.$EXT already exist, plz enter an alternative name"
            read alternative
            cp -vi $FILEPATH/$NOEXT.$EXT $2/drawable-mdpi/$alternative.$EXT
            cp -vi $FILEPATH/$NOEXT@2x.$EXT $2/drawable-xhdpi/$alternative.$EXT
            cp -vi $FILEPATH/$NOEXT@3x.$EXT $2/drawable-xxhdpi/$alternative.$EXT
        else    
            cp -vi $FILEPATH/$NOEXT.$EXT $2/drawable-mdpi/$NOEXT.$EXT
            cp -vi $FILEPATH/$NOEXT@2x.$EXT $2/drawable-xhdpi/$NOEXT.$EXT
            cp -vi $FILEPATH/$NOEXT@3x.$EXT $2/drawable-xxhdpi/$NOEXT.$EXT
        fi
    else
        echo "Usage: my_android_imgcopy imgfile(1x) target-res-dir"
    fi
}
