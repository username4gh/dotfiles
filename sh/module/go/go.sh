#! /bin/bash
export GOROOT="$MY_BIN/go"
export PATH="$GOROOT/bin:$PATH"

export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

_go_latest_url_mac() {
    local url
    url=$(curl -s https://golang.org/dl/ | ack -o "(?<=<td\ class=\"filename\"><a\ class=\"download\"\ href=\").*?(?=\">)" | ack -v "src"| ack -i "tar.gz" | ack -i "darwin" | head -1)
    echo $url
}

_go_latest_url_linux() {
    local url
    url=$(curl -s https://golang.org/dl/ | ack -o "(?<=<td\ class=\"filename\"><a\ class=\"download\"\ href=\").*?(?=\">)" | ack -v "src"| ack -i "tar.gz" | ack -i "linux" | head -1)
    echo $url
}
