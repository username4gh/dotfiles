#! /usr/bin/env sh

_java_7_url_linux() {
    local url
    url="http://ghaffarian.net/downloads/Java/$(curl -s http://ghaffarian.net/downloads/Java/ | s -o "(?<=<a\ href=\").*?(?=\">)" | s x64.tar.gz | s 7u)"
    echo $url
}

_java_8_url_linux() {
    local url
    url="http://ghaffarian.net/downloads/Java/$(curl -s http://ghaffarian.net/downloads/Java/ | s -o "(?<=<a\ href=\").*?(?=\">)" | s x64.tar.gz | s 8u)"
    echo $url
}

if [[ "$(_check_os)" == "Linux" ]];then
    export JDK_PATH="$(_autodetect_bin "jdk1\..*")"
    export JAVA_HOME="$(_autodetect_bin "jdk1\..*")"
    export PATH="$JDK_PATH/bin:$PATH"
fi
