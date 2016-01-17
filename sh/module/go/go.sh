#! /bin/bash
export GOROOT="$MY_BIN/go"
export PATH="$GOROOT/bin:$PATH"

export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

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
