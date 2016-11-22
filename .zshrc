#! /usr/bin/env zsh

export ZSH=$HOME/.oh-my-zsh

plugins=(z zsh_reload)

source $ZSH/oh-my-zsh.sh

export MY_CURRENT_SHELL='zsh'

source "$HOME/.dotfiles/my-i3/sh/init.bash"

function _git_prompt_info() {
    local prompt_info
    prompt_info="$(echo -e " $(git_prompt_info)" | tr -d '[[:space:]]')"

    if [[ "${#prompt_info}" -eq 0 ]];then
        echo -e " "
    else
        echo -e " $prompt_info "
    fi
}

export PS1='%n %F{green}$PWD%f$(_git_prompt_info)%# '
