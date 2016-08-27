#! /usr/bin/env bash

if [[ "$(_check_os)" == 'Darwin' ]];then
    if [[ ! -d "$MY_REPO/m-cli" ]];then
        git clone https://github.com/rgcr/m-cli "$MY_REPO/m-cli"
    fi

    export PATH="$MY_REPO/m-cli:$PATH"

    if [[ "$MY_CURRENT_SHELL" == 'bash' ]];then
        source "$MY_REPO/m-cli/completion/bash/m"
    fi

    if [[ "$MY_CURRENT_SHELL" == 'zsh' ]];then
        source "$MY_REPO/m-cli/completion/zsh/m"
    fi
fi
