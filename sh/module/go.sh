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

if [[ ! -d "$MY_BIN/go" ]]; then
    mkdir -p "$MY_BIN/go"
    if [[ "$(_check_os)" == "Darwin" ]];then
        (cd "$MY_BIN"; curl -L -C - "$(_go_latest_mac)")
    elif [[ "$(_check_os)" == "Linux" ]]; then
        (cd "$MY_BIN"; curl -L -C - "$(_go_latest_linux)")
    fi
fi

if [[ ! -d "$HOME/go" ]];then
    mkdir -p "$HOME/go"
fi

_go_install_codesearch() {
    go get github.com/google/codesearch/cmd/...
}

_go_install_sift() {
    go get github.com/svent/sift
}

_go_install_pt() {
    go get -u github.com/monochromegane/the_platinum_searcher/...
}
