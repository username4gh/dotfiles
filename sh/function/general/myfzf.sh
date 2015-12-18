#! /usr/bin/env bash

#Description wrapper for fzf

myfzf() {
    if [[ ! -d "$HOME/.fzf" ]];then
        pushd "$HOME" \
            && git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf \
            || popd
    fi

    if [[ "$#" == 0 ]];then
        (export PATH="$HOME/.fzf:$PATH"; fzf)
    else
        (export PATH="$HOME/.fzf:$PATH"; fzf "$@")
    fi
}
