#! /usr/bin/env bash

_virtual_pyenv_complete () {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local enable_disable_args="alias plugin completion"
    COMPREPLY=( $(compgen -W "${enable_disable_args}" -- ${cur}) )
}

complete -F _virtual_pyenv_complete virtual_pyenv
