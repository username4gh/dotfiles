#! /usr/bin/env bash

_android_apktool_jar_url(){
    local url
    url="https://bitbucket.org$(curl -s https://bitbucket.org/iBotPeaches/apktool/downloads | ack -o "(?<=<a\ class=\"execute\"\ href=\").*?(?=\">)" | head -1)"
    echo $url
}

_android_apktool() {
    if [[ ! -f "$MY_BIN/apktool" ]];then
        curl -C - https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/osx/apktool > "$MY_BIN/apktool"

    fi

    if [[ ! -f "$MY_BIN/apktool.jar" ]];then
        curl -L -C - "$(_android_apktool_jar_url)" > "$MY_BIN/apktool.jar"
    fi
}
