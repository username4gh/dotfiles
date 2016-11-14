#! /usr/bin/env bash

_go_latest_url_mac() {
    local url
    url=$(curl -s https://golang.org/dl/ | s -o "(?<=<td\ class=\"filename\"><a\ class=\"download\"\ href=\").*?(?=\">)" | s -v "src"| s -i "tar.gz" | s -i "darwin" | head -1)
    echo $url
}

_go_latest_url_linux() {
    local url
    url=$(curl -s https://golang.org/dl/ | s -o "(?<=<td\ class=\"filename\"><a\ class=\"download\"\ href=\").*?(?=\">)" | s -v "src"| s -i "tar.gz" | s -i "linux" | head -1)
    echo $url
}

_go_path_init() {
    if [[ ! -d "$MY_BIN/go" ]]; then
        mkdir -p "$MY_BIN/go"
    fi

    if [[ ! -d "$HOME/go" ]];then
        mkdir -p "$HOME/go"
    fi
}

_go_bin_init() {
    local fileUrl
    local fileName

    if [[ "$(_check_command go)" == 0 ]];then
        echo "beginning go init"
        if [[ "$(_check_os)" == "Darwin" ]];then
            fileUrl=$(_go_latest_url_mac)
        elif [[ "$(_check_os)" == "Linux" ]]; then
            fileUrl=$(_go_latest_url_linux)
        fi

        fileName=$(_file_name_from_uri "$fileUrl")

        (echo $fileUrl

        echo $fileName

        curl -L -C - "$fileUrl" -o "$MY_BIN/$fileName" && cd $MY_BIN && tar -xf $fileName)
    fi
}

_go_init() {
    _go_path_init
    _go_bin_init
}
