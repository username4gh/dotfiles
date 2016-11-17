#! /usr/bin/env bash

if [[ "$#" == 3 ]];then
    FILEPATH=${2%/*}
    FILE_NO_PATH=${2##*/};
    NOEXT=${FILE_NO_PATH%\.*};
    EXT=${FILE_NO_PATH##*.}

    case $1 in
        "-r")
        if [[ -f "$3/drawable-mdpi/$NOEXT.$EXT" || -f "$3/drawable-xhdpi/$NOEXT.$EXT" || -f "$3/drawable-xxhdpi/$NOEXT.$EXT" ]];then
            echo "$NOEXT.$EXT already exist, plz enter an alternative name"
            read alternative
        fi

        if [[ "$alternative" == '' ]];then
            echo "alternative was illegal, so execute in overwrite mode"
            cp -vf $FILEPATH/$NOEXT.$EXT $3/drawable-mdpi/$NOEXT.$EXT
            cp -vf $FILEPATH/$NOEXT@2x.$EXT $3/drawable-xhdpi/$NOEXT.$EXT
            cp -vf $FILEPATH/$NOEXT@3x.$EXT $3/drawable-xxhdpi/$NOEXT.$EXT
        else
            cp -vi $FILEPATH/$NOEXT.$EXT $3/drawable-mdpi/$alternative.$EXT
            cp -vi $FILEPATH/$NOEXT@2x.$EXT $3/drawable-xhdpi/$alternative.$EXT
            cp -vi $FILEPATH/$NOEXT@3x.$EXT $3/drawable-xxhdpi/$alternative.$EXT
        fi
        ;;
        "-o")
        echo "overwrite mode"
        cp -vf $FILEPATH/$NOEXT.$EXT $3/drawable-mdpi/$NOEXT.$EXT
        cp -vf $FILEPATH/$NOEXT@2x.$EXT $3/drawable-xhdpi/$NOEXT.$EXT
        cp -vf $FILEPATH/$NOEXT@3x.$EXT $3/drawable-xxhdpi/$NOEXT.$EXT
        ;;
        "*")
        echo "no mode was specified, so do nothing"
        ;;
    esac
else
    echo "Usage: my_android_imgcopy mode imgfile(1x) target-project-res-dir"
    echo "mode : -o -- overwrite, -r -- rename"
    echo "imgfile must be in the format of './.*\.ext'"
fi
