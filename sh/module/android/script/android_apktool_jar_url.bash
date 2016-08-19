#! /usr/bin/env bash

url="https://bitbucket.org$(curl -s https://bitbucket.org/iBotPeaches/apktool/downloads | s -o "(?<=<a\ class=\"execute\"\ href=\").*?(?=\">)" | head -1)"
echo $url

if [[ ! -f "$MY_BIN/apktool" ]];then
    curl -C - https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/osx/apktool > "$MY_BIN/apktool" \
    && chmod 0755 "$MY_BIN/apktool"
fi

if [[ ! -f "$MY_BIN/apktool.jar" ]];then
    curl -L -C - "$url" > "$MY_BIN/apktool.jar"
fi
unset url
