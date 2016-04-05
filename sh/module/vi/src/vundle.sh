#! /usr/bin/env sh

# https://github.com/VundleVim/Vundle.vim/issues/599
# https://github.com/VundleVim/Vundle.vim/issues/639
my_vi_fix_plugin_search() {
    curl -C - http://vim-scripts.org/api/scripts.json -o ~/.vim/bundle/.vundle/script-names.vim-scripts.org.json
}
