#! /usr/bin/env sh

if [[ "$MY_CURRENT_SHELL" == 'bash' ]];then
    _virtual_nvm_complete () {
        local cur="${COMP_WORDS[COMP_CWORD]}"
        local completion_args="commitizen_init git-cz npm"
        COMPREPLY=( $(compgen -W "${completion_args}" -- ${cur}) )
    }

    complete -F _virtual_nvm_complete virtual_nvm
fi
