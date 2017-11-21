#! /usr/bin/env bash

if _is_darwin;then
    _mcli_init() {
        if [[ ! -d "$MY_DOTFILES_RESOURCES/m-cli" ]];then
            git clone https://github.com/rgcr/m-cli "$MY_DOTFILES_RESOURCES/m-cli"
        fi
    }

    export PATH="$MY_DOTFILES_RESOURCES/m-cli:$PATH"

    if [[ "$MY_CURRENT_SHELL" == 'bash' ]];then
        [[ -f "$MY_DOTFILES_RESOURCES/m-cli/completion/bash/m" ]] && source "$MY_DOTFILES_RESOURCES/m-cli/completion/bash/m"
    fi

    if [[ "$MY_CURRENT_SHELL" == 'zsh' ]];then
        [[ -f "$MY_DOTFILES_RESOURCES/m-cli/completion/zsh/_m" ]] && source "$MY_DOTFILES_RESOURCES/m-cli/completion/zsh/_m"
    fi
fi
