#! /usr/bin/env bash

# in order to keep pyenv and YouCompleteMe both work
# https://github.com/Valloric/YouCompleteMe/issues/8
_myvi() {
    if [[ "$#" == 0 ]];then
        (unset PATH;
        export PATH="/usr/bin";
        export PATH="/opt/local/bin:$PATH";
        export PATH="/opt/local/sbin:$PATH";
        export PATH="/opt/local/libexec/gnubin:$PATH";
        vim)
    else
        (unset PATH; 
        export PATH="/usr/bin";
        export PATH="/opt/local/bin:$PATH";
        export PATH="/opt/local/sbin:$PATH";
        export PATH="/opt/local/libexec/gnubin:$PATH";
        vim "$@")
    fi
}

_myvi_compile_YouCompileMe() {
    if [[ "$(port select --list python | ack active | ack -o '(?<=^).*?(?=\()')" == 'none' ]];then
        echo "please do 'sudo port select --set python python27'";
    else
        (cd "$HOME/.vim/bundle/YouCompleteMe";
        unset PATH;
        export PATH="/opt/local/bin:$PATH"
        export PATH="/opt/local/sbin:$PATH"
        export PATH="/opt/local/libexec/gnubin:$PATH"

        python ./install.py)
    fi
}

_myvi_init() {
    if [[ ! -h "$HOME/.vimrc" ]];then
        if [[ -f "$HOME/.vimrc" ]];then
            rm "$HOME/.vimrc"
        fi

        ln -s "$MY_REPO/my-i3/.vimrc" "$HOME/.vimrc"
    fi
}

if [[ "$(_check_command nvim)" == 1 ]]; then
    alias vi='nvim'
elif [[ "$(_check_command vim)" == 1 ]]; then
    if [[ "$(_check_os)" == 'Darwin' ]];then
        alias vi='_myvi'
    else 
        alias vi='vim'
    fi
fi
