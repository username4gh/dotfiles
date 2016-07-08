#! /usr/bin/env bash

# in order to keep pyenv and YouCompleteMe both work
# https://github.com/Valloric/YouCompleteMe/issues/8
_vi() {
    if [[ "$#" == 0 ]];then
        (unset PATH;
        export PATH="/bin"
        export PATH="/usr/bin:$PATH";
        export PATH="/opt/local/bin:$PATH";
        export PATH="/opt/local/sbin:$PATH";
        export PATH="/opt/local/libexec/gnubin:$PATH";
        vim)
    else
        (unset PATH;
        export PATH="/bin"
        export PATH="/usr/bin:$PATH";
        export PATH="/opt/local/bin:$PATH";
        export PATH="/opt/local/sbin:$PATH";
        export PATH="/opt/local/libexec/gnubin:$PATH";
        vim "$@")
    fi
}

if [[ "$(_check_command multimarkdown)" == 0 ]];then
    echo "Need multimarkdown for previewing markdown"
fi

if [[ "$(_check_command nvim)" == 1 ]]; then
    alias vim='nvim'
elif [[ "$(_check_command vim)" == 1 ]]; then
    if [[ "$(_check_os)" == 'Darwin' ]];then
        alias vim='_vi'
    else
        alias vim='vim'
    fi
fi
