#! /usr/bin/env bash

if [[ "$(_check_command multimarkdown)" == 0 ]];then
    _sh_log "${BASH_SOURCE[0]}" "Need multimarkdown for previewing markdown"
fi

if [[ "$(_check_command nvim)" == 1 ]]; then
    alias vi='nvim'
    alias vim='nvim'
elif [[ "$(_check_command vim)" == 1 ]]; then
    if [[ "$(_check_os)" == 'Darwin' ]];then
        if [[ "$MY_CURRENT_PACKAGE_MANAGER" == 'macports' ]];then
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
                    export PATH="$MY_DOTFILES/ctags:$PATH"
                    vim)
                else
                    (unset PATH;
                    export PATH="/bin"
                    export PATH="/usr/bin:$PATH";
                    export PATH="/opt/local/bin:$PATH";
                    export PATH="/opt/local/sbin:$PATH";
                    export PATH="/opt/local/libexec/gnubin:$PATH";
                    export PATH="$MY_DOTFILES/ctags:$PATH"
                    vim "$@")
                fi
            }

            alias vi='_vi'
            alias vim='_vi'
        fi
    else
        alias vim='vim'
    fi
fi
