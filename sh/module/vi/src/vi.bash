#! /usr/bin/env bash

if [[ "$(_check_command multimarkdown)" == 0 ]];then
    _sh_log "${BASH_SOURCE[0]}" "Need multimarkdown for previewing markdown"
fi

if [[ "$(_check_command vim)" == 1 ]]; then
    if [[ "$(_check_os)" == 'Darwin' ]];then
        if [[ "$MY_CURRENT_PACKAGE_MANAGER" == 'macports' ]];then
            # in order to keep pyenv and YouCompleteMe both work
            # https://github.com/Valloric/YouCompleteMe/issues/8
            _vi() {
                (unset PATH;
                export PATH="/bin"
                export PATH="/usr/bin:$PATH";
                export PATH="/opt/local/bin:$PATH";
                export PATH="/opt/local/sbin:$PATH";
                export PATH="/opt/local/libexec/gnubin:$PATH";
                export PATH="$MY_DOTFILES_RESOURCES/ctags:$PATH"
                export NVM_DIR="$HOME/.nvm";
                [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm, some vim-plugin need it.
                vim "$@")
            }

            alias vi='_vi'
            alias vim='_vi'
        elif [[ "$MY_CURRENT_PACKAGE_MANAGER" == 'homebrew' ]];then
            alias vi='vim'
        fi
    fi
fi
