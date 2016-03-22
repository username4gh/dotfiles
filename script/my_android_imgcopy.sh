#! /usr/bin/env bash

echo 'ldpi 120dpi  0.75'
echo 'mdpi 160dpi  1'
echo 'hdpi 240dpi  1.5'
echo 'xhdpi 320dpi  2'
echo 'xxhdpi 480dpi 2.5'
echo 'xxxhdpi 640dpi 3'

if [[ "$#" == 2 ]];then
    FILEPATH=${1%/*}
    FILE_NO_PATH=${1##*/};
    NOEXT=${FILE_NO_PATH%\.*};
    EXT=${FILE_NO_PATH##*.}

    cp -vi $FILEPATH/$NOEXT.$EXT $2/drawable-mdpi/$NOEXT.$EXT
    cp -vi $FILEPATH/$NOEXT@2x.$EXT $2/drawable-xhdpi/$NOEXT.$EXT
    cp -vi $FILEPATH/$NOEXT@3x.$EXT $2/drawable-xxhdpi/$NOEXT.$EXT
else
    echo "Usage: imgcopy.sh imgfile(1x) target-res-dir"
fi
