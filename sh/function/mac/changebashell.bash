#! /usr/bin/env bash

if _is_bash;then
    _changeshell_bash_2_zsh() {
        sudo dscl . -change "$HOME" UserShell /opt/local/bin/bash /opt/local/bin/zsh
    }
fi

if _is_zsh;then
    _changeshell_zsh_2_bash() {
        sudo dscl . -change "$HOME" UserShell /opt/local/bin/zsh /opt/local/bin/bash
    }
fi
