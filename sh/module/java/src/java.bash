#! /usr/bin/env bash

_java_7_url_linux() {
    local url
    url="http://ghaffarian.net/downloads/Java/$(curl -s http://ghaffarian.net/downloads/Java/ | s -o "(?<=<a\ href=\").*?(?=\">)" | s x64.tar.gz | uniq -d | s 7u)"
    echo $url
}

_java_8_url_linux() {
    local url
    url="http://ghaffarian.net/downloads/Java/$(curl -s http://ghaffarian.net/downloads/Java/ | s -o "(?<=<a\ href=\").*?(?=\">)" | s x64.tar.gz | uniq -d | s 8u)"
    echo $url
}

_java_bin_init() {
    local fileUrl
    local fileName

    if [[ "$(_check_command java)" == 0 ]];then
        echo "beginning java init"
        if [[ "$(_check_os)" == "Darwin" ]];then
            echo "Go 'http://www.oracle.com/technetwork/java/javase/downloads/index.html' to download !"
        elif [[ "$(_check_os)" == "Linux" ]]; then
            fileUrl=$(_java_8_url_linux)
        fi

        fileName=$(_file_name_from_url "$fileUrl")

        (echo $fileUrl

        echo $fileName

        curl -L -C - "$fileUrl" -o "$MY_BIN/$fileName" && cd $MY_BIN && tar -xf $fileName)
    fi
}

_java_init() {
    _java_bin_init
}

if [[ "$(_check_os)" == "Linux" ]];then
    export JDK_PATH="$(_autodetect_bin "jdk1\..*")"
    export JAVA_HOME="$(_autodetect_bin "jdk1\..*")"
    export PATH="$JDK_PATH/bin:$PATH"
fi