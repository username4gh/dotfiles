#! /bin/bash
export GOROOT="$HOME/bin/go"
export PATH="$GOROOT/bin:$PATH"
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

_go_latest_mac() {
    local url
    url=$(curl -s https://golang.org/dl/ | grep -Po "(?<=<td\ class=\"filename\"><a\ class=\"download\"\ href=\").*?(?=\">)" | grep -v "src"| grep -i "tar" | grep -i "darwin" | head -1)
    echo $url
}

_go_latest_linux() {
    local url
    url=$(curl -s https://golang.org/dl/ | grep -Po "(?<=<td\ class=\"filename\"><a\ class=\"download\"\ href=\").*?(?=\">)" | grep -v "src"| grep -i "tar" | grep -i "linux" | head -1)
    echo $url
}

if [[ ! -d "$HOME/bin/go" ]]; then
    mkdir -p "$HOME/bin/go"
    if [[ "$(_check_os)" == "Darwin" ]];then
        wget -c "$(_go_latest_mac)" -P "$HOME/bin/"
    elif [[ "$(_check_os)" == "Linux" ]]; then
        wget -c "$(_go_latest_linux)" -P "$HOME/bin"
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
