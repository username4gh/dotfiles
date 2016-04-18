#! /usr/bin/env sh

if [[ "$MY_CURRENT_SHELL" == 'bash' ]];then
    _changeshell_bash_2_zsh() {
        sudo dscl . -change "$HOME" UserShell /opt/local/bin/bash /opt/local/bin/zsh
    }
fi

if [[ "$MY_CURRENT_SHELL" == 'zsh' ]];then
    _changeshell_zsh_2_bash() {
        sudo dscl . -change "$HOME" UserShell /opt/local/bin/zsh /opt/local/bin/bash
    }
fi
