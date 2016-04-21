#! /usr/bin/env sh

_go_install_codesearch() {
    go get github.com/google/codesearch/cmd/...
}

_go_install_sift() {
    go get github.com/svent/sift
}

_go_install_pt() {
    go get -u github.com/monochromegane/the_platinum_searcher/...
}

_go_install_noti() {
    # https://github.com/variadico/noti
    go get -u github.com/variadico/noti
}
