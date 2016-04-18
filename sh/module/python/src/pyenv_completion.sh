#! /usr/bin/env sh

if [[ "$MY_CURRENT_SHELL" == 'bash' ]];then
    _virtual_pyenv_complete () {
        local cur="${COMP_WORDS[COMP_CWORD]}"
        local enable_disable_args="pip pyenv pypw"
        COMPREPLY=( $(compgen -W "${enable_disable_args}" -- ${cur}) )
    }

    complete -F _virtual_pyenv_complete virtual_pyenv
fi
