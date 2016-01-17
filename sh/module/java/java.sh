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

if [[ "$(_check_os)" == "Linux" ]];then
    export JDK_PATH="$MY_BIN/jdk1.7.0_80"
    export JAVA_HOME="$MY_BIN/jdk1.7.0_80"
    export PATH="$JDK_PATH/bin:$PATH"
fi
