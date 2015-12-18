#! /bin/bash
if [[ -d "$HOME/bin/go" ]]; then
    export GOROOT="$HOME/bin/go"
    export PATH="$GOROOT/bin:$PATH"
else
    echo "GO hasn't been installed yet'"
fi

if [[ -d "$HOME/go" ]];then
    export GOPATH="$HOME/go"
    export PATH="$GOPATH/bin:$PATH"
else
    echo "GOPATH hasn't been setted yet"
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