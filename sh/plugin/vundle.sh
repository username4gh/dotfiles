#! /usr/bin/env bash

# https://github.com/VundleVim/Vundle.vim/issues/599
# https://github.com/VundleVim/Vundle.vim/issues/639
vundle_fix_plugin_search() {
    wget http://vim-scripts.org/api/scripts.json -v -O ~/.vim/bundle/.vundle/script-names.vim-scripts.org.json
}